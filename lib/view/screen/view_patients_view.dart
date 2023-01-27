import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../routes.dart';
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
        [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.home),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.addPatient),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(children: [
        SearchBar(),
        Expanded(
          child: ListView(
            children: vm.simplePatients
                .map(
                  (e) => Row(children: [
                    Text(e.id),
                    Text(e.name),
                  ]),
                )
                .toList(),
          ),
        )
      ]),
    );
  }

  @override
  ViewPatientsViewModel buildViewModel() {
    return ViewPatientsViewModel();
  }
}
