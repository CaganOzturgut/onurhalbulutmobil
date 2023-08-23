class BeldeListResponseDto{
  List<Belde>? BeldeList;
  String? Error;

  BeldeListResponseDto({required this.BeldeList,required this.Error});

  factory BeldeListResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['BeldeList'] as List;

    List<Belde> beldeList = list.map((i) => Belde.fromJson(i)).toList();

    return BeldeListResponseDto(
      Error: json['Error'] ?? "",
      BeldeList: beldeList,
    );
  }
}

class Belde {
  int ID;
  String BeldeAdi;

  Belde({required this.ID, required this.BeldeAdi});

  factory Belde.fromJson(Map<String, dynamic> json) {
    return Belde(
      ID: json['ID'],
      BeldeAdi: json['BeldeAdi'],
    );
  }
}