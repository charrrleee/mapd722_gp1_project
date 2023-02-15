import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/view/widget/appBar.dart';

import '../../framework.dart';
import '../../routes.dart';
import '../../view_model/screen/home_view_model.dart';
import '../widget/card.dart';
import '../widget/search_patient_icon.dart';

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
        [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.viewPatients),
            icon: const Icon(Icons.document_scanner),
          ),
          searchPatientIcon(ctx),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.addPatient),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: vm.patientMap.values.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: PatientCard(vm.patientMap.values.toList()[index]),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.viewPatient,
                    arguments: vm.patientMap.values.toList()[index],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel buildViewModel() {
    return HomeViewModel();
  }
}
