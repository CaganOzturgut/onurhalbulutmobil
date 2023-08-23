import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:onurhalbulutmobil/dto/alimSekliRequestDto.dart';
import 'package:onurhalbulutmobil/dto/alimSekliResponseDto.dart';
import 'package:onurhalbulutmobil/dto/ambarEditRequestDto.dart';
import 'package:onurhalbulutmobil/dto/ambarEditResponseDto.dart';
import 'package:onurhalbulutmobil/dto/beldeListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/beldeListResponseDto.dart';
import 'package:onurhalbulutmobil/dto/buroListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/buroListResponseDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartListResponseDto.dart';
import 'package:onurhalbulutmobil/dto/ilRequestDto.dart';
import 'package:onurhalbulutmobil/dto/ilResponseDto.dart';
import 'package:onurhalbulutmobil/dto/ilceListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/ilceListResponseDto.dart';
import 'package:onurhalbulutmobil/dto/urunNitelikRequestDto.dart';
import 'package:onurhalbulutmobil/dto/urunNitelikResponseDto.dart';
import 'package:onurhalbulutmobil/helperwidgets/helperStorage.dart';
import 'package:onurhalbulutmobil/main.dart';
import 'package:onurhalbulutmobil/pages/homepage.dart';
import 'package:onurhalbulutmobil/services/beldeListService.dart';
import 'package:onurhalbulutmobil/services/buroListService.dart';
import 'package:onurhalbulutmobil/services/cariKartListService.dart';
import 'package:onurhalbulutmobil/services/ilListService.dart';
import 'package:onurhalbulutmobil/services/ilceListService.dart';
import 'package:onurhalbulutmobil/services/stokKunyeAlService.dart';
import 'package:onurhalbulutmobil/services/urunNitelikListService.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:select_searchable_list/select_searchable_list.dart';
import 'package:share_plus/share_plus.dart';
import '../dto/cariKartEditRequestDto.dart';
import '../dto/cariKartEditResponseDto.dart';
import '../dto/cariKartListRequestDto.dart';
import '../dto/stokKartRequestDto.dart';
import '../dto/stokKartResponseDto.dart';
import '../services/alimSekliService.dart';
import '../services/cariKartEditService.dart';
import '../services/stokKartListService.dart';

class StokKunyesiAl extends StatefulWidget{

  @override
  StokKuneyesiAlState createState() => StokKuneyesiAlState();
}
class StokKuneyesiAlState extends State<StokKunyesiAl> {

  final cariAraController = TextEditingController();
  final ilAraController = TextEditingController();
  final ilceAraController = TextEditingController();
  final beldeAraController = TextEditingController();

  final TextEditingController _urunadicontroller = TextEditingController();
  final TextEditingController _stokadetcontroller = TextEditingController();
  final TextEditingController _stokkilocontroller = TextEditingController();
  final TextEditingController _stokbagcontroller = TextEditingController();
  final TextEditingController _stokkasacontroller = TextEditingController();
  final TextEditingController _stokfiyatcontroller = TextEditingController();

  late String girilenUrunAciklama = "";
  late String girilenKilo = "";
  late String girilenKasa = "";
  late String girilenFiyat = "";
  late String girilenAdet =  "";
  late String girilenBag =  "";
  late String StokKunyeNo = "0000000000000000000";


  final List<int> _selectedCategoryValue = [];

  late StokKartListService _stokKartListService;
  late List<dynamic> stokKartList = [];
  late Map<int,String> urunListesi = {};

  List<Map<String, dynamic>> IslemList = [
    {"id": 1, "ad": "Sadece HKS Künye Al"},
    {"id": 2, "ad": "HKS Künye Al ve E-Belge (Müstahsil Makbuzu) Oluştur"},
    {"id": 3, "ad": "Sadece E-Belge Oluştur"},
  ];


  List<Map<String, dynamic>> eklenenUrunList = [];

  // TODO : Kullanıcı tarafından girilen verileri kullanarak yeni bir öğe oluşturur
  void addItem(int urunID, String urunAdi, String urunAdet, String urunBag,
      String urunKilo, String urunKasa, String urunFiyat) {
    Map<String, dynamic> newItem = {
      'urunID': urunID,
      'urunAdi': urunAdi,
      'urunAdet': urunAdet,
      'urunKilo': urunKilo,
      'urunBag' : urunBag,
      'urunKasa': urunKasa,
      'urunFiyat': urunFiyat,
    };
    eklenenUrunList.add(newItem);
    setState(() {
      urunEkle = false;
      _stokfiyatcontroller.clear();
      _stokkasacontroller.clear();
      _stokkilocontroller.clear();
      _stokbagcontroller.clear();
      _stokadetcontroller.clear();
      _urunadicontroller.clear();
    });
  }

  // TODO : Controllers
  TextEditingController alimSifatiController = TextEditingController();
  TextEditingController alimYeriController = TextEditingController();
  TextEditingController stokKartController = TextEditingController();
  TextEditingController plakaNoController = TextEditingController();
  TextEditingController ilController = TextEditingController();
  TextEditingController ilceController = TextEditingController();
  TextEditingController beldeController = TextEditingController();
  TextEditingController malNitelikController = TextEditingController();
  TextEditingController aciklamaController = TextEditingController();

  // TODO : Değişkenler
  late String secilenCari = "";
  late int secilenCariID = 0;

  late String secilenIlAdi = "";
  late int secilenIlID = 0;

  late String secilenIlceAdi = "";
  late int secilenIlceID = 0;

  late String secilenBeldeAdi = "";
  late int secilenBeldeID = 0;

  late String secilenUrunAdi = "";
  late int secilenUrunID = 0;

  late String secilenSifatAdi = "";
  late int secilenSifatID = 0;

  late String secilenIsyeriAdi = "";
  late int secilenIsyeriID = 0;

  late String secilenAlimSekliAdi = "";
  late int secilenAlimSekliID = 0;

  late String secilenIslemAdi = "";
  late int secilenIslemID = 0;

  late String BuroKodu = "";
  late int BuroID = 0;

  late String girilenPlakaNo = "";
  late String girilenAciklama = "";

  late int kunyeUrunID = 0;

  late String secilenStokUrun = "";
  late String gelenStokUrunAdi = "";

