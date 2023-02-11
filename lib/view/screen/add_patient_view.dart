import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../routes.dart';
import '../../view_model/screen/add_patient_view_model.dart';
import '../widget/appBar.dart';
import '../widget/textfield.dart';

class AddPatientView extends StatefulWidget {
  const AddPatientView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AddPatientView> createState() => AddPatientViewState();
}

class AddPatientViewState
    extends BaseMVVMState<AddPatientView, AddPatientViewModel> {
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
  Widget buildChild(ctx, AddPatientViewModel vm) {
    return Scaffold(
      appBar: appBar(
        "Add Patient",
        "",
        [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.home),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              var success = vm.savePatient();
              if (success) {
                Navigator.pushNamed(
                  context,
                  Routes.viewPatient,
                  arguments: vm.patientId,
                );
              }
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Column(children: [
        Row(
          children: [
            customTextField(
              "First Name",
              "",
              (String? text) {},
            ),
            customTextField(
              "Last Name",
              "",
              (String? text) {},
            ),
          ],
        ),
        Row(
          children: [
            customTextField(
              "ID Card Number",
              "",
              (String? text) {},
            ),
            customTextField(
              "Bed Number",
              "",
              (String? text) {},
            ),
          ],
        ),
        Row(
          children: [
            customTextField(
              "Age",
              "",
              (String? text) {},
            ),
            customTextField(
              "Gender",
              "",
              (String? text) {},
            ),
          ],
        ),
        Row(
          children: [
            customTextField(
              "Height (cm)",
              "",
              (String? text) {},
            ),
            customTextField(
              "Weight (kg)",
              "",
              (String? text) {},
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
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    onDateTimeChanged: (DateTime? datetime) {}),
              ),
              child: Text(
                DateTime.now().toIso8601String().substring(0, 10),
                style: TextStyle(fontSize: 22.0, color: Colors.black),
              ),
            )
          ],
        ),
        Row(
          children: [
            customTextField(
              "Image Url",
              "",
              (String? text) {},
            )
          ],
        ),
        Row(
          children: [
            customTextField(
              "Phone Number",
              "",
              (String? text) {},
            )
          ],
        ),
        Row(
          children: [
            customTextField(
              "Email",
              "",
              (String? text) {},
            )
          ],
        ),
        Row(
          children: [
            customTextField(
              "Address",
              "",
              (String? text) {},
            )
          ],
        ),
      ]),
    );
  }

  @override
  AddPatientViewModel buildViewModel() {
    return AddPatientViewModel();
  }
}
