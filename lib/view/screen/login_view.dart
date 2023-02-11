import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../routes.dart';
import '../../view_model/screen/login_view_model.dart';
import '../widget/appBar.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends BaseMVVMState<LoginView, LoginViewModel> {
  @override
  Widget buildChild(ctx, LoginViewModel vm) {
    return Scaffold(
      appBar: appBar("Login", "Welcome Back", []),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    // contentPadding: const EdgeInsets.all(20.0),
                    labelText: "Username",
                    border: const OutlineInputBorder(),
                    hintText: vm.username.toString(),
                  ),
                  // validator: (v) => vm.validateNumbersOfHour(v),
                  onChanged: vm.onChangeUsername,
                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              )),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20.0),
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                      hintText: vm.username.toString(),
                    ),
                    // validator: (v) => vm.validateNumbersOfHour(v),
                    onChanged: vm.onChangePassword,
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, Routes.home),
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }

  @override
  LoginViewModel buildViewModel() {
    return LoginViewModel();
  }
}
