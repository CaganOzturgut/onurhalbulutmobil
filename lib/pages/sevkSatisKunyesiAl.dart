import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:onurhalbulutmobil/dto/ambarKalanRequestDto.dart';
import 'package:onurhalbulutmobil/dto/ambarKalanResponseDto.dart';
import 'package:onurhalbulutmobil/dto/ambarSatisEditRequestDto.dart';
import 'package:onurhalbulutmobil/dto/ambarSatisEditResponseDto.dart';
import 'package:onurhalbulutmobil/dto/beldeListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartListResponseDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartSifatListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartSifatListResponseDto.dart';
import 'package:onurhalbulutmobil/dto/faturaTurListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/faturaTurListResponseDto.dart';
import 'package:onurhalbulutmobil/dto/ilceListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/soforListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/soforListResponseDto.dart';
import 'package:onurhalbulutmobil/main.dart';
import 'package:onurhalbulutmobil/services/ambarSatisKunyeAl.dart';
import 'package:onurhalbulutmobil/services/beldeListService.dart';
import 'package:onurhalbulutmobil/services/cariKartEditService.dart';
import 'package:onurhalbulutmobil/services/cariKartIsyeriListService.dart';
import 'package:onurhalbulutmobil/services/cariKartListService.dart';
import 'package:onurhalbulutmobil/services/cariKartSifatListService.dart';
import 'package:onurhalbulutmobil/services/faturaTurListesiService.dart';
import 'package:onurhalbulutmobil/services/ilListService.dart';
import 'package:onurhalbulutmobil/services/ilceListService.dart';
import 'package:onurhalbulutmobil/services/soforListService.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';
import 'package:select_searchable_list/select_searchable_list.dart';
import '../dto/beldeListResponseDto.dart';
import '../dto/cariKartEditRequestDto.dart';
import '../dto/cariKartEditResponseDto.dart';
import '../dto/cariKartIsyeriListRequestDto.dart';
import '../dto/cariKartIsyeriListResponseDto.dart';
import '../dto/cariKartListRequestDto.dart';
import '../dto/ilRequestDto.dart';
import '../dto/ilResponseDto.dart';
import '../dto/ilceListResponseDto.dart';
import '../services/ambarKalanStokListService.dart';

class SevkSatisKunyesiAl extends StatefulWidget{

  @override
  SevkSatisKunyesiAlState createState() => SevkSatisKunyesiAlState();
}

class SevkSatisKunyesiAlState extends State<SevkSatisKunyesiAl> {

  TextEditingController plakaNoController = TextEditingController();
  TextEditingController adresController = TextEditingController();
  TextEditingController aciklamaController = TextEditingController();

  final cariAraController = TextEditingController();
  final ilAraController = TextEditingController();
  final ilceAraController = TextEditingController();
  final beldeAraController = TextEditingController();


  List<dynamic> CariListe = [];
  List<dynamic> ilList = [];
  List<dynamic> ilceList = [];
  List<dynamic> beldeList = [];
  List<dynamic> soforList = [];
  List<dynamic> faturaTuruList = [];
  List<dynamic> cariKartSifatList = [];
  List<dynamic> cariKartIsyeriList = [];
  List<dynamic> ambarKalanStokList = [];
  List<AmbarSatisSatirEdit> editUrunList = [];

  late CariKartListeService _cariKartListeService;
  late CariKartEditService _cariKartEditService;
  late IlListService _ilListService;
  late IlceListService _ilceListService;
  late BeldeListService _beldeListService;
  late SoforListService _soforListService;
  late FaturaTuruListService _faturaTuruListService;
  late CariKartSifatListService _cariKartSifatListService;
  late CariKartIsyeriListService _cariKartIsyeriListService;
  late AmbarKalanStokListService _ambarKalanStokListService;
  late AmbarSatisKunyeAlService _ambarSatisKunyeAlService;

  late bool _loading = false;
  late bool satisUrunEkle = false;

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

  late String secilenSoforAdi = "";
  late int secilenSoforID = 0;

  late String secilenFaturaTurAdi = "";
  late int secilenFaturaTurID = 0;

  late String secilenCariKartSifatAdi = "";
  late int secilenCariKartSifatID = 0;

  late String secilenCariKartIsyeriAdi = "";
  late int secilenCariKartIsyeriID = 0;

  late String secilenIslemAdi = "";
  late int secilenIslemID = 0;

  late int CariEditIlID = 0;
  late int CariEditIlceID = 0;
  late int CariEditBeldeID = 0;

  late String girilenPlakaNo = "";
  late String girilenAdres = "";
  late String girilenIrsaliyeNo = "";
  late String girilenAciklama = "";
  late String girilenIrsaliyeAdresi = "";
  late String stokAdiIndex = "";
  late String StokKunyeNo = "0000000000000000000";

