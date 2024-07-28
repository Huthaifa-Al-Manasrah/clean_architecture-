import 'package:clean_architecture/features/post/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost({required int postId});
  Future<Either<Failure, Unit>> updatePost({required Post updatedPost});
  Future<Either<Failure, Unit>> addPost({required Post newPost});
}