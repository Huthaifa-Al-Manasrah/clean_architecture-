part of 'add_update_delete_bloc.dart';

@immutable
abstract class AddUpdateDeleteState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUpdateDeleteInitial extends AddUpdateDeleteState {}

class LoadingAddUpdateDeletePost extends AddUpdateDeleteState {}

class ErrorAddUpdateDeletePost extends AddUpdateDeleteState {
  final String message;

  ErrorAddUpdateDeletePost({required this.message});

  @override
  List<Object> get props => [message];
}

class AddUpdateDeletePostSuccess extends AddUpdateDeleteState {
  final String message;

  AddUpdateDeletePostSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
