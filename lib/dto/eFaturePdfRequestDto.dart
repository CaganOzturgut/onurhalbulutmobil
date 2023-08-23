class EFaturaPdfRequestDto{
  int LisansID;
  String VTAdi;
  int SubeID;
  String UserName;
  String UserPass;
  int KaynakID;
  int EFTur;
  String Guid;

  EFaturaPdfRequestDto({
    required this.LisansID, required this.VTAdi,
    required this.SubeID,required this.UserName,
    required this.KaynakID,required this.UserPass,
    required this.EFTur,required this.Guid});

  EFaturaPdfRequestDto.fromJson(Map<String, dynamic> json)
      : LisansID = json['LisansID'],
        SubeID = json['SubeID'],
        KaynakID = json['KaynakID'],
        EFTur = json['EFTur'],
        Guid = json['Guid'],
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
      'KaynakID' : KaynakID,
      'EFTur' : EFTur,
      'Guid' : Guid
    };
  }
}