class LoginResponseDto {
  String? Error;
  int? ID;
  String? UserName;
  List<Lisanslar>? LisansList;

  LoginResponseDto({this.Error,this.ID,
    this.UserName,required this.LisansList});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {

      var list = json['Lisanslar'];

      var lisanslarJson = json['Lisanslar'];
      List<Lisanslar> lisanslar;
      String? Error;
      if (lisanslarJson != null) {
        lisanslar = (lisanslarJson as List).map((json) => Lisanslar.fromJson(json)).toList();
      } else {
        // Eğer "Lisanslar" alanı null ise, boş bir liste veya varsayılan bir değer kullanabilirsiniz.
        Error = "Kullanıcı Adı ve ya Şifre hatalı !";
        lisanslar = [];
      }

      return LoginResponseDto(
        Error: Error,
        ID: json['ID'],
        UserName: json['UserName'],
        LisansList: lisanslar,
      );
  }
}

class Lisanslar {
  int ID;
  String FirmaAdi;
  String Adres;
  String TahsisNo;
  int SubeAdet;
  List<VTList> vtList;


  Lisanslar({required this.ID,required this.FirmaAdi,required this.Adres,required this.TahsisNo,required this.SubeAdet,required this.vtList});

  factory Lisanslar.fromJson(Map<String, dynamic> json) {

  //  List<Lisanslar> lisansList = list.map((i) => Lisanslar.fromJson(i)).toList();

    var list = json['VTList'] as List;
    List<VTList> vtList = list.map((i) => VTList.fromJson(i))
        .toList();

    return Lisanslar(
      ID: json['ID'],
      FirmaAdi: json['FirmaAdi'],
      Adres: json['Adres'] ?? '',
      TahsisNo: json['TahsisNo'] ?? '',
      SubeAdet: json['SubeAdet'],
      vtList: vtList
    );
  }
}

class VTList {
  int ID;
  String DBAdi;
  String VTAdi;

  VTList({required this.ID, required this.DBAdi, required this.VTAdi});

  factory VTList.fromJson(Map<String, dynamic> json) {
    return VTList(
      ID: json['ID'],
      DBAdi: json['DBAdi'],
      VTAdi: json['VTAdi'],
    );
  }
}





