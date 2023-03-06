part of 'postes_bloc.dart';

abstract class PostesState extends Equatable {
  const PostesState();

  @override
  List<Object> get props => [];
}

class PostesInitial extends PostesState {}

class LoadingPostState extends PostesState {}

class SucceededLoadedPostState extends PostesState {
  final List<PostEntity> posts;

  const SucceededLoadedPostState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class SucceededAddDeleteUpdatePostState extends PostesState {
  final String message;

  const SucceededAddDeleteUpdatePostState({required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorPostState extends PostesState {
  final String message;

  const ErrorPostState({required this.message});
  @override
  List<Object> get props => [message];
}
