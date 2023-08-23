class FaturaTurListResponseDto{
  List<SatisFaturaTur> SatisFaturaTurList;
  String? Error;

  FaturaTurListResponseDto({required this.SatisFaturaTurList,required this.Error});

  factory FaturaTurListResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['SatisFaturaTurList'] as List;

    List<SatisFaturaTur> faturaTuruList = list.map((i) => SatisFaturaTur.fromJson(i)).toList();

    return FaturaTurListResponseDto(
      Error: json['Error'] ?? "",
      SatisFaturaTurList: faturaTuruList,
    );
  }
}

class SatisFaturaTur {
  int ID;
  String FaturaTuruAdi ;

  SatisFaturaTur({required this.ID, required this.FaturaTuruAdi });

  factory SatisFaturaTur.fromJson(Map<String, dynamic> json) {
    return SatisFaturaTur(
      ID: json['ID'],
      FaturaTuruAdi : json['FaturaTuruAdi'],
    );
  }
}