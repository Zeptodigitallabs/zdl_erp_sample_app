import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:zdl_erp_sample_app/utils/shared_prefs_key.dart';

class NetworkHelper{
   static final NetworkHelper _singleton = NetworkHelper._internal();
   static String baseUrl ='';

    factory NetworkHelper(){
       return  _singleton;
    }

    NetworkHelper._internal();

    Future<String> getToken() async {
       final prefs = await SharedPreferences.getInstance();
       String token = prefs.getString(keyToken) ?? '';
       return token;
    }

    Future<Dio> getApiClient(bool isAuth, String token,String baseUrl) async {
       var dio = Dio(BaseOptions(
           baseUrl: baseUrl,
          connectTimeout: const Duration(minutes:1),
          receiveTimeout: const Duration(minutes: 1),
          contentType:  Headers.jsonContentType,
          responseType: ResponseType.plain
       ));
       dio.options.headers['Client-Service'] = 'smartschool';
       dio.options.headers['Auth-Key'] = 'schoolAdmin@';
       if (isAuth){
          if (token.isNotEmpty) {
             if (kDebugMode){
                print('token==>$token');
             }
             dio.options.headers['Authorization'] = "Barer $token";
          }
       }
       if (kDebugMode) {
          dio.interceptors.add(
             TalkerDioLogger(
                settings: const TalkerDioLoggerSettings(
                    printRequestHeaders: true,
                    printResponseHeaders: true,
                    printResponseMessage: true,
                    printRequestData: true,
                    printResponseData: true
                )
             )
          );
       }
       return dio;

    }
}