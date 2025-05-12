import 'package:flutter/cupertino.dart';

class Utils {
  static Future showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) => showCupertinoModalPopup(
    useRootNavigator: false,
    context: context,
    builder:
        (context) => CupertinoActionSheet(
          actions: [child],
          cancelButton: CupertinoActionSheetAction(
            onPressed: onClicked,
            child: const Text('Select'),
          ),
        ),
  );
  static bool scrollNotifier(Object? notification, VoidCallback callback) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;

      if (before == max) callback();
    }
    return false;
  }
  // static void showSnackBar(String text) {
  //   final snackBar = SnackBar(
  //     content: Text(text),
  //     behavior: SnackBarBehavior.floating,
  //   );

  // Keys.messangerKey.currentState!
  //   ..removeCurrentSnackBar()
  //   ..showSnackBar(snackBar);

  static bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);

    return regExp.hasMatch(email);
  }

  static bool isPhone(String input) {
    return RegExp(
      r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
    ).hasMatch(input);
  }
}
