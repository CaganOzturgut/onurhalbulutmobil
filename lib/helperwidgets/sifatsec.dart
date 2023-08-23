import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:onurhalbulutmobil/dto/sifatListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/sifatListResponseDto.dart';
import 'package:onurhalbulutmobil/main.dart';
import 'package:onurhalbulutmobil/services/sifatListService.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';

import '../dto/cariKartEditResponseDto.dart';

class Sifat {
  final int id;
  final String name;

  Sifat({
    required this.id,
    required this.name,
  });
}

class SifatSec extends StatefulWidget {

  final CariKartEditResponseDto? cariKartEditResponseDto;
  final bool? duzenlemeMi;

  SifatSec({this.duzenlemeMi,this.cariKartEditResponseDto});

  @override
  State<StatefulWidget> createState() {
    return SifatSecState(this.duzenlemeMi,this.cariKartEditResponseDto);
  }
}

class SifatSecState extends State<SifatSec> {

  final CariKartEditResponseDto? cariKartEditResponseDto;
  final bool? duzenlemeMi;

  SifatSecState(this.duzenlemeMi,this.cariKartEditResponseDto);

  List<dynamic> _selectedSifatlar2 = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  List<dynamic> sifatList = [];
  List<MultiSelectItem<Object?>> sifatItems = [];

  late bool _loading = false;

  late SifatListService _sifatListService;

  @override
  void initState() {
    _sifatListService = SifatListService();
    getSifatList();
    super.initState();
  }

  getSifatList() {
    _loading = true;

    SifatListRequestDto sifatReq = SifatListRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        SubeID: OnurHalBulutAppSetting().subeID,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<SifatListResponseDto> sifat = _sifatListService.getSifatList(sifatReq);

    List gelen;

    sifat.then((value) async {
      if(value.SifatList != null){
        gelen = value.SifatList!.toList();
        setState(() {
          sifatList.addAll(gelen);
          print(sifatList);
        });
        final _items = sifatList.map((sifat) => MultiSelectItem<dynamic>(sifat, sifat.SifatAdi)).toList();
        setState(() {
          sifatItems = _items;
        });
      }
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("HKS Sıfat Seç",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: MediaQuery.of(context).size.height/40),),
      ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height/45),
                    child: Column(
                      children: <Widget>[
                        MultiSelectBottomSheetField(
                          isDismissible: false,
                          searchHint: "Sıfat Ara",
                          searchTextStyle: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black),
                          initialChildSize: 0.65,
                          maxChildSize: 0.65,
                          listType: MultiSelectListType.CHIP,
                          searchable: true,
                          backgroundColor: const Color(0xff10AEE4),
                          selectedColor: Colors.black87,
                          selectedItemsTextStyle: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45),
                          unselectedColor: Colors.white,
                          decoration: BoxDecoration(
                              color: const Color(0xff10AEE4),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black,
                                  width: 0.5)),
                          cancelText: Text("Vazgeç",
                            style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height/45,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),),
                          confirmText: Text("Seç",
                              style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          itemsTextStyle: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black),
                          buttonIcon: const Icon(Icons.add,color: Colors.white),
                          buttonText: Text("Sıfat Seçiniz",
                            style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height/45,
                                color: Colors.white),),
                          title: Text("Sıfatlar",
                            style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height/45,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),),
                          items: sifatItems,
                          onConfirm: (values) {
                            _selectedSifatlar2 = values;
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            onTap: (value) {
                              setState(() {
                                _selectedSifatlar2.remove(value);
                                if(_selectedSifatlar2.isEmpty){
                                  _selectedSifatlar2.length = 0;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
              child: Image.asset("assets/images/arkaplan.png",color: Colors.black12,),
            ),
            if (_loading) ...[
              Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Colors.black38),
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            child: Lottie.asset('assets/loading2.json')),
                      )
                    ],
                  )),
            ],
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height/1.5),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.pop(context,_selectedSifatlar2);
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height/17,
                    width: MediaQuery.of(context).size.width/1.1,
                    decoration: BoxDecoration(
                        color: const Color(0xff10AEE4),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Center(
                      child: Text("Kaydet",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.height/45,
                            color: Colors.white),),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}