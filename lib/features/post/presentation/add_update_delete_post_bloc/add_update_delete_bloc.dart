// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/strings/posts_features_messages.dart';
import 'package:clean_architecture/features/post/domain/entities/post.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/usecases/add_post.dart';
import '../../domain/usecases/delete_post.dart';
import '../../domain/usecases/update_post.dart';

part 'add_update_delete_event.dart';

part 'add_update_delete_state.dart';

class AddUpdateDeleteBloc
    extends Bloc<AddUpdateDeleteEvent, AddUpdateDeleteState> {
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  AddUpdateDeleteBloc(
      {required this.addPostUseCase,
      required this.updatePostUseCase,
      required this.deletePostUseCase})
      : super(AddUpdateDeleteInitial()) {
    on<AddUpdateDeleteEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdateDeletePost());
        final failureOrAddedMessage =
            await addPostUseCase.call(newPost: event.post);
        failureOrAddedMessage.fold((failure) {
          emit(ErrorAddUpdateDeletePost(message: _mapFailureMessage(failure)));
        }, (_) {
          emit(AddUpdateDeletePostSuccess(message: ADD_POST_SUCCESS));
        });
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddUpdateDeletePost());
        final failureOrUpdatedMessage =
            await updatePostUseCase.call(updatedPost: event.post);
        failureOrUpdatedMessage.fold((failure) {
          emit(ErrorAddUpdateDeletePost(message: _mapFailureMessage(failure)));
        }, (_) {
          emit(AddUpdateDeletePostSuccess(message: UPDATE_POST_SUCCESS));
        });
      } else if (event is DeletePostEvent) {
        emit(LoadingAddUpdateDeletePost());
        final failureOrDeleteMessage =
            await deletePostUseCase.call(postId: event.postId);
        failureOrDeleteMessage.fold((failure) {
          emit(ErrorAddUpdateDeletePost(message: _mapFailureMessage(failure)));
        }, (_) {
          emit(AddUpdateDeletePostSuccess(message: DELETE_POST_SUCCESS));
        });
      }
    });
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
