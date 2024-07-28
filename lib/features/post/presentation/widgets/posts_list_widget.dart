import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';
import '../screens/post_details_screen.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> postsList;
  const PostsListWidget({super.key, required this.postsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostDetailsScreen(post: postsList[index])));
          },
          child: Card(
            color: Colors.white24,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(postsList[index].title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  Text(postsList[index].body, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
