class VergiDairesiListResponseDto{
  List<VergiDairesi>? VergiDairesiList;
  String? Error;

  VergiDairesiListResponseDto({required this.VergiDairesiList,required this.Error});

  factory VergiDairesiListResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['VergiDairesiList'] as List;

    List<VergiDairesi> vergiDairesiList = list.map((i) => VergiDairesi.fromJson(i))
        .toList();

    return VergiDairesiListResponseDto(
      Error: json['Error'] ?? "",
      VergiDairesiList: vergiDairesiList,
    );
  }
}

class VergiDairesi {
  int ID;
  String DaireAdi;

  VergiDairesi({required this.ID, required this.DaireAdi});

  factory VergiDairesi.fromJson(Map<String, dynamic> json) {
    return VergiDairesi(
      ID: json['ID'],
      DaireAdi: json['DaireAdi'],
    );
  }
}