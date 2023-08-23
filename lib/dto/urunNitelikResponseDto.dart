class UrunNitelikResponseDto{
  List<UrunNitelik>? UrunNitelikList;
  String? Error;

  UrunNitelikResponseDto({required this.UrunNitelikList,this.Error});

  factory UrunNitelikResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['UrunNitelikList'] as List;

    List<UrunNitelik> urunNitelikList = list.map((i) => UrunNitelik.fromJson(i))
        .toList();

    return UrunNitelikResponseDto(
      UrunNitelikList: urunNitelikList,
      Error: json['Error'] ?? "",
    );
  }
}

class UrunNitelik {
  int ID;
  String NitelikAdi;

  UrunNitelik({required this.ID, required this.NitelikAdi});

  factory UrunNitelik.fromJson(Map<String, dynamic> json) {
    return UrunNitelik(
      ID: json['ID'],
      NitelikAdi: json['NitelikAdi'],
    );
  }
}