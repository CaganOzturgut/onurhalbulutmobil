class BuroListResponseDto{
  int ID;
  String BuroKodu;
  List<SifatDto>? Sifat;
  List<CariKartTanimIsyeri>? Isyeri;
  String Error;

  BuroListResponseDto({required this.Error,required this.BuroKodu,
    this.Sifat,this.Isyeri,required this.ID});

  factory BuroListResponseDto.fromJson(Map<String, dynamic> json) {

    var sifatlist = json['Sifat'] as List;

    List<SifatDto> sifat = sifatlist.map((i) => SifatDto.fromJson(i)).toList();


    var isyeriList = json['Isyeri'] as List;

    List<CariKartTanimIsyeri> isYeri = isyeriList.map((i) => CariKartTanimIsyeri.fromJson(i)).toList();


    return BuroListResponseDto(
      ID: json['ID'],
      BuroKodu: json['BuroKodu'],
      Isyeri: isYeri,
      Sifat: sifat,
      Error: json['Error'] ?? ''
    );
  }
}

class SifatDto {
  int ID;
  String SifatAdi;


  SifatDto({
    required this.ID,
    required this.SifatAdi,

  });

  factory SifatDto.fromJson(Map<String, dynamic> json) {
    return SifatDto(
      ID: json['ID'],
      SifatAdi: json['SifatAdi'],

    );
  }
}

class CariKartTanimIsyeri {
  int ID;
  int IsyeriID;
  String IsyeriAdi;
  int HalID;
  String HalAdi;
  int IsyeriTurID;
  String L_IsyeriTurID;
  int IlID;
  String L_IlID;
  int IlceID;
  String L_IlceID;
  int BeldeID;
  String L_BeldeID;
  String Adres;
  String PlakaNo;
  bool Varsayilan;
  // int HKSAdresOncelikli;

  CariKartTanimIsyeri({
    required this.ID,
    required this.IsyeriID,
    required this.IsyeriAdi,
    required this.HalID,
    required this.HalAdi,
    required this.IsyeriTurID,
    required this.L_IsyeriTurID,
    required this.IlID,
    required this.L_IlID,
    required this.IlceID,
    required this.L_IlceID,
    required this.BeldeID,
    required this.L_BeldeID,
    required this.Adres,
    required this.PlakaNo,
    required this.Varsayilan,
    // required this.HKSAdresOncelikli,
  });

  factory CariKartTanimIsyeri.fromJson(Map<String, dynamic> json) {
    return CariKartTanimIsyeri(
      ID: json['ID'],
      IsyeriID: json['IsyeriID'],
      IsyeriAdi: json['IsyeriAdi'] ?? '',
      HalID: json['HalID'],
      HalAdi: json['HalAdi'] ?? '',
      IsyeriTurID: json['IsyeriTurID'],
      L_IsyeriTurID: json['L_IsyeriTurID'] ?? '',
      IlID: json['IlID'],
      L_IlID: json['L_IlID'],
      IlceID: json['IlceID'],
      L_IlceID: json['L_IlceID'] ?? '',
      BeldeID: json['BeldeID'],
      L_BeldeID: json['L_BeldeID'] ?? '',
      Adres: json['Adres'] ?? '',
      PlakaNo: json['PlakaNo'] ?? '',
      Varsayilan: json['Varsayilan'],
      // HKSAdresOncelikli: json['HKSAdresOncelikli']
    );
  }
}