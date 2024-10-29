import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> push(Widget page) {
    if (navigatorKey.currentState!= null) {
      return navigatorKey.currentState!.push(CustomPageRoute(route: page));
    } else {
      throw Exception("Navigator key is not initialized yet.");
    }
  }

  static Future<dynamic> pushReplacement(Widget page) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pushReplacement(CustomPageRoute(route: page));
    } else {
      throw Exception("Navigator key is not initialized yet.");
    }
  }

  static void pop() {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pop();
    } else {
      throw Exception("Navigator key is not initialized yet.");
    }
  }

  static Future<dynamic> pushAndRemoveUntil(Widget page, bool Function(Route<dynamic>) predicate) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pushAndRemoveUntil(
        CustomPageRoute(route: page),
        predicate,
      );
    } else {
      throw Exception("Navigator key is not initialized yet.");
    }
  }

  static Future<dynamic> pushMaterialRoute(MaterialPageRoute route) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.push(route);
    } else {
      throw Exception("Navigator key is not initialized yet.");
    }
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget route;
  final AxisDirection direction;

  CustomPageRoute({required this.route, this.direction = AxisDirection.right})
      : super(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => route,
  );

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return FadeTransition(
      opacity: animation,
      child: route,
    );
  }
}