 late String IndexKalanKasa = "";
 late String IndexKalanKilo = "";
 late String IndexStokAdi = "";

  late bool formCheck = true;
  late bool formCheckMusteri = false;
  late bool formCheckAliciSifat = false;
  late bool formCheckAliciYeri = false;
  late bool formCheckSofor = false;
  late bool formCheckPlaka = false;
  late bool formCheckFaturaAdresi = false;
  late bool formCheckIl = false;
  late bool formCheckIlce = false;
  late bool formCheckBelde = false;
  late bool formCheckFaturaTuru = false;
  late bool formCheckIslemTuru = false;


  CariKartEditResponseDto? cariEdit;

  final TextEditingController _urunTextEditingController = TextEditingController();
  final TextEditingController _stokadetcontroller = TextEditingController();
  final TextEditingController _stokkilocontroller = TextEditingController();
  final TextEditingController _stokbagcontroller = TextEditingController();
  final TextEditingController _stokkasacontroller = TextEditingController();
  final TextEditingController _stokfiyatcontroller = TextEditingController();

  late String girilenKilo = "";
  late String girilenKasa = "";
  late String girilenFiyat = "";
  late String girilenAdet = "";

  late int stokAdet = 0;
  late double stokKg = 0.0;

  final List<int> _selectedCategoryValue = [0];

  late List<dynamic> stokKartList = [];
  late Map<int,String> urunListesi = {};

  late List<int> UrunID = [];


  @override
  void initState(){
    _cariKartListeService = CariKartListeService();
    _cariKartEditService = CariKartEditService();
    _ilListService = IlListService();
    _ilceListService = IlceListService();
    _beldeListService = BeldeListService();
    _soforListService = SoforListService();
    _faturaTuruListService = FaturaTuruListService();
    _cariKartSifatListService = CariKartSifatListService();
    _cariKartIsyeriListService = CariKartIsyeriListService();
    _ambarKalanStokListService = AmbarKalanStokListService();
    _ambarSatisKunyeAlService = AmbarSatisKunyeAlService();
    getCariKartList();
    getSoforList();
    getFaturaTuru();
    getIlList();
    getAmbarKalanStokList();
    super.initState();
  }

  List<Map<String, dynamic>> IslemList = [
    {"id": 1, "ad": "Sadece HKS Künye Al"},
    {"id": 2, "ad": "HKS Künye Al ve E-Belge (Müstahsil Makbuzu) Oluştur"},
    {"id": 3, "ad": "Sadece E-Belge Oluştur"},
  ];

