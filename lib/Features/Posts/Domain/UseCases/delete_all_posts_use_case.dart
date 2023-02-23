import 'package:clean_architecture_demo_app/Core/Errors/failure.dart';
import 'package:clean_architecture_demo_app/Features/Posts/Domain/Repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAllPostsuseCase {
  final PostsRepository postsRepository;

  DeleteAllPostsuseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call() async {
    return await postsRepository.deleteAllPosts();
  }
}
