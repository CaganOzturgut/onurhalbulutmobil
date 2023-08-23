class IlceListResponseDto{
  List<Ilce>? IlceList;
  String? Error;

  IlceListResponseDto({required this.IlceList,required this.Error});

  factory IlceListResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['IlceList'] as List;

    List<Ilce> ilceList = list.map((i) => Ilce.fromJson(i)).toList();

    return IlceListResponseDto(
      Error: json['Error'] ?? "",
      IlceList: ilceList,
    );
  }
}

class Ilce {
  int ID;
  String IlceAdi;

  Ilce({required this.ID, required this.IlceAdi});

  factory Ilce.fromJson(Map<String, dynamic> json) {
    return Ilce(
      ID: json['ID'],
      IlceAdi: json['IlceAdi'],
    );
  }
}