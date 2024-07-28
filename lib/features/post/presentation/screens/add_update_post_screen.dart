import 'package:clean_architecture/core/util/snak_bar_message.dart';
import 'package:clean_architecture/core/widgets/form_widget.dart';
import 'package:clean_architecture/core/widgets/loading_widget.dart';
import 'package:clean_architecture/features/post/domain/entities/post.dart';
import 'package:clean_architecture/features/post/presentation/add_update_delete_post_bloc/add_update_delete_bloc.dart';
import 'package:clean_architecture/features/post/presentation/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdatePostScreen extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const AddUpdatePostScreen({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePost ? 'Update Post' : 'Add Post'),
      ),

      body: BlocConsumer<AddUpdateDeleteBloc, AddUpdateDeleteState>(
        listener: (context, state) {
          if(state is AddUpdateDeletePostSuccess){
            SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PostsScreen()), (route) => false);
          }else if(state is ErrorAddUpdateDeletePost){
            SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
          }
        },
        builder: (context, state) {
          if(state is LoadingAddUpdateDeletePost){
            return const LoadingWidget();
          }
          return FormWidget(isUpdatePost: isUpdatePost, post: post);
        },
      )
    );
  }
}
