import 'package:clean_architecture/core/widgets/loading_widget.dart';
import 'package:clean_architecture/features/post/presentation/posts_bloc/posts_bloc.dart';
import 'package:clean_architecture/features/post/presentation/widgets/posts_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_update_post_screen.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts Page')),
      body: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is LoadingPostsState) {
          return const LoadingWidget();
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
              },
              child: PostsListWidget(postsList: state.posts));
        }else if(state is ErrorPostsState){
          return Text(state.message);
        }
        return const SizedBox.shrink();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddUpdatePostScreen(isUpdatePost: false)));
        },
        child: const Icon(Icons.add_circle_outline),
      ),
    );
  }
}