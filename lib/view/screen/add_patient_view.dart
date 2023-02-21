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
        [
          IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, Routes.home),
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
        ],
      ),
      body: Form(
      key: _formKey,
      child: Column(children: [
        Row(
          children: [
            customTextField(
              "First Name",
              "",
              vm.onChangeFirstName,
              vm.validateEmptyOrNull
            ),
            customTextField(
              "Last Name",
              "",
              vm.onChangeLastName,
              vm.validateEmptyOrNull
            ),
          ],
        ),
        Row(
          children: [
            customTextField(
              "ID Card Number",
              "",
              vm.onChangeIdCardNumber,
              vm.validateEmptyOrNull
            ),
            customTextField(
              "Bed Number",
              "",
              vm.onChangeBedNumber,
              vm.validateEmptyOrNull
            ),
          ],
        ),
        Row(
          children: [
            customTextField(
              "Phone Number",
              "",
              vm.onChangePhoneNumber,
              vm.validatePhone
            ),
            Padding(padding: const EdgeInsets.only(left: 6.0), child: Text("Male"),) ,
            Switch(
              // This bool value toggles the switch.
              
              value: vm.gender == "Female" ? true : false,
              activeColor: Colors.red,
              inactiveTrackColor: Colors.blue,
              onChanged: (bool value) {
               vm.onChangeGender(value ? "Female" : "Male");
              },
            ),
            Padding(padding: const EdgeInsets.only(right: 6.0), child: Text("Female"),) ,

          ],
        ),
        Row(
          children: [
            customTextField(
              "Height (cm)",
              "",
              vm.onChangeHeight,
              vm.validateHeight
            ),
            customTextField(
              "Weight (kg)",
              "",
              vm.onChangeWeight,
              vm.validateWeight
            ),
          ],
        ),
        Row(
          children: [
            const Padding( 
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Date of Birth",
                style: TextStyle(fontSize: 20.0, color: Colors.black))),
            const Spacer(),
            CupertinoButton(
              onPressed: () => _showDialog(
                CupertinoDatePicker(
                    initialDateTime: vm.dateOfBirth,
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    onDateTimeChanged: vm.onChangeDOB),
              ),
              child: Text(
                vm.dateOfBirth.toIso8601String().substring(0, 10),
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
              ),
            )
          ],
        ),
        Row(
          children: [
            customTextField(
              "Image Url",
              "",
              vm.onChangeImageURL,
              vm.validateEmptyOrNull
            )
          ],
        ),
        Row(
          children: [
            customTextField(
              "Email",
              "",
              vm.onChangeEmail,
              vm.validateEmail
            )
          ],
        ),
        Row(
          children: [
            customTextField(
              "Address",
              "",
              vm.onChangeAddress,
              vm.validateEmptyOrNull
            ),
            customTextField(
              "Postal Code",
              "",
              vm.onChangePostalCode,
              vm.validateEmptyOrNull
            ),
          ],
        ),
      ]),
      )
    );
  }

  @override
  AddPatientViewModel buildViewModel() {
    return AddPatientViewModel();
  }
}
