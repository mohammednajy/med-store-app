import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../modules/auth/models/user_model.dart';

enum PrefKeys { user, isLoggedIn, onBoarding, guestUser }

class SharedPrefController {
  static final _instance = SharedPrefController._();

  factory SharedPrefController() {
    return _instance;
  }

  late SharedPreferences preferences;
  SharedPrefController._();

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  save(UserModel user) async {
    String userEncoded = jsonEncode(user.toJsonUser());
    await preferences.setString(PrefKeys.user.toString(), userEncoded);
  }

  UserModel getUser() {
    String userJson = preferences.getString(PrefKeys.user.toString()) ?? '';
    final userObject = jsonDecode(userJson);
    return UserModel.fromJson(userObject);
  }

  void isLoggedIn({required bool value}) {
    preferences.setBool(PrefKeys.isLoggedIn.toString(), value);
  }

  bool getLoggedIn() {
    return preferences.getBool(PrefKeys.isLoggedIn.toString()) ?? false;
  }

  void setOnBoarding({required bool value}) {
    preferences.setBool(PrefKeys.onBoarding.toString(), value);
  }

  void setGuestUser({required bool value}) {
    preferences.setBool(PrefKeys.guestUser.toString(), value);
  }

  bool getGuestUser() {
    return preferences.getBool(PrefKeys.guestUser.toString()) ?? false;
  }

  bool getOnBoarding() {
    return preferences.getBool(PrefKeys.onBoarding.toString()) ?? false;
  }

  clear() {
    preferences.clear();
  }

  remove() {
    preferences.remove(PrefKeys.user.toString());
  }
}
