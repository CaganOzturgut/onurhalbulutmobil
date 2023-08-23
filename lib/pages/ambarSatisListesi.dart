import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:onurhalbulutmobil/dto/ambarSatisListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/ambarSatisListResponseDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartListResponseDto.dart';
import 'package:onurhalbulutmobil/dto/eFaturaPdfResponseDto.dart';
import 'package:onurhalbulutmobil/dto/eFaturePdfRequestDto.dart';
import 'package:onurhalbulutmobil/dto/stokKartRequestDto.dart';
import 'package:onurhalbulutmobil/dto/stokKartResponseDto.dart';
import 'package:onurhalbulutmobil/main.dart';
import 'package:onurhalbulutmobil/services/ambarSatisListService.dart';
import 'package:onurhalbulutmobil/services/cariKartListService.dart';
import 'package:onurhalbulutmobil/services/stokKartListService.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:select_searchable_list/select_searchable_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:table_calendar/table_calendar.dart';

import '../services/eFaturaPdfListeService.dart';

class SevkSatisKunyesiList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return SevkSatisKunyesiListState();
  }
}

class SevkSatisKunyesiListState extends State<SevkSatisKunyesiList>
    with SingleTickerProviderStateMixin{

  @override
  void initState(){
    _stokKartListService = StokKartListService();
    _cariKartListeService = CariKartListeService();
    _ambarSatisListService = AmbarSatisListService();
    _eFaturaPdfListeService = EFaturaPdfListeService();
    getStokKartList();
    getCariKartList();
    getAmbarSatisList();
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
    _urunTextEditingController.dispose();
  }

  late AnimationController _animationController;
  bool _isExpanded = false;

  final TextEditingController _urunTextEditingController = TextEditingController();
  final cariAraController = TextEditingController();
  final plakaNoController = TextEditingController();

  late EFaturaPdfListeService _eFaturaPdfListeService;

  late StokKartListService _stokKartListService;
  late List<dynamic> stokKartList = [];
  late Map<int,String> urunListesi = {};
  final List<int> _selectedCategoryValue = [0];

  late CariKartListeService _cariKartListeService;
  List<dynamic> CariListe = [];
  List<dynamic> AmbarSatisListe = [];

  late AmbarSatisListService _ambarSatisListService;

  late String secilenCari = "";
  late int secilenCariID = 0;
  late String girilenPlakaNo = "";
  DateTime? _secilenTarih; // Değişkeni null olarak başlatıyoruz
  late List<int> secilenStokKartID = [];
  late bool _loading = false;

  getPDFData(int EFTur,String Guid,int KaynakID){
    setState(() {
      _loading = true;
    });

    final EFaturaPdfRequestDto efatura = EFaturaPdfRequestDto(
      LisansID: OnurHalBulutAppSetting().lisansID,
      SubeID: OnurHalBulutAppSetting().subeID,
      VTAdi: OnurHalBulutAppSetting().vtAdi,
      UserName: OnurHalBulutApp.userDto.UserName,
      UserPass: OnurHalBulutApp.userDto.UserPass,
      EFTur: EFTur,
      Guid: Guid,
      KaynakID: KaynakID
    );

    Future<EFaturaPdfResponseDto> gelenSonuc = _eFaturaPdfListeService.getEFaturaPdf(efatura);

    print(gelenSonuc);
    List gelen;

    Uint8List convertToUint8List(List<int> bytes) {
      return Uint8List.fromList(bytes);
    }
    gelenSonuc.then((value) async{
      setState(() {
        _loading = false;
      });
      if(value.PDF.length != 0){
        Uint8List pdfData = convertToUint8List(value.PDF);

        showDialog(context: context, builder: (BuildContext context){
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Text("E-Belge",
                      style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height/40)),
                ),
                Container(
                  height: MediaQuery.of(context).size.height/2.0,
                  width: MediaQuery.of(context).size.width/1.1,
                  child: Center(
                      child: PDFView(pdfData: pdfData)),
                ),
                GestureDetector(
                  onTap: () async {
                    final tempDir = await getTemporaryDirectory();
                    final tempPath = tempDir.path;
                    final pdfPath = '$tempPath/e-belge.pdf';
                    await File(pdfPath).writeAsBytes(pdfData);
                    Share.shareXFiles([XFile(pdfPath)], text: 'PDF paylaşımı');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height/19,
                    width: MediaQuery.of(context).size.width/1.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff10AEE4)
                    ),
                    child: Center(
                      child: Text("Paylaş",
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height/19,
                    width: MediaQuery.of(context).size.width/1.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red
                    ),
                    child: Center(
                      child: Text("Kapat",
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45)),
                    ),
                  ),
                ),
              ],
            ),
            // child:
          );
        });
      }else{
        setState(() {
          _loading = false;
        });
        showDialog(context: context, builder: (BuildContext context){
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height/3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(" İlgili Fatura Bulunamadı !",
                        style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height/40,
                        color: Colors.black)),

                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height/19,
                        width: MediaQuery.of(context).size.width/1.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red
                        ),
                        child: Center(
                          child: Text("Kapat",
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45)),
                        ),
                      ),
                    ),
                  ],
                ),),
            ),
          );
        });
      }
    });
  }

  getAmbarSatisList(){
    setState(() {
      _loading = true;
    });

    final AmbarSatisListRequestDto ambarsatis = AmbarSatisListRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass,
      Tarih: _secilenTarih,
      CariKartID: secilenCariID != 0 ? secilenCariID : 0,
      PlakaNo: girilenPlakaNo.isNotEmpty ? girilenPlakaNo : "",
      StokKartID: secilenStokKartID.isNotEmpty ? secilenStokKartID.first : 0
    );

    Future<AmbarSatisListResponseDto> liste = _ambarSatisListService.getAmbarSatisList(ambarsatis);

    print(liste);
    List gelen;

    liste.then((value) async {
      if(value.AmbarSatisList !=null){
        gelen = value.AmbarSatisList!.toList();
        setState(() {
          AmbarSatisListe = value.AmbarSatisList!.toList();
          _loading = false;
          _toggleExpanded();
        });
        print(AmbarSatisListe);
      }
    });

  }

  getStokKartList() {
    setState(() {
      _loading = true;
    });

    final StokKartRequestDto stokReq = StokKartRequestDto(
      LisansID: OnurHalBulutAppSetting().lisansID,
      SubeID: OnurHalBulutAppSetting().subeID,
      VTAdi: OnurHalBulutAppSetting().vtAdi,
      UserName: OnurHalBulutApp.userDto.UserName,
      UserPass: OnurHalBulutApp.userDto.UserPass,
    );

    Future<StokKartResponseDto> stok = _stokKartListService.getStokKartList(stokReq);

    stok.then((value) async {
      if (value.StokKartList != null) {
        stokKartList = value.StokKartList!.map((item) => StokKart.fromJson(item.toJson())).toList();
        Map<int, String> mappedList = {};
        for (StokKart item in stokKartList) {
          int id = item.ID;
          String stokKodu = item.StokKodu;
          mappedList[id] = stokKodu;
          setState(() {
            urunListesi = mappedList;
          });
          // print(stokKodu);
        }
      }
      setState(() {
        _loading = false;
      });
    });
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
        // getcariIcerik(secilenCariID);
        // print(CariListe);
      }
      setState(() {
        _loading = false;
      });
    });
  }

  List<dynamic> orijinalCariListe = []; // Orijinal CariListe'yi saklayan geçici liste

  void ureticiFiltrele(String query) {
    if (orijinalCariListe.isEmpty) {
      // orijinalCariListe ilk kez dolduruluyorsa, CariListe'yi de doldur
      orijinalCariListe = List.from(CariListe);
    }

    List<dynamic> temp = [];

    if (query.isEmpty) {
      // Eğer arama sorgusu boşsa, orijinalCariListe'yi geri yükle
      temp = List.from(orijinalCariListe);
    } else {
      for (var element in orijinalCariListe) {
        if (element.CariKodu.toLowerCase().contains(query.toLowerCase())) {
          temp.add(element);
        }
      }
    }

    CariListe = temp;
    print(temp);
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  DateTime? _focusedDate = DateTime.now();



  @override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Sevk/Satış Künyesi Listesi",
            style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height/40)),
        centerTitle: true,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff10AEE4), Color(0xff10AEE4)]
              )
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: _toggleExpanded,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height/27,
                        bottom: MediaQuery.of(context).size.height/35
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height/17,
                      width: MediaQuery.of(context).size.width/1.1,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xff10AEE4),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Icon(
                                Icons.search,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.height/35),
                            Text('Filtrele',
                              style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizeTransition(
                    sizeFactor: CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.easeInOut,
                    ),
                    child: Column(
                      children: [
                        // TODO : Ghost Kombo
                        GestureDetector(
                          child: Container(),
                        ),
                        // TODO : Üretici Seç Kombosu
                        SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Üretici", style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                        ),
                        GestureDetector(
                          onTap: (){
                            cariAraController.clear();
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context){
                                  return Dialog(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context).size.height/30,
                                          ),
                                          child: Center(
                                              child: Text("Üretici Seçiniz",
                                                style: GoogleFonts.poppins(
                                                    decoration: TextDecoration.none,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: MediaQuery.of(context).size.height/45,
                                                    color: Colors.black),)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width/1.4,
                                            child: TextField(
                                              style: const TextStyle(color: Color(0xff10AEE4)),
                                              onChanged: (value) {
                                                ureticiFiltrele(value);
                                                if(value.isEmpty){
                                                  getCariKartList();}
                                              },
                                              controller: cariAraController,
                                              decoration: const InputDecoration(
                                                  labelText: "Ara",
                                                  hintText: "Ara",
                                                  labelStyle: TextStyle(color: Colors.black),
                                                  hintStyle: TextStyle(color: Colors.black),
                                                  iconColor: Color(0xff10AEE4),
                                                  prefixIcon: Icon(Icons.search,
                                                      color: Colors.black),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(17.0)),
                                                      borderSide: BorderSide(
                                                          color: Color(0xff10AEE4),width: 1)
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xff10AEE4),width: 2),
                                                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: MediaQuery.of(context).size.height/1.55,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/75),
                                              child: ListView.builder(
                                                  itemCount: CariListe.length,
                                                  itemBuilder: (context, index){
                                                    return Padding(
                                                      padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          setState(() {
                                                            secilenCari = CariListe[index].CariKodu;
                                                            secilenCariID = CariListe[index].ID;
                                                          });
                                                          Navigator.pop(context);
                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(context).size.height/19,
                                                          width: MediaQuery.of(context).size.width/1.3,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(8),
                                                              color: const Color(0xff10AEE4)
                                                          ),
                                                          child: Center(child: Text(CariListe[index].CariKodu,
                                                              textAlign: TextAlign.center,
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: MediaQuery.of(context).size.height/50,
                                                                  color: Colors.white)),),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/75),
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Container(
                                                height: MediaQuery.of(context).size.height/19,
                                                width: MediaQuery.of(context).size.width/1.35,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(8)
                                                ),
                                                child: Center(child: Text("Kapat",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: MediaQuery.of(context).size.height/50,
                                                      color: Colors.white),),),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height/17,
                            width: MediaQuery.of(context).size.width/1.1,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff10AEE4),
                            ),
                            child:Center(
                              child: secilenCari.isNotEmpty ? Text(secilenCari,
                                  style: GoogleFonts.poppins(
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.white))
                                  : Text("Üretici Seçiniz",
                                  style: GoogleFonts.poppins(
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        // TODO : Ürün Seç Kombosu
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.1,
                            child: Text("Ürün Seç",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child: DropDownTextField(

                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: "Stok Seçiniz",
                              hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              isDense: true,
                              border: InputBorder.none,),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.height/45),
                            textEditingController: _urunTextEditingController,
                            title: '',
                            hint: '',
                            options: urunListesi,
                            isSearchVisible: true,
                            selectedOptions: _selectedCategoryValue,
                            onChanged: (selectedIds) {
                              setState(() {
                                secilenStokKartID = selectedIds!;
                              });
                            },
                          ),
                        ),
                        // TODO : Plaka Input
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width/1.1,
                            child: Text("Plaka No", style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height/45,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height/17,
                            width: MediaQuery.of(context).size.width/1.1,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xff10AEE4)),
                            child: TextFormField(
                                controller: plakaNoController,
                                textAlign: TextAlign.center,
                                cursorColor: Colors.white,
                                onChanged: (value){
                                  setState(() {
                                    girilenPlakaNo = value;
                                  });
                                },
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.height/45),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: "Araç Plakası Giriniz",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.of(context).size.height/45),
                                    border: InputBorder.none))),
                        // TODO : Tarih Seç Kombosu
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: Text("Tarih", style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                        _tarihSeciciGoster(context);
                        },
                          child: Container(
                            height: MediaQuery.of(context).size.height/17,
                            width: MediaQuery.of(context).size.width/1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xff10AEE4),
                                border: Border.all(color: Colors.black,width: 0.5)
                            ),
                            child: _secilenTarih != null ? Center(
                              child: Text(
                                "${_secilenTarih!.day}-${_secilenTarih!.month}-${_secilenTarih!.year}",
                                style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ) : Center(
                              child: Text(
                                'Tarih Seçiniz',
                                style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // TODO : Listele Butonu
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 27,
                              bottom: MediaQuery.of(context).size.height / 27
                          ),
                          child: GestureDetector(
                            onTap: (){
                              getAmbarSatisList();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height/17,
                              width: MediaQuery.of(context).size.width/1.1,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.black,
                                      width: 0.5)
                              ),
                              child: Center(child: Text("Filtre Uygula",style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height / 45,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),),),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/33),
                  child: Divider(
                    color: Colors.black,
                    thickness: 1.5,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: AmbarSatisListe.length,
                    itemBuilder: (context, index) {
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
                                      getPDFData(
                                          AmbarSatisListe[index].EFTur,
                                          AmbarSatisListe[index].Guid,
                                          AmbarSatisListe[index].ID);
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/15,
                                      width: MediaQuery.of(context).size.width/1.05,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff10AEE4)
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.picture_as_pdf,color: Colors.white),
                                      ),
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
                                getPDFData(
                                    AmbarSatisListe[index].EFTur,
                                    AmbarSatisListe[index].Guid,
                                    AmbarSatisListe[index].ID);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xff10AEE4)
                                ),
                                width: MediaQuery.of(context).size.width/1.05,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment : MainAxisAlignment.spaceAround,
                                      children: [
                                        AmbarSatisListe[index].FaturaNo != null && AmbarSatisListe[index].FaturaNo.isNotEmpty ? Center(
                                          child: Text(
                                            AmbarSatisListe[index].FaturaNo,
                                            style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height / 50,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                            : Center(child: Text(
                                            "Fatura No bulunmuyor",
                                            style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height / 50,
                                              color: Colors.red,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            formatTarih(AmbarSatisListe[index].Tarih.toString()),
                                            style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/50,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                    Center(
                                        child: Text(AmbarSatisListe[index].CariKodu,
                                      style: GoogleFonts.poppins(
                                          fontSize: MediaQuery.of(context).size.height/50,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,)),
                                    Row(
                                      mainAxisAlignment : MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(AmbarSatisListe[index].PlakaNo,
                                          style: GoogleFonts.poppins(
                                            fontSize: MediaQuery.of(context).size.height / 50,
                                            color: Colors.white, // Siyah renk
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Fatura Tutarı : ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.height / 50,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "${AmbarSatisListe[index].FaturaTutari} TL",
                                                style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.height / 50,
                                                  color: Colors.black, // Siyah renk
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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
      )
  );
  }
  String formatTarih(String tarihStr) {
    DateTime dateTime = DateTime.parse(tarihStr);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  Future<void> _tarihSeciciGoster(BuildContext context) async {
    DateTime? yeniTarih = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: _secilenTarih ?? DateTime.now(),
      locale: const Locale('tr', 'TR'), // Türkçe dil için
    );
    if (yeniTarih != null) {
      setState(() {
        _secilenTarih = yeniTarih;
        print(_secilenTarih);
      });
    }
  }
}


