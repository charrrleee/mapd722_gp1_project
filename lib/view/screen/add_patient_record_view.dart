import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/view/screen/home_view.dart';
import 'package:mapd722_gp1_project/view/widget/text.dart';

import '../../framework.dart';
import '../../model/patient.dart';
import '../../routes.dart';
import '../../view_model/screen/add_patient_record_view_model.dart';
import '../widget/app_bar.dart';
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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget buildChild(ctx, AddPatientRecordViewModel vm) {
    vm.patient = ModalRoute.of(ctx)!.settings.arguments as Patient;

    return Scaffold(
        appBar: appBar(
          "Medical Record",
          "",
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
                          Text(
                              "${vm.patient.bedNumber} - ${vm.patient.firstname} ${vm.patient.lastname}"),
                          Text("Add Medical Record"),
                        ]),
                    Spacer(),
                    IconButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, Routes.home),
                      icon: const Icon(Icons.home),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var response = await vm.savePatientRecord();
                          if (!mounted) return;
                          if (response) {
                            Navigator.pushNamed(
                              context,
                              Routes.viewPatientRecords,
                              arguments: vm.patient,
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.save),
                    )
                  ])),
              Form(
                  key: _formKey,
                  child: Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(children: [
                      Row(
                        children: [
                          const Text("Record Date"),
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
                              ),
                            ),
                          ),
                        ],
                      ),
                      textFieldStyleWidget(
                        "Blood Pressure",
                        Row(
                          children: [
                            customTextField("Upper(mmHg)", "",
                                vm.onChangeBloodPressureUpper, vm.validateBP),
                            customTextField("Lower(mmHg)", "",
                                vm.onChangeBloodPressureLower, vm.validateBP)
                          ],
                        ),
                      ),
                      textFieldStyleWidget(
                        "Respiratory Rate",
                        Row(
                          children: [
                            customTextField("rate(/min)", "",
                                vm.onChangeRespiratoryRate, vm.validateRR),
                          ],
                        ),
                      ),
                      textFieldStyleWidget(
                        "Blood Oxygen Level",
                        Row(
                          children: [
                            customTextField("level(%)", "",
                                vm.onChangeBloodOxygenLevel, vm.validateBO),
                          ],
                        ),
                      ),
                      textFieldStyleWidget(
                        "Heartbeat Rate",
                        Row(
                          children: [
                            customTextField("rate(/min)", "",
                                vm.onChangeHeartBeatRate, vm.validateHBR),
                          ],
                        ),
                      ),
                      customTextField("Nurse", "", vm.onChangeNurseName,
                          vm.validateEmptyOrNull)
                    ]),
                  )))
            ])));
  }

  @override
  AddPatientRecordViewModel buildViewModel() {
    return AddPatientRecordViewModel();
  }
}
