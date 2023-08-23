import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:onurhalbulutmobil/dto/cariKartEditRequestDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartEditResponseDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartListResponseDto.dart';
import 'package:onurhalbulutmobil/pages/cariKartEkle.dart';
import 'package:onurhalbulutmobil/pages/homepage.dart';
import 'package:onurhalbulutmobil/services/cariKartEditService.dart';
import 'package:onurhalbulutmobil/services/cariKartListService.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';
import '../main.dart';

class CariKartListesi extends StatefulWidget{
  const CariKartListesi({super.key});


  @override
  CariKartListesiState createState() => CariKartListesiState();
}

class CariKartListesiState extends State<CariKartListesi> {

  TextEditingController editingController = TextEditingController();

  late CariKartEditResponseDto? cariEdit;
  late CariKartListeService _cariKartListeService;
  late CariKartEditService _cariKartEditService;

  List<dynamic> CariListe = [];

  List<dynamic> filteredItems = [];

  List<dynamic> cariEditList = [];

  bool _loading = false;
  bool duzenlemeMi = false;
  bool filtrelendi = false;

  @override
  void initState(){
    _cariKartListeService = CariKartListeService();
    _cariKartEditService = CariKartEditService();
    getCariKartList();
    // items.addAll(CariListe);
    super.initState();
  }

  getCariKartList(){
    setState(() {
      _loading = true;
    });

    final CariKartListRequestDto cari = CariKartListRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<CariKartListResponseDto> liste = _cariKartListeService.getCariKartList(cari);

    print(liste);

    List gelen;
    liste.then((value) async {
      if(value.CariKartList != null){
        gelen = value.CariKartList!.toList();
        setState(() {
          CariListe.addAll(gelen);
        });
        print(CariListe);
      }

      setState(() {
        _loading = false;
      });
    });
  }

  _cariDuzenle(editID) async{
    final CariKartEditRequestDto edit = CariKartEditRequestDto(
        ID: editID,
        LisansID: OnurHalBulutAppSetting().lisansID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        SubeID: OnurHalBulutAppSetting().subeID,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);
    CariKartEditResponseDto? editInfo = await _cariKartEditService.getCariKartEdit(edit);
    print(editInfo);

    if(editInfo.Error == ""){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
          CariKartEkle(cariKartEditResponseDto: editInfo,duzenlemeMi: duzenlemeMi,gelensayfaIndex: 0,)));
    }
    print(editID);
  }


  void filterList(String query) {

    List<dynamic> temp = [];

    CariListe.forEach((element) {
      if (element.CariKodu.toLowerCase().contains(query.toLowerCase())) {
        temp.add(element);
        setState(() {
          CariListe = temp;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomePage(yetkiListesi: OnurHalBulutAppSetting().yetkiListesi)));
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              setState(() {
                duzenlemeMi = false;
              });
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CariKartEkle(duzenlemeMi: duzenlemeMi,cariKartEditResponseDto: null,cariKartSaveRequestDto: null,gelensayfaIndex: 0,)));
            },
            child: Container(
                width: MediaQuery.of(context).size.width/7,
                child: Center(child: Icon(Icons.add,size: MediaQuery.of(context).size.height/25,))),
          )
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0xff10AEE4),
                    Color(0xff10AEE4)])
          ),
        ),
        title: Text("Cari Kart Listesi",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            fontSize: MediaQuery.of(context).size.height/40)),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                  child: Image.asset("assets/images/vatan.png",color: Colors.black12,),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.05,
                          child: TextField(
                            style: const TextStyle(color: Color.fromRGBO(15, 38, 72, 1.0)),
                            onChanged: (value) {
                              filterList(value);
                              if(value.isEmpty){
                                getCariKartList();
                              }
                            },
                            controller: editingController,
                            decoration: const InputDecoration(
                                labelText: "Ara",
                                hintText: "Ara",
                                labelStyle: TextStyle(color: Colors.black),
                                hintStyle: TextStyle(color: Colors.black),
                                iconColor: Color(0xff10AEE4),
                                prefixIcon: Icon(Icons.search,
                                    color: Color(0xff10AEE4)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.0)),
                                    borderSide: BorderSide(
                                        color: Color(0xff10AEE4),width: 1)
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff10AEE4),width: 1),
                                    borderRadius: BorderRadius.all(Radius.circular(12.0)))),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: ListView.builder(
                              itemCount: CariListe.length,
                              itemBuilder: (context, int index){
                                return Slidable(
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    dragDismissible: false,
                                    dismissible: DismissiblePane(onDismissed: () {}),
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/30),
                                            child: GestureDetector(
                                              onTap: (){
                                                _cariDuzenle(CariListe[index].ID);
                                                duzenlemeMi = true;
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context).size.height/15,
                                                width: MediaQuery.of(context).size.width/1.05,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xff10AEE4)
                                                ),
                                                child: const Center(
                                                  child: Icon(Icons.library_add,color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/30),
                                            child: Container(
                                              height: MediaQuery.of(context).size.height/15,
                                              width: MediaQuery.of(context).size.width/1.05,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red
                                              ),
                                              child: const Center(
                                                child: Icon(Icons.delete,color: Colors.white,),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/33),
                                      child: GestureDetector(
                                        onTap: (){
                                          _cariDuzenle(CariListe[index].ID);
                                          duzenlemeMi = true;
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              color: const Color(0xff10AEE4)
                                          ),
                                          height: MediaQuery.of(context).size.height/15,
                                          width: MediaQuery.of(context).size.width/1.05,
                                          child: Center(child: Text(CariListe[index].CariKodu,
                                            style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/50,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,)),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ))
                  ],
                ),
              ],
            ),
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
        ],
      ),
    );
  }
}