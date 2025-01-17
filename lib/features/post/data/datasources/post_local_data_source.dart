// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}
const CACHED_POSTS = 'CACHED_POSTS';


class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    try{
      List postModelsToJson = postModels
          .map<Map<String, dynamic>>((postModel) => postModel.toJson())
          .toList();
      sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    }catch(e){
      log(e.toString());
    }
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if(jsonString != null){
      List decodedJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodedJsonData.map<PostModel>((postModel) => PostModel.fromJson(postModel)).toList();
      return Future.value(jsonToPostModels);
    }else{
      throw EmptyCacheException();
    }
  }
}