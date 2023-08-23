import 'dart:convert';

class AmbarSatisEditResponseDto{
  int ID;
  int FaturaTur ;
  String L_FaturaTur;
  int CariKartSifat;
  String L_CariKartSifat ;
  int CariKartIsyeriID ;
  String L_CariKartIsyeriID ;
  int CariKartID;
  String L_CariKartID;
  String PlakaNo;
  String IrsaliyeNo;
  int IlID;
  String L_IlID;
  int IlceID;
  String L_IlceID;
  int BeldeID;
  String L_BeldeID;
  String Aciklama;
  int SoforID ;
  String L_SoforID;
  String IrsaliyeAdresi ;
  String FaturaAdresi ;
  List<AmbarSatisSatirEditResponse> Urunler;
  int Islem;
  bool EFatura;
  List<int> PDF;
  String Error;

  AmbarSatisEditResponseDto({
    required this.ID,
    required this.FaturaTur,
    required this.L_FaturaTur,
    required this.CariKartSifat,
    required this.L_CariKartSifat,
    required this.CariKartIsyeriID,
    required this.L_CariKartIsyeriID,
    required this.CariKartID,
    required this.L_CariKartID,
    required this.PlakaNo,
    required this.IrsaliyeNo,
    required this.IlID,
    required this.L_IlID,
    required this.IlceID,
    required this.L_IlceID,
    required this.BeldeID,
    required this.L_BeldeID,
    required this.Aciklama,
    required this.SoforID,
    required this.L_SoforID,
    required this.IrsaliyeAdresi,
    required this.FaturaAdresi,
    required this.Urunler,
    required this.Islem,
    required this.EFatura,
    required this.PDF,
    required this.Error
  });

  factory AmbarSatisEditResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['Urunler'] as List;

    List<AmbarSatisSatirEditResponse> urunList = list.map((i) => AmbarSatisSatirEditResponse.fromJson(i)).toList();

    var pdfData = json['PDF'];

    List<int> pdfBytes = base64.decode(pdfData);

    return AmbarSatisEditResponseDto(
        ID: json['ID'],
        FaturaTur: json['FaturaTur'],
        L_FaturaTur: json['L_FaturaTur'] ?? "",
        CariKartSifat: json['CariKartSifat'],
        L_CariKartSifat: json['L_CariKartSifat'] ?? "",
        CariKartIsyeriID: json['CariKartIsyeriID'],
        L_CariKartIsyeriID: json['L_CariKartIsyeriID'] ?? "",
        CariKartID: json['CariKartID'],
        L_CariKartID: json['L_CariKartID'] ?? "",
        PlakaNo: json['PlakaNo'],
        IlID: json['IlID'],
        L_IlID: json['L_IlID'] ?? "",
        IlceID: json['IlceID'],
        L_IlceID: json['L_IlceID'] ?? "",
        BeldeID: json['BeldeID'],
        L_BeldeID: json['L_BeldeID'] ?? "",
        Aciklama: json['Aciklama'],
        SoforID : json['SoforID'],
        L_SoforID  : json['L_SoforID'] ?? "",
        IrsaliyeAdresi : json['IrsaliyeAdresi'],
        FaturaAdresi  : json['FaturaAdresi'],
        Error: json['Error'] as String? ?? "",
        Urunler: urunList,
        EFatura: json['EFatura'],
        Islem : json['Islem '] ?? 0,
        IrsaliyeNo: json['IrsaliyeNo'],
        PDF: pdfBytes
    );
  }
}

class AmbarSatisSatirEditResponse {
  int ID;
  int AmbarSatirID;
  String L_MarkaID;
  String L_StokID;
  int KasaAdet ;
  int KasaAdetBirim;
  double BagKilo;
  int BagKiloBirim;
  double Fiyat;
  int KunyeNo;
  String ErrorKunyeAl;
  String StokText;

  AmbarSatisSatirEditResponse({
  required this.ID,required this.AmbarSatirID,required this.L_MarkaID,required this.L_StokID,
  required this.KasaAdet,required this.KasaAdetBirim,required this.BagKilo,required this.BagKiloBirim,
  required this.Fiyat,required this.KunyeNo,required this.ErrorKunyeAl,required this.StokText
  });

  factory AmbarSatisSatirEditResponse.fromJson(Map<String, dynamic> json) {
    return AmbarSatisSatirEditResponse(
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
      StokText: json['StokText'],
    );
  }
}