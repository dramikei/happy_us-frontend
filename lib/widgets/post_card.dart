import 'package:easy_container/easy_container.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/post.getx.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/repository/post_repo.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/utils/constants.dart';

class PostCard extends GetView<PostController> {
  static const id = 'PostCard';

  final String postId;
  final bool openedFromDialog;
  late Post post;

  PostCard(
    this.postId, {
    Key? key,
    this.openedFromDialog = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    post = controller.posts.firstWhere((element) => element.id == postId);
    print(post.likedBy);
    return EasyContainer(
      margin: 0,
      borderRadius: 10,
      height: openedFromDialog ? null : 300,
      padding: 0,
      elevation: 10,
      color: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: kFocusColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      zeroDownElevationOnTap: false,
      alignment: null,
      onTap: openedFromDialog
          ? null
          : () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(kIsWeb ? 100 : 30),
                        child: SizedBox(
                          height: kIsWeb ? 1000 : 450,
                          child: PostCard(this.postId, openedFromDialog: true),
                        ),
                      ),
                    );
                  });
            },
      onDoubleTap: () {
        print("double tap to like?");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Material(
              color: kFocusColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomText(
                  post.heading,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  overflow: openedFromDialog ? null : TextOverflow.ellipsis,
                  maxLines: openedFromDialog ? null : 1,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: openedFromDialog
                        ? SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: _content(),
                          )
                        : _content(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          post.timeAgo,
                          style: TextStyle(
                            fontSize: 14,
                            color: kFocusColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      CustomText(
                        post.likedBy.length.toString(),
                        style: TextStyle(),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () async {
                          if (!Globals.isLoggedIn) {
                            NavigationService.push(context,
                                path: NavigationService.loginPath);
                          } else {
                            final isLiked = controller.isLiked(
                                postId: post.id, userId: Globals.userId!);

                            final success = await PostRepo.updateLikeCount(
                                postId: post.id,
                                event: isLiked
                                    ? UpdateCountEvent.remove
                                    : UpdateCountEvent.add);

                            if (success == true) {
                              controller.updateLike(
                                  postId: post.id,
                                  userId: Globals.userId!,
                                  event: isLiked
                                      ? UpdateCountEvent.remove
                                      : UpdateCountEvent.add);
                            }
                          }
                        },
                        child: Obx(
                          () => Icon(
                            Globals.isLoggedIn
                                ? controller.isLiked(
                                        postId: post.id,
                                        userId: Globals.userId!)
                                    ? Icons.favorite
                                    : Icons.favorite_border
                                : Icons.favorite_border,
                            size: 25,
                            color: kFocusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content() {
    return CustomText(
      post.content,
      style: TextStyle(fontSize: 18),
      overflow: openedFromDialog ? null : TextOverflow.ellipsis,
      maxLines: openedFromDialog ? null : 8,
    );
  }
}
