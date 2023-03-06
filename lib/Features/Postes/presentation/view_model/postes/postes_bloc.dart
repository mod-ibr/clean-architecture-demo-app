import 'package:clean_architecture_demo_app/Core/Errors/errors_strings.dart';
import 'package:clean_architecture_demo_app/Core/Errors/failure.dart';
import 'package:clean_architecture_demo_app/Core/Utils/Constants/message_strings.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Entites/post_entity.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/UseCases/add_post_use_case.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/UseCases/delete_post_use_case.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/UseCases/get_all_postes_use_case.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/UseCases/update_post_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'postes_event.dart';
part 'postes_state.dart';

class PostesBloc extends Bloc<PostesEvent, PostesState> {
  final GetAllPostsUseCase getAllPostsUseCase;
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  PostesBloc(
      {required this.getAllPostsUseCase,
      required this.addPostUseCase,
      required this.updatePostUseCase,
      required this.deletePostUseCase})
      : super(PostesInitial()) {
    on<PostesEvent>((event, emit) async {
      if ((event is GetAllPostesEvent) || (event is RefreshPostesEvent)) {
        emit(LoadingPostState());
        final Either<Failure, List<PostEntity>> failureOrPostes =
            await getAllPostsUseCase.call();
        failureOrPostes.fold(
          (failure) =>
              emit(ErrorPostState(message: _mapFailureToMessage(failure))),
          (posts) => emit(LoadedPostState(posts: posts)),
        );
      } else if (event is AddPostEvent) {
        emit(LoadingPostState());
        final Either<Failure, Unit> failureOrDoneMessage =
            await addPostUseCase.call(event.postEntity);
        emit(_eitherDoneMessageOrErrorState(
            either: failureOrDoneMessage,
            message: MessageStrings.addSuccessMessgae));
      } else if (event is UpdatePostEvent) {
        emit(LoadingPostState());
        final Either<Failure, Unit> failureOroneMessage =
            await updatePostUseCase.call(event.postEntity);
        emit(_eitherDoneMessageOrErrorState(
            either: failureOroneMessage,
            message: MessageStrings.updateSuccessMessgae));
      } else if (event is DeletePostEvent) {
        emit(LoadingPostState());
        final Either<Failure, Unit> failureOroneMessage =
            await deletePostUseCase.call(event.postId);
        emit(_eitherDoneMessageOrErrorState(
            either: failureOroneMessage,
            message: MessageStrings.deleteSuccessMessgae));
      }
    });
  }

  PostesState _eitherDoneMessageOrErrorState(
      {required Either<Failure, Unit> either, required String message}) {
    return either.fold(
        (failure) => ErrorPostState(message: _mapFailureToMessage(failure)),
        (_) => MessageAddDeleteUpdatePostState(message: message));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorsStrings.serverFailureMessage;
      case EmptyCacheFailure:
        return ErrorsStrings.emptyCacheFailureMessage;
      case OfflineFailure:
        return ErrorsStrings.offlineFailureMessage;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
