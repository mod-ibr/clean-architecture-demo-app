part of 'postes_bloc.dart';

abstract class PostesState extends Equatable {
  const PostesState();

  @override
  List<Object> get props => [];
}

class PostesInitial extends PostesState {}

class LoadingPostState extends PostesState {}

class LoadedPostState extends PostesState {
  final List<PostEntity> posts;

  const LoadedPostState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class MessageAddDeleteUpdatePostState extends PostesState {
  final String message;

  const MessageAddDeleteUpdatePostState({required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorPostState extends PostesState {
  final String message;

  const ErrorPostState({required this.message});
  @override
  List<Object> get props => [message];
}
