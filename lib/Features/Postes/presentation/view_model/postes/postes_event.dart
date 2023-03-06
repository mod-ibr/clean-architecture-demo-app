part of 'postes_bloc.dart';

abstract class PostesEvent extends Equatable {
  const PostesEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostesEvent extends PostesEvent {}

class RefreshPostesEvent extends PostesEvent {}

class AddPostEvent extends PostesEvent {
  final PostEntity postEntity;

  const AddPostEvent({required this.postEntity});
  @override
  List<Object> get props => [postEntity];
}

class UpdatePostEvent extends PostesEvent {
  final PostEntity postEntity;

  const UpdatePostEvent({required this.postEntity});

  @override
  List<Object> get props => [postEntity];
}

class DeletePostEvent extends PostesEvent {
  final int postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
