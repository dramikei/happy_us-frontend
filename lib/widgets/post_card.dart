import 'package:easy_container/easy_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/utils/constants.dart';

class PostCard extends StatelessWidget {
  static const id = 'PostCard';

  final Post post;

  const PostCard(
      this.post, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyContainer(
      margin: 0,
      borderRadius: 10,
      padding: 0,
      elevation: 10,
      color: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: kFocusColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      zeroDownElevationOnTap: false,
      alignment: null,
      onDoubleTap: () {
        print("double tap to like?");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  post.content,
                  style: TextStyle(fontSize: 16),
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
        ],
      ),
    );
  }
}
