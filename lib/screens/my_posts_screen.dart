import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/post.getx.dart';
import 'package:happy_us/repository/post_repo.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/no_data.dart';
import 'package:happy_us/widgets/post_card.dart';
import 'package:happy_us/widgets/responsive_grid_view.dart';

class MyPostsScreen extends StatefulWidget {
  static const id = 'MyPostsScreen';

  const MyPostsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MyPostsScreenState createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  late Future<List<Post>?> _posts;
  bool allDeleted = false;

  @override
  void initState() {
    _posts = PostRepo.getUserPosts();
    super.initState();
  }

  void deletePost(String postId) async {
    if (!Globals.isLoggedIn) {
      NavigationService.push(context, path: NavigationService.loginPath);
    } else {
      final success = await PostRepo.removePost(
        postId: postId,
      );
      if (success == true) {
        Get.find<PostController>()
            .posts
            .removeWhere((element) => element.id == postId);
        if (Get.find<PostController>().posts.length == 0) {
          allDeleted = true;
        }
        setState(() {});
        AlertsService.success("Deleted Successfully");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen =
        MediaQuery.of(context).size.width < SMALL_SCREEN_WIDTH;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? kFocusColor
              : Colors.transparent,
          elevation: 0,
          title: CustomText('My Posts'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _posts = PostRepo.getUserPosts();
            setState(() {});
          },
          child: allDeleted
              ? NoData()
              : FutureBuilder<List<Post>?>(
                  future: _posts,
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return snapshot.data is List && snapshot.data!.length > 0
                          ? Obx(
                              () => ResponsiveGridList(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 35),
                                minSpacing: 50,
                                desiredItemWidth: isSmallScreen ? 270 : 350,
                                children: List.generate(
                                  Get.find<PostController>().posts.length,
                                  (index) {
                                    final post =
                                        Get.find<PostController>().posts[index];
                                    return PostCard(
                                      post,
                                      isCreator: true,
                                      onDeleteTap: () => deletePost(post.id),
                                    );
                                  },
                                ),
                              ),
                            )
                          : NoData();
                    } else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  },
                ),
        ),
      ),
    );
  }
}
