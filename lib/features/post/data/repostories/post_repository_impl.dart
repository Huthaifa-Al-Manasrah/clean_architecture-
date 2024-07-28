import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/post/data/models/post_model.dart';
import 'package:clean_architecture/features/post/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/post_repository.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if(await networkInfo.isConnected) {
      try {
        final remotesPosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotesPosts);
        return Right(remotesPosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost({required Post newPost}) async {
    final PostModel postModel = PostModel(id: newPost.id, title: newPost.title, body: newPost.body);
    return await _getMessage(() => remoteDataSource.addPost(post: postModel));
  }

  @override
  Future<Either<Failure, Unit>> updatePost({required Post updatedPost}) async {
    final PostModel postModel = PostModel(id: updatedPost.id, title: updatedPost.title, body: updatedPost.body);
    return await _getMessage(() => remoteDataSource.updatePost(post: postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required int postId}) async {
    return await _getMessage(() => remoteDataSource.deletePost(postId: postId));
  }


  Future<Either<Failure, Unit>> _getMessage(DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if(await networkInfo.isConnected){
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else {
      return Left(OfflineFailure());
    }
  }
}