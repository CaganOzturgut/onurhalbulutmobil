import 'package:onurhalbulutmobil/dto/loginRequestDto.dart';

class OnurHalBulutAppSetting {

  static OnurHalBulutAppSetting? _instance;
  static const String ProjectName = "OnurHalMobil";
  static const String BaseUrl = "";
  static const String TestUrl = "api2-test.onurhalbulut.com";

  LoginRequestDto2? loginInfo;
  String kullaniciAdi = "";
  String lisansAdi = "";
  String donemAdi = "";
  String subeAdi = "";
  String vtAdi = "";
  List<String> yetkiListesi = [];
  int lisansID = 0;
  int lisansAdet = 0;
  int subeID = 0;

  factory OnurHalBulutAppSetting() => _instance ??= OnurHalBulutAppSetting._();
  OnurHalBulutAppSetting._();
}
