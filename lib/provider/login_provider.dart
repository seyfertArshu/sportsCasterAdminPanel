import 'dart:ffi';

import 'package:agriappadmin/model/login_model.dart';
import 'package:agriappadmin/screen/NBHomeScreen.dart';
import 'package:agriappadmin/screen/NBSignInScreen.dart';
import 'package:agriappadmin/services/helpers/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

//

  bool _firstTime = true;
  bool get firstTime => _firstTime;

  set firstTime(bool newState) {
    _firstTime = newState;
    notifyListeners();
  }

  //entry point
  bool? _entrypoint;
  bool get entrypoint => _entrypoint ?? false;

  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  //
  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  //
  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    entrypoint = prefs.getBool('entrypoint') ?? false;
    loggedIn = prefs.getBool('loggedIn') ?? false;
  }

  final loginFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = loginFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  //
  userLogin(LoginModel model) {
    AuthHelper.login(model).then((response) {
      log(response);  
      if (response && firstTime) {
        Get.off(() => NBHomeScreen());
      } else if (response && !firstTime) {
        Get.off(() => NBHomeScreen());
      } else if (!response) {
        Get.snackbar("Sign Failed", "Check Your Credential",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  //logout
  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.remove('token');
    _firstTime = false;
    Get.offAll(NBSignInScreen());
  }
}
