import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../model/patient.dart';
import '../../routes.dart';
import '../../view_model/screen/edit_patient_view_model.dart';
import '../widget/appBar.dart';
import '../widget/textfield.dart';

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
    vm.patient = ModalRoute.of(ctx)!.settings.arguments as Patient;

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
          const SizedBox(height: 50),
          Center(
            child: Image.network(vm.patient.imgURL),
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              customTextField(
                  "First Name", vm.patient.firstname, vm.onChangeFirstName),
              customTextField(
                  "Last Name", vm.patient.lastname, vm.onChangeFirstName),
            ],
          ),
          Row(
            children: [
              customTextField(
                  "Date of Birth",
                  vm.patient.dateOfBirth.toIso8601String().substring(0, 10),
                  vm.onChangeFirstName),
            ],
          ),
          Row(
            children: [
              customTextField(
                  "Height", vm.patient.height.toString(), vm.onChangeFirstName),
              customTextField(
                  "Weight", vm.patient.weight.toString(), vm.onChangeFirstName),
            ],
          ),
        ],
      ),
    );
  }

  @override
  EditPatientViewModel buildViewModel() {
    return EditPatientViewModel();
  }
}
