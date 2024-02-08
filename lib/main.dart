import 'package:beyond_vision/provider/date_provider.dart';
import 'package:beyond_vision/ui/home/home.dart';
import 'package:beyond_vision/ui/login/google_login.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(ChangeNotifierProvider(
      create: (context) => DateProvider(), child: MyApp())));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routes = {HomePage: (context) => const HomePage()};

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beyond Vision',
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!);
      },
    );
  }
}
