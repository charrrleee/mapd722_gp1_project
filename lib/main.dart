import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/routes.dart';
import 'package:mapd722_gp1_project/view/screen/home_view.dart';
import 'package:mapd722_gp1_project/view/screen/login_view.dart';
import 'package:mapd722_gp1_project/view/screen/view_patients_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(
        title: 'LoginView',
      ),
      routes: {
        Routes.home: (BuildContext context) =>
            const HomeView(title: "HomeView"),
        Routes.viewPatients: (BuildContext context) =>
            const ViewPatientsView(title: "ViewPatientsView"),
      },
    );
  }
}
