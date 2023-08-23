class SifatListResponseDto{
  List<Sifat>? SifatList;
  String? Error;

  SifatListResponseDto({required this.SifatList,required this.Error});

  factory SifatListResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['SifatList'] as List;

    List<Sifat> sifatList = list.map((i) => Sifat.fromJson(i))
        .toList();

    return SifatListResponseDto(
      Error: json['Error'] ?? "",
      SifatList: sifatList,
    );
  }
}

class Sifat {
  int ID;
  String SifatAdi;

  Sifat({required this.ID, required this.SifatAdi});

  factory Sifat.fromJson(Map<String, dynamic> json) {
    return Sifat(
      ID: json['ID'],
      SifatAdi: json['SifatAdi'],
    );
  }
}