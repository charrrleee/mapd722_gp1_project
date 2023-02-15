import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../model/patient.dart';
import '../../routes.dart';
import '../../view_model/screen/view_patients_view_model.dart';
import '../widget/appBar.dart';

class ViewPatientsView extends StatefulWidget {
  const ViewPatientsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ViewPatientsView> createState() => ViewPatientsViewState();
}

class ViewPatientsViewState
    extends BaseMVVMState<ViewPatientsView, ViewPatientsViewModel> {
  @override
  Widget buildChild(ctx, ViewPatientsViewModel vm) {
    vm.patients = ModalRoute.of(ctx)!.settings.arguments as List<Patient>;

    return Scaffold(
      appBar: appBar(
        "Patient Clinical Data",
        "View All Patients",
        [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.home),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.addPatient),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(children: [
        // SearchBar(),
        Expanded(
            child: ListView.builder(
          itemCount: vm.patients.length,
          itemBuilder: (context, index) {
            var patient = vm.patients[index];
            return ListTile(
              title: Text(
                "${patient.bedNumber} ${patient.firstname} ${patient.lastname}",
                style: const TextStyle(fontSize: 20),
              ),
              onTap: () => Navigator.pushNamed(
                context,
                Routes.viewPatient,
                arguments: vm.patients[index],
              ),
            );
          },
        ))
      ]),
    );
  }

  @override
  ViewPatientsViewModel buildViewModel() {
    return ViewPatientsViewModel();
  }
}
