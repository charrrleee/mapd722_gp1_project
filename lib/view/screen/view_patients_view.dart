import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../view_model/screen/view_patients_view_model.dart';
import '../widget/appBar.dart';
import '../widget/searchBar.dart';

class ViewPatientsView extends StatefulWidget {
  const ViewPatientsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ViewPatientsView> createState() => ViewPatientsViewState();
}

class ViewPatientsViewState
    extends BaseMVVMState<ViewPatientsView, ViewPatientsViewModel> {
  @override
  Widget buildChild(ctx, ViewPatientsViewModel vm) {
    return Scaffold(
      appBar: appBar(
        "Patient Clinical Data",
        "View All Patients",
        [],
      ),
      body: Column(children: [
        SearchBar(),
        ListView(
          children: vm.simplePatients
              .map(
                (e) => Row(children: [
                  Text(e.id),
                  Text(e.name),
                ]),
              )
              .toList(),
        )
      ]),
    );
  }

  @override
  ViewPatientsViewModel buildViewModel() {
    return ViewPatientsViewModel();
  }
}
