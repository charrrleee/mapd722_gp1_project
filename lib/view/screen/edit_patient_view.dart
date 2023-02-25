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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildChild(ctx, EditPatientViewModel vm) {
    vm.patient = ModalRoute.of(ctx)!.settings.arguments as Patient;

    return Scaffold(
        appBar: appBar(
          "Edit Patient",
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
                          Text("Patient Overview"),
                        ]),
                    Spacer(),
                    IconButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, Routes.home),
                      icon: const Icon(Icons.home),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              
                              Center(
                                child: Image.network(vm.patient.imgURL),
                              ),
                              
                              Row(
                                children: [
                                  Text("First Name"),
                                  customTextField(
                                      "",
                                      vm.patient.firstname,
                                      vm.onChangeFirstName,
                                      vm.validateEmptyOrNull),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Last Name"),
                                  customTextField(
                                      "",
                                      vm.patient.lastname,
                                      vm.onChangeLastName,
                                      vm.validateEmptyOrNull),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Date of Birth"),
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
                                      vm.patient.dateOfBirth
                                          .toIso8601String()
                                          .substring(0, 10)
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Height"),
                                  customTextField(
                                      "",
                                      vm.patient.height.toString(),
                                      vm.onChangeHeight,
                                      vm.validateHeight),
                                  Text("cm"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Weight"),
                                  customTextField(
                                      "",
                                      vm.patient.weight.toString(),
                                      vm.onChangeWeight,
                                      vm.validateWeight),
                                  Text("(kg)"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Image Url"),
                                  customTextField(
                                      "",
                                      vm.patient.imgURL,
                                      vm.onChangeImageUrl,
                                      vm.validateEmptyOrNull),
                                ],
                              ),
                            ],
                          ))))
            ])));
  }

  @override
  EditPatientViewModel buildViewModel() {
    return EditPatientViewModel();
  }
}
