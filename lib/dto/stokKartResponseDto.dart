class StokKartResponseDto{
  List<StokKart>? StokKartList ;


  StokKartResponseDto({this.StokKartList});

  factory StokKartResponseDto.fromJson(Map<String, dynamic> json) {

    var stokList = json['StokKartList'] as List;

    List<StokKart> stok = stokList.map((i) => StokKart.fromJson(i)).toList();


    return StokKartResponseDto(
      StokKartList: stok,
    );
  }
}

class StokKart {
  int ID;
  String StokKodu;
  double SatisFiyati;
  double AlisFiyati;
  String UrunKodu;

  StokKart({
    required this.ID,
    required this.StokKodu,
    required this.SatisFiyati,
    required this.AlisFiyati,
    required this.UrunKodu

  });

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'StokKodu': StokKodu,
      'SatisFiyati': SatisFiyati,
      'AlisFiyati': AlisFiyati,
      'UrunKodu': UrunKodu
    };
  }

  factory StokKart.fromJson(Map<String, dynamic> json) {
    return StokKart(
      ID: json['ID'],
      StokKodu: json['StokKodu'],
      SatisFiyati: json['SatisFiyati'],
      AlisFiyati: json['AlisFiyati'],
      UrunKodu: json['UrunKodu']
    );
  }
}