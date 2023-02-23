import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/model/patientRecord.dart';
import 'package:mapd722_gp1_project/model/patientRecordsGroup.dart';
import 'package:mapd722_gp1_project/model/response.dart';

import '../../framework.dart';
import '../../model/patient.dart';
import '../../routes.dart';
import '../../view_model/screen/view_patient_records_view_model.dart';
import '../widget/appBar.dart';
import '../widget/medicalRecordItem.dart';

import "package:collection/collection.dart";

class ViewPatientRecordsView extends StatefulWidget {
  const ViewPatientRecordsView({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<ViewPatientRecordsView> createState() => ViewPatientRecordsViewState();
}

class ViewPatientRecordsViewState
    extends BaseMVVMState<ViewPatientRecordsView, ViewPatientRecordsViewModel> {
  List<PatientRecordsGroup> patientRecordsGroup = [];
  bool isInitPatientRecordsGroup = false;
  Map<int, bool> expanded = {};
  @override
  Widget buildChild(ctx, ViewPatientRecordsViewModel vm) {
    vm.patient = ModalRoute.of(ctx)!.settings.arguments as Patient;
    patientRecordsGroup = vm.patientRecordsGroup;
    if (isInitPatientRecordsGroup == false) {
      print("init");
      vm.getPatientRecords().whenComplete(() {
        setState(() {
          patientRecordsGroup = vm.patientRecordsGroup;
          isInitPatientRecordsGroup = true;
        });
      });
    }
    return Scaffold(
        appBar: appBar(
          "${vm.patient.id} ${vm.patient.firstname} ${vm.patient.lastname}",
          "Medical Records",
          [
            IconButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, Routes.home),
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(
                  context, Routes.addPatientRecord,
                  arguments: vm.patient),
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, Routes.viewPatient,
                  arguments: vm.patient),
              icon: const Icon(Icons.remove_red_eye),
            )
          ],
        ),
        body: SingleChildScrollView(

            // this will make your body scrollable
            child: Container(
              margin: EdgeInsets.all(15),
                child: Column(children: [
          ExpansionPanelList(
              expansionCallback: (index, isExpanded) {
                setState(() {
                  expanded[index] = !isExpanded;
                });
              },
              animationDuration: Duration(milliseconds: 500),
              //animation duration while expanding/collapsing
              children: [
                for (int i = 0; i < vm.patientRecordsGroup.length; i++)
                  ExpansionPanel(
                      headerBuilder: (context, isOpen) {
                        return Container(
                            margin: EdgeInsets.zero,
                            color: vm.patientRecordsGroup[i].critical
                                ? Colors.red[300]
                                : Colors.grey[200],
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  () {
                                    String convertedDateTime =
                                        "${vm.patientRecordsGroup[i].modifyDate.year.toString()}-${vm.patientRecordsGroup[i].modifyDate.month.toString().padLeft(2, '0')}-${vm.patientRecordsGroup[i].modifyDate.day.toString().padLeft(2, '0')} ${vm.patientRecordsGroup[i].modifyDate.hour.toString().padLeft(2, '0')}:${vm.patientRecordsGroup[i].modifyDate.minute.toString().padLeft(2, '0')}";
                                    return convertedDateTime;
                                    //return recordsGroup.modifyDate.toString();
                                  }(),
                                  textAlign: TextAlign.left,
                                )));
                      },
                      body: MedicalRecordItem(vm.patientRecordsGroup[i]),
                      isExpanded: expanded[i] == true ? true : false),
              ]),

          /*ListView.builder(
                  itemCount: vm.patientRecordsGroup.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title:
                        
                            MedicalRecordItem(vm.patientRecordsGroup[index]));
                  })),*/
          Padding(
              padding: EdgeInsets.all(30),
              child: FilledButton(
                onPressed: () {
                  vm.getPatientRecords().whenComplete(() {
                    setState(() {
                      patientRecordsGroup = vm.patientRecordsGroup;
                    });
                  });
                },
                child: Text("Load More"),
              ))
        ]))));
  }

  @override
  ViewPatientRecordsViewModel buildViewModel() {
    return ViewPatientRecordsViewModel();
  }
}
