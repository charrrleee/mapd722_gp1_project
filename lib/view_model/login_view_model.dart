import '../framework.dart';

class LoginViewModel extends BaseViewModel {
  String username = "";
  String password = "";

  String login() {
    if (["charlene", "gloria"].contains(username)) {
      return "Login Success";
    } else {
      return "Login fail";
    }
  }

  onChangeUsername(String text) {}

  onChangePassword(String text) {}
}
