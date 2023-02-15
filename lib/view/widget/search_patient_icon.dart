import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/model/response.dart';

import '../../routes.dart';
import '../../service/patientService.dart';

IconButton searchPatientIcon(BuildContext context) {
  return IconButton(
    onPressed: () {
      showSearch(
        context: context,
        delegate: MySearchDelegate(),
      );
    },
    icon: const Icon(Icons.search),
  );
}

class MySearchDelegate extends SearchDelegate with ChangeNotifier {
  List<String> recommendList = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, recommendList);
          } else {
            query = "";
          }
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, recommendList),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: FutureBuilder(
          future: PatientService().fetch(),
          builder: (context, snapshot) {
            print(
                "${snapshot.connectionState} ${snapshot.hasData} ${snapshot.data}");
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              var response = snapshot.data as ListResponse;
              // recommendList = response.list!.map((e) => e.firstname).toList();
              return Text(
                query,
                style:
                    const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = recommendList.where((element) {
      final String result = element.toLowerCase();
      final String input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return FutureBuilder(
        future: PatientService().fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            var response = snapshot.data as ListResponse;
            // todo recommendList should be Patient Object;
            recommendList =
                response.list!.map((e) => "${e['bedNumber']} ${e["firstName"]} ${e["lastName"]}").toList();
          }
          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              return ListTile(
                title: Text(suggestion),
                // todo handle tap action
                onTap: () {
                  query = suggestion;
                  // todo handle patient
                  Navigator.pushNamed(
                    context,
                    Routes.viewPatient,
                    arguments: {"patientId", "1"},
                  );
                },
              );
            },
          );
        });
  }
}
