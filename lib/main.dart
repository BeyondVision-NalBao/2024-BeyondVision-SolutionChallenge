import 'package:beyond_vision/provider/date_provider.dart';
import 'package:beyond_vision/service/date_service.dart';
import 'package:beyond_vision/service/login_service.dart';
import 'package:beyond_vision/ui/home/home.dart';
import 'package:beyond_vision/ui/login/google_login.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(ChangeNotifierProvider(
      create: (context) => DateProvider(), child: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LoginService loginService = LoginService();
  bool isLogined = false;

  @override
  void initState() async {
    // TODO: implement initState
    isLogined = await loginService.checkLogin();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beyond Vision',
      home: isLogined ? const HomePage() : const LoginPage(),
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
