class SoforListResponseDto{
  List<Sofor> SoforList;
  String? Error;

  SoforListResponseDto({required this.SoforList,this.Error});

  factory SoforListResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['SoforList'] as List;

    List<Sofor> soforList = list.map((i) => Sofor.fromJson(i))
        .toList();

    return SoforListResponseDto(
      SoforList: soforList,
      Error: json['Error'] ?? "",
    );
  }
}

class Sofor {
  int ID;
  String SoforAdi;
  String SoforTCNo;
  String SoforCepTel;

  Sofor({required this.ID, required this.SoforAdi,required this.SoforCepTel,required this.SoforTCNo});

  factory Sofor.fromJson(Map<String, dynamic> json) {
    return Sofor(
      ID: json['ID'],
      SoforAdi: json['SoforAdi'],
      SoforTCNo: json['SoforTCNo'],
      SoforCepTel: json['SoforCepTel']
    );
  }
}