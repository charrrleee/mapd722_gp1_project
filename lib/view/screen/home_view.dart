import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/view/widget/appBar.dart';

import '../../framework.dart';
import '../../routes.dart';
import '../../view_model/screen/home_view_model.dart';
import '../widget/searchBar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends BaseMVVMState<HomeView, HomeViewModel> {
  @override
  Widget buildChild(ctx, HomeViewModel vm) {
    return Scaffold(
      appBar: appBar(
        "Patient Clinical Data",
        "Home Page - Welcome!",
        [],
      ),
      body: Column(
        children: [
          SearchBar(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.viewPatients);
            },
            child: const Text("View All Patient"),
          ),
          Expanded(
            child: ListView(
              children: const <Card>[],
            ),
          )
        ],
      ),
    );
  }

  @override
  HomeViewModel buildViewModel() {
    return HomeViewModel();
  }
}
