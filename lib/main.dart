import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/post/presentation/add_update_delete_post_bloc/add_update_delete_bloc.dart';
import 'features/post/presentation/posts_bloc/posts_bloc.dart';
import 'features/post/presentation/screens/posts_screen.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (context) => di.sl<AddUpdateDeleteBloc>()),
        ],
        child: MaterialApp(
          title: 'Flutter Clean Code',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const PostsScreen(),
        ));
  }
}
