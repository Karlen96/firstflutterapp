import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:myapp/helpers/base.dart';
import 'package:myapp/helpers/config.dart';

class ServicesAPI {
  /*
   * get home page
   */
  Future<List> getHomePage(apiKey, language, sid) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'sid': '$sid',
        'api_key': '$apiKey',
        'language': '$language'
      };
      var options = BaseOptions(
        connectTimeout: Config.timeOut,
        receiveTimeout: Config.timeOut,
      );
      var response = await Dio(options).get(
        Config.homePage,
        options: Options(
          headers: headers,
        ),
      );
      if (response.data != null && response.statusCode == 200) {
        Base.restId = response.data['restaurants'][0]['id'];
        return response.data['restaurants'];
      } else {
        return null;
      }
    } on DioError catch (err) {
      if (err.type == DioErrorType.CONNECT_TIMEOUT) {
        print("Connection  Timeout Exception");
        return null;
      }

      switch (err.response.data['errors']) {
        case "100":
          return getSid(Base.deviceId).then((value) {
            return getHomePage(Base.apiKey, Base.language, value);
          });
          break;
        default:
      }
      return null;
    }
  }

  /*
   * get sid
   */
  Future getSid(deviceId) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      var response = await Dio().post(
        Config.session,
        options: Options(headers: headers),
        data: {"device_id": "$deviceId"},
      );
      if (response.data != null && response.statusCode == 200) {
        int answer = mathExpressions(response.data['sid'], [2, 21, 28, 18, 6]);
        return getSesionOtvet(Base.deviceId, answer);
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print('error time');
      return null;
    } on SocketException catch (_) {
      print('error socet');
      return null;
    }
  }

  int mathExpressions(string, idents) {
    int one = int.parse(string[idents[0]]);
    int two = int.parse(string[idents[1]]);
    int three = int.parse(string[idents[2]]);
    int four = int.parse(string[idents[3]]);
    int five = int.parse(string[idents[4]]);
    return pow(((one + two + three) * four - five), 2);
  }

  /*
   * session answer
   */
  Future getSesionOtvet(deviceId, answer) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      var response = await Dio().post(
        Config.sesionotvet,
        options: Options(headers: headers),
        data: {"device_id": "$deviceId", "otvet": answer},
      );
      if (response.data != null && response.statusCode == 200) {
        Base.sid = response.data['sid'];
        return response.data['sid'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  /*
   * menu get
   */
  Future<dynamic> getMenu(restId, apiKey, language, sid) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'sid': '$sid',
        'api_key': '$apiKey',
        'language': '$language',
        'rest_id': '$restId'
      };
      var options = BaseOptions(
        connectTimeout: Config.timeOut,
        receiveTimeout: Config.timeOut,
      );
      var response = await Dio(options)
          .get(Config.menuget, options: Options(headers: headers));

      return response.data;
    } on DioError catch (err) {
      if (err.type == DioErrorType.CONNECT_TIMEOUT) {
        print("Connection  Timeout Exception");
        return null;
      }
      if (err.type == DioErrorType.RECEIVE_TIMEOUT) {
        print("Connection  Timeout Exception");
        return null;
      }
      switch (err.response.data['errors']) {
        case "100":
          return getSid(Base.deviceId).then((value) {
            return getMenu(Base.restId, Base.apiKey, Base.language, value);
          });
          break;
        default:
      }
      return null;
    }
  }
}
