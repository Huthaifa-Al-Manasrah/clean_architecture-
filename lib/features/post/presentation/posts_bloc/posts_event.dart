part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class GetAllPostsEvent extends PostsEvent {}

class RefreshPostsEvent extends PostsEvent {}
