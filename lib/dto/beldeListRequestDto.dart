class BeldeListRequestDto{
  int LisansID;
  String VTAdi;
  int SubeID;
  String UserName;
  String UserPass;
  int IlceID;

  BeldeListRequestDto({required this.LisansID, required this.VTAdi, required this.SubeID,required this.UserName,required this.UserPass,required this.IlceID});

  BeldeListRequestDto.fromJson(Map<String, dynamic> json)
      : LisansID = json['LisansID'],
        SubeID = json['SubeID'],
        UserName = json['UserName'],
        UserPass = json['UserPass'],
        IlceID = json['IlceID'],
        VTAdi = json['VTAdi'];

  Map<String, dynamic> toJson() {
    return {
      'LisansID': LisansID,
      'SubeID': SubeID,
      'UserName' : UserName,
      'UserPass' : UserPass,
      'VTAdi' : VTAdi,
      'IlceID' : IlceID
    };
  }

}