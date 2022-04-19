import 'dart:developer';
import 'package:dio/dio.dart';

import '../constants.dart';

class RemoteServices {
  static String initialUrl = kBackendURL;

  static Future<String> changePassword(
      String email, String currentPassword, String newPassword) async {
    Uri url = Uri.parse('$initialUrl/changepassword.php');

    var response = await Dio().post(
      url.toString(),
      data: {
        "email": email,
        "password": currentPassword,
        "newpassword": newPassword,
      },
    );
    log(response.data);
    return response.data;
  }

  static Future<String> requestPasswordChange({
    required String email,
  }) async {
    log("<==Changing the password==>");
    Uri url = Uri.parse(
        '$initialUrl/passwordresetrest/requestreset.php?email=$email');

    var response = await Dio().get(url.toString());
    log(response.data);
    return response.data;
  }

  static Future<String> submitVerificationCode(
      String code, String email) async {
    log("<==Submitting Verification Code==>");
    Uri url = Uri.parse(
        '$initialUrl/passwordresetrest/verifyCode.php?email=$email&token=$code');
    var response = await Dio().get(url.toString());
    log(response.data);
    return response.data;
  }

  static Future<String> resetPassword(
      String token, String email, String password) async {
    log("<==Resetting the password==>");
    Uri url = Uri.parse('$initialUrl/passwordresetrest/resetpassword.php');

    var response = await Dio().post(
      url.toString(),
      data: {
        "email": email,
        "token": token,
        "password": password,
      },
    );
    log(response.data);
    return response.data;
  }
}
