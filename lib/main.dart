import 'package:beyond_vision/provider/date_provider.dart';
import 'package:beyond_vision/service/date_service.dart';
import 'package:beyond_vision/ui/home/home.dart';
import 'package:beyond_vision/ui/login/google_login.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final routes = {HomePage: (context) => const HomePage()};
  DateService dateService = DateService();

  bool isLogined = false;

  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('loginDate') != null &&
        prefs.getBool('isLogined') != null) {
      if (dateService.compareDate(prefs.getString('loginDate')!)) {
        isLogined = prefs.getBool('isLogined')!;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
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
