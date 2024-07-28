import 'package:clean_architecture/core/util/snak_bar_message.dart';
import 'package:clean_architecture/features/post/presentation/add_update_delete_post_bloc/add_update_delete_bloc.dart';
import 'package:clean_architecture/features/post/presentation/screens/posts_screen.dart';
import 'package:clean_architecture/features/post/presentation/widgets/delete_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/post.dart';
import 'add_update_post_screen.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;
  const PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(post.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            const Divider(),
            Text(
              post.body, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddUpdatePostScreen(isUpdatePost: true, post: post)));
                }, child: const Text('Edit')),
                ElevatedButton(onPressed: () async {
                  await showDeleteDialog(context);
                }, child: const Text('Delete')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> showDeleteDialog(BuildContext context) async {
    showDialog(context: context, builder: (context) {
      return BlocConsumer<AddUpdateDeleteBloc, AddUpdateDeleteState>(
        builder: (context, state) {
          if(state is LoadingAddUpdateDeletePost){
            return const Center(child: CircularProgressIndicator());
          }
          return DeleteDialogWidget(postId: post.id!);
        },
        listener: (context, state) {
          if(state is AddUpdateDeletePostSuccess){
            SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PostsScreen()), (route) => false);
          }else if(state is ErrorAddUpdateDeletePost){
            Navigator.of(context).pop();
            SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
          }
        },
      );
    });
  }

}
