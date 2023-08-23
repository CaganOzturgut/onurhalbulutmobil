class CariTuruListResponseDto{
  List<CariTuru>? CariTuruList;
  String? Error;

  CariTuruListResponseDto({required this.CariTuruList,required this.Error});

  factory CariTuruListResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['CariTuruList'] as List;

    List<CariTuru> cariTuruList = list.map((i) => CariTuru.fromJson(i))
        .toList();

    return CariTuruListResponseDto(
      Error: json['Error'] ?? "",
      CariTuruList: cariTuruList,
    );
  }
}

class CariTuru {
  int ID;
  String CariTuruAdi;

  CariTuru({required this.ID, required this.CariTuruAdi});

  factory CariTuru.fromJson(Map<String, dynamic> json) {
    return CariTuru(
      ID: json['ID'],
      CariTuruAdi: json['CariTuruAdi'],
    );
  }
}