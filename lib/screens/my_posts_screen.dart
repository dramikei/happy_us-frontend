import 'package:flutter/material.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/post_card.dart';
import 'package:happy_us/widgets/responsive_grid_view.dart';

class MyPostsScreen extends StatelessWidget {
  static const id = 'MyPostsScreen';

  const MyPostsScreen({
    Key? key,
  }) : super(key: key);

  static final __posts = [
    Post.fromJson({
      '_id': '#1',
      'heading': 'My Dead Brother Comes to America',
      'content': '''
The narrator recounts the foggy winter day his family arrived at Ellis Island. There was a crowd waiting for the passengers to disembark. People called out to their family members. He heard a shout calling his mother's name. It was his father. The family hasn't seen him in years. He went ahead of them to America. Now, he's waiting to see his wife and four children again.
''',
      'creatorId': '',
      'time': '2021-06-09 00:00:00.000',
      'likedBy': ['11', '22'],
    }),
    Post.fromJson({
      '_id': '#2',
      'heading': 'Redemption',
      'content': '''
On a spring day, Jack Hawthorne accidentally runs over and kills his younger brother, David, with a tractor. His father is nearly destroyed by it and turns to smoking and women to survive. His mother is sapped by grief. She gets comfort from food and her friends. While no one blames Jack for the tragedy, he takes it badly, replaying the accident in his mind and viewing himself as evil.
''',
      'creatorId': '',
      'time': '2021-06-04 00:00:00.000',
      'likedBy': ['44'],
    }),
  ];

  static final posts = [
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
        appBar: AppBar(title: CustomText('My Posts')),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: ResponsiveGridList(
            padding: const EdgeInsets.symmetric(vertical: 35),
            minSpacing: 50,
            desiredItemWidth: isSmallScreen ? 270 : 350,
            children: List.generate(
              posts.length,
              (index) {
                final post = posts[index];
                return PostCard(post);
              },
            ),
          ),
        ),
      ),
    );
  }
}
