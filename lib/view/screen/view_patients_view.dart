import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../model/patient.dart';
import '../../routes.dart';
import '../../view_model/screen/view_patients_view_model.dart';
import '../widget/appBar.dart';

import '../widget/search_patient_icon.dart';
import '../widget/text.dart';
import '../widget/textfield.dart';

class ViewPatientsView extends StatefulWidget {
  const ViewPatientsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ViewPatientsView> createState() => ViewPatientsViewState();
}

class ViewPatientsViewState
    extends BaseMVVMState<ViewPatientsView, ViewPatientsViewModel> {
  List<Patient> patients = [];
  bool isInit = false;

  void onSearch(ViewPatientsViewModel vm, value) {
    vm.filterPatient(value);
    setState(() {
      patients =
          vm.patients.where((p) => vm.patientHidden[p.id] != true).toList();
    });
  }

  @override
  Widget buildChild(ctx, ViewPatientsViewModel vm) {
    vm.patients = ModalRoute.of(ctx)!.settings.arguments as List<Patient>;
    if (isInit == false) {
      Future.delayed(Duration.zero, () async {
        setState(() {
          patients = vm.patients;
          isInit = true;
        });
      });
    }
    return Scaffold(
        appBar: appBar(
          "Patient Clinical Data",
          "View All Patients",
          [],
        ),
        body: Container(
            padding: EdgeInsets.only(top: 16),
            color: Colors.grey[200],
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Patient Clinical Data"),
                          Text("View All Patients"),
                        ]),
                    Spacer(),
                    IconButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, Routes.home),
                      icon: const Icon(Icons.home),
                    ),
                    IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.addPatient),
                      icon: const Icon(Icons.add),
                    )
                  ])),
              Row(children: [
                searchPatientIcon(ctx),
                customTextField("Enter Name / Bed Number", "",
                    (value) => onSearch(vm, value), null),
              ]),

              // SearchBar(),
              Expanded(
                  child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  var patient = patients[index];
                  return ListTile(
                    title: Text(
                      "${patient.bedNumber} ${patient.firstname} ${patient.lastname}",
                    ),
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.viewPatient,
                      arguments: patients[index],
                    ),
                  );
                },
              ))
            ])));
  }

  @override
  ViewPatientsViewModel buildViewModel() {
    return ViewPatientsViewModel();
  }
}
