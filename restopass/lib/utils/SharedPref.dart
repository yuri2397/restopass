import 'package:restopass/models/Compte.dart';
import 'package:restopass/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String USER_EMAIL = "user_email";
  static const String USER_MATRICULE = "user_matricule";
  static const String USER_NAME = "user_name";
  static const String USER_IMAGE_PATH = "image_path";
  static const String USER_ID = "user_id";
  static const String USER_FIRST_NAME = "first_name";
  static const String USER_LAST_NAME = "last_name";

  static const String TOKEN = "token";

  static const String COMPTE_ID = "compte_id";
  static const String COMPTE_NUM = "compte_num";
  static const String COMPTE_CODE = "compte_code";
  static const String COMPTE_PAY = 'compte_pay';
  static const String COMPTE_STATUS = 'compte_status';
  static const String COMPTE_DEBT = 'compte_debt';
  static const String COMPTE_USER_ID = 'compte_user_id';

  static const String COMPTE_PIN = 'pin';

  static saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_MATRICULE, user.matricule);
    prefs.setInt(USER_ID, user.id);
    prefs.setString(USER_FIRST_NAME, user.firstName);
    prefs.setString(USER_EMAIL, user.email);
    prefs.setString(USER_LAST_NAME, user.lastName);
  }

  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(USER_MATRICULE) == null) {
      return null;
    }

    return User(
      id: prefs.getInt(USER_ID) ?? -1,
      matricule: prefs.getString(USER_MATRICULE) ?? '',
      firstName: prefs.getString(USER_FIRST_NAME) ?? '',
      lastName: prefs.getString(USER_LAST_NAME) ?? '',
      email: prefs.getString(USER_EMAIL) ?? '',
    );
  }

  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN);
  }

  static Future setCompte(Compte compte) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(COMPTE_CODE, compte.accountCode);
    prefs.setString(COMPTE_NUM, compte.accountNum);
    prefs.setInt(COMPTE_ID, compte.id);
    prefs.setInt(COMPTE_PAY, compte.pay);
    prefs.setInt(COMPTE_DEBT, compte.debt);
    prefs.setInt(COMPTE_USER_ID, compte.userId);
    prefs.setInt(COMPTE_STATUS, compte.status);
  }

  static Future<Compte?> getCompte() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? code = prefs.getString(COMPTE_CODE);
    if (code == null) return null;
    return Compte(
        accountCode: code,
        accountNum: prefs.getString(COMPTE_NUM) ?? '',
        status: prefs.getInt(COMPTE_STATUS) ?? -1,
        debt: prefs.getInt(COMPTE_DEBT) ?? -1,
        id: prefs.getInt(COMPTE_ID) ?? -1,
        pay: prefs.getInt(COMPTE_PAY) ?? -1,
        userId: prefs.getInt(COMPTE_USER_ID) ?? -1);
  }

  static Future setPin(String pin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(COMPTE_PIN, pin);
  }

  static Future setPay(int pay) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(COMPTE_PAY, pay);
  }

  static Future<int?> getPay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(COMPTE_PAY);
  }

  static Future<String?> getPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(COMPTE_PIN);
  }

  static removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(USER_EMAIL);
    prefs.remove(USER_MATRICULE);
    prefs.remove(USER_NAME);
    prefs.remove(USER_IMAGE_PATH);
    prefs.remove(USER_ID);
    prefs.remove(USER_FIRST_NAME);
    prefs.remove(USER_LAST_NAME);
    prefs.remove(TOKEN);
    prefs.remove(COMPTE_ID);
    prefs.remove(COMPTE_NUM);
    prefs.remove(COMPTE_CODE);
    prefs.remove(COMPTE_PAY);
    prefs.remove(COMPTE_STATUS);
    prefs.remove(COMPTE_DEBT);
    prefs.remove(COMPTE_USER_ID);
    prefs.remove(COMPTE_PIN);
  }
}
