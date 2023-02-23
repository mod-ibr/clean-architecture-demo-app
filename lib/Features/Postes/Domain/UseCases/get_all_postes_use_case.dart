import 'package:clean_architecture_demo_app/Core/Errors/failure.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Entites/post_entity.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Repositories/postes_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPosts {
  final PostesRepository postesRepository;

  GetAllPosts(this.postesRepository);

  Future<Either<Failure, List<Post>>> call() async {
    return await postesRepository.getAllPosts();
  }
}
