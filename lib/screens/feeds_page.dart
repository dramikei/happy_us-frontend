import 'package:flutter/material.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/widgets/post_card.dart';

class FeedsPage extends StatelessWidget {
  static const id = 'FeedsPage';

  const FeedsPage({
    Key? key,
  }) : super(key: key);

  static final _posts = [
    Post.fromJson({
      'id': '#1',
      'heading': 'Post1 heading' * 8,
      'content': 'Post 1 content' * 25,
      'time': '2021-06-09 00:00:00.000',
      'likedBy': ['11', '22'],
    }),
    Post.fromJson({
      'id': '#2',
      'heading': 'Post2 heading',
      'content': 'Post 2 content' * 50,
      'time': '2021-06-04 00:00:00.000',
      'likedBy': ['44'],
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.separated(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 35),
          separatorBuilder: (c, i) => const SizedBox(height: 25),
          itemBuilder: (context, index) {
            final post = _posts[index];
            return PostCard(post);
          },
          itemCount: _posts.length,
        ),
      ),
    );
  }
}
