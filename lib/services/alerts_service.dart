import 'package:flutter/material.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:overlay_support/overlay_support.dart';

class AlertsService {
  static Text _text(String message, {Color? color}) => Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: color),
      );

  static void success(String message) {
    showOverlay((context, t) {
      return Opacity(
        opacity: t,
        child: _IosStyleToast(message: message),
      );
    });
  }

  static void message(String message, {String? subtitle}) {
    showSimpleNotification(
      _text(message),
      background: kAccentColor,
      subtitle: subtitle == null ? null : Text(subtitle),
      position: NotificationPosition.bottom,
    );
  }

  static void error(String message) {
    showSimpleNotification(
      _text(message, color: Colors.white),
      background: Colors.red,
      position: NotificationPosition.bottom,
    );
  }
}

class _IosStyleToast extends StatelessWidget {
  final String message;

  const _IosStyleToast({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTextStyle(
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.black87,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    Text(message),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
