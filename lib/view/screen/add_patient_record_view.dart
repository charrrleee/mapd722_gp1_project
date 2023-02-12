import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/view/widget/text.dart';

import '../../framework.dart';
import '../../routes.dart';
import '../../view_model/screen/add_patient_record_view_model.dart';
import '../widget/appBar.dart';
import '../widget/textfield.dart';

class AddPatientRecordView extends StatefulWidget {
  const AddPatientRecordView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AddPatientRecordView> createState() => AddPatientRecordViewState();
}

class AddPatientRecordViewState
    extends BaseMVVMState<AddPatientRecordView, AddPatientRecordViewModel> {
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
  Widget buildChild(ctx, AddPatientRecordViewModel vm) {
    return Scaffold(
      appBar: appBar(
        "Medical Record",
        "Add Medical Record",
        [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.home),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              var success = vm.savePatientRecord();
              if (success) {
                Navigator.pushNamed(
                  context,
                  Routes.viewPatientRecords,
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
            const Text("Record Date",
                style: TextStyle(fontSize: 25.0, color: Colors.black)),
            const Spacer(),
            Expanded(
                child: CupertinoButton(
              onPressed: () => _showDialog(
                CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.dateAndTime,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime? datetime) {},
                ),
              ),
              child: Text(
                DateTime.now().toIso8601String().toString(),
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
              ),
            ))
          ],
        ),
        textFieldStyleWidget(
          "Blood Pressure",
          Row(
            children: [
              customTextField(
                "Upper(mmHg)",
                "",
                (String? text) {},
              ),
              customTextField(
                "Lower(mmHg)",
                "",
                (String? text) {},
              )
            ],
          ),
        ),
        textFieldStyleWidget(
          "Respiratory Rate",
          Row(
            children: [
              customTextField(
                "rate(/min)",
                "",
                (String? text) {},
              ),
            ],
          ),
        ),
        textFieldStyleWidget(
          "Blood Oxygen Level",
          Row(
            children: [
              customTextField(
                "level(%)",
                "",
                (String? text) {},
              ),
            ],
          ),
        ),
        textFieldStyleWidget(
          "Heartbeat Rate",
          Row(
            children: [
              customTextField(
                "rate(/min)",
                "",
                (String? text) {},
              ),
            ],
          ),
        ),
        customTextField("Nurse", "", (String? text) {})
      ]),
    );
  }

  @override
  AddPatientRecordViewModel buildViewModel() {
    return AddPatientRecordViewModel();
  }
}
