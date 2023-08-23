import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onurhalbulutmobil/dto/HKSIsyeriRequestDto.dart';
import 'package:onurhalbulutmobil/dto/HKSIsyeriResponseDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartSaveResponseDto.dart';
import 'package:onurhalbulutmobil/main.dart';
import 'package:onurhalbulutmobil/pages/cariKartListesi.dart';
import 'package:onurhalbulutmobil/services/HKSIsyeriAlService.dart';
import 'package:onurhalbulutmobil/services/cariKartSaveService.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';

import '../dto/cariKartEditResponseDto.dart';
import '../dto/cariKartSaveRequestDto.dart';

class HKSIsyeri extends StatefulWidget {

  final CariKartEditResponseDto? cariKartEditResponseDto;
  final CariKartSaveRequestDto? cariKartSaveRequestDto;
  final bool? duzenlemeMi;

  HKSIsyeri({this.cariKartEditResponseDto,this.duzenlemeMi,this.cariKartSaveRequestDto});

  @override
  State<StatefulWidget> createState() {
    return HKSIsyeriState(this.cariKartEditResponseDto,this.duzenlemeMi,this.cariKartSaveRequestDto);
  }
}

class HKSIsyeriState extends State<HKSIsyeri> {

  final CariKartEditResponseDto? cariKartEditResponseDto;
  final CariKartSaveRequestDto? cariKartSaveRequestDto;
  final bool? duzenlemeMi;

  HKSIsyeriState(this.cariKartEditResponseDto,this.duzenlemeMi,this.cariKartSaveRequestDto);

  late bool _loading;
  late HKSIsYeriAlService _hksIsYeriAlService;
  late List<dynamic> HKSIsList = [];
  late String hksMessage = "";
  late String hksIsyeriAdi = "";
  late bool hksdenAlindi = false;

  late CariKartSaveService _cariKartSaveService;

  @override
  void initState(){
    _hksIsYeriAlService = HKSIsYeriAlService();
    _cariKartSaveService = CariKartSaveService();
  }

  getHKSIsyeri() async {
    setState(() {
      _loading = true;
    });

    HKSIsyeriRequestDto hksReq = await HKSIsyeriRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        SubeID: OnurHalBulutAppSetting().subeID,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass,
        TCNo: cariKartEditResponseDto?.TCKNo ?? ''
    );

    HKSIsyeriResponseDto hksisyeri = await _hksIsYeriAlService.getHKSIsyeri(hksReq);

    List gelenVeri;

