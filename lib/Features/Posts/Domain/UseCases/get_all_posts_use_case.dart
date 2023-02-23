import 'package:clean_architecture_demo_app/Core/Errors/failure.dart';
import 'package:clean_architecture_demo_app/Features/Posts/Domain/Entites/post_entity.dart';
import 'package:clean_architecture_demo_app/Features/Posts/Domain/Repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPosts {
  final PostsRepository postsRepository;

  GetAllPosts(this.postsRepository);

  Future<Either<Failure, List<Post>>> call() async {
    return await postsRepository.getAllPosts();
  }
}
