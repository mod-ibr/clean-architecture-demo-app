import 'package:clean_architecture_demo_app/Core/Errors/failure.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Repositories/postes_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostesRepository postesRepository;

  DeletePostUseCase({required this.postesRepository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await postesRepository.deletePostById(id);
  }
}
