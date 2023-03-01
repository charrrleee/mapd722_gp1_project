import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/view/widget/app_bar.dart';

import '../../framework.dart';
import '../../model/patient.dart';
import '../../routes.dart';
import '../../view_model/screen/home_view_model.dart';
import '../widget/card.dart';
import '../widget/search_patient_icon.dart';
import '../widget/text.dart';
import '../widget/textfield.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends BaseMVVMState<HomeView, HomeViewModel> {
  Map<String, Patient> _patientMap = {};
  bool isInit = false;
  void onSearch(HomeViewModel vm, value) {
    vm.filterPatient(value);
    setState(() {
      _patientMap = Map.from(vm.patientMap)
        ..removeWhere((k, v) => vm.patientHidden[k] == true);
    });
  }

  @override
  Widget buildChild(ctx, HomeViewModel vm) {
    if (isInit == false) {
      Future.delayed(Duration.zero, () async {
        setState(() {
          _patientMap = vm.patientMap;
          isInit = true;
        });
      });
    }

    return Scaffold(
      appBar: appBar(
        "Main Page",
        "",
        [],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16),
        color: Colors.grey[200],
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Patient Clinical Data"),
                    Text("Home Page - Welcome!"),

                    /* IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.addPatient),
                      icon: const Icon(Icons.add),
                    ),*/
                    Row(children: [
                      searchPatientIcon(ctx),
                      customTextField("Enter Name / Bed Number", "",
                          (value) => onSearch(vm, value), null),
                    ]),
                  ],
                )),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.viewPatients,
                  arguments: _patientMap.values.toList()),
              child: Text("View All Patients"),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _patientMap.values.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: PatientCard(_patientMap.values.toList()[index]),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.viewPatient,
                    arguments: _patientMap.values.toList()[index],
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
