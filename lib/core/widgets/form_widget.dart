import 'package:clean_architecture/features/post/domain/entities/post.dart';
import 'package:clean_architecture/features/post/presentation/add_update_delete_post_bloc/add_update_delete_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({super.key, required this.isUpdatePost, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if(widget.isUpdatePost){
      _titleController.text = widget.post?.title ?? '';
      _bodyController.text = widget.post?.body ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if(value?.isEmpty ?? true){
                  return 'fill the title please';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: widget.post?.title ?? 'post title'
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) {
                if(value?.isEmpty ?? true){
                  return 'fill the body please';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: widget.post?.title ?? 'post body',
              ),
              maxLines: 6,
              minLines: 6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              if(widget.isUpdatePost){
                if(validateTheForm()){
                  BlocProvider.of<AddUpdateDeleteBloc>(context).add(AddPostEvent(post: Post(title: _titleController.text, body: _bodyController.text)));
                }
              }else {
                if(validateTheForm()){
                  BlocProvider.of<AddUpdateDeleteBloc>(context).add(UpdatePostEvent(post: Post(id: 0, title: _titleController.text, body: _bodyController.text)));
                }
              }
            }, child: Text(widget.isUpdatePost ? 'Update Post' : 'Add Post'))
          ],
        ),
      ),
    );
  }


  bool validateTheForm(){
    return _formKey.currentState?.validate() ?? false;
  }
}
