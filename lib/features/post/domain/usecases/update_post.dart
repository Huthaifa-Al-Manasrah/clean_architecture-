import 'package:clean_architecture/features/post/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/post_repository.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call({required Post updatedPost}) async {
    return await repository.updatePost(updatedPost: updatedPost);
  }
}