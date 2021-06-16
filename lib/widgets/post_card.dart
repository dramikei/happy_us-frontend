import 'package:easy_container/easy_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/utils/constants.dart';

class PostCard extends StatelessWidget {
  static const id = 'PostCard';

  final Post post;
  final bool openedFromDialog;

  const PostCard(
    this.post, {
    Key? key,
    this.openedFromDialog = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          child: PostCard(this.post, openedFromDialog: true),
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
                child: Text(
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
                        child: Text(
                          post.timeAgo,
                          style: TextStyle(
                            fontSize: 14,
                            color: kFocusColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        post.likedBy.length.toString(),
                        style: TextStyle(),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          false ? Icons.favorite : Icons.favorite_border,
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

  Widget _content() {
    return Text(
      post.content,
      style: TextStyle(fontSize: 18),
      overflow: openedFromDialog ? null : TextOverflow.ellipsis,
      maxLines: openedFromDialog ? null : 8,
    );
  }
}
