import 'package:clean_architecture_demo_app/Core/Errors/failure.dart';
import 'package:clean_architecture_demo_app/Features/Posts/Domain/Repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostsRepository postsRepository;

  DeletePostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await postsRepository.deletePostById(id);
  }
}
