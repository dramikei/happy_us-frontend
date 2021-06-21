import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/post_card.dart';
import 'package:happy_us/widgets/responsive_grid_view.dart';
import 'package:happy_us/widgets/custom_text.dart';

class FeedsPage extends StatelessWidget {
  static const id = 'FeedsPage';

  const FeedsPage({
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
            child: CustomText(
              "Show some love",
              style: Theme.of(context).appBarTheme.titleTextStyle,
              maxLines: 2,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 3));
          },
          child: ResponsiveGridList(
            padding: const EdgeInsets.symmetric(vertical: 35),
            minSpacing: 50,
            desiredItemWidth: isSmallScreen ? 270 : 350,
            children: List.generate(_posts.length, (index) {
              final post = _posts[index];
              return PostCard(post);
            }),
          ),
        ),
        floatingActionButton: _customFAB(context),
      ),
    );
  }

  Widget _customFAB(BuildContext context) {
    const text = "We know its difficult, but sharing can help";
    final onPressed = () {
      if (!Globals.isLoggedIn) {
        NavigationService.push(context, path: NavigationService.loginPath);
      } else {
        NavigationService.push(
          context,
          path: NavigationService.createPostPath,
        );
      }
    };
    if (kIsWeb)
      return FloatingActionButton.extended(
        icon: Icon(Icons.favorite, color: kFocusColor),
        label: CustomText(text),
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
