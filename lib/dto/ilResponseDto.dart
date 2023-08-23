class IlResponseDto{
  List<Il>? IlList;
  String? Error;

  IlResponseDto({required this.IlList,required this.Error});

  factory IlResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['IlList'] as List;

    List<Il> ilList = list.map((i) => Il.fromJson(i)).toList();

    return IlResponseDto(
      Error: json['Error'] ?? "",
      IlList: ilList,
    );
  }
}

class Il {
  int ID;
  String IlAdi;

  Il({required this.ID, required this.IlAdi});

  factory Il.fromJson(Map<String, dynamic> json) {
    return Il(
      ID: json['ID'],
      IlAdi: json['IlAdi'],
    );
  }
}