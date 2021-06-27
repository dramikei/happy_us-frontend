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
            .userPosts
            .removeWhere((element) => element.id == postId);
        if (Get.find<PostController>().userPosts.length == 0) {
          allDeleted = true;
        }
        setState(() {});
        AlertsService.success("Deleted Successfully");
      }
    }
  }

  @override
  Widget build(BuildContext context) {

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
                      Get.find<PostController>()
                          .insertUserPosts(snapshot.data ?? []);
                      return snapshot.data is List && snapshot.data!.length > 0
                          ? Obx(
                              () => ListView.separated(
                                physics: BouncingScrollPhysics(),
                                separatorBuilder: (__, _) => SizedBox(
                                  height: 40,
                                ),
                                padding: const EdgeInsets.all(35),
                                itemCount:
                                    Get.find<PostController>().userPosts.length,
                                itemBuilder: (ctx, index) {
                                  final post = Get.find<PostController>()
                                      .userPosts[index];
                                  return PostCard(
                                    post,
                                    isCreator: true,
                                    onDeleteTap: () => deletePost(post.id),
                                  );
                                },
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
