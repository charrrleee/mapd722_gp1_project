import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../routes.dart';
import '../../view_model/screen/edit_patient_view_model.dart';
import '../widget/appBar.dart';

class EditPatientView extends StatefulWidget {
  const EditPatientView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<EditPatientView> createState() => EditPatientViewState();
}

class EditPatientViewState
    extends BaseMVVMState<EditPatientView, EditPatientViewModel> {
  @override
  Widget buildChild(ctx, EditPatientViewModel vm) {
    return Scaffold(
      appBar: appBar(
        "${vm.patient.id} ${vm.patient.firstname} ${vm.patient.lastname}",
        "Patient Overview",
        [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.home),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              var success = vm.updatePatient();
              if (success) {
                Navigator.pushNamed(
                  context,
                  Routes.viewPatient,
                  arguments: {"patientId", vm.patient.id},
                );
              }
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: [
          // todo make the rows as reuse components
          Column(
            children: [
              // todo add image url component
              Row(
                children: [
                  const Text("name"),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: vm.patient.firstname,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Date of Birth"),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: vm.patient.lastname,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text("height"),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: vm.patient.dateOfBirth,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("weight"),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: vm.patient.height,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Image URL"),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: vm.patient.imgURL,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  EditPatientViewModel buildViewModel() {
    return EditPatientViewModel();
  }
}
