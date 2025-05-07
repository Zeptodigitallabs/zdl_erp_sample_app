import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zdl_erp_sample_app/utils/strings.dart';

import '../models/config_vo.dart';
import '../models/user_vo.dart';
import '../utils/shared_prefs_key.dart';
import 'api_constants.dart';
import 'network_helper.dart';

class APIResponse {
  static final APIResponse _singleton = APIResponse._internal();

  factory APIResponse() {
    return _singleton;
  }

  APIResponse._internal();

  Future<ConfigVo?> getAppConfigs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? appUrl = prefs.getString(keyAppBaseUrl);
      if (kDebugMode) {
        print("AppUrl===>$appUrl");
      }
      var dio = await NetworkHelper().getApiClient(false, '', appUrl ?? '');
      var response = await dio.post(configuration);
      return ConfigVo.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<UserVo> authenticateUserAPI(
    String deviceToken,
    String userName,
    String password,
    String userType,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? apiUrl = prefs.getString(keyApiUrl);
    var client = await NetworkHelper().getApiClient(true, deviceToken, apiUrl ?? '');
    Map bodyData = {'deviceToken': deviceToken, 'username': userName, 'password': password};
    String url = authenticateUser;
    if (userType == ksStaff) {
      url = authenticateStaff;
    }

    var response = await client.post(url, data: json.encode(bodyData));
    var responseData = json.decode(response.data);
    if (kDebugMode) {
      print('$url---->$responseData');
    }
    UserVo userVo = UserVo.fromJson(jsonDecode(response.data));
    return userVo;
  }
}
