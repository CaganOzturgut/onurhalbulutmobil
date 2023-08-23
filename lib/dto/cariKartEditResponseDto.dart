class CariKartEditResponseDto{
  int? ID;
  String? CariKodu;
  String? CariAdi;
  int? VergiDairesiID;
  String? L_VergiDairesiID;
  String? TCKNo;
  String? PlakaNo;
  int? UreticiTipi;
  String? L_UreticiTipi;
  String? Adres;
  int? IlID;
  String? L_IlID;
  int? IlceID;
  String? L_IlceID;
  int? BeldeID;
  String? L_BeldeID;
  String? CepTel;
  bool? HKSKayit;
  List<CariKartTanimSifatDTO>? Sifat;
  List<CariKartTanimIsyeriDTO>? Isyeri;
  // List<CariKartTanimMarkaDTO>? Marka;
  bool? IsyeriChanged;
  String? Error;


  CariKartEditResponseDto({
    required this.ID,
    required this.CariKodu,
    required this.CariAdi,
    required this.VergiDairesiID,
    required this.L_VergiDairesiID,
    required this.TCKNo,
    required this.PlakaNo,
    required this.UreticiTipi,
    required this.L_UreticiTipi,
    required this.Adres,
    required this.IlID,
    required this.L_IlID,
    required this.IlceID,
    required this.L_IlceID,
    required this.BeldeID,
    required this.L_BeldeID,
    required this.CepTel,
    required this.HKSKayit,
    required this.Sifat,
    required this.Isyeri,
    // required this.Marka,
    required this.IsyeriChanged,
    required this.Error
  });

  factory CariKartEditResponseDto.fromJson(Map<String, dynamic> json) {

    var sifatlist = json['Sifat'] as List;

    List<CariKartTanimSifatDTO> carikartSifat = sifatlist.map((i) => CariKartTanimSifatDTO.fromJson(i)).toList();

    // var markaList = json['Marka'] as List;

    // List<CariKartTanimMarkaDTO> carikartMarka = markaList.map((i) => CariKartTanimMarkaDTO.fromJson(i)).toList();

    var isyeriList = json['Isyeri'] as List;

    List<CariKartTanimIsyeriDTO> carikartIsyeri = isyeriList.map((i) => CariKartTanimIsyeriDTO.fromJson(i)).toList();


    return CariKartEditResponseDto(
      ID: json['ID'],
      CariKodu: json['CariKodu'],
      CariAdi: json['CariAdi'],
      VergiDairesiID: json['VergiDairesiID'],
      L_VergiDairesiID: json['L_VergiDairesiID'],
      TCKNo: json['TCKNo'],
      PlakaNo: json['PlakaNo'],
      UreticiTipi: json['UreticiTipi'],
      L_UreticiTipi: json['L_UreticiTipi'],
      Adres: json['Adres'],
      IlID: json['IlID'],
      L_IlID: json['L_IlID'],
      IlceID: json['IlceID'],
      L_IlceID: json['L_IlceID'],
      BeldeID: json['BeldeID'],
      L_BeldeID: json['L_BeldeID'],
      CepTel: json['CepTel'],
      HKSKayit: json['HKSKayit'],
      Sifat: carikartSifat,
      // Marka: carikartMarka,
      Isyeri: carikartIsyeri,
        IsyeriChanged: json['IsyeriChanged'],
      Error: json['Error'] ?? ""
    );
  }
}

class CariKartTanimSifatDTO {
  int ID;
  int SifatID;
  String L_SifatID;
  bool Varsayilan;

  CariKartTanimSifatDTO({
    required this.ID,
    required this.SifatID,
    required this.L_SifatID,
    required this.Varsayilan,
  });

  factory CariKartTanimSifatDTO.fromJson(Map<String, dynamic> json) {
    return CariKartTanimSifatDTO(
      ID: json['ID'],
      SifatID: json['SifatID'],
      L_SifatID: json['L_SifatID'],
      Varsayilan: json['Varsayilan'],
    );
  }
}

class CariKartTanimIsyeriDTO {
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

  CariKartTanimIsyeriDTO({
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

  factory CariKartTanimIsyeriDTO.fromJson(Map<String, dynamic> json) {
    return CariKartTanimIsyeriDTO(
      ID: json['ID'],
      IsyeriID: json['IsyeriID'],
      IsyeriAdi: json['IsyeriAdi'],
      HalID: json['HalID'],
      HalAdi: json['HalAdi'],
      IsyeriTurID: json['IsyeriTurID'],
      L_IsyeriTurID: json['L_IsyeriTurID'],
      IlID: json['IlID'],
      L_IlID: json['L_IlID'],
      IlceID: json['IlceID'],
      L_IlceID: json['L_IlceID'],
      BeldeID: json['BeldeID'],
      L_BeldeID: json['L_BeldeID'],
      Adres: json['Adres'],
      PlakaNo: json['PlakaNo'],
      Varsayilan: json['Varsayilan'],
      // HKSAdresOncelikli: json['HKSAdresOncelikli']
    );
  }
}

class CariKartTanimMarkaDTO{
  int ID;
  String Marka;
  int UretimSekliID;
  String L_UretimSekliID;
  int MalNereden;
  String L_MalNereden;

  CariKartTanimMarkaDTO({
    required this.ID,
    required this.Marka,
    required this.UretimSekliID,
    required this.L_UretimSekliID,
    required this.MalNereden,
    required this.L_MalNereden
  });

  factory CariKartTanimMarkaDTO.fromJson(Map<String, dynamic> json) {
    return CariKartTanimMarkaDTO(
      ID: json['ID'],
      Marka: json['Marka'],
      UretimSekliID: json['UretimSekliID'],
      L_UretimSekliID: json['L_UretimSekliID'],
      MalNereden: json['MalNereden'],
      L_MalNereden: json['L_MalNereden']
    );
  }

}