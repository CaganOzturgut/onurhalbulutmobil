class AmbarSatisEditRequestDto{
  int? LisansID;
  String? VTAdi;
  int? SubeID;
  String? UserName;
  String? UserPass;
  int? ID;
  int? FaturaTur;
  int? CariKartSifat;
  int? CariKartIsyeriID;
  int? CariKartID;
  String? PlakaNo;
  String? IrsaliyeNo;
  int? IlID;
  int? IlceID;
  int? BeldeID;
  String? Aciklama;
  int? SoforID;
  String? IrsaliyeAdresi;
  String? FaturaAdresi;
  int? Islem;
  List<AmbarSatisSatirEdit>? Urunler;

  AmbarSatisEditRequestDto({
    this.LisansID,
    this.VTAdi,
    this.SubeID,
    this.UserName,
    this.UserPass,
    this.ID,
    this.FaturaTur,
    this.CariKartSifat,
    this.CariKartIsyeriID,
    this.CariKartID,
    this.PlakaNo,
    this.IrsaliyeNo,
    this.IlID,
    this.IlceID,
    this.BeldeID,
    this.Aciklama,
    this.SoforID,
    this.IrsaliyeAdresi,
    this.FaturaAdresi,
    this.Islem,
    this.Urunler
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> urunList = [];
    if (Urunler != null) {
      urunList = Urunler!.map((urun) => urun.toJson()).toList();
    }

    return {
      'LisansID': LisansID,
      'VTAdi': VTAdi,
      'SubeID': SubeID,
      'UserName': UserName,
      'UserPass': UserPass,
      'ID': ID,
      'FaturaTur': FaturaTur,
      'CariKartSifat': CariKartSifat,
      'CariKartIsyeriID': CariKartIsyeriID,
      'CariKartID': CariKartID,
      'PlakaNo': PlakaNo,
      'IrsaliyeNo': IrsaliyeNo,
      'IlID': IlID,
      'IlceID': IlceID,
      'BeldeID': BeldeID,
      'Aciklama': Aciklama,
      'SoforID': SoforID,
      'IrsaliyeAdresi': IrsaliyeAdresi,
      'FaturaAdresi': FaturaAdresi,
      'Islem': Islem,
      'Urunler': Urunler,
    };
  }
}

class AmbarSatisSatirEdit {
  int ID;
  int AmbarSatirID;
  String L_MarkaID;
  String L_StokID;
  int KasaAdet;
  int KasaAdetBirim;
  double BagKilo;
  int BagKiloBirim;
  double Fiyat;
  double KunyeNo;
  String ErrorKunyeAl;
  String StoKText;


  factory AmbarSatisSatirEdit.fromJson(Map<String, dynamic> json) {
    return AmbarSatisSatirEdit(
      ID: json['ID'],
      AmbarSatirID: json['AmbarSatirID'],
      L_MarkaID: json['L_MarkaID'],
      L_StokID: json['L_StokID'],
      KasaAdet: json['KasaAdet'],
      KasaAdetBirim: json['KasaAdetBirim'],
      BagKilo: json['BagKilo'],
      BagKiloBirim: json['BagKiloBirim'],
      Fiyat: json['Fiyat'],
      KunyeNo: json['KunyeNo'],
      ErrorKunyeAl: json['ErrorKunyeAl'],
      StoKText: json['StoKText'],
    );
  }

  AmbarSatisSatirEdit({
    required this.ID,
    required this.AmbarSatirID,
    required this.L_MarkaID,
    required this.L_StokID,
    required this.KasaAdet,
    required this.KasaAdetBirim,
    required this.BagKilo,
    required this.BagKiloBirim,
    required this.Fiyat,
    required this.KunyeNo,
    required this.ErrorKunyeAl,
    required this.StoKText
  });

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'AmbarSatirID': AmbarSatirID,
      'L_MarkaID': L_MarkaID,
      'KasaAdet': KasaAdet,
      'L_StokID' : L_StokID,
      'KasaAdetBirim': KasaAdetBirim,
      'BagKilo': BagKilo,
      'BagKiloBirim': BagKiloBirim,
      'Fiyat': Fiyat,
      'KunyeNo': KunyeNo,
      'ErrorKunyeAl': ErrorKunyeAl,
      'StoKText': StoKText,
    };
  }
}