    if(hksisyeri.Error!.isEmpty){
      gelenVeri = hksisyeri.IsyeriList!.toList();
      HKSIsList = [];
      setState(() {
        HKSIsList.addAll(gelenVeri);
        hksdenAlindi = true;
        hksMessage = "İş Yerleri HKS'den güncellendi";
      });
    }else{
      setState(() {
        hksMessage = hksisyeri.Error.toString();
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return duzenlemeMi == true ? Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
            child: Image.asset("assets/images/arkaplan.png",color: Colors.black12,),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                child: GestureDetector(
                  onTap: (){
                    getHKSIsyeri().then((_){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return Dialog(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height/3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(hksMessage,
                                        style: GoogleFonts.poppins(
                                            fontSize: MediaQuery.of(context).size.height/45,
                                            color: Colors.black)),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height/17,
                                        width: MediaQuery.of(context).size.width/2,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: const Color(0xff10AEE4),
                                            border: Border.all(color: Colors.black,width: 0.5)
                                        ),
                                        child: Center(child: Text("Tamam",style: GoogleFonts.poppins(
                                            fontSize: MediaQuery.of(context).size.height/45,
                                            color: Colors.black),),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height/17,
                    width: MediaQuery.of(context).size.width/1.5,
                    decoration: BoxDecoration(
                        color:  const Color(0xff10AEE4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black,width: 0.5)),
                    child: Center(
                      child: Text("HKS'den Al",
                      style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.height/45,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/21,
                  width: MediaQuery.of(context).size.width/1.5,
                  child: Center(child: Text("HKS Bilgileri",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.height/40,
                      color:  Colors.black,),)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Türü Adı",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.height/50,
                    color:  Colors.black,)),
                  Text("İl İlçe Belde",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.height/50,
                    color:  Colors.black,))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/55,
                  width: MediaQuery.of(context).size.width,
                  child: const Divider(
                    color:  Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/2.25,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width/55,
                          right: MediaQuery.of(context).size.width/55,
                        ),
                        child: !hksdenAlindi ? ListView.builder(
                          itemCount: cariKartEditResponseDto?.Isyeri?.length ?? 0,
                          itemBuilder: (context, index) {
                            final isyeri = cariKartEditResponseDto?.Isyeri?[index];
                            if (isyeri != null) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/45),
                                child: Container(
                                  height: MediaQuery.of(context).size.height/15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xff10AEE4)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width:MediaQuery.of(context).size.width/2,
                                            child: Text(isyeri.L_IsyeriTurID,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: MediaQuery.of(context).size.height/65,
                                                  color:  Colors.black,)),
                                          ),
                                          SizedBox(
                                            width:MediaQuery.of(context).size.width/2,
                                            child: Text(isyeri.IsyeriAdi,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: MediaQuery.of(context).size.height/65,
                                                  color:  Colors.white,)),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:MediaQuery.of(context).size.width/3,
                                        child: Text("${isyeri.L_IlID}/${isyeri.L_IlceID}/${isyeri.L_BeldeID}",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w300,
                                              fontSize: MediaQuery.of(context).size.height/65,
                                              color:  Colors.white,)),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox.shrink(); // Null ise boş bir widget döndürme
                            }
                          },
                        ) :
                        ListView.builder(
                          itemCount: HKSIsList.length,
                          itemBuilder: (context, index) {
                            final isyeri = HKSIsList;
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/45),
                                child: Container(
                                  height: MediaQuery.of(context).size.height/15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xff10AEE4)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width:MediaQuery.of(context).size.width/2,
                                            child: Text(HKSIsList[index].L_IsyeriTurID,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: MediaQuery.of(context).size.height/65,
                                                  color:  Colors.black,)),
                                          ),
                                          SizedBox(
                                            width:MediaQuery.of(context).size.width/2,
                                            child: Text(HKSIsList[index].IsyeriAdi,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: MediaQuery.of(context).size.height/65,
                                                  color:  Colors.white,)),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:MediaQuery.of(context).size.width/3,
                                        child: Text("${HKSIsList[index].L_IlID}/${HKSIsList[index].L_IlceID}/${HKSIsList[index].L_BeldeID}",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w300,
                                              fontSize: MediaQuery.of(context).size.height/65,
                                              color:  Colors.white,)),
                                      )
                                    ],
                                  ),
                                ),
                              );
                          }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height/28,
                    top: MediaQuery.of(context).size.height/25),
                child: GestureDetector(
                  // TODO : Cari Kart Güncelleme ve Kayıt İşlemi
                  onTap: (){
                    final CariKartSaveRequestDto kaydet = CariKartSaveRequestDto(
                      VTAdi: OnurHalBulutAppSetting().vtAdi,
                      SubeID: OnurHalBulutAppSetting().subeID,
                      LisansID: OnurHalBulutAppSetting().lisansID,
                      UserName: OnurHalBulutApp.userDto.UserName,
                      UserPass: OnurHalBulutApp.userDto.UserPass,
                      ID: cariKartSaveRequestDto?.ID,
                      UreticiTipi: cariKartSaveRequestDto?.UreticiTipi,
                      Adres: cariKartSaveRequestDto?.Adres,
                      CepTel: cariKartSaveRequestDto?.CepTel,
                      PlakaNo: cariKartSaveRequestDto?.PlakaNo,
                      CariAdi: cariKartSaveRequestDto?.CariAdi,
                      CariKodu: cariKartSaveRequestDto?.CariKodu,
                      TCKNo: cariKartSaveRequestDto?.TCKNo,
                      IlID: cariKartSaveRequestDto?.IlID,
                      BeldeID: cariKartSaveRequestDto?.BeldeID,
                      IlceID: cariKartSaveRequestDto?.IlceID,
                      VergiDairesiID: cariKartSaveRequestDto?.VergiDairesiID,
                      Sifat: cariKartSaveRequestDto?.Sifat,
                      Isyeri: cariKartSaveRequestDto?.Isyeri,
                      HKSKayit: false
                    );
                    Future<CariKartSaveResponseDto> sonuc = _cariKartSaveService.getCariKartSave(kaydet);
                    print(sonuc);
                    String gelen;
                    sonuc.then((value) async {
                      setState(() {
                        _loading = false;
                      });
                      if(value.Error == ''){
                        gelen = value.Error.toString();
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                          return Dialog(
                            child: Container(
                              height: MediaQuery.of(context).size.height/3,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white38,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Kayıt İşlemi Başarılı !",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/50,
                                          color: Colors.black)),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/17),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                                        const CariKartListesi()));                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height/21,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: const Color(0xff0A85C3)
                                        ),
                                        child: Center(child: Text("Tamam",style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/50,
                                            color: Colors.white),),),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                      }else{
                        showDialog(context: context, builder: (BuildContext context){
                          return Dialog(
                            child: Container(
                              height: MediaQuery.of(context).size.height/3,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white38,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(value.Error.toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/50,
                                          color: Colors.black)),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/17),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height/21,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: const Color(0xff0A85C3)
                                        ),
                                        child: Center(child: Text("Tamam",style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/50,
                                            color: Colors.white),),),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                      }
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height/17,
                    width: MediaQuery.of(context).size.width/1.05,
                    decoration: BoxDecoration(
                        color: const Color(0xff10AEE4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color:Colors.black,width: 0.5)
                    ),
                    child: Center(child: Text("Kaydı Tamamla",style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/45,color: Colors.white),),),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ) :
    Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xff10AEE4),Color(0xff10AEE4)]
              )
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("HKS İş Yeri",style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: MediaQuery.of(context).size.height/40),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
              child: Image.asset("assets/images/arkaplan.png",color: Colors.black12,),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                  child: GestureDetector(
                    onTap: (){
                      getHKSIsyeri().then((_){
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return Dialog(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height/3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(hksMessage,
                                          style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/45,
                                              color: Colors.black)),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height/17,
                                          width: MediaQuery.of(context).size.width/2,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              color: const Color(0xff10AEE4),
                                              border: Border.all(color: Colors.black,width: 0.5)
                                          ),
                                          child: Center(child: Text("Tamam",style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/45,
                                              color: Colors.black),),),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height/17,
                      width: MediaQuery.of(context).size.width/1.5,
                      decoration: BoxDecoration(
                          color:  const Color(0xff10AEE4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black,width: 0.5)),
                      child: Center(
                        child: Text("HKS'den Al",
                          style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height/21,
                    width: MediaQuery.of(context).size.width/1.5,
                    child: Center(child: Text("HKS Bilgileri",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.height/40,
                        color:  Colors.black,),)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("Türü Adı",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.height/50,
                      color:  Colors.black,)),
                    Text("İl İlçe Belde",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.height/50,
                      color:  Colors.black,))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height/55,
                    width: MediaQuery.of(context).size.width,
                    child: const Divider(
                      color:  Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/2.25,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width/55,
                            right: MediaQuery.of(context).size.width/55,
                          ),
                          child: !hksdenAlindi ? ListView.builder(
                            itemCount: cariKartEditResponseDto?.Isyeri?.length ?? 0,
                            itemBuilder: (context, index) {
                              final isyeri = cariKartEditResponseDto?.Isyeri?[index];
                              if (isyeri != null) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/45),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/15,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color(0xff10AEE4)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width:MediaQuery.of(context).size.width/2,
                                              child: Text(isyeri.L_IsyeriTurID,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: MediaQuery.of(context).size.height/65,
                                                    color:  Colors.black,)),
                                            ),
                                            SizedBox(
                                              width:MediaQuery.of(context).size.width/2,
                                              child: Text(isyeri.IsyeriAdi,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: MediaQuery.of(context).size.height/65,
                                                    color:  Colors.white,)),
                                            )
                                          ],
                                        ),
                                        Container(
                                          width:MediaQuery.of(context).size.width/3,
                                          child: Text("${isyeri.L_IlID}/${isyeri.L_IlceID}/${isyeri.L_BeldeID}",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300,
                                                fontSize: MediaQuery.of(context).size.height/65,
                                                color:  Colors.white,)),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox.shrink(); // Null ise boş bir widget döndürme
                              }
                            },
                          ) :
                          ListView.builder(
                              itemCount: HKSIsList.length,
                              itemBuilder: (context, index) {
                                final isyeri = HKSIsList;
                                return Padding(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/45),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/15,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color(0xff10AEE4)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width:MediaQuery.of(context).size.width/2,
                                              child: Text(HKSIsList[index].L_IsyeriTurID,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: MediaQuery.of(context).size.height/65,
                                                    color:  Colors.black,)),
                                            ),
                                            SizedBox(
                                              width:MediaQuery.of(context).size.width/2,
                                              child: Text(HKSIsList[index].IsyeriAdi,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: MediaQuery.of(context).size.height/65,
                                                    color:  Colors.white,)),
                                            )
                                          ],
                                        ),
                                        Container(
                                          width:MediaQuery.of(context).size.width/3,
                                          child: Text("${HKSIsList[index].L_IlID}/${HKSIsList[index].L_IlceID}/${HKSIsList[index].L_BeldeID}",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300,
                                                fontSize: MediaQuery.of(context).size.height/65,
                                                color:  Colors.white,)),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height/28,
                      top: MediaQuery.of(context).size.height/25),
                  child: GestureDetector(
                    // TODO : Cari Kart Güncelleme ve Kayıt İşlemi
                    onTap: (){
                      final CariKartSaveRequestDto kaydet = CariKartSaveRequestDto(
                          VTAdi: OnurHalBulutAppSetting().vtAdi,
                          SubeID: OnurHalBulutAppSetting().subeID,
                          LisansID: OnurHalBulutAppSetting().lisansID,
                          UserName: OnurHalBulutApp.userDto.UserName,
                          UserPass: OnurHalBulutApp.userDto.UserPass,
                          ID: cariKartSaveRequestDto?.ID,
                          UreticiTipi: cariKartSaveRequestDto?.UreticiTipi,
                          Adres: cariKartSaveRequestDto?.Adres,
                          CepTel: cariKartSaveRequestDto?.CepTel,
                          PlakaNo: cariKartSaveRequestDto?.PlakaNo,
                          CariAdi: cariKartSaveRequestDto?.CariAdi,
                          CariKodu: cariKartSaveRequestDto?.CariKodu,
                          TCKNo: cariKartSaveRequestDto?.TCKNo,
                          IlID: cariKartSaveRequestDto?.IlID,
                          BeldeID: cariKartSaveRequestDto?.BeldeID,
                          IlceID: cariKartSaveRequestDto?.IlceID,
                          VergiDairesiID: cariKartSaveRequestDto?.VergiDairesiID,
                          Sifat: cariKartSaveRequestDto?.Sifat,
                          Isyeri: cariKartSaveRequestDto?.Isyeri,
                          HKSKayit: false
                      );
                      Future<CariKartSaveResponseDto> sonuc = _cariKartSaveService.getCariKartSave(kaydet);
                      print(sonuc);
                      String gelen;
                      sonuc.then((value) async {
                        setState(() {
                          _loading = false;
                        });
                        if(value.Error == ''){
                          gelen = value.Error.toString();
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return Dialog(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/3,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white38,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Kayıt İşlemi Başarılı !",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/50,
                                                color: Colors.black)),
                                        Padding(
                                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/17),
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                                              const CariKartListesi()));                                      },
                                            child: Container(
                                              height: MediaQuery.of(context).size.height/21,
                                              width: MediaQuery.of(context).size.width/1.5,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  color: const Color(0xff0A85C3)
                                              ),
                                              child: Center(child: Text("Tamam",style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/50,
                                                  color: Colors.white),),),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }else{
                          showDialog(context: context, builder: (BuildContext context){
                            return Dialog(
                              child: Container(
                                height: MediaQuery.of(context).size.height/3,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white38,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(value.Error.toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/50,
                                            color: Colors.black)),
                                    Padding(
                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/17),
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height/21,
                                          width: MediaQuery.of(context).size.width/1.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              color: const Color(0xff0A85C3)
                                          ),
                                          child: Center(child: Text("Tamam",style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/50,
                                              color: Colors.white),),),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                        }
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height/17,
                      width: MediaQuery.of(context).size.width/1.05,
                      decoration: BoxDecoration(
                          color: const Color(0xff10AEE4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color:Colors.black,width: 0.5)
                      ),
                      child: Center(child: Text("Kaydı Tamamla",style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/45,color: Colors.white),),),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}