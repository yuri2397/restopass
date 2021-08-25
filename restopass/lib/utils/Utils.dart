import 'package:flutter/material.dart';
import 'package:restopass/models/User.dart';
import 'package:restopass/utils/SharedPref.dart';

const String HOST = "http://192.168.43.228:8000";
const String HOST_ADRESS = "192.168.43.228";
const String API = "http://192.168.43.228:8000/api";
const int PORT = 8000;
const String APP_NAME = "Resto Pass";
const Color PRIMARY_COLOR = Color(0xFF5C01CA);
const Color SECONDARY_COLOR = Color(0xFFF1E6FF);
const String PASS = "restopass.vigil";

// CODE EXCEPTION
final int UNAUTH = 401;

Future<User?> isLogin() async {
  return await SharedPref.getUser();
}
