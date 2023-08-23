class SubeResponseDto{
  List<Sube>? SubeList;
  String? Error;

  SubeResponseDto({required this.SubeList,required this.Error});

  factory SubeResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['SubeList'] as List;

    List<Sube> subeler = list.map((i) => Sube.fromJson(i))
        .toList();

    return SubeResponseDto(
      Error: json['Error'] ?? "",
      SubeList: subeler,
    );
  }
}

class Sube {
  int ID;
  String SubeAdi;
  String MenuYetki;

  Sube({required this.ID, required this.SubeAdi, required this.MenuYetki});

  factory Sube.fromJson(Map<String, dynamic> json) {
    return Sube(
      ID: json['ID'],
      SubeAdi: json['SubeAdi'],
      MenuYetki: json['MenuYetki'],
    );
  }
}