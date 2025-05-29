import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zdl_erp_sdk/api/api_response.dart';
import 'package:zdl_erp_sdk/models/ErpData.dart';
import 'package:zdl_erp_sdk/models/zdl_erp_options.dart';
import 'package:zdl_erp_sdk/zdl_erp_sdk.dart';

import '../../../utils/colors.dart';
import '../../../utils/image_paths.dart';
import '../../../utils/strings.dart';
import '../login/login_view.dart';

class OptionSelectionViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  openLoginScreen(BuildContext ctx) async {
    Navigator.push(ctx, MaterialPageRoute(builder: (context) => LoginView()));
  }

  void showSchoolSelectionSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // so your container's radius is visible
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: kcWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: kcWhite,
                image: DecorationImage(
                  opacity: 0.05,
                  repeat: ImageRepeat.repeat,
                  image: AssetImage(kiBg),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ksSelectSchool,
                            style: TextStyle(
                              fontSize: 16,
                              color: kcPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const CircleAvatar(
                              radius: 16,
                              child: Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: unifiedSchools.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              Navigator.of(context).pop();
                              await callUnifiedLoginApiAndOpenSDK(
                                context,
                                unifiedSchools[index][0],
                                unifiedSchools[index][1],
                              ); // Close sheet
                            },
                            child: Card(
                              color: kcWhite,
                              elevation: 3,
                              child: ListTile(
                                selectedTileColor: kcVeryLightPrimary,
                                title: Text(
                                  unifiedSchools[index][0],
                                  style: TextStyle(
                                    color: kcBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  color: kcBlack,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> callUnifiedLoginApiAndOpenSDK(
    BuildContext context,
    String schoolName,
    String packageName,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await APIResponse().unifiedLogin(
        schoolName,
        packageName,
      );
      if (kDebugMode) {
        print('response-->$response');
      }
      String apiUrl = (response['data'])['apiUrl'];
      if (kDebugMode) {
        print('apiUrl-->$apiUrl');
      }

      String admissionNo = (response['data'])['admissionNo'];
      if (kDebugMode) {
        print('admissionNo-->$admissionNo');
      }

      ErpData erpData = ErpData.fromJson((response['data'])['erpData']);
      if (kDebugMode) {
        print('erpData-->${erpData.toJson()}');
      }
      // Handle the response as needed, e.g., check for success, save tokens, etc.
      _isLoading = false;
      notifyListeners();
      String? messageID = '';
      try {
        await ZdlErpSdk.instance.initialiseZDLErpSdk(
          ZDLErpOptions(
            admissionNumber: admissionNo,
            erpData: erpData,
            messageId: messageID,
            appBaseUrl: schoolerpAppBaseUrl,
            appPackageName: packageName
          ),
        );
        final response = await ZdlErpSdk.instance.launchErpSdk(true);
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
                content: Text('Unable to launch SDK. Please contact support.'),
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
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
