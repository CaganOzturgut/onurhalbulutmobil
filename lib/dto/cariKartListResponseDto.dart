class CariKartListResponseDto{
  List<CariKart>? CariKartList;
  String? Error;

  CariKartListResponseDto({required this.CariKartList,required this.Error});

  factory CariKartListResponseDto.fromJson(Map<String, dynamic> json) {

    var list = json['CariKartList'] as List;

    List<CariKart> carikartlist = list.map((i) => CariKart.fromJson(i))
        .toList();

    return CariKartListResponseDto(
      Error: json['Error'] ?? "",
      CariKartList: carikartlist,
    );
  }
}

class CariKart {
  int ID;
  String CariKodu;
  String TCKNo;

  CariKart({required this.ID, required this.CariKodu, required this.TCKNo});

  factory CariKart.fromJson(Map<String, dynamic> json) {
    return CariKart(
      ID: json['ID'],
      CariKodu: json['CariKodu'],
      TCKNo: json['TCKNo'],
    );
  }
}