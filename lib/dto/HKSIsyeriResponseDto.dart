class HKSIsyeriResponseDto {
  String? Error;
  List<HKS_Isyeri>? IsyeriList;

  HKSIsyeriResponseDto({required this.Error,required this.IsyeriList});

  factory HKSIsyeriResponseDto.fromJson(Map<String, dynamic> json) {

    var list = json['IsyeriList'] as List;

    List<HKS_Isyeri> hksislist = list.map((i) => HKS_Isyeri.fromJson(i)).toList();

    return HKSIsyeriResponseDto(
      Error: json['Error'] ?? "",
      IsyeriList: hksislist,
    );
  }
}

class HKS_Isyeri {
  int ID;
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

  HKS_Isyeri({required this.ID, required this.IsyeriAdi,required this.HalID,required this.HalAdi,
  required this.IsyeriTurID,required this.L_IsyeriTurID,required this.IlID,required this.L_IlID,required this.IlceID,required this.L_IlceID,
    required this.BeldeID,required this.L_BeldeID,required this.Adres});

  factory HKS_Isyeri.fromJson(Map<String, dynamic> json) {
    return HKS_Isyeri(
      ID: json['ID'] == null ? '' : json["ID"],
      IsyeriAdi: json['IsyeriAdi'] == null ? '' : json["IsyeriAdi"],
      HalID: json['HalID'] == null ? '' : json["HalID"],
      HalAdi: json['HalAdi'] == null ? '' : json["HalAdi"],
      IsyeriTurID: json['IsyeriTurID'] == null ? '' : json["IsyeriTurID"],
      L_IsyeriTurID: json['L_IsyeriTurID'] == null ? '' : json["L_IsyeriTurID"],
      IlID: json['IlID'] == null ? '' : json["IlID"],
      L_IlID: json['L_IlID'] == null ? '' : json["L_IlID"],
      IlceID: json['IlceID'] == null ? '' : json["IlceID"],
      L_IlceID: json['L_IlceID'] == null ? '' : json["L_IlceID"],
      BeldeID: json['BeldeID'] == null ? '' : json["BeldeID"],
      L_BeldeID: json['L_BeldeID'] == null ? '' : json["L_BeldeID"],
      Adres: json['Adres'] == null ? '' : json["Adres"],
    );
  }
}