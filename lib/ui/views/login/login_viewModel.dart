import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zdl_erp_sample_app/utils/colors.dart';
import 'package:zdl_erp_sample_app/utils/strings.dart';
import 'package:zdl_erp_sdk/models/zdl_erp_options.dart';
import 'package:zdl_erp_sdk/zdl_erp_sdk.dart';

class LoginViewModel extends ChangeNotifier {
  late bool _isObScureText = true;

  bool get isObScureText => _isObScureText;

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  UserRole _selectedUserType  = UserRole.student;
  UserRole get selectedUserType => _selectedUserType;

  List<String> _selectedSchool = schools[0];

  List<String> get selectedSchool => _selectedSchool;


  Future<List<String>> getSelectedSchool() async {
    return _selectedSchool;
  }

  void setSelectedSchool(
    List<String> school,
  ) async {
    _selectedSchool = school;
    notifyListeners();
  }

  onBackPressed(BuildContext context) async {
    Navigator.pop(context);
  }

  setObscureText(bool value) {
    _isObScureText = value;
    notifyListeners();
  }

  void authenticateUser(
    String name,
    String password,
    BuildContext context,
    UserRole userType,
  ) async {
    if (name.isEmpty || password.isEmpty) {
      showDialog<String>(
        context: context,
        builder:
            (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: kcWhite,
              surfaceTintColor: kcWhite,
              title: Text(
                ksError,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kcBlack,
                ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    ksOk,
                    style: TextStyle(fontSize: 16, color: kcWhite),
                  ),
                ),
              ],
            ),
      );
    } else {
      String? messageID = '';
      try {
        await ZdlErpSdk.instance.initialiseZDLErpSdk(
          ZDLErpOptions(
            userName: name,
            password: password,
            userRole: userType,
            messageId: messageID,
            appBaseUrl: selectedSchool[1],
            appPackageName: selectedSchool[2],
          ),
        );
        final response = await ZdlErpSdk.instance.launchErpSdk(false);
        print('response---->${response?.message}');
      } catch (exception) {
        if (kDebugMode) {
          print('exception-->${exception.toString()}');
        }
        await showDialog<String>(
          context: context,
          builder:
              (BuildContext context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: kcWhite,
                surfaceTintColor: kcWhite,
                title: Text(
                  ksError,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kcBlack,
                  ),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      ksOk,
                      style: TextStyle(fontSize: 16, color: kcWhite),
                    ),
                  ),
                ],
              ),
        );
      }
    }
  }

  Future <UserRole> getSelectedUserType() async {
    return selectedUserType;
  }

  void setLoginType(UserRole s) {
    _selectedUserType = s;
  }
}
