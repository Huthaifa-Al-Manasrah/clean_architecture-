// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/features/post/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost({required postId});

  Future<Unit> updatePost({required PostModel post});

  Future<Unit> addPost({required PostModel post});
}

const BASE_URL = 'https://jsonplaceholder.typicode.com';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse('$BASE_URL/posts/'),
        headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200){
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      return postModels;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost({required PostModel post}) async {
    final body = {
      'title': post.title,
      'body':post.body
    };
    final response = await client.post(Uri.parse('$BASE_URL/posts/'), body: body);
    if(response.statusCode == 201){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost({required postId}) async {
    final response = await client.delete(Uri.parse('$BASE_URL/posts/$postId'), headers: {"Content-Type": "application/json"});

    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost({required PostModel post}) async {
    final body = {
      'title': post.title,
      'body':post.body
    };
    final response = await client.patch(Uri.parse('$BASE_URL/posts/${post.id}'), body: body);
    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }
}