  late bool _loading;
  late bool urunEkle = false;
  late bool urunGuncelle = false;
  late String urunAdiValue = "";
  late int setlenenUrunID = 0;

  // TODO : Liste Tanımlamaları
  List<dynamic> CariListe = [];
  List<dynamic> ilList = [];
  List<dynamic> ilceList = [];
  List<dynamic> beldeList = [];
  List<dynamic> nitelikList = [];
  List<dynamic> sifatList = [];
  List<dynamic> isyeriList = [];
  List<dynamic> alimSekliList = [];
  List<AmbarSatirEdit> editUrunList = [];

  // TODO : Service Tanımlamaları
  late CariKartListeService _cariKartListeService;
  late CariKartEditService _cariKartEditService;
  late IlListService _ilListService;
  late IlceListService _ilceListService;
  late BeldeListService _beldeListService;
  late UrunNiteliktListService _niteliktListService;
  late BuroListService _buroListService;
  late StokKunyeAlService _stokKunyeAlService;
  late AlimSekliListService _alimSekliListService;

  CariKartEditResponseDto? cariEdit;

  @override
  void initState(){
    _cariKartListeService = CariKartListeService();
    _cariKartEditService = CariKartEditService();
    _ilListService = IlListService();
    _ilceListService = IlceListService();
    _beldeListService = BeldeListService();
    _niteliktListService = UrunNiteliktListService();
    _buroListService = BuroListService();
    _stokKartListService = StokKartListService();
    _stokKunyeAlService = StokKunyeAlService();
    _alimSekliListService = AlimSekliListService();
    getStokKartList();
    getCariKartList();
    getIlList();
    getUrunNitelik();
    getBuroList();
    getAlimSekli();
    super.initState();
    _loading = true;
  }

  @override
  void dispose(){
    super.dispose();
    _urunadicontroller.dispose();
  }

  // TODO : Methodlar

  getAlimSekli(){
    setState(() {
      _loading = true;
    });

    final AlimSekliRequestDto alimSekliReq = AlimSekliRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<AlimSekliResponseDto> alimSekli = _alimSekliListService.getAlimSekli(alimSekliReq);

    List gelen;
    alimSekli.then((value) async{
      gelen = value.AlimSekliList.toList();
      setState(() {
        alimSekliList.addAll(gelen);
      });
    });
    setState(() {
      _loading = false;
    });
  }

  getIlList(){
    setState(() {
      _loading = true;
    });

    final IlRequestDto ilReq = IlRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<IlResponseDto> il = _ilListService.getIlList(ilReq);

    List gelen;
    il.then((value) async {
      if(value.IlList != null){
        gelen = value.IlList!.toList();
        setState(() {
          ilList.addAll(gelen);
        });
      }
      _loading = false;
    });
  }

  getIlceList(){
    setState(() {
      _loading = true;
    });
    final IlceListRequestDto ilceReq = IlceListRequestDto(
        IlID: secilenIlID,
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<IlceListResponseDto> il = _ilceListService.getIlceList(ilceReq);

    List gelen;
    il.then((value) async {
      if(value.IlceList != null){
        gelen = value.IlceList!.toList();
        setState(() {
          ilceList.addAll(gelen);
        });
      }
      _loading = false;
    });
  }

  getBeldeList(){
    setState(() {
      _loading = true;
    });

    final BeldeListRequestDto beldeReq = BeldeListRequestDto(
        IlceID: secilenIlceID,
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<BeldeListResponseDto> belde = _beldeListService.getBeldeList(beldeReq);

    List gelen;
    belde.then((value) async {
      if(value.BeldeList != null){
        gelen = value.BeldeList!.toList();
        setState(() {
          beldeList.addAll(gelen);
        });
      }
      _loading = false;
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
        print(CariListe);
      }
      setState(() {
        _loading = false;
      });
    });
  }

  getcariIcerik(editID) async{
    setState(() {
      _loading = true;
    });
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
      setState(() {
        cariEdit = editInfo;
        plakaNoController.text = cariEdit!.PlakaNo!;
      });
      if(cariEdit!.L_IlceID!.isEmpty){
        setState(() {
          secilenIlID = cariEdit!.IlID!;
        });
        getIlceList();
      }else if(cariEdit!.L_BeldeID!.isEmpty){
        setState(() {
          secilenIlceID = cariEdit!.IlceID!;
        });
        getBeldeList();
      }
    }
    setState(() {
      _loading = false;
    });
    print(editID);
  }

  getUrunNitelik(){
    setState(() {
      _loading = true;
    });
    final UrunNitelikRequestDto urunReq = UrunNitelikRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<UrunNitelikResponseDto> nitelik = _niteliktListService.getUrunNitelikList(urunReq);

    List gelen;
    nitelik.then((value) async {
      if(value.UrunNitelikList !=null){
        gelen = value.UrunNitelikList!.toList();
        setState(() {
          nitelikList.addAll(gelen);
        });
      }
      _loading = false;
    });
  }

