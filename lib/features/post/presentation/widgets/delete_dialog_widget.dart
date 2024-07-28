import 'package:clean_architecture/features/post/presentation/add_update_delete_post_bloc/add_update_delete_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  const DeleteDialogWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure to delete the post?'),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: const Text('No')),
        TextButton(onPressed: (){
          BlocProvider.of<AddUpdateDeleteBloc>(context).add(DeletePostEvent(postId: postId));
        }, child: const Text('Yes')),
      ],
    );
  }
}
