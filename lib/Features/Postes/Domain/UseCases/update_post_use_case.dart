import 'package:clean_architecture_demo_app/Core/Errors/failure.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Entites/post_entity.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Repositories/postes_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUseCase {
  final PostesRepository postesRepository;

  UpdatePostUseCase({required this.postesRepository});

  Future<Either<Failure, Unit>> call(PostEntity post) async {
    return await postesRepository.updatePost(post);
  }
}
