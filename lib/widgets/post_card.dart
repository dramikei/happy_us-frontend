import 'package:easy_container/easy_container.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/post.getx.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/repository/post_repo.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PostCard extends StatefulWidget {
  static const id = 'PostCard';

  final Post post;
  final bool openedFromDialog;
  final bool isCreator;
  final VoidCallback? onDeleteTap;

  PostCard(
    this.post, {
    Key? key,
    this.openedFromDialog = false,
    this.onDeleteTap,
    this.isCreator = false,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool isLiked;

  @override
  void initState() {
    isLiked = Globals.isLoggedIn
        ? Get.find<PostController>().isLiked(
            postId: widget.post.id,
            userId: Globals.userId!,
          )
        : false;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostController>();
    return EasyContainer(
      margin: 0,
      borderRadius: 10,
      height: widget.openedFromDialog ? null : 300,
      padding: 0,
      elevation: 10,
      color: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: kFocusColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      zeroDownElevationOnTap: false,
      alignment: null,
      onTap: widget.openedFromDialog
          ? null
          : () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(kIsWeb ? 100 : 30),
                        child: SizedBox(
                          height: kIsWeb ? 1000 : 450,
                          child: PostCard(
                            this.widget.post,
                            openedFromDialog: true,
                          ),
                        ),
                      ),
                    );
                  });
              setState(() {});
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      widget.post.heading,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 21,
                        color: Colors.white,
                      ),
                      overflow: widget.openedFromDialog
                          ? null
                          : TextOverflow.ellipsis,
                      maxLines: widget.openedFromDialog ? null : 1,
                    ),
                    if (Globals.isLoggedIn && widget.isCreator)
                      GestureDetector(
                        onTap: widget.onDeleteTap,
                        child: Icon(
                          Icons.delete,
                          size: 25,
                          color: kAccentColor,
                        ),
                      ),
                  ],
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
                    child: widget.openedFromDialog
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
                          widget.post.timeAgo,
                          style: TextStyle(
                            fontSize: 14,
                            color: kFocusColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      CustomText(
                        widget.post.likedBy.length.toString(),
                        style: TextStyle(),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => likePost(controller),
                        child: Icon(
                          Globals.isLoggedIn
                              ? controller.isLiked(
                                      postId: widget.post.id,
                                      userId: Globals.userId!)
                                  ? Icons.favorite
                                  : Icons.favorite_border
                              : Icons.favorite_border,
                          size: 25,
                          color: kFocusColor,
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

  void likePost(PostController controller) async {
    if (!Globals.isLoggedIn) {
      NavigationService.push(context, path: NavigationService.loginPath);
    } else {
      bool isLiked =
          controller.isLiked(postId: widget.post.id, userId: Globals.userId!);

      controller.updateLike(
          postId: widget.post.id,
          userId: Globals.userId!,
          event: isLiked ? UpdateCountEvent.remove : UpdateCountEvent.add);
      isLiked = !isLiked;
      setState(() {});
      await PostRepo.updateLikeCount(
          postId: widget.post.id,
          event: !isLiked ? UpdateCountEvent.remove : UpdateCountEvent.add);
    }
  }

  Widget _content() {
    return widget.openedFromDialog
        ? Linkify(
            onOpen: (link) async {
              if (await canLaunch(link.url))
                await launch(link.url);
              else
                AlertsService.error("Can't launch link");
            },
            text: widget.post.content,
            style: TextStyle(fontSize: 16),
            linkStyle: TextStyle(color: kFocusColor),
          )
        : CustomText(
            widget.post.content,
            style: TextStyle(fontSize: 16),
            overflow: widget.openedFromDialog ? null : TextOverflow.ellipsis,
            maxLines: widget.openedFromDialog ? null : 8,
          );
  }
}
