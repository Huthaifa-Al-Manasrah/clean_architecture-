import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/post/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture/features/post/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture/features/post/domain/usecases/add_post.dart';
import 'package:clean_architecture/features/post/domain/usecases/delete_post.dart';
import 'package:clean_architecture/features/post/domain/usecases/get_all_posts.dart';
import 'package:clean_architecture/features/post/domain/usecases/update_post.dart';
import 'package:clean_architecture/features/post/presentation/add_update_delete_post_bloc/add_update_delete_bloc.dart';
import 'package:clean_architecture/features/post/presentation/posts_bloc/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/post/data/repostories/post_repository_impl.dart';
import 'features/post/domain/repositories/post_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///!Features
  //- Posts Feature
  //Blocs
  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() => AddUpdateDeleteBloc(
      addPostUseCase: sl.call(),
      updatePostUseCase: sl.call(),
      deletePostUseCase: sl.call()));
  //Use Cases
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl.call()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl.call()));
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  //Repository

  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl.call()));
  //Data Source

  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //- Other Feature ---> do same thing like the previous feature
  //Blocs
  //Use Cases
  //Repository
  //Data Source

  ///!Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  
  ///!External
  final shredPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => shredPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
