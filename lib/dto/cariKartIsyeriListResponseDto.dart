class CariKartIsyeriListResponseDto{
  List<CariKartIsyeri> CariKartIsyeriList ;
  String? Error;

  CariKartIsyeriListResponseDto({required this.CariKartIsyeriList,required this.Error});

  factory CariKartIsyeriListResponseDto.fromJson(Map<String, dynamic> json) {

    var list = json['CariKartIsyeriList'] as List;

    List<CariKartIsyeri> carikartisyerilist = list.map((i) => CariKartIsyeri.fromJson(i))
        .toList();

    return CariKartIsyeriListResponseDto(
      Error: json['Error'] ?? "",
      CariKartIsyeriList: carikartisyerilist,
    );
  }
}

class CariKartIsyeri {
  int ID;
  int IsyeriID;
  String IsyeriAdi;
  int HalID ;
  String HalAdi;
  int IsyeriTurID;
  String L_IsyeriTurID;
  int IlID;
  String L_IlID;
  int IlceID ;
  String L_IlceID;
  int BeldeID;
  String L_BeldeID;

  CariKartIsyeri({
    required this.ID, required this.IsyeriID,required this.IsyeriAdi,required this.IlceID,required this.IlID,
    required this.BeldeID,required this.L_IlID,required this.L_IlceID,required this.L_BeldeID,
    required this.L_IsyeriTurID,required this.IsyeriTurID,required this.HalAdi,required this.HalID
  });

  factory CariKartIsyeri.fromJson(Map<String, dynamic> json) {
    return CariKartIsyeri(
      ID: json['ID'] ?? "",
      IsyeriID: json['IsyeriID'] ?? "",
      IsyeriAdi: json['IsyeriAdi'] ?? "",
      HalID: json['HalID'] ?? "",
      HalAdi: json['HalAdi'] ?? "",
      IsyeriTurID: json['IsyeriTurID'] ?? "",
      IlID: json['IlID'] ?? "",
      L_IlID: json['L_IlID'] ?? "",
      IlceID: json['IlceID'] ?? "",
      BeldeID: json['BeldeID'] ?? "",
      L_BeldeID: json['L_BeldeID'] ?? "",
      L_IlceID: json['L_IlceID'] ?? "",
      L_IsyeriTurID: json['L_IsyeriTurID'] ?? "",
    );
  }
}