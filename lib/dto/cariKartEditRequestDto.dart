class CariKartEditRequestDto{
  int ID;
  int LisansID;
  String VTAdi;
  int SubeID;
  String UserName;
  String UserPass;

  CariKartEditRequestDto({
    required this.ID,
    required this.LisansID,
    required this.VTAdi,
    required this.SubeID,
    required this.UserName,
    required this.UserPass
  });

  CariKartEditRequestDto.fromJson(Map<String, dynamic> json)
      : ID = json['ID'],
        LisansID = json['LisansID'],
        SubeID = json['SubeID'],
        UserName = json['UserName'],
        UserPass = json['UserPass'],
        VTAdi = json['VTAdi'];

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'LisansID': LisansID,
      'SubeID': SubeID,
      'UserName' : UserName,
      'UserPass' : UserPass,
      'VTAdi' : VTAdi
    };
  }
}