  getCariKartSifatList(){
    setState(() {
      _loading = true;
    });

    final CariKartSifatListRequestDto cariSifatReq = CariKartSifatListRequestDto(
        CariKartID: secilenCariID,
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<CariKartSifatListResponseDto> sifat = _cariKartSifatListService.getCariKartSifatList(cariSifatReq);

    List gelen;
    sifat.then((value) async{
      gelen = value.CariKartSifatList.toList();
      setState(() {
        cariKartSifatList.addAll(gelen);
      });
    });
    setState(() {
      _loading = false;
    });
  }

  getCariKartIsyeriList(){
    setState(() {
      _loading = true;
    });

    final CariKartIsyeriListRequestDto cariIsyeriReq = CariKartIsyeriListRequestDto(
        CariKartID: secilenCariID,
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<CariKartIsyeriListResponseDto> isyeri = _cariKartIsyeriListService.getCariKartIsyeriList(cariIsyeriReq);

    List gelen;
    isyeri.then((value) async{
      gelen = value.CariKartIsyeriList.toList();
      setState(() {
        cariKartIsyeriList.addAll(gelen);
      });
    });
    setState(() {
      _loading = false;
    });
  }

  getAmbarKalanStokList()async{
    setState(() {
      _loading = true;
    });

    final AmbarKalanRequestDto ambar = AmbarKalanRequestDto(
        CariKartID: secilenCariKartSifatID,
        CariKartIsyeriID: secilenCariKartIsyeriID,
        LisansID: OnurHalBulutAppSetting().lisansID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        SubeID: OnurHalBulutAppSetting().subeID,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    AmbarKalanResponseDto ambarInfo = await _ambarKalanStokListService.getAmbarKalanStokList(ambar);

    if(ambarInfo.StokList.isNotEmpty){
      stokKartList = ambarInfo.StokList!.map((item) => AmbarKalan.fromJson(item.toJson())).toList();
      Map<int, String> mappedList = {};
      for (AmbarKalan item in stokKartList) {
        int id = item.ID;
        String stokKodu = "${item.L_CariKartMarkaID} ${item.L_StokKartID}";
        mappedList[id] = stokKodu;
        setState(() {
          urunListesi = mappedList;
        });
        print(stokKodu);
      }
    }
  }

  getFaturaTuru(){
    setState(() {
      _loading = true;
    });

    final FaturaTurListRequestDto faturaReq = FaturaTurListRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<FaturaTurListResponseDto> fatura = _faturaTuruListService.getFaturaTuruList(faturaReq);

    List gelen;
    fatura.then((value) async{
      gelen = value.SatisFaturaTurList.toList();
      setState(() {
        faturaTuruList.addAll(gelen);
      });
    });
    setState(() {
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

  getSoforList(){
    setState(() {
      _loading = true;
    });

    final SoforListRequestDto soforReq = SoforListRequestDto(
          LisansID: OnurHalBulutAppSetting().lisansID,
          SubeID: OnurHalBulutAppSetting().subeID,
          VTAdi: OnurHalBulutAppSetting().vtAdi,
          UserName: OnurHalBulutApp.userDto.UserName,
          UserPass: OnurHalBulutApp.userDto.UserPass);

      Future<SoforListResponseDto> sofor = _soforListService.getSoforList(soforReq);

      List gelen;
      sofor.then((value) async{
        if(value.Error !=null){
          gelen = value.SoforList.toList();
          setState(() {
            soforList.addAll(gelen);
          });
        }
      });

      setState(() {
        _loading = false;
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
        adresController.text = cariEdit!.Adres!;
        CariEditIlID = cariEdit!.IlID!;
        CariEditIlceID = cariEdit!.IlceID!;
        CariEditBeldeID = cariEdit!.BeldeID!;
      });
      if(cariEdit!.L_IlceID!.isEmpty){
        setState(() {
          secilenIlID = cariEdit!.IlID!;
          formCheckIl = true;
        });
        getIlceList();
      }else if(cariEdit!.L_BeldeID!.isEmpty){
        setState(() {
          secilenIlceID = cariEdit!.IlceID!;
          formCheckIlce = true;
        });
        getBeldeList();
      }
    }
    setState(() {
      _loading = false;
    });
    print(editID);
  }

  ambarKunyeAl(){
    setState(() {
      _loading = true;
    });

    for (var urunMap in eklenenStokList) {

      AmbarSatisSatirEdit newItem = AmbarSatisSatirEdit(
        ID: urunMap['stokID'],
        AmbarSatirID: 0,
        BagKilo: double.parse(urunMap['stokBagKilo']),
        BagKiloBirim: 0,
        KasaAdet: int.parse(urunMap['stokKasaAdet']),
        KasaAdetBirim: 0,
        L_MarkaID: '',
        StoKText: '',
        L_StokID: urunMap['stokAdi'],
        Fiyat: double.parse(urunMap['stokFiyat']),
        KunyeNo: 0,
        ErrorKunyeAl: '',
      );
      editUrunList.add(newItem);
    }

    final AmbarSatisEditRequestDto req = AmbarSatisEditRequestDto(
      UserName: OnurHalBulutApp.userDto.UserName,
      UserPass: OnurHalBulutApp.userDto.UserPass,
      VTAdi: OnurHalBulutAppSetting().vtAdi,
      SubeID: OnurHalBulutAppSetting().subeID,
      LisansID: OnurHalBulutAppSetting().lisansID,
      CariKartID: secilenCariID,
      CariKartSifat: secilenCariKartSifatID,
      CariKartIsyeriID: secilenCariKartIsyeriID,
      SoforID: secilenSoforID,
      PlakaNo: plakaNoController.text,
      IrsaliyeNo: girilenIrsaliyeNo,
      IrsaliyeAdresi: girilenIrsaliyeAdresi,
      FaturaAdresi: girilenAdres,
      FaturaTur: secilenFaturaTurID,
      Aciklama: girilenAciklama,
      IlID: secilenIlID,
      BeldeID: secilenBeldeID,
      IlceID: secilenIlceID,
      ID: 0,
      Urunler: editUrunList,
      Islem: secilenIslemID
    );

    Future<AmbarSatisEditResponseDto> ambar = _ambarSatisKunyeAlService.getKunyeAl(req);

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
      }
      if(value.Error.isEmpty){
        List<AmbarSatisSatirEditResponse> urunler = value.Urunler;

        for (AmbarSatisSatirEditResponse urun in urunler) {
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
    setState(() {
      _loading = false;
    });
  }

  seciliUrunGetir(id) {
    AmbarKalan? seciliUrun;
    for (AmbarKalan item in stokKartList) {
      if (item.ID == id) {
        seciliUrun = item;
        setState(() {
          String kalanKasa = item.KalanKasaAdet.toString();
          String kalanbagKilo = item.KalanBagKilo.toString();
          _stokadetcontroller.text = kalanKasa;
          _stokkilocontroller.text = kalanbagKilo;
          IndexKalanKasa = kalanKasa;
          IndexKalanKilo = kalanbagKilo;
          IndexStokAdi = item.L_CariKartMarkaID + " " + item.L_StokKartID;
        });
        break;
      }
    }
  }

  List<Map<String, dynamic>> eklenenStokList = [];

  // TODO : Kullanıcı tarafından girilen verileri kullanarak yeni bir öğe oluşturur
  void addItem(int stokID, String stokAdi, String stokKasaAdet, String stokBagKilo,
      String stokFiyat) {
    Map<String, dynamic> newItem = {
      'stokID': stokID,
      'stokAdi': stokAdi,
      'stokKasaAdet': stokKasaAdet,
      'stokBagKilo': stokBagKilo,
      'stokFiyat': stokFiyat,
    };
    eklenenStokList.add(newItem);
  }

  // TODO : FORM CONTROL
  bool formValid(){
    if (secilenCariID == 0){
      return false;
    }else if (secilenCariKartSifatID == 0){
      return false;
    }else if (secilenCariKartIsyeriID == 0){
      return false;
    }else if (secilenSoforID == 0){
      return false;
    }else if (secilenFaturaTurID == 0){
      return false;
    }else if(secilenIslemID == 0){
      return false;
    }
    return true;
  }

  // TODO : Filtreleme Methodları

  List<dynamic> orijinalCariListe = []; // Orijinal CariListe'yi saklayan geçici liste

  void musteriFiltrele(String query) {
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

  // TODO : Alim Yeri Filtrele
  List<dynamic> orijinalalimYeriListe = [];

  void alimYeriFiltrele(String query){

    if (orijinalalimYeriListe.isEmpty) {
      orijinalalimYeriListe = List.from(cariKartSifatList);
    }

    List<dynamic> temp = [];

    if(query.isEmpty){
      temp = List.from(orijinalalimYeriListe);
    }else {
      for(var element in cariKartSifatList){
        if(element.SifatAdi.toLowerCase().contains(query.toLowerCase())){
          temp.add(element);
        }
      }
    }
    cariKartSifatList = temp;
  }

  // TODO : Alici Yeri Filtrele
  List<dynamic> orijinalaliciYeriListe = [];

  void aliciYeriFiltrele(String query){

    if (orijinalaliciYeriListe.isEmpty) {
      orijinalaliciYeriListe = List.from(cariKartIsyeriList);
    }

    List<dynamic> temp = [];

    if(query.isEmpty){
      temp = List.from(orijinalaliciYeriListe);
    }else {
      for(var element in cariKartIsyeriList){
        if(element.L_IsyeriTurID.toLowerCase().contains(query.toLowerCase())){
          temp.add(element);
        }
      }
    }
    cariKartIsyeriList = temp;
  }

  // TODO : Sofor Liste Filtrele
  List<dynamic> orijinalsoforListe = [];

  void soforFiltrele(String query){

    if (orijinalsoforListe.isEmpty) {
      orijinalsoforListe = List.from(soforList);
    }

    List<dynamic> temp = [];

    if(query.isEmpty){
      temp = List.from(orijinalsoforListe);
    }else {
      for(var element in soforList){
        if(element.SoforAdi.toLowerCase().contains(query.toLowerCase())){
          temp.add(element);
        }
      }
    }
    soforList = temp;
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
              if(satisUrunEkle == true){
                setState(() {
                  satisUrunEkle = false;
                });
              }else{
                Navigator.pop(context);
              }
            },
            child: const Icon(Icons.arrow_back_ios_new)
        ),
        actions: [
          GestureDetector(
            onTap: (){
              setState(() {
                satisUrunEkle = true;
              });
            },
            child: satisUrunEkle ? Container() : Container(
              child: Image.asset("assets/images/kamyonicon.png"),
            ),
          ),
        ],
        centerTitle: true,
        title: satisUrunEkle ? Text("Satış Ürün Ekle",
            style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/40))
            : Text("Sevk/Satış Künyesi Al",
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
      resizeToAvoidBottomInset: false,
      body: _loading ? Container(
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
          )) : Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                  child: Image.asset("assets/images/vatan.png",color: Colors.black12,),
                ),
                satisUrunEkle ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      // TODO: STOK
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                        child: Container(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Stok",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height/45,
                                fontWeight: FontWeight.w500,
                                color: Colors.black) ,),
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
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.height/45),
                            isDense: true,
                            border: InputBorder.none,),
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45),
                          textEditingController: _urunTextEditingController,
                          title: 'Stok Seçiniz',
                          hint: 'Stok Seçiniz',
                          options: urunListesi,
                          isSearchVisible: true,
                          selectedOptions: _selectedCategoryValue,
                          onChanged: (selectedIds) {
                            setState(() {
                              UrunID = selectedIds!;
                              var secilenID = UrunID.first;
                              seciliUrunGetir(secilenID);
                            });
                            print(selectedIds);
                          },
                        ),
                      ),
                      // TODO: KASA ADET
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/65),
                        child: Container(
                            width: MediaQuery.of(context).size.width/1.1,
                            child: Text("Kasa/Adet",
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
                          decoration: UrunID.isNotEmpty ? BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ) : BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey,
                          ),
                          child: TextFormField(
                              enabled: UrunID.isNotEmpty ? true : false,
                              controller: _stokadetcontroller,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              onChanged: (value){
                                setState(() {
                                  girilenAdet = value;
                                });
                              },
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/50),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "Kasa/Adet Giriniz",
                                  hintStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.height/50),
                                  border: InputBorder.none))
                      ),
                      // TODO : BAĞ KİLO
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/65),
                        child: Container(
                            width: MediaQuery.of(context).size.width/1.1,
                            child: Text("Bağ/Kilo",
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
                          decoration: UrunID.isNotEmpty ? BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ) : BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            color:  Colors.grey,
                          ),
                          child: TextFormField(
                              enabled:  UrunID.isNotEmpty ? true : false,
                              controller: _stokkilocontroller,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              onChanged: (value){
                                setState(() {
                                  girilenKilo = value;
                                });
                              },
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/50),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "Bağ/Kilo Giriniz",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.height/50),
                                  border: InputBorder.none))
                      ),
                      // TODO : FİYAT
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
                              controller: _stokkasacontroller,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              onChanged: (value){
                                setState(() {
                                  girilenKasa = value;
                                });
                              },
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "Fiyat Giriniz",
                                  hintStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.height/50),
                                  border: InputBorder.none))
                      ),
                      // TODO : İşlem Butonları
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                        child: Center(
                          child: GestureDetector(
                            // TODO : Kaydet İşlemi
                            onTap: (){
                              if(UrunID.isEmpty || girilenKasa.isEmpty || _stokadetcontroller.text.isEmpty || _stokkilocontroller.text.isEmpty || _urunTextEditingController.value.text.isEmpty){
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
                                          Text("Bilgileri eksiksiz giriniz",
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
                              addItem(UrunID.first,_urunTextEditingController.value.text, _stokadetcontroller.text,_stokkilocontroller.text,girilenKasa);
                              setState(() {
                                satisUrunEkle = false;
                                _stokfiyatcontroller.clear();
                                _stokkasacontroller.clear();
                                _stokkilocontroller.clear();
                                _stokbagcontroller.clear();
                                _stokadetcontroller.clear();
                                _urunTextEditingController.clear();
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height/17,
                              width: MediaQuery.of(context).size.width/1.1,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xff10AEE4),
                              ),
                              child: Center(
                                child: Text("Kaydet",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      fontWeight: FontWeight.w500),),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ) : SingleChildScrollView(
                  child: Column(
                    children: [
                      // TODO : Müşteri
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/55),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Müşteri",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,),textAlign: TextAlign.start,),
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
                                              musteriFiltrele(value);
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
                                                          formCheckMusteri = true;
                                                          secilenCari = CariListe[index].CariKodu;
                                                          secilenCariID = CariListe[index].ID;
                                                          getcariIcerik(secilenCariID);
                                                          getCariKartSifatList();
                                                          getCariKartIsyeriList();
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: const Color(0xff10AEE4)
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              Text(CariListe[index].CariKodu,
                                                                  textAlign: TextAlign.center,
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: MediaQuery.of(context).size.height/50,
                                                                      color: Colors.white)),
                                                              Text(CariListe[index].TCKNo,
                                                                  textAlign: TextAlign.center,
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: MediaQuery.of(context).size.height/50,
                                                                      color: Colors.white))
                                                            ],
                                                          ),),
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
                            border: formCheck ? Border.all(color: Colors.black, width: 0.5) :
                            formCheck! || secilenCariID == 0 ? Border.all(color: Colors.red,width: 1) :
                            formCheck! || secilenCariID > 0 ? Border.all(color: Colors.black, width: 0.5) : null,
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
                      // TODO : Alıcı Sıfatı
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Alıcı Sıfatı",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,),textAlign: TextAlign.start,),
                        ),
                      ),
                      secilenCariID > 0 ? GestureDetector(
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
                                            child: Text("Alıcı Sıfatı Seçiniz",
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
                                                itemCount: cariKartSifatList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          secilenCariKartSifatAdi = cariKartSifatList[index].SifatAdi;
                                                          secilenCariKartSifatID = cariKartSifatList[index].ID;
                                                          formCheckAliciSifat = true;
                                                          // getcariIcerik(secilenCariID);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/17,
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: const Color(0xff10AEE4)
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                              cariKartSifatList[index].SifatAdi,
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
                            border: formCheckAliciSifat ? Border.all(color: Colors.black, width: 0.5) :
                            Border.all(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child:Center(
                            child: secilenCariKartSifatAdi.isNotEmpty ? Text(secilenCariKartSifatAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white))
                                : Text("Alıcı Sıfatı Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ) : Container(
                        height: MediaQuery.of(context).size.height/17,
                        width: MediaQuery.of(context).size.width/1.1,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey,
                        ),
                        child:Center(
                          child: Text("Önce Üretici Seçiniz",
                              style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  color: Colors.white)),
                        ),
                      ),
                      // TODO : Alıcı Yeri
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("Alıcı Yeri",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.black),
                                  textAlign: TextAlign.start))),
                     secilenCariID > 0 ? GestureDetector(
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
                                            child: Text("Alıcı Yeri Seçiniz",
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
                                              aliciYeriFiltrele(value);
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
                                                itemCount: cariKartIsyeriList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          secilenCariKartIsyeriAdi = cariKartIsyeriList[index].IsyeriAdi ;
                                                          secilenCariKartIsyeriID = cariKartIsyeriList[index].IsyeriID ;
                                                          // getcariIcerik(secilenCariID);
                                                          formCheckAliciYeri = true;
                                                          print(secilenCariKartIsyeriID);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/17,
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: const Color(0xff10AEE4)
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                              cariKartIsyeriList[index].IsyeriAdi,
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
                            border: formCheckAliciYeri ? Border.all(color: Colors.black, width: 0.5) :
                            Border.all(color: Colors.red,width: 1),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child:Center(
                            child: secilenCariKartIsyeriAdi.isNotEmpty ? Text(secilenCariKartIsyeriAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white))
                                : Text("Alıcı Yeri Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ) :
                     Container(
                       height: MediaQuery.of(context).size.height/17,
                       width: MediaQuery.of(context).size.width/1.1,
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.black, width: 0.5),
                         borderRadius: BorderRadius.circular(12),
                         color: Colors.grey,
                       ),
                       child:Center(
                         child: Text("Önce Üretici Seçiniz",
                             style: GoogleFonts.poppins(
                                 fontSize: MediaQuery.of(context).size.height/45,
                                 color: Colors.white)),
                       ),
                     ),
                      // TODO : Şoför
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("Şoför",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.black),
                                  textAlign: TextAlign.start))),
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
                                            child: Text("Şoför Seçiniz",
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
                                              soforFiltrele(value);
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
                                                itemCount: soforList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          secilenSoforAdi = soforList[index].SoforAdi;
                                                          secilenSoforID = soforList[index].ID;
                                                          formCheckSofor = true;
                                                          // getcariIcerik(secilenCariID);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: const Color(0xff10AEE4)
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  soforList[index].SoforAdi,
                                                                  textAlign: TextAlign.center,
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: MediaQuery.of(context).size.height/50,
                                                                      color: Colors.white)),
                                                              Text(
                                                                  soforList[index].SoforTCNo,
                                                                  textAlign: TextAlign.center,
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: MediaQuery.of(context).size.height/50,
                                                                      color: Colors.white)),
                                                              Text(
                                                                  "Cep : " + soforList[index].SoforCepTel,
                                                                  textAlign: TextAlign.center,
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: MediaQuery.of(context).size.height/50,
                                                                      color: Colors.white)),

                                                            ],
                                                          ),),
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
                            border: formCheck ? Border.all(color: Colors.black, width: 0.5) :
                            formCheck! || secilenSoforID == 0 ? Border.all(color: Colors.red,width: 1) :
                            formCheck! || secilenSoforID > 0 ? Border.all(color: Colors.black,width: 0.5) : null,
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child:Center(
                            child: secilenSoforAdi.isNotEmpty ? Text(secilenSoforAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white))
                                : Text("Şoför Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      // TODO : Araç Plaka
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("Plaka No",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.black),
                                  textAlign: TextAlign.start))),
                      Container(
                          height: MediaQuery.of(context).size.height/17,
                          width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                              border: formCheck ?
                              Border.all(color: Colors.black,width: 0.5) : formCheck! || plakaNoController.text.isEmpty ?
                              Border.all(color: Colors.red,width: 1) : formCheck! || plakaNoController.text.isNotEmpty ?
                              Border.all(color: Colors.black,width: 0.5) : null,
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff10AEE4)),
                          child: TextFormField(
                              controller: plakaNoController,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              onChanged: (value){
                                setState(() {
                                  girilenPlakaNo = value;
                                  formCheckPlaka = true;
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
                      // TODO : İrsaliye No
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("İrsaliye No",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.black),
                                  textAlign: TextAlign.start))),
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
                            // controller: adres,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              onChanged: (value){
                                setState(() {
                                  girilenIrsaliyeNo = value;
                                });
                              },
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Lütfen İrsaliye No Giriniz",
                                  hintStyle: TextStyle(color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.height/45),
                                  border: InputBorder.none))),
                      // TODO : Fatura Adresi
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("Fatura Adresi",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.black),
                                  textAlign: TextAlign.start))),
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
                              controller: adresController,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              onChanged: (value){
                                setState(() {
                                  girilenAdres = value;
                                });
                              },
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Fature Adresi Giriniz",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.height/45),
                                  border: InputBorder.none))),
                      // TODO : İrsaliye Adresi
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("İrsaliye Adresi",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.black),
                                  textAlign: TextAlign.start))),
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
                            // controller: adres,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              onChanged: (value){
                                setState(() {
                                  girilenIrsaliyeAdresi = value;
                                });
                              },
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Lütfen İrsaliye Adresi Giriniz",
                                  hintStyle: TextStyle(color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.height/45),
                                  border: InputBorder.none))),
                      // TODO : İL
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("İl",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.black),
                                  textAlign: TextAlign.start))),
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
                                                          formCheckIl = true;
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
                            border: CariEditIlID > 0 || secilenIlID > 0 ? Border.all(color: Colors.black, width: 0.5) :
                             CariEditIlID == 0 || secilenIlID == 0 ? Border.all(color: Colors.red,width: 1) : null,
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
                      //TODO : İLÇE
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("İlçe",
                                  style: GoogleFonts.poppins(
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),textAlign: TextAlign.start))),
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
                                                          formCheckIlce = true;
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
                            border: CariEditIlceID > 0 || secilenIlceID > 0 ? Border.all(color: Colors.black, width: 0.5) :
                            CariEditIlceID == 0 || secilenIlceID == 0 ? Border.all(color: Colors.red,width: 1) : null,
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
                      // TODO : BELDE
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Belde",style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start),
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
                                                          formCheckBelde = true;
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
                            border: CariEditBeldeID > 0 || secilenBeldeID > 0 ? Border.all(color: Colors.black, width: 0.5) :
                            CariEditBeldeID == 0 || secilenBeldeID == 0 ? Border.all(color: Colors.red,width: 1) : null,
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
                      // TODO : Fatura Türü
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Fatura Türü",
                              style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start),
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
                                            child: Text("Fatura Türü Seçiniz",
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
                                                itemCount: faturaTuruList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          secilenFaturaTurAdi = faturaTuruList[index].FaturaTuruAdi;
                                                          secilenFaturaTurID = faturaTuruList[index].ID;
                                                          // getcariIcerik(secilenCariID);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/17,
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: const Color(0xff10AEE4)
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                              faturaTuruList[index].FaturaTuruAdi,
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
                            border: formCheck? Border.all(color: Colors.black, width: 0.5) :
                            formCheck! || secilenFaturaTurID == 0 ? Border.all(color: Colors.red,width: 1) :
                            formCheck! || secilenFaturaTurID > 0 ? Border.all(color: Colors.black,width: 0.5) : null,
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child:Center(
                            child: secilenFaturaTurAdi.isNotEmpty ? Text(secilenFaturaTurAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white))
                                : Text("Fatura Türü Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      //  TODO : İŞLEM
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("İşlem Türü",
                              style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start),
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
                            border: formCheck ? Border.all(color: Colors.black, width: 0.5) :
                            formCheck! || secilenIslemID == 0 ? Border.all(color: Colors.red,width: 1) :
                            formCheck! || secilenIslemID > 0 ? Border.all(color: Colors.black,width: 0.5) : null,
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child:Center(
                            child: secilenIslemAdi.isNotEmpty ? Text(secilenIslemAdi,
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)) : Text("İşlem Türü Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      // TODO : AÇIKLAMA
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height/21,
                            bottom: MediaQuery.of(context).size.height/21),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            // TODO : Temizle Butonu
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
                                                  padding: EdgeInsets.only(
                                                      top: MediaQuery.of(context).size.height/21),
                                                  child: Text("Temizlemek istediğinize emin misiniz? Girdiğiniz tüm bilgiler temizlenecektir.",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(context).size.height/45,
                                                        color: Colors.black),),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context).size.height/15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap:(){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/17,
                                                        width: MediaQuery.of(context).size.width/3,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12),
                                                            color: const Color(0xff10AEE4),
                                                            border: Border.all(color: Colors.black,width: 0.5)
                                                        ),
                                                        child: Center(child: Text("Vazgeç",
                                                          style: GoogleFonts.poppins(
                                                              fontSize: MediaQuery.of(context).size.height/50,
                                                              color: Colors.white),)),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap:(){

                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                          height: MediaQuery.of(context).size.height/17,
                                                          width: MediaQuery.of(context).size.width/3,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(12),
                                                              color: const Color(0xff10AEE4),
                                                              border: Border.all(color: Colors.black,width: 0.5)
                                                          ),
                                                          child: Center(
                                                              child: Text("Tamam",
                                                                style: GoogleFonts.poppins(
                                                                    fontSize: MediaQuery.of(context).size.height/45,
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
                                width: MediaQuery.of(context).size.width/2.4,
                                decoration: BoxDecoration(
                                    color: const Color(0xff10AEE4),
                                    border: Border.all(color: Colors.black,width: 0.5),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Text("Temizle",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context).size.height/45)),
                                ),
                              ),
                            ),
                            // TODO :  Vazgeç Butonu
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
                                                  padding: EdgeInsets.only(
                                                      top: MediaQuery.of(context).size.height/30),
                                                  child: SizedBox(
                                                    width: MediaQuery.of(context).size.width/1.3,
                                                    child: Text("Vazgeçmek istediğinize emin misiniz? Girdiğiniz bilgiler kaybolacaktır. Listeleme ekranına yönlendirileceksiniz.",
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: MediaQuery.of(context).size.height/45,
                                                          color: Colors.black),),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context).size.height/15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap:(){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/17,
                                                        width: MediaQuery.of(context).size.width/3,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12),
                                                            color: const Color(0xff10AEE4),
                                                            border: Border.all(color: Colors.black,width: 0.5)
                                                        ),
                                                        child: Center(child: Text("Vazgeç",
                                                          style: GoogleFonts.poppins(
                                                              fontSize: MediaQuery.of(context).size.height/45,
                                                              color: Colors.white),)),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: (){
                                                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                                        //     builder: (context) => CariKartListesi()), (route) => false);
                                                      },
                                                      child: Container(
                                                          height: MediaQuery.of(context).size.height/17,
                                                          width: MediaQuery.of(context).size.width/3,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(12),
                                                              color: const Color(0xff10AEE4),
                                                              border: Border.all(color: Colors.black,width: 0.5)
                                                          ),
                                                          child: Center(
                                                              child: Text("Tamam",
                                                                style: GoogleFonts.poppins(
                                                                    fontSize: MediaQuery.of(context).size.height/45,
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
                                width: MediaQuery.of(context).size.width/2.4,
                                decoration: BoxDecoration(
                                    color: const Color(0xff10AEE4),
                                    border: Border.all(color: Colors.black,width: 0.5),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Text("Vazgeç",
                                    style: GoogleFonts.poppins(
                                        fontSize: MediaQuery.of(context).size.height/45,
                                        color: Colors.white),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // TODO : Sevk Satış Künyesi Al
                      Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/27),
                        child: GestureDetector(
                          onTap: (){
                            bool isFormValid = formValid();
                            if (isFormValid) {
                              if(eklenenStokList.isNotEmpty){
                                ambarKunyeAl();
                              }else{
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
                              }
                            } else {
                              setState(() {
                                formCheck = false;
                              });
                              // Form geçerli değil, kullanıcıya bilgi vermek için SnackBar göster
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Lütfen zorunlu alanları doldurun.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.width/1.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black,width: 1),
                              color: const Color(0xff10AEE4),
                            ),
                            child: Center(child: Text("Sevk/Satış Künyesi Al",
                                style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height/45,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),),
                          ),
                        ),
                      ),
                      // TODO : Girilen Stok Ürün
                      Center(child: Text("Stok",style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.height/40,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),),),
                      Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/27),
                        child: Container(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Divider(
                            color: Colors.black),
                        ),
                      ),
                      // TODO : ListView Stok
                     eklenenStokList.isNotEmpty ? Container(
                        height: MediaQuery.of(context).size.height/2,
                        width: MediaQuery.of(context).size.width/1.1,
                        child: ListView.builder(
                            itemCount: eklenenStokList.length,
                            itemBuilder: (context , int index){
                              Map<String, dynamic> urun = eklenenStokList[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/27),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xff10AEE4),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Text(urun['stokAdi'],style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/55,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500))),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                              child: Text('Adet : ' + urun['stokKasaAdet'],style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.height/55,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500))),
                                          Center(
                                              child: Text('Kg : ' + urun['stokBagKilo'],
                                                  style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.height/55,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500))),
                                        ],
                                      ),
                                      Center(
                                          child: Text("Sevk Satış Künyesi",
                                              style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/50,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500))),
                                      Center(
                                          child: Text(StokKunyeNo,style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/45,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500))),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ) :
                         Padding(
                           padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/25),
                           child: Text("Eklenen Stok Ürün yok!",style: GoogleFonts.poppins(
                               fontSize: MediaQuery.of(context).size.height/45,
                               color: Colors.black,
                               fontWeight: FontWeight.w500)),
                         )
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
