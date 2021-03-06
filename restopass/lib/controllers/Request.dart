import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restopass/models/LoginData.dart';
import 'package:restopass/models/LoginResponse.dart';
import 'package:restopass/models/PayTechResponse.dart';
import 'package:restopass/models/Payment.dart';
import 'package:restopass/models/RefreshResponse.dart';
import 'package:restopass/models/Response.dart';
import 'package:restopass/models/Tranfer.dart';
import 'package:restopass/models/User.dart';
import 'package:restopass/utils/SharedPref.dart';
import 'package:restopass/utils/Utils.dart';

abstract class Request {
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<http.Response?> login(LoginData data) async {
    var uri = Uri.parse(API + '/etudiant/login');

    var client = new http.Client();
    http.Response? response;
    try {
      response = await client.post(uri,
          body: json.encode({'email': data.email, 'password': data.password}),
          headers: headers);
    } on SocketException {
      response = null;
    }
    return response;
  }

  static Future<http.Response?> createPin(String pin) async {
    var uri = Uri.parse(API + '/etudiant/pin');
    String? token = await SharedPref.getToken();
    if (token == null) {
      return null;
    }

    var hdrs = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var client = new http.Client();

    return await client.post(uri,
        body: json.encode({'pin': pin}), headers: hdrs);
  }

  static Future<List<Transfert>?> getTranferts() async {
    var uri = Uri.parse(API + '/etudiant/transfert');
    String? token = await SharedPref.getToken();

    if (token == null) {
      return null;
    }

    var hdrs = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var client = new http.Client();
    late List<Transfert>? apiResponse;

    http.Response response = await client.get(uri, headers: hdrs);
    if (response.statusCode == 200) {
      apiResponse = tranfertsFromJson(response.body);
    } else
      apiResponse = null;
    return apiResponse;
  }

  static Future<Response?> transfert(String? to, int? amount) async {
    var uri = Uri.parse(API + '/etudiant/transfert');
    String? token = await SharedPref.getToken();

    if (token == null) {
      return null;
    }

    var hdrs = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var client = new http.Client();

    http.Response response = await client.post(uri,
        body: json.encode({'to': to, 'amount': amount}), headers: hdrs);
    return responseFromJson(response.body);
  }

  static Future<RefreshResponse?> getUser() async {
    var uri = Uri.parse(API + '/etudiant');
    String? token = await SharedPref.getToken();

    if (token == null) {
      return null;
    }

    var hdrs = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var client = new http.Client();
    late RefreshResponse? apiResponse;

    http.Response response = await client.get(uri, headers: hdrs);
    if (response.statusCode == 200) {
      apiResponse = refreshResponseFromJson(response.body);
    } else
      apiResponse = null;
    return apiResponse;
  }

  static Future<List<Payment>?> getPayments() async {
    var uri = Uri.parse(API + '/etudiant/payments');
    String? token = await SharedPref.getToken();

    if (token == null) {
      return null;
    }

    var hdrs = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var client = new http.Client();
    http.Response response = await client.get(uri, headers: hdrs);
    if (response.statusCode == 200) {
      return payementsFromJson(response.body);
    } else
      return null;
  }

  static Future<http.Response> resetPassword(String email) async {
    var uri = Uri.parse(API + '/etudiant/reset-password');

    var client = new http.Client();

    http.Response response = await client.post(uri,
        body: json.encode({'email': email}), headers: headers);
    log(response.body, name: "RESET PASSWORD");
    return response;
  }

  static Future<http.Response> resetPin(String email) async {
    var uri = Uri.parse(API + '/etudiant/reset-pin');

    var client = new http.Client();

    http.Response response = await client.post(uri,
        body: json.encode({'email': email}), headers: headers);
    log(response.body, name: "RESET PIN");
    return response;
  }

  static Future<http.Response> newPassword(
      String email, String code, String password) async {
    var uri = Uri.parse(API + '/etudiant/new-password');

    var client = new http.Client();

    http.Response response = await client.post(uri,
        body: json.encode({'email': email, 'code': code, 'password': password}),
        headers: headers);
    log(response.body, name: "NEW PASSWORD");
    return response;
  }

  static Future<Response?> setPassword(
      String currentPassword, String newPassword) async {
    var uri = Uri.parse(API + '/etudiant/edit-password');
    String? token = await SharedPref.getToken();

    if (token == null) {
      return null;
    }

    var client = new http.Client();
    var hdrs = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    http.Response response = await client.post(uri,
        body: json.encode(
            {'old_password': currentPassword, 'new_password': newPassword}),
        headers: hdrs);
    return responseFromJson(response.body);
  }

  static Future<Response?> setPin(String currentPin, String newPin) async {
    var uri = Uri.parse(API + '/etudiant/edit-pin');
    String? token = await SharedPref.getToken();

    if (token == null) {
      return null;
    }

    var client = new http.Client();
    var hdrs = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    http.Response response = await client.post(uri,
        body: json.encode({'old_pin': currentPin, 'new_pin': newPin}),
        headers: hdrs);

    print("NEW PIN: " + response.body);
    return responseFromJson(response.body);
  }

  static Future<PayTech?> payement(int amount) async {
    var uri = Uri.parse(API + '/payment');
    String? token = await SharedPref.getToken();

    if (token == null) {
      return null;
    }

    var client = new http.Client();
    var hdrs = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    http.Response response = await client.post(uri,
        body: json.encode({
          'amount': amount,
        }),
        headers: hdrs);
    print("PAY RESPONSE: " + response.body);

    if (response.statusCode == 200) {
      return paytechFromJson(response.body);
    }
    return null;
  }
}
