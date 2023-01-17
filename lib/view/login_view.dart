import 'package:flutter/material.dart';

import '../framework.dart';
import '../view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends BaseMVVMState<LoginView, LoginViewModel> {
  @override
  Widget buildChild(ctx, LoginViewModel vm) {
    return Column(
      children: [
        Row(
          children: [
            const Text("Username"),
            Expanded(
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
            ),
          ],
        ),
        Row(
          children: [
            const Text("Password"),
            Expanded(
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  labelText: "Username",
                  border: const OutlineInputBorder(),
                  hintText: vm.username.toString(),
                ),
                // validator: (v) => vm.validateNumbersOfHour(v),
                onChanged: vm.onChangePassword,
                // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: vm.login,
          child: const Text("Login"),
        ),
      ],
    );
  }

  @override
  LoginViewModel buildViewModel() {
    return LoginViewModel();
  }
}
