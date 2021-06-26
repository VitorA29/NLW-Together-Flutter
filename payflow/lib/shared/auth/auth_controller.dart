import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthController
{
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user)
  {
    if (user != null)
    {
      _user = user;
      saveUser(user);
      Navigator.pushReplacementNamed(context, "/home", arguments: user);
      return;
    }
    Navigator.pushReplacementNamed(context, "/login");
  }

  Future<void> saveUser(UserModel user) async
  {
    final instance = await SharedPreferences.getInstance();
    instance.setString("user", user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async
  {
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey("user"))
    {
      final userJson = instance.get("user") as String;
      setUser(context, UserModel.fromJson(userJson));
      return;
    }
    setUser(context, null);
  }
}
