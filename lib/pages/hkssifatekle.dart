import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:onurhalbulutmobil/dto/HKSCariSifatRequestDto.dart';
import 'package:onurhalbulutmobil/dto/HKSCariSifatResponseDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartEditResponseDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartSaveRequestDto.dart';
import 'package:onurhalbulutmobil/dto/sifatListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/sifatListResponseDto.dart';
import 'package:onurhalbulutmobil/helperwidgets/sifatsec.dart';
import 'package:onurhalbulutmobil/main.dart';
import 'package:onurhalbulutmobil/pages/hksisyeri.dart';
import 'package:onurhalbulutmobil/services/HKSSifatAlService.dart';
import 'package:onurhalbulutmobil/services/sifatListService.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';

import 'cariKartEkle.dart';

class HKSSifatEkle extends StatefulWidget{

  final CariKartEditResponseDto? cariKartEditResponseDto;
  final CariKartSaveRequestDto? cariKartSaveRequestDto;
  final bool duzenlemeMi;


  HKSSifatEkle({this.cariKartEditResponseDto,required this.duzenlemeMi,this.cariKartSaveRequestDto});

  @override
  State<StatefulWidget> createState() {
    return HKSSifatEkleState(cariKartEditResponseDto,duzenlemeMi,cariKartSaveRequestDto);
  }
}

class HKSSifatEkleState extends State<HKSSifatEkle> {

  late final CariKartEditResponseDto? cariKartEditResponseDto;
  late final CariKartSaveRequestDto? cariKartSaveRequestDto;
  late final bool duzenlemeMi;

  HKSSifatEkleState(this.cariKartEditResponseDto,this.duzenlemeMi,this.cariKartSaveRequestDto);

  final _multiSelectKey = GlobalKey<FormFieldState>();

  List<dynamic> sifatList = [];
  List<CariKartTanimSifatDTO> secilenSifatlar = [];

  late bool _loading = false;
  late List<int> sifatAdiList = [];
  late List<dynamic> seciliGelenSifatlar = [];

  late SifatListService _sifatListService;
  late HKSSifatAlService _hksSifatAlService;

  late String hksMessage = "";
  late bool dialogGoster = false;
  late bool hksdenAlindi = false;
  late bool sifatEklendi = false;
  late String hksSifatAdi = "";
  late String eklenenSifatAdi = "";

  ScrollController _scrollController = ScrollController();

