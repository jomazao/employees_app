import 'package:employees_app/src/config/routes.dart';
import 'package:employees_app/src/config/themes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employees app',
      debugShowCheckedModeBanner: false,
      theme: Themes().ligthTheme,
      initialRoute: '/',
      routes: Routes.routes,
    );
  }
}
