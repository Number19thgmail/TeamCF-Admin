import 'package:flutter/material.dart';
import 'package:team_c_f/store/login/login.dart';

class DataLogin extends ChangeNotifier{
  Login? login;

  DataLogin()
  {
    login = Login();
  }
}