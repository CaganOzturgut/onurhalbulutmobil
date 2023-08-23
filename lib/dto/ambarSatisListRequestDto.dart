class AmbarSatisListRequestDto{
  int? LisansID;
  String? VTAdi;
  int? SubeID;
  String? UserName;
  String? UserPass;
  DateTime? Tarih;
  int? CariKartID;
  String? PlakaNo;
  int? StokKartID;

 AmbarSatisListRequestDto({
   this.Tarih,this.CariKartID,this.PlakaNo,this.StokKartID,this.LisansID,
 this.VTAdi,this.SubeID,this.UserName,this.UserPass});

 AmbarSatisListRequestDto.fromJson(Map<String, dynamic> json)
     : Tarih = json['Tarih'],
       CariKartID = json['CariKartID'],
       PlakaNo = json['PlakaNo'],
       StokKartID = json['StokKartID'],
       LisansID = json['LisansID'],
       VTAdi = json['VTAdi'],
       SubeID = json['SubeID'],
       UserName = json['UserName'],
       UserPass = json['UserPass'];

 Map<String, dynamic> toJson() {
   return {
     'Tarih': Tarih?.toIso8601String(),
     'CariKartID': CariKartID,
     'PlakaNo' : PlakaNo,
     'StokKartID' : StokKartID,
     'LisansID' : LisansID,
     'VTAdi' : VTAdi,
     'SubeID' : SubeID,
     'UserName' : UserName,
     'UserPass' : UserPass
   };
 }

}