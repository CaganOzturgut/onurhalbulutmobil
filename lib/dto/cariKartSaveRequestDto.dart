class CariKartSaveRequestDto {
  int? LisansID;
  String? VTAdi;
  int? SubeID;
  String? UserName;
  String? UserPass;
  int? ID;
  String? CariKodu;
  String? CariAdi;
  int? VergiDairesiID;
  String? TCKNo;
  String? PlakaNo;
  int? UreticiTipi;
  String? Adres;
  int? IlID;
  int? IlceID;
  int? BeldeID;
  String? CepTel;
  bool? HKSKayit;
  List<CariKartTanimSifatSaveDTO>? Sifat;
  List<CariKartTanimIsyeriSaveDTO>? Isyeri;

  CariKartSaveRequestDto({
    this.LisansID,
    this.VTAdi,
    this.SubeID,
    this.UserName,
    this.UserPass,
    this.ID,
    this.CariKodu,
    this.CariAdi,
    this.VergiDairesiID,
    this.TCKNo,
    this.PlakaNo,
    this.UreticiTipi,
    this.Adres,
    this.IlID,
    this.IlceID,
    this.BeldeID,
    this.CepTel,
    this.HKSKayit,
    this.Sifat,
    this.Isyeri,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> sifatList = [];
    if (Sifat != null) {
      sifatList = Sifat!.map((sifat) => sifat.toJson()).toList();
    }

    List<Map<String, dynamic>> isyeriList = [];
    if (Isyeri != null) {
      isyeriList = Isyeri!.map((isyeri) => isyeri.toJson()).toList();
    }

    return {
      'LisansID': LisansID,
      'VTAdi': VTAdi,
      'SubeID': SubeID,
      'UserName': UserName,
      'UserPass': UserPass,
      'ID': ID,
      'CariKodu': CariKodu,
      'CariAdi': CariAdi,
      'VergiDairesiID': VergiDairesiID,
      'TCKNo': TCKNo,
      'PlakaNo': PlakaNo,
      'UreticiTipi': UreticiTipi,
      'Adres': Adres,
      'IlID': IlID,
      'IlceID': IlceID,
      'BeldeID': BeldeID,
      'CepTel': CepTel,
      'HKSKayit': HKSKayit,
      'Sifat': sifatList,
      'Isyeri': isyeriList,
    };
  }
}

class CariKartTanimSifatSaveDTO {
  int ID;
  int SifatID;
  String L_SifatID;
  bool Varsayilan;

  factory CariKartTanimSifatSaveDTO.fromJson(Map<String, dynamic> json) {
    return CariKartTanimSifatSaveDTO(
      ID: json['ID'],
      SifatID: json['SifatID'],
      L_SifatID: json['L_SifatID'],
      Varsayilan: json['Varsayilan'],
    );
  }

  CariKartTanimSifatSaveDTO({
    required this.ID,
    required this.SifatID,
    required this.L_SifatID,
    required this.Varsayilan,
  });

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'SifatID': SifatID,
      'L_SifatID': L_SifatID,
      'Varsayilan': Varsayilan,
    };
  }
}

class CariKartTanimIsyeriSaveDTO {
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

  CariKartTanimIsyeriSaveDTO({
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
  });

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'IsyeriID': IsyeriID,
      'IsyeriAdi': IsyeriAdi,
      'HalID': HalID,
      'HalAdi': HalAdi,
      'IsyeriTurID': IsyeriTurID,
      'L_IsyeriTurID': L_IsyeriTurID,
      'IlID': IlID,
      'L_IlID': L_IlID,
      'IlceID': IlceID,
      'L_IlceID': L_IlceID,
      'BeldeID': BeldeID,
      'L_BeldeID': L_BeldeID,
      'Adres': Adres,
      'PlakaNo': PlakaNo,
      'Varsayilan': Varsayilan,
    };
  }
}
