class CariKartSifatListResponseDto{
  List<CariKartSifat> CariKartSifatList ;
  String? Error;

  CariKartSifatListResponseDto({required this.CariKartSifatList,required this.Error});

  factory CariKartSifatListResponseDto.fromJson(Map<String, dynamic> json) {

    var list = json['CariKartSifatList'] as List;

    List<CariKartSifat> carikartSifatlist = list.map((i) => CariKartSifat.fromJson(i))
        .toList();

    return CariKartSifatListResponseDto(
      Error: json['Error'] ?? "",
      CariKartSifatList: carikartSifatlist,
    );
  }
}

class CariKartSifat {
  int ID;
  String SifatAdi;

  CariKartSifat({required this.ID, required this.SifatAdi});

  factory CariKartSifat.fromJson(Map<String, dynamic> json) {
    return CariKartSifat(
      ID: json['ID'],
      SifatAdi: json['SifatAdi'],
    );
  }
}