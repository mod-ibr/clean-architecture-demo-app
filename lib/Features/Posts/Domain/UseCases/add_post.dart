import 'package:clean_architecture_demo_app/Core/Errors/failure.dart';
import 'package:clean_architecture_demo_app/Features/Posts/Domain/Entites/post_entity.dart';
import 'package:clean_architecture_demo_app/Features/Posts/Domain/Repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class AddPostuseCase {
  final PostsRepository postsRepository;

  AddPostuseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postsRepository.addPost(post);
  }
}
