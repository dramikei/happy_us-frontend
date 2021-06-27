import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/post.getx.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/repository/post_repo.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/no_data.dart';
import 'package:happy_us/widgets/post_card.dart';
import 'package:happy_us/widgets/custom_text.dart';

class FeedsPage extends StatefulWidget {
  static const id = 'FeedsPage';

  const FeedsPage({
    Key? key,
  }) : super(key: key);

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  late Future<List<Post>?> _posts;

  @override
  void initState() {
    _posts = PostRepo.getAllPost();
    super.initState();
  }

  Future<void> refreshPage() async {
    _posts = PostRepo.getAllPost();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final postController = Get.find<PostController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FittedBox(
              child: CustomText(
                "Show some love",
                style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.87)
                          : null,
                    ),
                maxLines: 2,
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: FutureBuilder<List<Post>?>(
            future: _posts,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                postController.insertPosts(snapshot.data!);

                return snapshot.data!.length > 0
                    ? ListView.separated(
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (__, _) => SizedBox(
                              height: 40,
                            ),
                        padding: const EdgeInsets.fromLTRB(35, 35, 35, 85),
                        itemCount: postController.posts.length,
                        itemBuilder: (ctx, index) {
                          final post = postController.posts[index];
                          return PostCard(
                            post,
                            isCreator: false,
                          );
                        })
                    : NoData();
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
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
        NavigationService.push(context,
            path: NavigationService.createPostPath,
            args: {'refreshPage': refreshPage});
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
