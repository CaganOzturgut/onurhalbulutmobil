class AmbarKalanResponseDto{
  List<AmbarKalan> StokList;
  String? Error;

  AmbarKalanResponseDto({required this.StokList,required this.Error});

  factory AmbarKalanResponseDto.fromJson(Map<String, dynamic> json) {

    var list = json['StokList'] as List;

    List<AmbarKalan> stokList = list.map((i) => AmbarKalan.fromJson(i)).toList();

    return AmbarKalanResponseDto(
      Error: json['Error'] ?? "",
      StokList: stokList,
    );
  }
}

class AmbarKalan {
  int ID;
  int KasaAdetBirim;
  int BagKiloBirim;
  String L_CariKartMarkaID;
  String L_StokKartID;
  int KalanKasaAdet;
  double KalanBagKilo;
  double AmbarFiyat;

  AmbarKalan({required this.ID, required this.AmbarFiyat,
    required this.BagKiloBirim,required this.KalanKasaAdet,
    required this.KalanBagKilo ,required this.KasaAdetBirim,
    required this.L_CariKartMarkaID,required this.L_StokKartID});

  factory AmbarKalan.fromJson(Map<String, dynamic> json) {
    return AmbarKalan(
      ID: json['ID'] ?? '',
      KasaAdetBirim: json['KasaAdetBirim'] ?? '',
      BagKiloBirim: json['BagKiloBirim'] ?? '',
      L_CariKartMarkaID: json['L_CariKartMarkaID'] ?? '',
      L_StokKartID: json['L_StokKartID'] ?? '',
      KalanKasaAdet: json['KalanKasaAdet'] ?? '',
      KalanBagKilo: json['KalanBagKilo'] != null ? double.tryParse(json['KalanBagKilo'].toString()) ?? 0.0 : 0.0,
      AmbarFiyat: json['AmbarFiyat'] != null ? double.tryParse(json['AmbarFiyat'].toString()) ?? 0.0 : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'KasaAdetBirim': KasaAdetBirim,
      'BagKiloBirim': BagKiloBirim,
      'L_CariKartMarkaID': L_CariKartMarkaID,
      'L_StokKartID': L_StokKartID,
      'KalanKasaAdet': KalanKasaAdet,
      'KalanBagKilo': KalanBagKilo,
      'AmbarFiyat': AmbarFiyat,
    };
  }
}