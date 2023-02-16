import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/model/patientRecord.dart';
import 'package:mapd722_gp1_project/model/response.dart';

import '../../framework.dart';
import '../../model/patient.dart';
import '../../routes.dart';
import '../../view_model/screen/view_patient_records_view_model.dart';
import '../widget/appBar.dart';

class ViewPatientRecordsView extends StatefulWidget {
  const ViewPatientRecordsView({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<ViewPatientRecordsView> createState() => ViewPatientRecordsViewState();
}

class ViewPatientRecordsViewState
    extends BaseMVVMState<ViewPatientRecordsView, ViewPatientRecordsViewModel> {
  @override
  Widget buildChild(ctx, ViewPatientRecordsViewModel vm) {
    vm.patient = ModalRoute.of(ctx)!.settings.arguments as Patient;

    return Scaffold(
        appBar: appBar(
          "${vm.patient.id} ${vm.patient.firstname} ${vm.patient.lastname}",
          "Medical Records",
          [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, Routes.home),
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
        body: FutureBuilder(
          future: vm.getPatientRecords(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var response = snapshot.data as ListResponse;
              return ListView.builder(
                  itemCount: response.list!.length,
                  itemBuilder: (context, index) {
                    // todo
                    var record = PatientRecord.fromJson(response.list![index]);
                    return Text(
                        "${record.id} ${record.critical} ${record.category}");
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  @override
  ViewPatientRecordsViewModel buildViewModel() {
    return ViewPatientRecordsViewModel();
  }
}
