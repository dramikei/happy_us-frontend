import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/repository/post_repo.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/custom_text_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// ignore: must_be_immutable
class CreatePostScreen extends StatelessWidget {
  static const id = 'CreatePostScreen';
  final Future<void> Function() refreshPage;

  CreatePostScreen({
    Key? key,
    required this.refreshPage,
  }) : super(key: key);

  String? _heading;
  String? _content;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if ((_content?.trim().isNotEmpty ?? false) ||
            (_heading?.trim().isNotEmpty ?? false)) {
          Alert(
            context: context,
            style: AlertStyle(
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              titleStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              // animationType: AnimationType.fromTop
            ),
            title: "Are you sure you want to leave?",
            content: Text(
                "You will lose any entered content once you leave this screen"),
            buttons: [
              DialogButton(
                child: Text(
                  'Leave',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  NavigationService.pop(context);
                },
                color: Colors.red,
              ),
              DialogButton(
                child: Text(
                  'Stay',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                color: Colors.green,
              ),
            ],
          ).show();
          return false;
        } else
          return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? kFocusColor
                : Colors.transparent,
            elevation: 0,
            title: Text(
              "Create Post",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(7.5),
                child: ArgonButton(
                  height: 25,
                  width: 100,
                  color: kAccentColor,
                  borderRadius: 10,
                  child: Text("Post"),
                  onTap: (startLoading, stopLoading, btnState) async {
                    if (btnState == ButtonState.Idle) {
                      if (_heading == null ||
                          _heading!.length < 1 ||
                          _heading!.trim().isEmpty) {
                        AlertsService.error(
                            'Heading must be at least 1 character long!');
                        return;
                      }
                      if (_content == null ||
                          _content!.length <= 20 ||
                          _content!.trim().isEmpty) {
                        AlertsService.error(
                            'Content must be at least 20 characters long!');
                        return;
                      }

                      startLoading();
                      final post = await PostRepo.createPost(
                        userId: Globals.userId!,
                        content: _content!,
                        heading: _heading!,
                      );

                      if (post != null) {
                        AlertsService.success('Post created');
                        await refreshPage();
                        NavigationService.pop(context);
                      }
                      stopLoading();
                    }
                  },
                ),
              ),
            ],
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            children: [
              CustomTextField(
                maxLength: 20,
                hintText: "Add a content heading",
                color: Colors.transparent,
                maxLines: 2,
                autofocus: true,
                contentPadding: EdgeInsets.all(10),
                onChanged: (v) => _heading = v,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                maxLines: 10,
                hintText: "Add post content",
                color: Colors.transparent,
                contentPadding: EdgeInsets.all(10),
                onChanged: (v) => _content = v,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
