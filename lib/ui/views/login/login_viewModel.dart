import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zdl_erp_sample_app/api/api_response.dart';
import 'package:zdl_erp_sample_app/utils/colors.dart';
import 'package:zdl_erp_sample_app/utils/strings.dart';

import '../../../models/config_vo.dart';
import '../../../models/user_vo.dart';
import '../../../utils/shared_prefs_key.dart';

class LoginViewModel extends ChangeNotifier {

  late bool _isObScureText = true;

  bool get isObScureText => _isObScureText;

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String _selectedSchool = zlerpAppName;

  String get selectedSchool => _selectedSchool;

  String _selectedSchoolBaseUrl = zlerpAppName;

  String get selectedSchoolBaseUrl => _selectedSchoolBaseUrl;

  final List<List<String>> schools = [
    [zlerpAppName, zlerpAppBaseUrl],
    [schoolerpAppName, schoolerpAppBaseUrl],
    [aksharaAppName, aksharaAppBaseUrl],
    [dseAppName, dseAppBaseUrl],
  ];

  Future<String> getSelectedSchool() async {
    return _selectedSchool;
  }

  void setSelectedSchool(String school, String appBaseUrl) async {
    _selectedSchool = school;
    _selectedSchoolBaseUrl = appBaseUrl;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyAppBaseUrl, appBaseUrl);
    String? appUrl = prefs.getString(keyAppBaseUrl);
    print("AppUrl===>$appUrl");
    notifyListeners();
  }

  onBackPressed(BuildContext context) async {
    Navigator.pop(context);
  }

  setObscureText(bool value) {
    _isObScureText = value;
    notifyListeners();
  }

  void authenticateUser(String name, String password, BuildContext context, String userType) async {
    if (name.isEmpty || password.isEmpty) {
      showDialog<String>(
        context: context,
        builder:
            (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: kcWhite,
              surfaceTintColor: kcWhite,
              title: Text(
                ksError,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kcBlack),
              ),
              content: Text(ksEmptyValidator),
              insetPadding: EdgeInsets.zero,
              actionsAlignment: MainAxisAlignment.end,
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcPrimary,
                    fixedSize: Size(80, 36),
                    //side: BorderSide(color: Colors.black,width: 1,style: BorderStyle.solid),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(ksOk, style: TextStyle(fontSize: 16, color: kcWhite)),
                ),
              ],
            ),
      );
    } else {
      String? token = '';
      if (!kIsWeb) {
        try {
          token = await FirebaseMessaging.instance.getToken();
        } catch (e) {
          if (kDebugMode) {
            print('e==>$e');
          }
        }
      }
      try {
        ConfigVo? configs = await APIResponse().getAppConfigs();
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(keyApiUrl, configs!.url ?? '');
        UserVo userVo = await APIResponse().authenticateUserAPI(token!, name, password, userType);
      }catch (exception) {
        if (kDebugMode) {
          print('exception-->${exception.toString()}');
        }
        await showDialog<String>(
          context: context,
          builder:
              (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: kcWhite,
            surfaceTintColor: kcWhite,
            title: Text(
              ksError,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kcBlack),
            ),
            content: Text(ksInvalidValidator),
            insetPadding: EdgeInsets.zero,
            actionsAlignment: MainAxisAlignment.end,
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcPrimary,
                  fixedSize: Size(80, 36),
                  //side: BorderSide(color: Colors.black,width: 1,style: BorderStyle.solid),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(ksOk, style: TextStyle(fontSize: 16, color: kcWhite)),
              ),
            ],
          ),
        );
      }
    }

  }
}
