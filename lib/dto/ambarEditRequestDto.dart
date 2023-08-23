class AmbarEditRequestDto{
  int? LisansID;
  String? VTAdi;
  int? SubeID;
  String? UserName;
  String? UserPass;
  int? ID;
  int? AlimSekli;
  int? BuroSifat;
  int? BuroIsyeriID;
  int? CariKartID;
  String? PlakaNo;
  int? IlID;
  int? IlceID;
  int? BeldeID;
  int? MalNereden;
  String? Aciklama;
  String? GirisTarihi;
  int? Islem;
  List<AmbarSatirEdit>? Urunler;

  AmbarEditRequestDto({
    this.LisansID,
    this.VTAdi,
    this.SubeID,
    this.UserName,
    this.UserPass,
    this.ID,
    this.Islem,
    this.Urunler,
    this.GirisTarihi,this.CariKartID,this.BuroIsyeriID,
    this.Aciklama,this.MalNereden,this.BeldeID,this.PlakaNo,
    this.IlID,this.IlceID,this.BuroSifat,this.AlimSekli
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
      'Islem' : Islem,
      'AlimSekli': AlimSekli,
      'BuroSifat': BuroSifat,
      'BuroIsyeriID': BuroIsyeriID,
      'CariKartID': CariKartID,
      'PlakaNo': PlakaNo,
      'MalNereden': MalNereden,
      'Aciklama': Aciklama,
      'IlID': IlID,
      'IlceID': IlceID,
      'BeldeID': BeldeID,
      'GirisTarihi': GirisTarihi,
      'Urunler': Urunler
    };
  }
}

class AmbarSatirEdit {
  int ID;
  int StokID;
  String L_StokID;
  int Adet;
  double Kilo;
  int Bag;
  int Kasa;
  double Fiyat;
  double KunyeNo;
  String ErrorKunyeAl;

  factory AmbarSatirEdit.fromJson(Map<String, dynamic> json) {
    return AmbarSatirEdit(
      ID: json['ID'],
      StokID: json['StokID'],
      L_StokID: json['L_StokID'],
      Adet: json['Adet'],
      Kilo: json['Kilo'],
      Bag: json['Bag'],
      Kasa: json['Kasa'],
      Fiyat: json['Fiyat'],
      KunyeNo: json['KunyeNo'],
      ErrorKunyeAl: json['ErrorKunyeAl'],
    );
  }

  AmbarSatirEdit({
    required this.ID,
    required this.StokID,
    required this.L_StokID,
    required this.Adet,
    required this.Kilo,
    required this.Bag,
    required this.Kasa,
    required this.Fiyat,
    required this.KunyeNo,
    required this.ErrorKunyeAl,
  });

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'StokID': StokID,
      'L_StokID': L_StokID,
      'Adet': Adet,
      'Kilo': Kilo,
      'Bag': Bag,
      'Kasa': Kasa,
      'Fiyat': Fiyat,
      'KunyeNo': KunyeNo,
      'ErrorKunyeAl': ErrorKunyeAl,
    };
  }
}