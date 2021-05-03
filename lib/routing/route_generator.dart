import 'package:flutter/material.dart';
import 'package:myapp/routing/appRoutes.dart';
import 'package:myapp/screens/MainBottomTabNavigationContent.dart';
import 'package:myapp/screens/ProductPage.dart';
import 'package:myapp/screens/SignInPage.dart';
import 'package:myapp/screens/SignUpPage.dart';

class RouteGenereator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    // print(args);
    switch (settings.name) {
      case AppRoutes.mainBottomTabNavigationContent:
        return MaterialPageRoute(
            builder: (context) => MainBottomTabNavigationContent());
        break;
      case AppRoutes.productPage:
        return MaterialPageRoute(builder: (context) => ProductPage(item: args));
        break;
      case AppRoutes.sign_in:
        return MaterialPageRoute(builder: (context) => SignInPage());
        break;
      case AppRoutes.sign_up:
        return MaterialPageRoute(builder: (context) => SignUpPage());
        break;
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('error'),
          ),
          body: Center(
            child: Text('error routung'),
          ),
        );
      },
    );
  }
}
