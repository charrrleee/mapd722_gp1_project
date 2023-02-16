import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/view/widget/text.dart';

import '../../framework.dart';
import '../../model/patient.dart';
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
    vm.patient = ModalRoute.of(ctx)!.settings.arguments as Patient;

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
            onPressed: () async {
              var response = await vm.savePatientRecord();
              if (!mounted) return;
              if (response) {
                Navigator.pushNamed(
                  context,
                  Routes.viewPatientRecords,
                  arguments: vm.patient,
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
            Expanded(
              child: CupertinoButton(
                onPressed: () => _showDialog(
                  CupertinoDatePicker(
                    initialDateTime: vm.recordDateTime,
                    mode: CupertinoDatePickerMode.dateAndTime,
                    use24hFormat: true,
                    onDateTimeChanged: vm.onChangeRecordDateTime,
                  ),
                ),
                child: Text(
                  () {
                    String convertedDateTime =
                        "${vm.recordDateTime.year.toString()}-${vm.recordDateTime.month.toString().padLeft(2, '0')}-${vm.recordDateTime.day.toString().padLeft(2, '0')} ${vm.recordDateTime.hour.toString().padLeft(2, '0')}:${vm.recordDateTime.minute.toString().padLeft(2, '0')}";
                    return convertedDateTime;
                  }(),
                  style: const TextStyle(fontSize: 22.0, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        textFieldStyleWidget(
          "Blood Pressure",
          Row(
            children: [
              customTextField(
                "Upper(mmHg)",
                "",
                vm.onChangeBloodPressureUpper,
              ),
              customTextField(
                "Lower(mmHg)",
                "",
                vm.onChangeBloodPressureLower,
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
                vm.onChangeRespiratoryRate,
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
                vm.onChangeBloodOxygenLevel,
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
                vm.onChangeHeartBeatRate,
              ),
            ],
          ),
        ),
        customTextField("Nurse", "", vm.onChangeNurseName)
      ]),
    );
  }

  @override
  AddPatientRecordViewModel buildViewModel() {
    return AddPatientRecordViewModel();
  }
}
