class AmbarKalanRequestDto{
  int LisansID;
  String VTAdi;
  int SubeID;
  String UserName;
  String UserPass;
  int CariKartID;
  int CariKartIsyeriID;

  AmbarKalanRequestDto({
    required this.LisansID, required this.VTAdi,
    required this.SubeID,required this.UserName,
    required this.CariKartID,required this.UserPass,
    required this.CariKartIsyeriID});

  AmbarKalanRequestDto.fromJson(Map<String, dynamic> json)
      : LisansID = json['LisansID'],
        SubeID = json['SubeID'],
        CariKartID = json['CariKartID'],
        CariKartIsyeriID = json['CariKartIsyeriID'],
        UserName = json['UserName'],
        UserPass = json['UserPass'],
        VTAdi = json['VTAdi'];

  Map<String, dynamic> toJson() {
    return {
      'LisansID': LisansID,
      'SubeID': SubeID,
      'UserName' : UserName,
      'UserPass' : UserPass,
      'VTAdi' : VTAdi,
      'CariKartID' : CariKartID,
      'CariKartIsyeriID' : CariKartIsyeriID
    };
  }

}