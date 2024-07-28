part of 'add_update_delete_bloc.dart';

@immutable
abstract class AddUpdateDeleteEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddUpdateDeleteEvent {
  final Post post;

  AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddUpdateDeleteEvent {
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddUpdateDeleteEvent {
  final int postId;

  DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}