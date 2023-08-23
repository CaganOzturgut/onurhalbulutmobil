class SubeRequestDto{
 int LisansID;
 String VTAdi;
 int SubeID;
 String UserName;
 String UserPass;

 SubeRequestDto({required this.LisansID, required this.VTAdi, required this.SubeID,required this.UserName,required this.UserPass});

 SubeRequestDto.fromJson(Map<String, dynamic> json)
     : LisansID = json['LisansID'],
       SubeID = json['SubeID'],
       UserName = json['UserName'],
       UserPass = json['UserPass'],
       VTAdi = json['VTAdi'];

 Map<String, dynamic> toJson() {
   return {
     'LisansID': LisansID,
     'SubeID': SubeID,
     'UserName' : UserName,
     'UserPass' : UserPass,
     'VTAdi' : VTAdi
   };
 }

}