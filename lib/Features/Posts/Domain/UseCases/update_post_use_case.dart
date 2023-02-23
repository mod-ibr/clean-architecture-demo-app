import 'package:clean_architecture_demo_app/Core/Errors/failure.dart';
import 'package:clean_architecture_demo_app/Features/Posts/Domain/Entites/post_entity.dart';
import 'package:clean_architecture_demo_app/Features/Posts/Domain/Repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePost {
  final PostsRepository postsRepository;

  UpdatePost(this.postsRepository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postsRepository.updatePost(post);
  }
}
