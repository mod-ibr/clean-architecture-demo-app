import 'package:clean_architecture_demo_app/Core/Errors/exception.dart';
import 'package:clean_architecture_demo_app/Core/Network/network_connection_checker.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Data/DataSources/post_local_data_source.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Data/DataSources/post_remote_data_source.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Data/Models/post_model.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Entites/post_entity.dart';
import 'package:clean_architecture_demo_app/Core/Errors/failure.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Repositories/postes_repository.dart';
import 'package:dartz/dartz.dart';

class PostesRepositoryImpl extends PostesRepository {
  final PostLocalDataSource postLocalDataSource;
  final PostRemoteDataSource postRemoteDataSource;
  final NetworkConnectionChecker networkConnectionChecker;

  PostesRepositoryImpl(
      {required this.postLocalDataSource,
      required this.postRemoteDataSource,
      required this.networkConnectionChecker});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    if (await networkConnectionChecker.isConnected) {
      try {
        final List<PostModel> remotePostes =
            await postRemoteDataSource.getAllPostes();

        await postLocalDataSource.cachePost(remotePostes);
        return Right(remotePostes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<PostModel> localpostes =
            await postLocalDataSource.getCachedPosts();

        return Right(localpostes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    return await _doDeleteOrUpdateOrAddPost(
        () => postRemoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePostById(int id) async {
    return await _doDeleteOrUpdateOrAddPost(
        () => postRemoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.title);
    return await _doDeleteOrUpdateOrAddPost(
        () => postRemoteDataSource.updatePoste(postModel));
  }

  Future<Either<Failure, Unit>> _doDeleteOrUpdateOrAddPost(
     Future<Unit> Function() deleteOrUpdateOrAddPost) async {
    if (await networkConnectionChecker.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
