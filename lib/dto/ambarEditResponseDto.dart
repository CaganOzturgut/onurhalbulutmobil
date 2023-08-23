import 'dart:convert';
import 'dart:ffi';

class AmbarEditResponseDto{
  int ID;
  int AlimSekli;
  String L_AlimSekli;
  String FaturaNo;
  int BuroSifat;
  String L_BuroSifat;
  int BuroIsyeriID;
  String L_BuroIsyeriID;
  int CariKartID;
  String L_CariKartID;
  String PlakaNo;
  int IlID;
  String L_IlID;
  int IlceID;
  String L_IlceID;
  int BeldeID;
  String L_BeldeID;
  int MalNereden;
  String L_MalNereden;
  String Aciklama;
  String GirisTarihi;
  String Error;
  bool EFatura;
  List<int> PDF;
  List<AmbarSatirEditResponse> Urunler;

  AmbarEditResponseDto({required this.ID,required this.AlimSekli,required this.L_AlimSekli,
    required this.BuroSifat,required this.L_BuroSifat,required this.IlceID,required this.L_BeldeID,required this.IlID,
  required this.PlakaNo,required this.L_IlceID,required this.L_IlID,required this.BeldeID,required this.L_MalNereden,required this.MalNereden,
  required this.Aciklama,required this.BuroIsyeriID,required this.CariKartID,required this.GirisTarihi,required this.L_BuroIsyeriID,
  required this.L_CariKartID,required this.Urunler,required this.Error,required this.EFatura,required this.FaturaNo,required this.PDF});

  factory AmbarEditResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['Urunler'] as List;

    List<AmbarSatirEditResponse> urunList = list.map((i) => AmbarSatirEditResponse.fromJson(i)).toList();

    var pdfData = json['PDF'];

    List<int> pdfBytes = base64.decode(pdfData);

    return AmbarEditResponseDto(
      ID: json['ID'],
      AlimSekli: json['AlimSekli'],
      L_AlimSekli: json['L_AlimSekli'] ?? "",
      BuroSifat: json['BuroSifat'],
      L_BuroSifat: json['L_BuroSifat'] ?? "",
      BuroIsyeriID: json['BuroIsyeriID'],
      L_BuroIsyeriID: json['L_BuroIsyeriID'] ?? "",
      CariKartID: json['CariKartID'],
      L_CariKartID: json['L_CariKartID'] ?? "",
      PlakaNo: json['PlakaNo'],
      IlID: json['IlID'],
      L_IlID: json['L_IlID'] ?? "",
      IlceID: json['IlceID'],
      L_IlceID: json['L_IlceID'] ?? "",
      BeldeID: json['BeldeID'],
      L_BeldeID: json['L_BeldeID'] ?? "",
      MalNereden: json['MalNereden'],
      L_MalNereden: json['L_MalNereden'] ?? "",
      Aciklama: json['Aciklama'],
      GirisTarihi: json['GirisTarihi'],
      Error: json['Error'] as String? ?? "",
      Urunler: urunList,
      EFatura: json['EFatura'],
      FaturaNo: json['FaturaNo'],
      PDF: pdfBytes
    );
  }
}

class AmbarSatirEditResponse {
  int ID;
  int StokID;
  String L_StokID;
  int Adet;
  double Kilo;
  int Bag;
  int Kasa;
  double Fiyat;
  int KunyeNo;
  String ErrorKunyeAl;

  AmbarSatirEditResponse({required this.ID, required this.StokID,required this.L_StokID,required this.Adet,
  required this.Kilo,required this.Bag,required this.Kasa,required this.Fiyat,required this.KunyeNo,required this.ErrorKunyeAl});

  factory AmbarSatirEditResponse.fromJson(Map<String, dynamic> json) {
    return AmbarSatirEditResponse(
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
}