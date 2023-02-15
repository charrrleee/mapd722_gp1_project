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
              vm.savePatient().then((response) {
                if (response!.success) {
                  Navigator.pushNamed(
                    context,
                    Routes.viewPatient,
                    arguments: Patient.fromJson(response.data!),
                  );
                }
              });
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
              vm.onChangeFirstName,
            ),
            customTextField(
              "Last Name",
              "",
              vm.onChangeLastName,
            ),
          ],
        ),
        Row(
          children: [
            customTextField(
              "ID Card Number",
              "",
              vm.onChangeIdCardNumber,
            ),
            customTextField(
              "Bed Number",
              "",
              vm.onChangeBedNumber,
            ),
          ],
        ),
        Row(
          children: [
            customTextField(
              "Phone Number",
              "",
              vm.onChangePhoneNumber,
            ),
            customTextField(
              "Gender",
              "",
              vm.onChangeGender,
            ),
          ],
        ),
        Row(
          children: [
            customTextField(
              "Height (cm)",
              "",
              vm.onChangeHeight,
            ),
            customTextField(
              "Weight (kg)",
              "",
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
            )
          ],
        ),
        Row(
          children: [
            customTextField(
              "Email",
              "",
              vm.onChangeEmail,
            )
          ],
        ),
        Row(
          children: [
            customTextField(
              "Address",
              "",
              vm.onChangeAddress,
            ),
            customTextField(
              "Postal Code",
              "",
              vm.onChangePostalCode,
            ),
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
