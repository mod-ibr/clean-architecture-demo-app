import 'package:clean_architecture_demo_app/Core/Errors/failure.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Entites/post_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PostesRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePostById(int id);
  Future<Either<Failure, Unit>> addPost(PostEntity post);
  Future<Either<Failure, Unit>> updatePost(PostEntity post);
}
