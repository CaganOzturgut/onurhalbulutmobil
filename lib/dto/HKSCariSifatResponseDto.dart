class HKSCariSifatResponseDto{
  bool? Kayitli;
  List<int>? SifatList;
  String? Error;

  HKSCariSifatResponseDto({required this.Kayitli,required this.Error,required this.SifatList});

  factory HKSCariSifatResponseDto.fromJson(Map<String, dynamic> json) {

    var list = json['SifatList'] as List?;
    List<int>? sifatList = list?.map((i) => i as int).toList();

    return HKSCariSifatResponseDto(
      Error: json['Error'] ?? "",
      Kayitli: json['Kayitli'],
      SifatList: sifatList,
    );
  }
}