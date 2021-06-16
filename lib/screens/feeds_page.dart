import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/post_card.dart';
import 'package:happy_us/widgets/responsive_grid_view.dart';

class FeedsPage extends StatelessWidget {
  static const id = 'FeedsPage';

  const FeedsPage({
    Key? key,
  }) : super(key: key);

  static final __posts = [
    Post.fromJson({
      'id': '#1',
      'heading': 'Post1 heading' * 8,
      'content': 'Post 1 content' * 55,
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

  static final _posts = [
    ...__posts,
    ...__posts,
    ...__posts,
    ...__posts,
    ...__posts,
    ...__posts,
  ];

  @override
  Widget build(BuildContext context) {
    final isSmallScreen =
        MediaQuery.of(context).size.width < SMALL_SCREEN_WIDTH;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Show some love",
              style: TextStyle(fontSize: 35),
              maxLines: 2,
            ),
          ),
        ),
        body: ResponsiveGridList(
          padding: const EdgeInsets.symmetric(vertical: 35),
          minSpacing: 50,
          desiredItemWidth: isSmallScreen ? 270 : 350,
          children: List.generate(_posts.length, (index) {
            final post = _posts[index];
            return PostCard(post);
          }),
        ),
        floatingActionButton: _customFAB(),
      ),
    );
  }

  Widget _customFAB() {
    const text = "We know its difficult, but sharing can help";
    final onPressed = () {};
    if (kIsWeb)
      return FloatingActionButton.extended(
        icon: Icon(Icons.favorite, color: kFocusColor),
        label: Text(text),
        onPressed: onPressed,
      );
    else
      return FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: text,
        onPressed: onPressed,
      );
  }
}
