import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/model/response.dart';

import '../../framework.dart';
import '../../model/patient.dart';
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildChild(ctx, AddPatientViewModel vm) {
    return Scaffold(
        appBar: appBar(
          "Add Patient",
          "",
          [],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 32),
            child: Container(
                padding: EdgeInsets.only(top: 16),
                color: Colors.grey[200],
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text("Add Patient")]),
                        Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, Routes.home),
                          icon: const Icon(Icons.home),
                        ),
                        IconButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              vm.savePatient().then((response) {
                                if (response!.success) {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.viewPatient,
                                    arguments: Patient.fromJson(response.data!),
                                  );
                                }
                              });
                            }
                          },
                          icon: const Icon(Icons.save),
                        )
                      ])),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          Row(
                            children: [
                              Text("First Name"),
                              customTextField("First Name", "",
                                  vm.onChangeFirstName, vm.validateEmptyOrNull),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Last Name"),
                              customTextField("Last Name", "",
                                  vm.onChangeLastName, vm.validateEmptyOrNull),
                            ],
                          ),
                          Row(
                            children: [
                              Text("ID Card Number"),
                              customTextField("", "", vm.onChangeIdNumber,
                                  vm.validateEmptyOrNull),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Height"),
                              customTextField(
                                  "", "", vm.onChangeHeight, vm.validateHeight),
                              Text("(cm)"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Weight"),
                              customTextField(
                                  "", "", vm.onChangeWeight, vm.validateWeight),
                              Text("kg"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Bed Number"),
                              customTextField("", "", vm.onChangeBedNumber,
                                  vm.validateEmptyOrNull),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Gender"),
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Text("Male"),
                              ),
                              Switch(
                                // This bool value toggles the switch.

                                value: vm.gender == "Female" ? true : false,
                                activeColor: Colors.red,
                                inactiveTrackColor: Colors.blue,
                                onChanged: (bool value) {
                                  vm.onChangeGender(value ? "Female" : "Male");
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: Text("Female"),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Phone Number"),
                              customTextField("", "", vm.onChangePhoneNumber,
                                  vm.validatePhone),
                            ],
                          ),
                          Row(
                            children: [
                             Text("Date of Birth"),
                              const Spacer(),
                              CupertinoButton(
                                onPressed: () => _showDialog(
                                  CupertinoDatePicker(
                                    backgroundColor: Color.fromRGBO(200, 200, 200, 1),
                                      initialDateTime: vm.dateOfBirth,
                                      mode: CupertinoDatePickerMode.date,
                                      use24hFormat: true,
                                      onDateTimeChanged: vm.onChangeDOB),
                                ),
                                child: Text(
                                  vm.dateOfBirth
                                      .toIso8601String()
                                      .substring(0, 10),
                                  style: const TextStyle(
                                      fontSize: 22.0, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("Email"),
                              customTextField(
                                  "", "", vm.onChangeEmail, vm.validateEmail)
                            ],
                          ),
                          Row(
                            children: [
                              Text("Address"),
                              customTextField("", "", vm.onChangeAddress,
                                  vm.validateEmptyOrNull),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Postal Code"),
                              customTextField("", "", vm.onChangePostalCode,
                                  vm.validateEmptyOrNull),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Image Url"),
                              customTextField("", "", vm.onChangeImageURL,
                                  vm.validateEmptyOrNull)
                            ],
                          ),
                        ]),
                      ))
                ]))));
  }

  @override
  AddPatientViewModel buildViewModel() {
    return AddPatientViewModel();
  }
}
