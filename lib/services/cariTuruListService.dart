import 'package:http/http.dart' as http;
import 'package:onurhalbulutmobil/dto/cariTuruListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/cariTuruListResponseDto.dart';
import 'dart:convert';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';

class CariTuruListService {
  var _url = Uri.http(OnurHalBulutAppSetting.TestUrl,'api/lookup/carituru');

  Future<CariTuruListResponseDto> getCariTuruList (CariTuruListRequestDto cariTuru) async {

    var cache = cariTuru;

    var data = Crypt().encryptString(jsonEncode(cariTuru));

    var jsonData = null;
    var encrypted = data;

    var request = http.MultipartRequest('POST',_url)
      ..headers['XApiKey'] = "sDdF454Trgg54h&87tr5Rfgt5D.!"
      ..fields['data'] = encrypted;

    var response = await request.send();

    if (response.statusCode == 200) {

      var gelen = await response.stream.bytesToString();
      print(gelen);

      CariTuruListResponseDto cariList =
      CariTuruListResponseDto.fromJson(json.decode(gelen));
      print(cariList);
      return cariList;

    } else {
      //print(json.decode(response.body).toString());
      throw Exception(json.decode(await response.stream.bytesToString()));
    }
  }
}

class Crypt {
  final String xEncryptionKey =
      "~¨^&/5*-+d+5,;>|.#g!1?_t54w%<gv2¨âzu5&s+f6{e}7[e]a(é)";

  int convertToNet(String cChar) {
    switch (cChar) {
      case 'Ğ':
        return 208;
      case 'ğ':
        return 240;
      case 'Ş':
        return 222;
      case 'ş':
        return 254;
      case 'İ':
        return 221;
      case 'ı':
        return 253;
      case 'Ö':
        return 214;
      case 'ö':
        return 246;
      case 'Ç':
        return 199;
      case 'ç':
        return 231;
      default:
        return cChar.codeUnitAt(0);
    }
  }

  String convertToWin(int cChar) {
    switch (cChar) {
      case 208:
        return 'Ğ';
      case 240:
        return 'ğ';
      case 222:
        return 'Ş';
      case 254:
        return 'ş';
      case 221:
        return 'İ';
      case 253:
        return 'ı';
      case 214:
        return 'Ö';
      case 246:
        return 'ö';
      case 199:
        return 'Ç';
      case 231:
        return 'ç';
      default:
        return String.fromCharCode(cChar);
    }
  }

  String encryptString(String sText) {
    int iLoop, iKeyPointer;
    String sKey = xEncryptionKey;
    List<int> result = List<int>.filled(sText.length, 0);
    iKeyPointer = 0;
    for (iLoop = 0; iLoop < sText.length; iLoop++) {
      result[iLoop] =
      convertToNet(sText[iLoop]) ^ sKey.codeUnitAt(iKeyPointer);
      iKeyPointer++;
      if (iKeyPointer >= sKey.length) iKeyPointer = 0;
    }
    return base64.encode(result);
  }

  String encryptStringBytes(List<int> xData) {
    int iLoop, iKeyPointer;
    String sKey = xEncryptionKey;
    List<int> result = List<int>.filled(xData.length, 0);
    iKeyPointer = 0;
    for (iLoop = 0; iLoop < xData.length; iLoop++) {
      result[iLoop] = xData[iLoop] ^ sKey.codeUnitAt(iKeyPointer);
      iKeyPointer++;
      if (iKeyPointer >= sKey.length) iKeyPointer = 0;
    }
    return base64.encode(result);
  }

  String decryptString(String sText) {
    int iLoop, iKeyPointer;
    String sKey = xEncryptionKey;
    List<int> xData = base64.decode(sText);
    StringBuffer sb = StringBuffer();
    iKeyPointer = 0;
    for (iLoop = 0; iLoop < xData.length; iLoop++) {
      sb.write(convertToWin(xData[iLoop] ^ sKey.codeUnitAt(iKeyPointer)));
      iKeyPointer++;
      if (iKeyPointer >= sKey.length) iKeyPointer = 0;
    }
    return sb.toString();
  }
}