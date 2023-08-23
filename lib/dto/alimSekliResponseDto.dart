class AlimSekliResponseDto{
  List<AlimSekli> AlimSekliList ;
  String? Error;

  AlimSekliResponseDto({required this.AlimSekliList,required this.Error});

  factory AlimSekliResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['AlimSekliList'] as List;

    List<AlimSekli> alimSekliList = list.map((i) => AlimSekli.fromJson(i)).toList();

    return AlimSekliResponseDto(
      Error: json['Error'] ?? "",
      AlimSekliList: alimSekliList,
    );
  }
}

class AlimSekli {
  int ID;
  String AlimSekliAdi;

  AlimSekli({required this.ID, required this.AlimSekliAdi});

  factory AlimSekli.fromJson(Map<String, dynamic> json) {
    return AlimSekli(
      ID: json['ID'],
      AlimSekliAdi: json['AlimSekliAdi'],
    );
  }
}