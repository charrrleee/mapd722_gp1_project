import 'package:flutter/cupertino.dart';
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
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

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
              vm.updatePatient().then((value) {
                if (value == false) {
                  return;
                }
                Navigator.pushNamed(
                  context,
                  Routes.viewPatient,
                  arguments: vm.patient,
                );
              });
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
                "First Name",
                vm.patient.firstname,
                vm.onChangeFirstName,
              ),
              customTextField(
                "Last Name",
                vm.patient.lastname,
                vm.onChangeLastName,
              ),
            ],
          ),
          Row(
            children: [
              customTextField(
                "Height (cm)",
                vm.patient.height.toString(),
                vm.onChangeHeight,
              ),
              customTextField(
                "Weight (kg)",
                vm.patient.weight.toString(),
                vm.onChangeWeight,
              ),
            ],
          ),
          Row(
            children: [
              const Text("Date of Birth",
                  style: TextStyle(fontSize: 25.0, color: Colors.black)),
              const Spacer(),
              CupertinoButton(
                onPressed: () => _showDialog(
                  CupertinoDatePicker(
                    initialDateTime: vm.patient.dateOfBirth,
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    onDateTimeChanged: vm.onDateTimeChanged,
                  ),
                ),
                child: Text(
                  vm.patient.dateOfBirth.toIso8601String().substring(0, 10),
                  style: const TextStyle(fontSize: 22.0, color: Colors.black),
                ),
              )
            ],
          ),
          customTextField(
            "Image Url",
            vm.patient.imgURL,
            vm.onChangeImageUrl,
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
