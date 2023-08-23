class AmbarSatisListResponseDto{
  List<AmbarSatis>? AmbarSatisList;

  AmbarSatisListResponseDto({required this.AmbarSatisList});

  factory AmbarSatisListResponseDto.fromJson(Map<String, dynamic> json) {


    var list = json['AmbarSatisList'] as List;

    List<AmbarSatis> ambarSatisList = list.map((i) => AmbarSatis.fromJson(i)).toList();

    return AmbarSatisListResponseDto(
      AmbarSatisList: ambarSatisList,
    );
  }
}

class AmbarSatis {
  int ID;
  DateTime Tarih;
  String FaturaNo;
  String IrsaliyeNo;
  String CariKodu;
  double FaturaTutari;
  String EFaturaDurumu;
  String EIrsaliyeDurumu;
  int EFTur;
  String Guid;
  int EITur;
  String IGuid;
  String PlakaNo;

  AmbarSatis({required this.ID, required this.Tarih,required this.FaturaNo,required this.IrsaliyeNo,
  required this.CariKodu,required this.EFaturaDurumu,required this.EIrsaliyeDurumu,
  required this.PlakaNo, required this.FaturaTutari,required this.EFTur,required this.EITur,required this.Guid,required this.IGuid});

  factory AmbarSatis.fromJson(Map<String, dynamic> json) {
    return AmbarSatis(
      ID: json['ID'] ?? 0,
      Tarih: json['Tarih'] != null ? DateTime.parse(json['Tarih']) : DateTime.now(),
      FaturaNo: json['FaturaNo'] ?? "",
      IrsaliyeNo: json['IrsaliyeNo'] ?? "",
      CariKodu: json['CariKodu'] ?? "",
      FaturaTutari: json['FaturaTutari'] ?? 0,
      EFaturaDurumu: json['EFaturaDurumu'] ?? "",
      EIrsaliyeDurumu: json['EIrsaliyeDurumu'] ?? "",
      EFTur: json['EFTur'] ?? 0,
      Guid: json['Guid'] ?? "",
      EITur: json['EITur'] ?? 0,
      IGuid: json['IGuid'] ?? "",
      PlakaNo: json['PlakaNo'] ?? ""
    );
  }
}
