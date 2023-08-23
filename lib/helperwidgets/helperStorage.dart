import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onurhalbulutmobil/dto/loginRequestDto.dart';
import 'package:onurhalbulutmobil/dto/loginResponseDto.dart';
import 'package:onurhalbulutmobil/helperwidgets/localeDto.dart';
import 'package:onurhalbulutmobil/main.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';


class UserStorage {
  final storage = FlutterSecureStorage();
  static UserStorage? _instance;
  factory UserStorage() => _instance ??= new UserStorage._();
  UserStorage._();
  //static AktifKullaniciDto user;
  loadFromStorage() async {
    var kullanici = await storage.read(key: "User");
    if (kullanici != null) {
      var jsonObject = json.decode(kullanici);
      parseJson(jsonObject);
    } else {
      OnurHalBulutAppSetting().loginInfo;
    }
  }

  Future<bool> loginInfo(LoginRequestDto2 user) async {
    if (user == null) {
      print('null geldi');

      return false;
    }
    OnurHalBulutAppSetting().loginInfo = user;
    await storage.write(key: 'User', value: json.encode(user.toJson()));
    return true;
  }

  Future<bool> lisansInfo(String lisans) async {
    if (lisans == null) {
      print('null geldi');

      return false;
    }
    OnurHalBulutAppSetting().lisansAdi = lisans;
    await storage.write(key: 'Lisans', value: json.encode(lisans));
    return true;
  }

  Future<bool> vtAdiInfo(String vtAdi) async {
    if (vtAdi == null) {
      print('null geldi');

      return false;
    }
    OnurHalBulutAppSetting().vtAdi = vtAdi;
    await storage.write(key: 'vtAdi', value: json.encode(vtAdi));
    return true;
  }

  Future<bool> subeIDInfo(int subeID) async {
    if (subeID == null) {
      print('null geldi');

      return false;
    }
    OnurHalBulutAppSetting().subeID = subeID;
    await storage.write(key: 'subeID', value: json.encode(subeID));
    return true;
  }

  Future<bool> yetkiListesiInfo(List<String> yetkiListesi) async {
    if (yetkiListesi == null) {
      print('null geldi');

      return false;
    }
    OnurHalBulutAppSetting().yetkiListesi = yetkiListesi;
    await storage.write(key: 'vtAdi', value: json.encode(yetkiListesi));
    return true;
  }

  Future<bool> lisansID(int lisansID) async {
    if (lisansID == null) {
      print('null geldi');

      return false;
    }
    OnurHalBulutAppSetting().lisansID = lisansID;
    await storage.write(key: 'LisansID', value: json.encode(lisansID));
    return true;
  }

  Future<bool> donemInfo(String donem) async {
    if (donem == null) {
      print('null geldi');

      return false;
    }
    OnurHalBulutAppSetting().donemAdi = donem;
    await storage.write(key: 'Donem', value: json.encode(donem));
    return true;
  }

  Future<bool> subeInfo(String sube) async {
    if (sube == null) {
      print('null geldi');

      return false;
    }
    OnurHalBulutAppSetting().subeAdi = sube;
    await storage.write(key: 'Sube', value: json.encode(sube));
    return true;
  }

  Future<bool> writeUserInfo(LoginResponseDto userInfo) async {
    if (userInfo == null) {
      return false;
    }
    OnurHalBulutAppSetting().kullaniciAdi = userInfo.UserName!;
    await storage.write(key: 'UserName', value: json.encode(userInfo.UserName));

    return true;
  }


  Future<bool> writeLocale(LocaleDto locale) async {
    if (locale == null) {
      print('null geldi');
      return false;
    }
    await storage.write(key: 'Locale', value: json.encode(locale.toDatabaseJson()));
    return true;
  }


  static void parseJson(Map<String, dynamic> value) {

    OnurHalBulutAppSetting().loginInfo = LoginRequestDto2.fromJson(value);
    OnurHalBulutApp.userDto = OnurHalBulutAppSetting().loginInfo!;

  }

  Future<LoginRequestDto2?> getUser() async {
    OnurHalBulutAppSetting().loginInfo = null ;
    if (OnurHalBulutAppSetting().loginInfo != null)
      return OnurHalBulutAppSetting().loginInfo;
    var userString = await storage.read(key: "User");
    if (userString != null) {
      var jsonObject = json.decode(userString);
      OnurHalBulutAppSetting().loginInfo = LoginRequestDto2.fromJson(jsonObject);
    }
    return OnurHalBulutAppSetting().loginInfo;
  }

  Future<LoginRequestDto2?> deleteUser() async {
    await storage.deleteAll();
    OnurHalBulutAppSetting().loginInfo == null;
    return OnurHalBulutAppSetting().loginInfo;
  }
}
