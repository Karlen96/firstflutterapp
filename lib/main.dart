import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:myapp/providers/cartProvider.dart';
import 'package:myapp/providers/categoryProvider.dart';
import 'package:myapp/providers/comboProvider.dart';
import 'package:myapp/providers/restorantsProvider.dart';
import 'package:myapp/routing/appRoutes.dart';
import 'package:myapp/routing/route_generator.dart';
import 'package:myapp/theme/theme.dart';
import 'package:provider/provider.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

void main() {
  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale('en', 'EN'),
        Locale('ru', 'RU'),
        Locale('am', 'AM'),
      ],
      path: "resources/langs",
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestorantsProvider>(
          create: (_) => RestorantsProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider<ComboProvider>(
          create: (_) => ComboProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider(),
        ),
      ],
      child: AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: AdaptiveThemeMode.light,
        builder: (light, dark) => MaterialApp(
          theme: light,
          darkTheme: dark,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'my app',
          initialRoute: AppRoutes.mainBottomTabNavigationContent,
          onGenerateRoute: RouteGenereator.generateRoute,
        ),
      ),
    );
  }
}
