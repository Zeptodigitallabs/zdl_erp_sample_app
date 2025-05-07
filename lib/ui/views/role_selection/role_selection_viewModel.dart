import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/shared_prefs_key.dart';
import '../login/login_view.dart';

class RoleSelectionViewModel extends ChangeNotifier{
  String? _userType;
  String? get userType => _userType;

  selectedLoginType(String loginUserType, BuildContext ctx) async {
    await setLoginType(loginUserType: loginUserType);
    if (kDebugMode) {
      print("user===>$userType");
    }
    Navigator.push(
      ctx,
      MaterialPageRoute(
          builder: (context) =>  LoginView(userType: userType??'',)),
    );
  }

  Future<void> setLoginType ({String? loginUserType}) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyLoginUserType, loginUserType??'');
    _userType = prefs.getString(keyLoginUserType);
  }


}