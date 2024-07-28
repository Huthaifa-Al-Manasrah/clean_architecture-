import 'package:clean_architecture/features/post/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/post_repository.dart';

class AddPostUseCase{
  ///its here because we only need one instance
  ///so if we do this
  ///
  ///  Future<Either<Failure, Unit>> call({required Post newPost}) async {
  ///     localRepository = Repos();
  ///     so this will cause to create instance for each call to this method and any other methods!
  ///     and why is that !
  ///     either by singlton! (no need as its alredy beahc as singlton!) no need to create n....
  ///
  ///
  ///
  ///     return await repository.addPost(newPost: newPost);
  ///   }
  ///
  final PostRepository repository;

  AddPostUseCase(this.repository);

  Future<Either<Failure, Unit>> call({required Post newPost}) async {
    return await repository.addPost(newPost: newPost);
  }

}