  @override
  void initState(){
    _sifatListService = SifatListService();
    _hksSifatAlService = HKSSifatAlService();
    getSifatList();
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(0);
    });
  }

  getSifatList() async {

    setState(() {
      CariKartSaveRequestDto _cariKartSaveRequestDto = CariKartSaveRequestDto();
      _loading = true;
    });

    SifatListRequestDto sifatReq = SifatListRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        SubeID: OnurHalBulutAppSetting().subeID,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    SifatListResponseDto sifat = await _sifatListService.getSifatList(sifatReq);

    List gelen;

      if(sifat.SifatList != null){
        gelen = sifat.SifatList!.toList();
        setState(() {
          sifatList.addAll(gelen);
          // if(gelenSeciliSifatlar !=null){
          //   sifatList.addAll(gelenSeciliSifatlar!);
          // }
          if (cariKartEditResponseDto?.Sifat != null) {
            secilenSifatlar.addAll(
              cariKartEditResponseDto!.Sifat!.map((item) => item),
            );
          }
          print(sifatList);
        });

        final _items = sifatList.map((sifat) => MultiSelectItem<dynamic>(sifat, sifat.SifatAdi)).toList();
        print(_items);
      }

      setState(() {
        _loading = false;
      });
  }

  getHKSSifatAL() async {

    setState(() {
      _loading = true;
    });

    HKSCariSifatRequestDto hksReq = HKSCariSifatRequestDto(
      LisansID: OnurHalBulutAppSetting().lisansID,
      VTAdi: OnurHalBulutAppSetting().vtAdi,
      SubeID: OnurHalBulutAppSetting().subeID,
      UserName: OnurHalBulutApp.userDto.UserName,
      UserPass: OnurHalBulutApp.userDto.UserPass,
      TCNo: cariKartEditResponseDto?.TCKNo ?? cariKartSaveRequestDto?.TCKNo ?? '',
    );

    HKSCariSifatResponseDto hkssifat = await _hksSifatAlService.getHKSSifat(hksReq);

    if (hkssifat.Error != null) {

      List<int> gelen = hkssifat.SifatList!.toList();

      setState(() {

        cariKartEditResponseDto!.Sifat = []; // Önce mevcut liste içeriğini temizleyin

        sifatList.forEach((sifat) {

          if (gelen.contains(sifat.ID)) {
            CariKartTanimSifatDTO sifatDTO = CariKartTanimSifatDTO(
              L_SifatID: sifat.SifatAdi,
              SifatID: sifat.ID,
              Varsayilan: true,
              ID: 0,
            );

            CariKartTanimSifatSaveDTO sifatSaveDTO = CariKartTanimSifatSaveDTO(
                ID: 0,
                SifatID: sifat.ID,
                L_SifatID: sifat.SifatAdi,
                Varsayilan: true
            );

            cariKartEditResponseDto!.Sifat!.add(sifatDTO); // Karşılık gelen sıfatları ekleyin
            cariKartSaveRequestDto!.Sifat!.add(sifatSaveDTO);

          }
        });
        hksMessage = "Sıfatlar HKS'den güncellendi";
      });
    }

    setState(() {
      _loading = false;
      dialogGoster = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return !duzenlemeMi ? Scaffold(
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
        title: Text("Cari Kart Sıfat Ekle",style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: MediaQuery.of(context).size.height/40),),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: GestureDetector(
                    onTap: (){
                      getHKSSifatAL().then((_){
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
                      width: MediaQuery.of(context).size.width/2.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff10AEE4),
                          border: Border.all(color: Colors.black,
                              width: 0.5)
                      ),
                      child: Center(child: Text("HKS'den Al",
                          style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.white))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: GestureDetector(
                    onTap: ()async{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SifatSec();
                        },
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            sifatEklendi = true;
                            List<CariKartTanimSifatDTO> newSifatList = [];
                            List<CariKartTanimSifatSaveDTO> saveSifatList = [];

                            for (var item in value) {
                              int sifatID = int.tryParse(item.ID.toString()) ?? 0;
                              String sifatAdi = item.SifatAdi.toString();

                              CariKartTanimSifatDTO sifatDTO = CariKartTanimSifatDTO(
                                ID: 0,
                                SifatID: sifatID,
                                L_SifatID: sifatAdi,
                                Varsayilan: true,
                              );

                              CariKartTanimSifatSaveDTO saveSifatDto = CariKartTanimSifatSaveDTO(
                                  ID: 0,
                                  SifatID: sifatID,
                                  L_SifatID: sifatAdi,
                                  Varsayilan: true);

                              saveSifatList.add(saveSifatDto);
                              newSifatList.add(sifatDTO);
                            }
                            secilenSifatlar.addAll(newSifatList);
                            cariKartSaveRequestDto?.Sifat?.addAll(saveSifatList);
                            cariKartEditResponseDto?.Sifat?.addAll(newSifatList);
                          });
                        }
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height/17,
                      width: MediaQuery.of(context).size.width/2.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff10AEE4),
                          border: Border.all(color: Colors.black,width: 0.5)
                      ),
                      child: Center(child: Text("Sıfat Seç",style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.height/45,
                          color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/27),
              child: SizedBox(
                height: MediaQuery.of(context).size.height/13,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Center(
                      child: Text("Sıfatlar",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.height/40,
                            color: Colors.black),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height/30,
                        width: MediaQuery.of(context).size.width,
                        child: const Divider(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/2.0,
              child: ListView.builder(
                  itemCount: secilenSifatlar.length,
                  itemBuilder: (context,int index){
                    return Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30),
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 15,
                                  width: MediaQuery.of(context).size.width / 1.05,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: const Center(
                                    child: Icon(Icons.delete, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 33),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff10AEE4),
                            ),
                            height: MediaQuery.of(context).size.height / 15,
                            width: MediaQuery.of(context).size.width / 1.05,
                            child: Center(
                              child: Text(
                                secilenSifatlar[index].L_SifatID,
                                style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height / 50,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height/2.0,
            //   child: ListView.builder(
            //     controller: _scrollController,
            //     itemCount: cariKartEditResponseDto?.Sifat?.length ?? cariKartSaveRequestDto?.Sifat?.length,
            //     itemBuilder: (context, int index) {
            //       final sifat = cariKartEditResponseDto?.Sifat?[index];
            //       final saveSifat = cariKartSaveRequestDto?.Sifat?[index];
            //       if (hksdenAlindi && cariKartEditResponseDto != null) {
            //         cariKartEditResponseDto!.Sifat![index].L_SifatID = hksSifatAdi;
            //       }
            //       if(hksdenAlindi && cariKartEditResponseDto != null){
            //         cariKartSaveRequestDto!.Sifat![index].L_SifatID = hksSifatAdi;
            //       }
            //       if (sifat != null && duzenlemeMi) {
            //         return Padding(
            //           padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/100),
            //           child: Slidable(
            //             key: const ValueKey(0),
            //             endActionPane: ActionPane(
            //               motion: const ScrollMotion(),
            //               dismissible: DismissiblePane(onDismissed: () {}),
            //               children: [
            //                 Expanded(
            //                   child: Center(
            //                     child: Padding(
            //                       padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30),
            //                       child: Container(
            //                         height: MediaQuery.of(context).size.height / 15,
            //                         width: MediaQuery.of(context).size.width / 1.05,
            //                         decoration: const BoxDecoration(
            //                           shape: BoxShape.circle,
            //                           color: Colors.red,
            //                         ),
            //                         child: const Center(
            //                           child: Icon(Icons.delete, color: Colors.white),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             child: Center(
            //               child: Padding(
            //                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 33),
            //                 child: Container(
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(12),
            //                     color: const Color(0xff10AEE4),
            //                   ),
            //                   height: MediaQuery.of(context).size.height / 15,
            //                   width: MediaQuery.of(context).size.width / 1.05,
            //                   child: Center(
            //                     child: Text(
            //                       sifat.L_SifatID,
            //                       style: GoogleFonts.poppins(
            //                         fontSize: MediaQuery.of(context).size.height / 50,
            //                         color: Colors.white,
            //                       ),
            //                       textAlign: TextAlign.center,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         );
            //       } else {
            //         return Slidable(
            //           key: const ValueKey(0),
            //           endActionPane: ActionPane(
            //             motion: const ScrollMotion(),
            //             dismissible: DismissiblePane(onDismissed: () {}),
            //             children: [
            //               Expanded(
            //                 child: Center(
            //                   child: Padding(
            //                     padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30),
            //                     child: Container(
            //                       height: MediaQuery.of(context).size.height / 15,
            //                       width: MediaQuery.of(context).size.width / 1.05,
            //                       decoration: const BoxDecoration(
            //                         shape: BoxShape.circle,
            //                         color: Colors.red),
            //                       child: const Center(
            //                         child: Icon(Icons.delete, color: Colors.white),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           child: Center(
            //             child: Padding(
            //               padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 33),
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(12),
            //                   color: const Color(0xff10AEE4),
            //                 ),
            //                 height: MediaQuery.of(context).size.height / 15,
            //                 width: MediaQuery.of(context).size.width / 1.05,
            //                 child: Center(
            //                   child: Text(
            //                     saveSifat!.L_SifatID,
            //                     style: GoogleFonts.poppins(
            //                       fontSize: MediaQuery.of(context).size.height / 50,
            //                       color: Colors.white,
            //                     ),
            //                     textAlign: TextAlign.center,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ); // Null ise boş bir widget döndürme
            //       }
            //     },
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/40),
              child: Center(
                child: GestureDetector(
                  // TODO : Sıfat Kaydet Butonu Arkası
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (BuildContext context) => HKSIsyeri(
                      duzenlemeMi: duzenlemeMi,
                      cariKartSaveRequestDto: cariKartSaveRequestDto,
                      cariKartEditResponseDto: cariKartEditResponseDto)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xff10AEE4)
                    ),
                    height: MediaQuery.of(context).size.height/17,
                    width: MediaQuery.of(context).size.width/1.05,
                    child: Center(
                      child: Text("Kaydet",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45)),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ) : Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: GestureDetector(
                      onTap: (){
                        getHKSSifatAL().then((_){
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
                        width: MediaQuery.of(context).size.width/2.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                            border: Border.all(color: Colors.black,
                                width: 0.5)
                        ),
                        child: Center(child: Text("HKS'den Al",
                            style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height/45,
                                color: Colors.white))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: GestureDetector(
                      onTap: ()async{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SifatSec();
                          },
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              sifatEklendi = true;
                              List<CariKartTanimSifatDTO> newSifatList = [];
                              List<CariKartTanimSifatSaveDTO> saveSifatList = [];

                              for (var item in value) {
                                int sifatID = int.tryParse(item.ID.toString()) ?? 0;
                                String sifatAdi = item.SifatAdi.toString();

                                CariKartTanimSifatDTO sifatDTO = CariKartTanimSifatDTO(
                                  ID: 0,
                                  SifatID: sifatID,
                                  L_SifatID: sifatAdi,
                                  Varsayilan: true,
                                );

                                CariKartTanimSifatSaveDTO saveSifatDto = CariKartTanimSifatSaveDTO(
                                    ID: 0,
                                    SifatID: sifatID,
                                    L_SifatID: sifatAdi,
                                    Varsayilan: true);

                                saveSifatList.add(saveSifatDto);
                                newSifatList.add(sifatDTO);
                              }
                              secilenSifatlar.addAll(newSifatList);
                              cariKartSaveRequestDto?.Sifat?.addAll(saveSifatList);
                              cariKartEditResponseDto?.Sifat?.addAll(newSifatList);
                            });
                          }
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height/17,
                        width: MediaQuery.of(context).size.width/2.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                            border: Border.all(color: Colors.black,width: 0.5)
                        ),
                        child: Center(child: Text("Sıfat Seç",style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.height/45,
                            color: Colors.white))),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/27),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/13,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Center(
                        child: Text("Sıfatlar",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height/40,
                              color: Colors.black),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height/30,
                          width: MediaQuery.of(context).size.width,
                          child: const Divider(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/2.0,
                child: ListView.builder(
                  itemCount: secilenSifatlar.length,
                    itemBuilder: (context,int index){
                              return Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  dismissible: DismissiblePane(onDismissed: () {}),
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30),
                                          child: Container(
                                            height: MediaQuery.of(context).size.height / 15,
                                            width: MediaQuery.of(context).size.width / 1.05,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red),
                                            child: const Center(
                                              child: Icon(Icons.delete, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 33),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color(0xff10AEE4),
                                      ),
                                      height: MediaQuery.of(context).size.height / 15,
                                      width: MediaQuery.of(context).size.width / 1.05,
                                      child: Center(
                                        child: Text(
                                          secilenSifatlar[index].L_SifatID,
                                          style: GoogleFonts.poppins(
                                            fontSize: MediaQuery.of(context).size.height / 50,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                    }),
              ),
              // TODO : Düzenle Sifatlar
              // SizedBox(
              //   height: MediaQuery.of(context).size.height/2.0,
              //   child: ListView.builder(
              //     controller: _scrollController,
              //     itemCount: (cariKartEditResponseDto?.Sifat?.length ?? 0)
              //         + (cariKartSaveRequestDto?.Sifat?.length ?? 0),
              //     itemBuilder: (context, int index) {
              //       if (index < (cariKartEditResponseDto?.Sifat?.length ?? 0)) {
              //         final sifat = cariKartEditResponseDto?.Sifat?[index];
              //         if (hksdenAlindi && cariKartEditResponseDto != null) {
              //           cariKartEditResponseDto!.Sifat![index].L_SifatID = hksSifatAdi;
              //         }
              //         return Padding(
              //           padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 100),
              //           child: Slidable(
              //             key: const ValueKey(0),
              //             endActionPane: ActionPane(
              //               motion: const ScrollMotion(),
              //               dismissible: DismissiblePane(onDismissed: () {}),
              //               children: [
              //                 Expanded(
              //                   child: Center(
              //                     child: Padding(
              //                       padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30),
              //                       child: Container(
              //                         height: MediaQuery.of(context).size.height / 15,
              //                         width: MediaQuery.of(context).size.width / 1.05,
              //                         decoration: const BoxDecoration(
              //                           shape: BoxShape.circle,
              //                           color: Colors.red,
              //                         ),
              //                         child: const Center(
              //                           child: Icon(Icons.delete, color: Colors.white),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             child: Center(
              //               child: Padding(
              //                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 33),
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(12),
              //                     color: const Color(0xff10AEE4),
              //                   ),
              //                   height: MediaQuery.of(context).size.height / 15,
              //                   width: MediaQuery.of(context).size.width / 1.05,
              //                   child: Center(
              //                     child: Text(
              //                       sifat!.L_SifatID,
              //                       style: GoogleFonts.poppins(
              //                         fontSize: MediaQuery.of(context).size.height / 50,
              //                         color: Colors.white,
              //                       ),
              //                       textAlign: TextAlign.center,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       }else {
              //         final saveSifat = cariKartSaveRequestDto?.Sifat?[index - (cariKartEditResponseDto?.Sifat?.length ?? 0)];
              //         if (hksdenAlindi && cariKartSaveRequestDto != null) {
              //           cariKartSaveRequestDto!.Sifat![index - (cariKartEditResponseDto?.Sifat?.length ?? 0)].L_SifatID = hksSifatAdi;
              //         }
              //         return Slidable(
              //           key: const ValueKey(0),
              //           endActionPane: ActionPane(
              //             motion: const ScrollMotion(),
              //             dismissible: DismissiblePane(onDismissed: () {}),
              //             children: [
              //               Expanded(
              //                 child: Center(
              //                   child: Padding(
              //                     padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30),
              //                     child: Container(
              //                       height: MediaQuery.of(context).size.height / 15,
              //                       width: MediaQuery.of(context).size.width / 1.05,
              //                       decoration: const BoxDecoration(
              //                         shape: BoxShape.circle,
              //                         color: Colors.red,
              //                       ),
              //                       child: const Center(
              //                         child: Icon(Icons.delete, color: Colors.white),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //           child: Center(
              //             child: Padding(
              //               padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 33),
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(12),
              //                   color: const Color(0xff10AEE4),
              //                 ),
              //                 height: MediaQuery.of(context).size.height / 15,
              //                 width: MediaQuery.of(context).size.width / 1.05,
              //                 child: Center(
              //                   child: Text(
              //                     saveSifat!.L_SifatID,
              //                     style: GoogleFonts.poppins(
              //                       fontSize: MediaQuery.of(context).size.height / 50,
              //                       color: Colors.white,
              //                     ),
              //                     textAlign: TextAlign.center,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       }
              //     },
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/40),
                child: Center(
                  child: GestureDetector(
                    // TODO : Sıfat Kaydet Butonu Arkası
                    onTap: (){
                      // setState(() {
                      //   duzenlemeMi = true;
                      // });
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                          CariKartEkle(duzenlemeMi: duzenlemeMi,cariKartSaveRequestDto: cariKartSaveRequestDto,cariKartEditResponseDto: cariKartEditResponseDto,gelensayfaIndex: 3,)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xff10AEE4)
                      ),
                      height: MediaQuery.of(context).size.height/17,
                      width: MediaQuery.of(context).size.width/1.05,
                      child: Center(
                          child: Text("Kaydet",
                              style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height/45)),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
         if (_loading && duzenlemeMi == false) ...[
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
      ],
    );
  }
}
