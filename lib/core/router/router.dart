import 'package:flutter/material.dart';

class NavigationManager {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static pushNamed(String nameScreen, {Object? arguments}) async =>
      await navigatorKey.currentState!
          .pushNamed(nameScreen, arguments: arguments);

  static pushNamedReplacement(
    String routeName, {
    Object? arguments,
  }) {
    navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static goToAndRemove(String routeName, {Object? argument}) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: argument);
  }

  static pop() {
    navigatorKey.currentState!.pop();
  }

  static mayPop() {
    navigatorKey.currentState!.maybePop();
  }

  static popUntil(String screenName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(screenName));
  }
}
