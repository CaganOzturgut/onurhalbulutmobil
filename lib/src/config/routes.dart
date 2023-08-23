import 'package:flutter/material.dart';
import 'package:onurhalbulutmobil/pages/hkssifatekle.dart';
import 'package:onurhalbulutmobil/pages/homepage.dart';
import 'package:onurhalbulutmobil/pages/loginpage.dart';
import 'package:onurhalbulutmobil/pages/stokKunyesiAl.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';



class RouterSettings {
  static const String root = "/";
  static const String home = "/home";
  static const String login = "/login";
  static const String donemsec = "/donemsec";
  static const String subesec = "/subesec";
  static const String hkssifatekle = "/hkssifatekle";
  static const String stokkunyesial = "/stokkunyesial";

}

var onurhalroutes = <String, WidgetBuilder>{
    RouterSettings.login: (context) => Login(),
    RouterSettings.home: (context) => HomePage(yetkiListesi: OnurHalBulutAppSetting().yetkiListesi),
    // RouterSettings.hkssifatekle: (context) => HKSSifatEkle(),
    RouterSettings.stokkunyesial: (context) => StokKunyesiAl()

};
