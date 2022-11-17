import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:frontend/pages/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/login": (context) => const Login(),
          "/app": (context) => const App(),
        },
        initialRoute: "/login");
  }
}