  getBuroList(){
    setState(() {
      _loading = true;
    });

    final BuroListRequestDto buroReq = BuroListRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<BuroListResponseDto> buro = _buroListService.getBuroList(buroReq);

    List gelen;
    buro.then((value) async{
      if(value.Error.isEmpty){
        setState(() {
          BuroID = value.ID;
          BuroKodu = value.BuroKodu;
          sifatList = value.Sifat!.toList();
          isyeriList = value.Isyeri!.toList();
        });
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
        }
        setState(() {
          _loading = false;
        });
      }
    });
  }

  getStokKunyesiAl(){

    setState(() {
      _loading = true;
    });

    for (var urunMap in eklenenUrunList) {
      double kilo = double.tryParse(urunMap['urunKilo']) ?? 0.0;
      int adet = int.tryParse(urunMap['urunAdet']) ?? 0;
      int bag = int.tryParse(urunMap['urunBag']) ?? 0;
      int kasa = int.tryParse(urunMap['urunKasa']) ?? 0;
      double fiyat = double.tryParse(urunMap['urunFiyat']) ?? 0.0;

      AmbarSatirEdit newItem = AmbarSatirEdit(
        ID: 0,
        StokID: urunMap['urunID'],
        L_StokID: urunMap['urunAdi'],
        Adet: adet,
        Kilo: kilo,
        Bag: bag,
        Kasa: kasa,
        Fiyat: fiyat,
        KunyeNo: 0,
        ErrorKunyeAl: '',
      );
      editUrunList.add(newItem);
    }

    final AmbarEditRequestDto ambarReq = AmbarEditRequestDto(
      ID: 0,
      Islem: secilenIslemID,
      AlimSekli: secilenAlimSekliID,
      BuroSifat: secilenSifatID,
      BuroIsyeriID: secilenIsyeriID,
      CariKartID: secilenCariID,
      PlakaNo: girilenPlakaNo,
      IlID: secilenIlID,
      IlceID: secilenIlceID,
      BeldeID: secilenBeldeID,
      MalNereden: secilenUrunID,
      Aciklama: girilenAciklama,
      GirisTarihi: DateTime.now().toString(),
      UserName: OnurHalBulutApp.userDto.UserName,
      UserPass: OnurHalBulutApp.userDto.UserPass,
      VTAdi: OnurHalBulutAppSetting().vtAdi,
      SubeID: OnurHalBulutAppSetting().subeID,
      LisansID: OnurHalBulutAppSetting().lisansID,
      Urunler: editUrunList
    );

    print(ambarReq);
    Future<AmbarEditResponseDto> ambar = _stokKunyeAlService.getKunyeAl(ambarReq);

    Uint8List convertToUint8List(List<int> bytes) {
      return Uint8List.fromList(bytes);
    }

    ambar.then((value) async {
      if(value.PDF.isNotEmpty){

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
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(yetkiListesi: OnurHalBulutAppSetting().yetkiListesi)));
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
        setState(() {
          _loading = false;
        });
      }
      if(value.Error.isEmpty){
        List<AmbarSatirEditResponse> urunler = value.Urunler;

        for (AmbarSatirEditResponse urun in urunler) {
          setState(() {
            StokKunyeNo = urun.KunyeNo.toString(); // KunyeNo değerini alın
          });
          print(StokKunyeNo);
        }
        print(value);
      }else{
        showDialog(context: context, builder: (BuildContext context){
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height/3,
              child: Center(child: Text(value.Error),),
            ),
          );
        });
      }
    });


  }


  // TODO : Filtreleme Methodları

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

  List<dynamic> orijinalalimYeriListe = [];

  // TODO : Alim Yeri Filtrele
  void alimYeriFiltrele(String query){

    if (orijinalalimYeriListe.isEmpty) {
      orijinalalimYeriListe = List.from(isyeriList);
    }

    List<dynamic> temp = [];

    if(query.isEmpty){
      temp = List.from(orijinalalimYeriListe);
    }else {
      for(var element in isyeriList){
        if(element.L_IsyeriTurID.toLowerCase().contains(query.toLowerCase())){
          temp.add(element);
        }
      }
    }
    isyeriList = temp;
  }

  // TODO : İL Filtrele
  List<dynamic> orijinalilListe = [];

  void ilFiltrele (String query){

    if (orijinalilListe.isEmpty) {
      orijinalilListe = List.from(ilList);
    }

    List<dynamic> temp = [];

    if(query.isEmpty){
      temp = List.from(orijinalilListe);
    }else{
      for(var element in ilList){
        if(element.IlAdi.toLowerCase().contains(query.toLowerCase())){
          temp.add(element);
        }
      }
    }
    ilList = temp;
  }

  // TODO : İLÇE Filtrele
  List<dynamic> orijinalilceListe = [];

  void ilceFiltrele (String query){

    if (orijinalilceListe.isEmpty) {
      orijinalilceListe = List.from(ilceList);
    }

    List<dynamic> temp = [];

    if(query.isEmpty){
      temp = List.from(orijinalilceListe);
    }else{
      for(var element in ilceList){
        if(element.IlceAdi.toLowerCase().contains(query.toLowerCase())){
          temp.add(element);
        }
      }
    }
    ilceList = temp;
  }

  // TODO : Belde Filtrele
  List<dynamic> orijinalbeldeListe = [];

  void beldeFiltrele (String query){

    if (orijinalbeldeListe.isEmpty) {
      orijinalbeldeListe = List.from(beldeList);
    }

    List<dynamic> temp = [];

    if(query.isEmpty){
      temp = List.from(orijinalbeldeListe);
    }else{
      for(var element in beldeList){
        if(element.BeldeAdi.toLowerCase().contains(query.toLowerCase())){
          temp.add(element);
        }
      }
    }
    beldeList = temp;
  }

  // TODO : StokKart Filtrele
  List<dynamic> orijinalstokkartListe = [];

  void stokkartFiltrele (String query){

    if (orijinalstokkartListe.isEmpty) {
      orijinalstokkartListe = List.from(stokKartList);
    }

    List<dynamic> temp = [];

    if(query.isEmpty){
      temp = List.from(orijinalstokkartListe);
    }else{
      for(var element in stokKartList){
        if(element.StokKodu.toLowerCase().contains(query.toLowerCase())){
          temp.add(element);
        }
      }
    }
    stokKartList = temp;
  }

  // TODO : Listedene Elaman Sil

  void removeItem(int index) {
    if (index >= 0 && index < eklenenUrunList.length) {
      eklenenUrunList.removeAt(index);
    }
  }

  // TODO : Stok Ürün Ekleme Validasyon

  bool stokUrunEkleValid(){
    if(secilenSifatID != 5 && girilenFiyat.isEmpty){
      return false;
    }
    if(kunyeUrunID == 0){
      return false;
    }
    if(girilenKasa.isEmpty && girilenKilo.isEmpty && girilenBag.isEmpty && girilenAdet.isEmpty){
      return false;
    }
    return true;
  }

  // TODO : Stok Ürün Edit Değer Setle

  void stokUrunEditDegerSetle(Map<String, dynamic> urun) {

    setState(() {
      // Güncellenecek ürünün değerleri
      String urunAdi = urun['urunAdi'];
      String urunAdet = urun['urunAdet'];
      String urunKilo = urun['urunKilo'];
      String urunBag = urun['urunBag'];
      String urunKasa = urun['urunKasa'];
      String urunFiyat = urun['urunFiyat'];



      // Bu değerleri ilgili girdi alanlarına veya controller'lara yerleştirilir

       secilenStokUrun = urunAdi;
       gelenStokUrunAdi = urunAdi;
      _urunadicontroller.text = urunAdi;
      _stokadetcontroller.text = urunAdet;
      _stokkilocontroller.text = urunKilo;
      _stokbagcontroller.text = urunBag;
      _stokkasacontroller.text = urunKasa;
      _stokfiyatcontroller.text = urunFiyat;

    });
  }

  void stokUrunGuncelle(Map<String, dynamic> yeniVeriler) {

    if(secilenStokUrun != gelenStokUrunAdi){
      setState(() {
        _urunadicontroller.text = gelenStokUrunAdi;
      });
    }else{
      setState(() {
        _urunadicontroller.text = secilenStokUrun;
      });
    }

    print(eklenenUrunList.first);
    // Güncellenecek ürünün urunAdi'ni bulma
    String urunAdi = yeniVeriler['urunAdi'];

    // Güncellenecek ürünün indeksini bulma
    int indeks = eklenenUrunList.indexWhere((urun) => urun['urunAdi'] == urunAdi);

    if (indeks != -1) {
      // Yeni verilerle güncelleme


      setState(() {
        eklenenUrunList[indeks]['urunAdi'] = secilenStokUrun;
        eklenenUrunList[indeks]['urunAdet'] = yeniVeriler['urunAdet'];
        eklenenUrunList[indeks]['urunKilo'] = yeniVeriler['urunKilo'];
        eklenenUrunList[indeks]['urunBag'] = yeniVeriler['urunBag'];
        eklenenUrunList[indeks]['urunKasa'] = yeniVeriler['urunKasa'];
        eklenenUrunList[indeks]['urunFiyat'] = yeniVeriler['urunFiyat'];
        urunEkle = false;
        urunGuncelle = false;
      });
    }
  }


  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
           setState(() {
             if(urunEkle == true){
               urunEkle = false;
             }else{
               setState(() {
                 _stokfiyatcontroller.clear();
                 _stokkasacontroller.clear();
                 _stokkilocontroller.clear();
                 _stokbagcontroller.clear();
                 _stokadetcontroller.clear();
                 _urunadicontroller.clear();
                 secilenStokUrun = "";
                 girilenFiyat = "";
                 girilenAdet = "";
                 girilenKilo = "";
                 girilenBag = "";
                 kunyeUrunID = 0;
               });
               Navigator.pop(context);
             }
           });
          },
          child: const Icon(Icons.arrow_back_ios_new)
        ),
        actions: [
          GestureDetector(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokUrunEkle()));
            setState(() {
              urunEkle = true;
              _stokfiyatcontroller.clear();
              _stokkasacontroller.clear();
              _stokkilocontroller.clear();
              _stokbagcontroller.clear();
              _stokadetcontroller.clear();
              _urunadicontroller.clear();
              girilenFiyat = "";
              girilenAdet = "";
              girilenKilo = "";
              girilenBag = "";
              kunyeUrunID = 0;
              secilenStokUrun = "";
            });
            },
            child: urunEkle == false ? Container(
              child: Image.asset("assets/images/kamyonicon.png"),
            ) : Container(),
          ),
        ],
        centerTitle: true,
        title: urunEkle ? Text("Stok Ürün Ekle",
            style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/40)) :
        Text("Stok Künyesi Al",
            style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/40)),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xff10AEE4),Color(0xff10AEE4)]
              )
          ),
        ),
      ),
      body: Stack(
        children: [
          urunEkle == false ?
          // TODO : STOK KÜNYESİ AL
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/55),
                    child: Container(
                      height: MediaQuery.of(context).size.height/13,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Center(
                            child: Text("Stok Detay Bilgisi",
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
                  Column(
                    children: [
                      // TODO : Üretici Combo
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
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
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
                                                          getcariIcerik(secilenCariID);
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
                                            getCariKartList();
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
                      // TODO :  Alım Sıfatı Combo
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Alım Sıfatı", style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                        ),
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
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                                        child: Center(
                                            child: Text("Alım Sıfatı Seçiniz",
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
                                              // cariFiltrele(value);
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
                                                itemCount: sifatList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          secilenSifatAdi = sifatList[index].SifatAdi;
                                                          secilenSifatID = sifatList[index].ID;
                                                          if(secilenSifatID == 5){
                                                           setState(() {
                                                             IslemList = [
                                                               {"id": 1, "ad": "Sadece HKS Künye Al"},
                                                               // {"id": 2, "ad": "HKS Künye Al ve E-Belge (Müstahsil Makbuzu) Oluştur"},
                                                               {"id": 3, "ad": "Sadece E-Belge Oluştur"},
                                                             ];
                                                           });
                                                          }else{
                                                            setState(() {
                                                              IslemList = [
                                                                {"id": 1, "ad": "Sadece HKS Künye Al"},
                                                                {"id": 2, "ad": "HKS Künye Al ve E-Belge (Müstahsil Makbuzu) Oluştur"},
                                                                {"id": 3, "ad": "Sadece E-Belge Oluştur"},
                                                              ];
                                                            });
                                                          }
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
                                                        child: Center(child: Text(sifatList[index].SifatAdi,
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
                            child: secilenSifatAdi.isNotEmpty ? Text(secilenSifatAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)) : Text("Alım Sıfatı Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      // TODO : Alım Yeri Combo
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Alım Yeri", style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // cariAraController.clear();
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context){
                                return Dialog(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                                        child: Center(
                                            child: Text("Alım Yeri Seçiniz",
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
                                              alimYeriFiltrele(value);
                                            },
                                            controller: alimYeriController,
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
                                                itemCount: isyeriList.length,
                                                itemBuilder: (context, index){
                                                  String gelenturAdi = isyeriList[index].L_IsyeriTurID;
                                                  String gelenilAdi = isyeriList[index].L_IlID;
                                                  String gelenisyeriAdi = isyeriList[index].IsyeriAdi;
                                                  // if (gelenisyeriAdi.isNotEmpty || gelenturAdi.isNotEmpty) {
                                                  //   return ListTile(
                                                  //     title: Text(gelenisyeriAdi.isNotEmpty ? gelenisyeriAdi : gelenturAdi),
                                                  //   );
                                                  // } else {
                                                  //   return Container();
                                                  // }
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          if(gelenisyeriAdi.isNotEmpty){
                                                            secilenIsyeriAdi = isyeriList[index].IsyeriAdi;
                                                          }else{
                                                            secilenIsyeriAdi = isyeriList[index].L_IsyeriTurID +" / "+ isyeriList[index].L_IlID;
                                                          }
                                                          secilenIsyeriID = isyeriList[index].ID;
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
                                                        child: Center(
                                                          child: Text(gelenisyeriAdi.isNotEmpty ? gelenisyeriAdi : gelenturAdi + " / " + gelenilAdi,
                                                              textAlign: TextAlign.center,
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: MediaQuery.of(context).size.height/55,
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
                            child: secilenIsyeriAdi.isNotEmpty ? Text(secilenIsyeriAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)) : Text("Alım Yeri Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      // TODO : Alım Şekli
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Alım Şekli", style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                        ),
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
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                                        child: Center(
                                            child: Text("Alım Şekli Seçiniz",
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
                                              // cariFiltrele(value);
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
                                                itemCount: alimSekliList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          secilenAlimSekliAdi = alimSekliList[index].AlimSekliAdi;
                                                          secilenAlimSekliID = alimSekliList[index].ID;
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
                                                        child: Center(
                                                          child: Text(alimSekliList[index].AlimSekliAdi,
                                                              textAlign: TextAlign.center,
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: MediaQuery.of(context).size.height/55,
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
                            child: secilenAlimSekliAdi.isNotEmpty ? Text(secilenAlimSekliAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)) : Text("Alım Yeri Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      //TODO : İşlem
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("İşlem Türü", style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // cariAraController.clear();
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context){
                                return Dialog(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                                        child: Center(
                                            child: Text("İşlem Türü Seçiniz",
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
                                              // cariFiltrele(value);
                                            },
                                            // controller: cariAraController,
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
                                                itemCount: IslemList.length,
                                                itemBuilder: (context, index){
                                                  final item = IslemList[index];
                                                  final id = item['id'];
                                                  final ad = item['ad'];
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          secilenIslemAdi = ad;
                                                          secilenIslemID = id;
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
                                                        child: Center(
                                                          child: Text(ad,
                                                              textAlign: TextAlign.center,
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: MediaQuery.of(context).size.height/55,
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
                            child: secilenIslemAdi.isNotEmpty ? Text(secilenIslemAdi,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)) : Text("İşlem Türü Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      // TODO : İl Combo
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("İl", style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          ilAraController.clear();
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context){
                                return Dialog(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                                        child: Container(
                                            child: Center(
                                                child: Text("İl Seçiniz",
                                                  style: GoogleFonts.poppins(
                                                      decoration: TextDecoration.none,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: MediaQuery.of(context).size.height/45,
                                                      color: Colors.black),))),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width/1.4,
                                          child: TextField(
                                            style: const TextStyle(color: Color(0xff10AEE4)),
                                            onChanged: (value) {
                                              ilFiltrele(value);
                                              },
                                            controller: ilAraController,
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
                                                itemCount: ilList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          secilenIlAdi = ilList[index].IlAdi;
                                                          secilenIlID = ilList[index].ID;
                                                        });
                                                        Navigator.pop(context);
                                                        getIlceList();
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/19,
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: const Color(0xff10AEE4)
                                                        ),
                                                        child: Center(child: Text(ilList[index].IlAdi,
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
                                            getIlList();
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
                          height: MediaQuery.of(context).size.height / 17,
                          width: MediaQuery.of(context).size.width / 1.1,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child:  Center(
                            child: secilenIlAdi.isNotEmpty ?
                            Text(secilenIlAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height / 45,
                                    color: Colors.white)) : cariEdit?.L_IlID != null ?
                            Text(cariEdit!.L_IlID!,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height / 45,
                                    color: Colors.white)) :
                            Text("İl Seçiniz" ,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height / 45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      // TODO : İlce Combo
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("İlçe", style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // cariAraController.clear();
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context){
                                return Dialog(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                                        child: Center(
                                            child: Text("İlçe Seçiniz",
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
                                              ilceFiltrele(value);
                                            },
                                            controller: ilceAraController,
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
                                                itemCount: ilceList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          secilenIlceAdi = ilceList[index].IlceAdi;
                                                          secilenIlceID = ilceList[index].ID;
                                                        });
                                                        Navigator.pop(context);
                                                        getBeldeList();
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/19,
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: const Color(0xff10AEE4)
                                                        ),
                                                        child: Center(
                                                          child: Text(ilceList[index].IlceAdi,
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
                                            getIlceList();
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
                            child: secilenIlceAdi.isNotEmpty ?
                            Text(secilenIlceAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)) : cariEdit?.L_IlceID !=null ?
                            Text(cariEdit!.L_IlceID!,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height / 45,
                                    color: Colors.white)) :
                            Text("İlçe Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      // TODO: Belde Combo
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Belde", style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // cariAraController.clear();
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context){
                                return Dialog(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                                        child: Center(
                                            child: Text("Belde Seçiniz",
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
                                              beldeFiltrele(value);
                                            },
                                            controller: beldeAraController,
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
                                                itemCount: beldeList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          secilenBeldeAdi = beldeList[index].BeldeAdi;
                                                          secilenBeldeID = beldeList[index].ID;
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
                                                        child: Center(child: Text(beldeList[index].BeldeAdi,
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
                                            getBeldeList();
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
                            child: secilenBeldeAdi.isNotEmpty ?
                            Text(secilenBeldeAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)) : cariEdit?.L_BeldeID !=null ?
                            Text(cariEdit!.L_BeldeID!.isEmpty ? "Belde Seçiniz" : cariEdit!.L_BeldeID!,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height / 45,
                                    color: Colors.white)) :
                            Text("Belde Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      // TODO : Plaka No
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
                      // TODO : Mal Nitelik Combo
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Ürün Nitelik", style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                        ),
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
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                                        child: Center(
                                            child: Text("Ürün Nitelik Seçiniz",
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
                                              // cariFiltrele(value);
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
                                                itemCount: nitelikList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          secilenUrunAdi = nitelikList[index].NitelikAdi;
                                                          secilenUrunID = nitelikList[index].ID;
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
                                                        child: Center(child: Text(nitelikList[index].NitelikAdi,
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
                            child: secilenUrunAdi.isNotEmpty ? Text(secilenUrunAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)) : Text("Ürün Nitelik Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      // TODO : Açıklama
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Açıklama", style: GoogleFonts.poppins(
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
                              controller: aciklamaController,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              onChanged: (value){
                                setState(() {
                                  girilenAciklama = value;
                                });
                              },
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Açıklama Giriniz",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.height/45),
                                  border: InputBorder.none))),
                    ],
                  ),
                  // TODO : Butonlar ve Kayıtlı Stok Bilgisi
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/75),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height/70,
                              bottom: MediaQuery.of(context).size.height/40),
                          child: Container(
                            height: MediaQuery.of(context).size.height/17,
                            width: MediaQuery.of(context).size.width/1.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width/2.5,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff10AEE4),
                                      border: Border.all(color: Colors.black,width: 0.5),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Text("Temizle",style: GoogleFonts.poppins(color: Colors.white,fontSize: MediaQuery.of(context).size.height/45),),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return Dialog(
                                            child: Container(
                                              height: MediaQuery.of(context).size.height/4,
                                              color: Colors.white,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/21),
                                                      child: Container(
                                                        child: Text("Vazgeçmek istediğinize emin misiniz? Girdiğiniz bilgiler kaybolacaktır.",
                                                          textAlign: TextAlign.center,
                                                          style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,
                                                              color: Colors.black),),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap:(){
                                                            Navigator.pop(context);
                                                          },
                                                          child: Container(
                                                            height: MediaQuery.of(context).size.height/21,
                                                            width: MediaQuery.of(context).size.width/3,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              color: const Color(0xff10AEE4),
                                                            ),
                                                            child: Center(child: Text("İptal",
                                                              style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,color: Colors.white),)),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: (){
                                                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomePage(yetkiListesi: OnurHalBulutAppSetting().yetkiListesi)));
                                                          },
                                                          child: Container(
                                                              height: MediaQuery.of(context).size.height/21,
                                                              width: MediaQuery.of(context).size.width/3,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                color: const Color(0xff10AEE4),
                                                              ),
                                                              child: Center(child: Text("Tamam",
                                                                style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,color: Colors.white),))
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/2.5,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff10AEE4),
                                        border: Border.all(color: Colors.black,width: 0.5),
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text("Vazgeç",style: GoogleFonts.poppins(color: Colors.white,fontSize: MediaQuery.of(context).size.height/45),),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height/70),
                          child: GestureDetector(
                            onTap: (){
                              // TODO: KAYDET İŞLEMİNDEN SONRA OLACAK
                              if(eklenenUrunList.isEmpty){
                                showDialog(
                                    context: context, builder: (BuildContext context){
                                  return Dialog(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/4,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/21),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width/2,
                                                child: Text("Künye için ürün eklemeniz gerekmektedir",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,
                                                      color: Colors.black),),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      urunEkle = true;
                                                    });
                                                  },
                                                  child: Container(
                                                      height: MediaQuery.of(context).size.height/21,
                                                      width: MediaQuery.of(context).size.width/3,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: const Color(0xff10AEE4),
                                                      ),
                                                      child: Center(child: Text("Tamam",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: MediaQuery.of(context).size.height/55,
                                                            color: Colors.white),))
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              }else if(secilenSifatAdi.isEmpty || secilenIsyeriAdi.isEmpty ||
                                  secilenUrunAdi.isEmpty || secilenCari.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Lütfen zorunlu alanları doldurun.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }else{
                                getStokKunyesiAl();
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/55),
                              child: Container(
                                height: MediaQuery.of(context).size.height/17,
                                width: MediaQuery.of(context).size.width/1.1,
                                decoration: BoxDecoration(
                                    color: const Color(0xff10AEE4),
                                    border: Border.all(color: Colors.black,width: 0.5),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Text("Künye Al",
                                    style: GoogleFonts.poppins(color: Colors.white,
                                        fontSize: MediaQuery.of(context).size.height/45),),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/1.04,
                          child: Center(
                            child: Text("Kayıtlı Stok Bilgisi",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.black)),
                          ),
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
                        ),
                        eklenenUrunList.isNotEmpty ? Container(
                          height: MediaQuery.of(context).size.height/2,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              itemCount: eklenenUrunList.length,
                              itemBuilder: (context , int index){
                                Map<String, dynamic> urun = eklenenUrunList[index];
                                return  Slidable(
                                  closeOnScroll: true,
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      dragDismissible: false,
                                      dismissible: DismissiblePane(onDismissed: () {}),
                                      children: [
                                        // TODO : Düzenle Butonu
                                        Expanded(
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/30),
                                              // TODO : Ürün Ekle Edit
                                              child: GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    urunEkle = true;
                                                    urunGuncelle = true;
                                                    stokUrunEditDegerSetle(urun);
                                                  });
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height/15,
                                                  width: MediaQuery.of(context).size.width/1.05,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(0xff10AEE4)
                                                  ),
                                                  child: const Center(
                                                    child: Icon(Icons.edit_outlined,color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // TODO : Sil Butonu
                                        Expanded(
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/30),
                                              child: GestureDetector(
                                                onTap: (){
                                                  removeItem(index);
                                                  showDialog(
                                                      context: context, builder: (BuildContext context){
                                                    return Dialog(
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/3,
                                                        width: MediaQuery.of(context).size.width,
                                                        color: Colors.white38,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            Text("Silme İşlemi Başarılı !",
                                                                textAlign: TextAlign.center,
                                                                style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/50,
                                                                    color: Colors.black)),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/17),
                                                              child: GestureDetector(
                                                                onTap: (){
                                                                  Navigator.pop(context);
                                                                  setState(() {
                                                                    eklenenUrunList;
                                                                  });
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

                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height/15,
                                                  width: MediaQuery.of(context).size.width/1.05,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red
                                                  ),
                                                  child: const Center(
                                                    child: Icon(Icons.delete,color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: Accordion(
                                      disableScrolling: true,
                                      headerBackgroundColorOpened: Colors.black54,
                                      scaleWhenAnimating: true,
                                      openAndCloseAnimation: true,
                                      paddingListBottom: 0,
                                      headerPadding:
                                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                                      sectionClosingHapticFeedback: SectionHapticFeedback.light,
                                      children: [
                                        AccordionSection(
                                          headerBackgroundColor: const Color(0xff10AEE4),
                                          contentBorderColor: Colors.black, isOpen: true,
                                        // leftIcon: const Icon(Icons.food_bank, color: Colors.white),
                                        leftIcon: Image.asset("assets/images/urun.png",color: Colors.white,scale: 25,),
                                        header: Column(
                                          children: [
                                            Text(urun['urunAdi'], style: _headerStyle),
                                            Text("Stok Künyesi",
                                              style:  TextStyle(
                                                  fontSize: MediaQuery.of(context).size.height/50,
                                                  color: Colors.white),),

                                            Text(StokKunyeNo,style:  TextStyle(
                                                fontSize: MediaQuery.of(context).size.height/40,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black))
                                          ],
                                        ),
                                        content: DataTable(
                                          dividerThickness: 2,
                                          sortAscending: true,
                                          sortColumnIndex: 1,
                                          dataRowHeight: 50,
                                          columnSpacing: MediaQuery.of(context).size.width/17,
                                          showBottomBorder: false,
                                          columns: const [
                                            DataColumn(
                                                label: Text('Adet')),
                                            DataColumn(
                                                label: Text('Kilo'),
                                                numeric: true),
                                            DataColumn(
                                                label: Text('Bağ',)),
                                            DataColumn(
                                                label: Text('Kasa',)),
                                            DataColumn(
                                                label: Text('Fiyat',),
                                                numeric: true),
                                          ],
                                          rows: [
                                            DataRow(
                                              cells: [
                                                DataCell(
                                                    Container(
                                                        child: Center(
                                                          child: Text(urun['urunAdet'].toString(),
                                                            style: _contentStyle,textAlign: TextAlign.center,),
                                                        ))),
                                                DataCell(
                                                    Container(
                                                        child: Center(
                                                          child: Text(urun['urunKilo'].toString(),
                                                              style: _contentStyle,textAlign: TextAlign.center),
                                                        ))),
                                                DataCell(
                                                    Container(
                                                        child: Center(
                                                          child: Text(urun['urunBag'].toString(),
                                                              style: _contentStyle,textAlign: TextAlign.center),
                                                        ))),
                                                DataCell(
                                                    Container(
                                                        child: Center(
                                                          child: Text(urun['urunKasa'].toString(),
                                                              style: _contentStyle,textAlign: TextAlign.center),
                                                        ))),
                                                DataCell(
                                                    Container(
                                                        child: Center(
                                                          child: Text(urun['urunFiyat'].toString(),
                                                              style: _contentStyle,textAlign: TextAlign.center),
                                                        )))
                                              ],
                                            ),
                                          ],

                                        ),
                                      ),
                                    ],
                                  )
                                );
                              }),
                        ) : Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/35),
                              child: Container(
                                child: Text("Eklenen Ürün yok!",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.black)),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ) :
          // TODO : STOK ÜRÜN EKLE
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // TODO : Ürün Seç
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.1,
                      child: Text("Ürün Seç",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.height/45,
                            fontWeight: FontWeight.w500,
                            color: Colors.black) ,),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      stokKartController.clear();
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context){
                            return Dialog(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                                    child: Center(
                                        child: Text("Ürün Seçiniz",
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
                                          stokkartFiltrele(value);
                                          if(value.isEmpty){
                                            getStokKartList();
                                          }
                                        },
                                        controller: stokKartController,
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
                                            itemCount: stokKartList.length,
                                            itemBuilder: (context, index){
                                              return Padding(
                                                padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                       secilenStokUrun = stokKartList[index].StokKodu;
                                                       _urunadicontroller.text = secilenStokUrun;
                                                       kunyeUrunID = stokKartList[index].ID;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height/16,
                                                    width: MediaQuery.of(context).size.width/1.3,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: const Color(0xff10AEE4)
                                                    ),
                                                    child: Center(child: Text(stokKartList[index].StokKodu,
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
                                        getStokKartList();
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
                        child: secilenStokUrun.isNotEmpty ? Text(secilenStokUrun,
                            style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height/45,
                                color: Colors.white))
                            : Text("Ürün Seçiniz",
                            style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height/45,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                  // TODO : Adet
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/65),
                    child: Container(
                        width: MediaQuery.of(context).size.width/1.1,
                        child: Text("Adet",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black),)
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
                        color: const Color(0xff10AEE4),
                      ),
                      child: TextFormField(
                          controller: _stokadetcontroller,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.white,
                          onChanged: (value){
                            setState(() {
                              girilenAdet = value;
                            });
                          },
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Adet Giriniz",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              border: InputBorder.none))
                  ),
                  // TODO : Kilo
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/65),
                    child: Container(
                        width: MediaQuery.of(context).size.width/1.1,
                        child: Text("Kilo",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black),)
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
                        color: const Color(0xff10AEE4),
                      ),
                      child: TextFormField(
                          controller: _stokkilocontroller,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.white,
                          onChanged: (value){
                            setState(() {
                              girilenKilo = value;
                            });
                          },
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Kilo Giriniz",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              border: InputBorder.none))
                  ),
                  // TODO : Bağ
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/65),
                    child: Container(
                        width: MediaQuery.of(context).size.width/1.1,
                        child: Text("Bağ",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black),)
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
                        color: const Color(0xff10AEE4),
                      ),
                      child: TextFormField(
                          controller: _stokbagcontroller,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.white,
                          onChanged: (value){
                            setState(() {
                              girilenBag = value;
                            });
                          },
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Bağ Giriniz",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              border: InputBorder.none))
                  ),
                  // TODO : Kasa
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/65),
                    child: Container(
                        width: MediaQuery.of(context).size.width/1.1,
                        child: Text("Kasa",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black),)
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
                        color: const Color(0xff10AEE4),
                      ),
                      child: TextFormField(
                          controller: _stokkasacontroller,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.white,
                          onChanged: (value){
                            setState(() {
                              girilenKasa = value;
                            });
                          },
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Kasa Giriniz",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              border: InputBorder.none))
                  ),
                  // TODO : Fiyat
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/65),
                    child: Container(
                        width: MediaQuery.of(context).size.width/1.1,
                        child: Text("Fiyat",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black),)
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
                      color: const Color(0xff10AEE4),
                    ),
                    child: TextFormField(
                        controller: _stokfiyatcontroller,
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white,
                        onChanged: (value){
                          setState(() {
                            girilenFiyat = value;
                          });
                        },
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height/45),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Fiyat Giriniz",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.height/45),
                            border: InputBorder.none)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/12,bottom: MediaQuery.of(context).size.height/21 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // TODO : Temizle
                        GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return Dialog(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/3,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/21),
                                              child: Container(
                                                child: Text("Girdiğiniz bilgileri temizlemek istediğinize emin misiniz ?",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: MediaQuery.of(context).size.height/45,
                                                      color: Colors.black),),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height/21,
                                                    width: MediaQuery.of(context).size.width/3,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: const Color(0xff10AEE4),
                                                    ),
                                                    child: Center(child: Text("Hayır",
                                                      style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,color: Colors.white),)),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap:(){
                                                    setState(() {
                                                      Navigator.pop(context);
                                                      _stokfiyatcontroller.clear();
                                                      _stokkasacontroller.clear();
                                                      _stokkilocontroller.clear();
                                                      _stokbagcontroller.clear();
                                                      _stokadetcontroller.clear();
                                                      _urunadicontroller.clear();
                                                    });
                                                  },
                                                  child: Container(
                                                      height: MediaQuery.of(context).size.height/21,
                                                      width: MediaQuery.of(context).size.width/3,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: const Color(0xff10AEE4),
                                                      ),
                                                      child: Center(child: Text("Evet",
                                                        style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,color: Colors.white),))
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height/17,
                            width: MediaQuery.of(context).size.width/3.5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff10AEE4),
                            ),
                            child: Center(
                              child: Text("Temizle", style: GoogleFonts.poppins(color: Colors.white,fontSize: MediaQuery.of(context).size.height/45,fontWeight: FontWeight.w500),),
                            ),
                          ),
                        ),
                        // TODO : Vazgeç
                        GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return Dialog(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/3,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/21),
                                              child: Container(
                                                child: Text("Vazgeçmek istediğinize emin misiniz? Girdiğiniz bilgiler kaybolacaktır.",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: MediaQuery.of(context).size.height/50,
                                                      color: Colors.black),),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height/21,
                                                    width: MediaQuery.of(context).size.width/3,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: const Color(0xff10AEE4),
                                                    ),
                                                    child: Center(child: Text("Vazgeç",
                                                      style: GoogleFonts.poppins(
                                                          fontSize: MediaQuery.of(context).size.height/55,
                                                          color: Colors.white),)),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      urunEkle = false;
                                                      _stokfiyatcontroller.clear();
                                                      _stokkasacontroller.clear();
                                                      _stokkilocontroller.clear();
                                                      _stokbagcontroller.clear();
                                                      _stokadetcontroller.clear();
                                                      _urunadicontroller.clear();
                                                    });
                                                  },
                                                  child: Container(
                                                      height: MediaQuery.of(context).size.height/21,
                                                      width: MediaQuery.of(context).size.width/3,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: const Color(0xff10AEE4),
                                                      ),
                                                      child: Center(child: Text("Tamam",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: MediaQuery.of(context).size.height/55,
                                                            color: Colors.white),))
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height/17,
                            width: MediaQuery.of(context).size.width/3.5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff10AEE4),
                            ),
                            child: Center(
                              child: Text("Vazgeç", style: GoogleFonts.poppins(color: Colors.white,fontSize: MediaQuery.of(context).size.height/45,fontWeight: FontWeight.w500),),
                            ),
                          ),
                        ),
                        // TODO : Güncelle
                       urunGuncelle ? GestureDetector(
                         // TODO: GÜNCELLE İŞLEMİNDEN SONRA OLACAK
                         onTap: (){
                           stokUrunGuncelle({
                             'urunAdi': _urunadicontroller.text,
                             'urunAdet': _stokadetcontroller.text,
                             'urunKilo': _stokkilocontroller.text,
                             'urunBag': _stokbagcontroller.text,
                             'urunKasa': _stokkasacontroller.text,
                             'urunFiyat': _stokfiyatcontroller.text,

                           });
                           },
                         child: Container(
                           height: MediaQuery.of(context).size.height/17,
                           width: MediaQuery.of(context).size.width/3.5,
                           decoration: BoxDecoration(
                             border: Border.all(
                                 color: Colors.black,
                                 width: 0.5),
                             borderRadius: BorderRadius.circular(12),
                             color: const Color(0xff10AEE4),
                           ),
                           child: Center(
                             child: Text("Güncelle",
                               style: GoogleFonts.poppins(color: Colors.white,
                                   fontSize: MediaQuery.of(context).size.height/45,
                                   fontWeight: FontWeight.w500),),
                           ),
                         ),
                       )
                       // TODO : Kaydet
                           : GestureDetector(
                          // TODO: KAYDET İŞLEMİNDEN SONRA OLACAK
                          onTap: (){
                            if(stokUrunEkleValid()){
                              addItem(kunyeUrunID, _urunadicontroller.value.text,
                                  girilenAdet, girilenBag, girilenKilo, girilenKasa, girilenFiyat);
                              setState(() {
                                urunEkle = false;
                                _stokfiyatcontroller.clear();
                                _stokkasacontroller.clear();
                                _stokkilocontroller.clear();
                                _stokbagcontroller.clear();
                                _stokadetcontroller.clear();
                                _urunadicontroller.clear();
                                girilenFiyat = "";
                                girilenAdet = "";
                                girilenKilo = "";
                                girilenBag = "";
                                kunyeUrunID = 0;
                              });
                            }else{
                              if(secilenSifatID !=5 && girilenFiyat.isEmpty){
                                // TODO : Fiyat Kontrol Dialog
                                showDialog(
                                    context: context, builder: (BuildContext context){
                                  return Dialog(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/3,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white38,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Lütfen Fiyat bilgisi giriniz",
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
                              }else if(kunyeUrunID == 0){
                                // TODO : Ürün Kontrol Dialog
                                showDialog(
                                    context: context, builder: (BuildContext context){
                                  return Dialog(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/3,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white38,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Lütfen Ürün Seçiniz",
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
                              }else{
                                // TODO : Adet , Bağ , Kilo , Kasa Dialog
                                showDialog(
                                    context: context, builder: (BuildContext context){
                                  return Dialog(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/3,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white38,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Adet, Kilo , Bağ ve Kasa bilgilerinden en az 1 tanesini doldurunuz.",
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
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height/17,
                            width: MediaQuery.of(context).size.width/3.5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff10AEE4),
                            ),
                            child: Center(
                              child: Text("Kaydet",
                                style: GoogleFonts.poppins(color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    fontWeight: FontWeight.w500),),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
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
