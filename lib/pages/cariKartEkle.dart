import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:onurhalbulutmobil/dto/beldeListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/beldeListResponseDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartEditResponseDto.dart';
import 'package:onurhalbulutmobil/dto/cariKartSaveRequestDto.dart';
import 'package:onurhalbulutmobil/dto/cariTuruListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/ilRequestDto.dart';
import 'package:onurhalbulutmobil/dto/ilResponseDto.dart';
import 'package:onurhalbulutmobil/dto/ilceListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/ilceListResponseDto.dart';
import 'package:onurhalbulutmobil/dto/vergiDairesiListRequestDto.dart';
import 'package:onurhalbulutmobil/dto/vergiDairesiListResponseDto.dart';
import 'package:onurhalbulutmobil/main.dart';
import 'package:onurhalbulutmobil/pages/cariKartListesi.dart';
import 'package:onurhalbulutmobil/pages/hksisyeri.dart';
import 'package:onurhalbulutmobil/pages/hkssifatekle.dart';
import 'package:onurhalbulutmobil/services/beldeListService.dart';
import 'package:onurhalbulutmobil/services/cariTuruListService.dart';
import 'package:onurhalbulutmobil/services/ilListService.dart';
import 'package:onurhalbulutmobil/services/ilceListService.dart';
import 'package:onurhalbulutmobil/services/vergiDairesiListService.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';
import 'package:text_mask/text_mask.dart';
import '../dto/cariTuruListResponseDto.dart';

class CariKartEkle extends StatefulWidget {

  final CariKartEditResponseDto? cariKartEditResponseDto;
  final CariKartSaveRequestDto? cariKartSaveRequestDto;

  final bool duzenlemeMi;
  final int gelensayfaIndex;

  CariKartEkle({this.cariKartEditResponseDto,required this.duzenlemeMi,
    this.cariKartSaveRequestDto, required this.gelensayfaIndex});

  @override
  State<StatefulWidget> createState() {
    return CariKartEkleState(cariKartEditResponseDto,duzenlemeMi,cariKartSaveRequestDto ?? CariKartSaveRequestDto(),gelensayfaIndex);
  }

}

class CariKartEkleState extends State<CariKartEkle>
    with SingleTickerProviderStateMixin {

  final CariKartEditResponseDto? cariKartEditResponseDto;
  late final CariKartSaveRequestDto? cariKartSaveRequestDto;

  late bool duzenlemeMi;
  final int gelensayfaIndex;

  CariKartEkleState(this.cariKartEditResponseDto,this.duzenlemeMi,this.cariKartSaveRequestDto,this.gelensayfaIndex);

  late ScrollController _scrollController;
  late CariKartSaveRequestDto _cariKartSaveRequestDto;

  final cariKoduController = TextEditingController();
  final vergiAraController = TextEditingController();
  final cariTuruAraController = TextEditingController();
  final ilAraController = TextEditingController();
  final ilceAraController = TextEditingController();
  final beldeAraController = TextEditingController();
  final telNoController = TextEditingController();

  TextEditingController cariAdiDeger = TextEditingController();
  TextEditingController cariKoduDeger = TextEditingController();
  TextEditingController tcvkn = TextEditingController();
  TextEditingController aracPlaka = TextEditingController();
  TextEditingController adres = TextEditingController();
  TextEditingController cepTelefonu = TextEditingController();


  late String secilenVergiDairesi = "";
  late String secilenCariTuru = "";
  late String secilenIl = "";
  late String secilenIlce = "";
  late String secilenBelde = "";

  List<dynamic> vergiDairesiList = [];
  List<dynamic> cariTuruList = [];
  List<dynamic> ilList = [];
  List<dynamic> ilceList = [];
  List<dynamic> beldeList = [];

  late bool _loading = false;
  late bool degerDegisti = false;
  late bool formCheck = true;
  late bool formCheckKod = false;
  late bool formCheckAd = false;
  late bool formCheckVergi = false;
  late bool formCheckTCKN = false;
  late bool formCheckCari = false;
  late bool formCheckIl = false;
  late bool formCheckIlce = false;
  late bool formCheckBelde = false;
  late bool formCheckCep = false;

  late int ilIDInfo = 0;
  late int ilceIDInfo = 0;
  late int paramIlceID = 0;
  late int paramIlID = 0;

  late VergiDairesiListService _vergiDairesiListService;
  late CariTuruListService _cariTuruListService;
  late IlListService _ilListService;
  late IlceListService _ilceListService;
  late BeldeListService _beldeListService;

  // TODO: CariKart Ekle

  late String _cariAdiDeger = "";
  late String _cariKoduDeger = "";
  late int _secilenVergiDaireID = 0;
  late String _tcvkn = "";
  late String _aracPlaka = "";
  late int _secilenCariTurID = 0;
  late String _adres = "";
  late int _secilenIlID = 0;
  late int _secilenIlceID = 0;
  late int _secilenBeldeID = 0;
  late String _cepTelefon = "";

  // TODO: CariKart Sayfa Index

  late int sayfaIndex = 0;

  List<CariKartTanimSifatSaveDTO> _sifatListesi = []; // Sifat listesi için değişken tanımı
  List<CariKartTanimIsyeriSaveDTO> _isyeriListesi = []; // İş Yeri listesi için değişken tanımı

  @override
  void initState() {
    _vergiDairesiListService = VergiDairesiListService();
    _cariTuruListService = CariTuruListService();
    _ilListService = IlListService();
    _ilceListService = IlceListService();
    _beldeListService = BeldeListService();
    _cariKartSaveRequestDto = widget.cariKartSaveRequestDto ?? CariKartSaveRequestDto();
    getVergiDairesiList();
    getCariTuruList();
    getIlList();
    degerSetle();
    if(gelensayfaIndex == 0){
        sayfaIndex = 1;
    }else{
      sayfaIndex = 3;
    }
    // TODO: Belde Boş Gelirse Combobox buradan dolar..
    if(cariKartEditResponseDto != null && cariKartEditResponseDto!.L_BeldeID == ""){
      setState(() {
        paramIlceID = cariKartEditResponseDto!.IlceID!;
      });
      getBeldeListParam(paramIlceID);
    }

    // TODO: İlçe boş gelirse Combobox buradan dolar..
    if(cariKartEditResponseDto != null && cariKartEditResponseDto!.L_IlceID == ""){
      setState(() {
        paramIlID = cariKartEditResponseDto!.IlID!;
      });
      getIlceListParam(paramIlID);
    }
    super.initState();
    _scrollController = ScrollController();

    if (widget.cariKartEditResponseDto != null) {
      List<CariKartTanimSifatDTO> sifatListesi = widget.cariKartEditResponseDto?.Sifat ?? [];
      _sifatListesi = sifatListesi.map((item) => CariKartTanimSifatSaveDTO(
        ID: item.ID,
        SifatID: item.SifatID,
        L_SifatID: item.L_SifatID,
        Varsayilan: item.Varsayilan
      )).toList();
    }

    if(widget.cariKartEditResponseDto !=null){
      List<CariKartTanimIsyeriDTO> isYeriListesi = widget.cariKartEditResponseDto?.Isyeri ?? [];
      _isyeriListesi = isYeriListesi.map((e) => CariKartTanimIsyeriSaveDTO(
          ID: e.ID,
          IsyeriID: e.IsyeriID,
          IsyeriAdi: e.IsyeriAdi,
          HalID: e.HalID,
          HalAdi: e.HalAdi,
          IsyeriTurID: e.IsyeriTurID,
          L_IsyeriTurID: e.L_IsyeriTurID,
          IlID: e.IlID,
          L_IlID: e.L_IlID,
          IlceID: e.IlceID,
          L_IlceID: e.L_IlceID,
          BeldeID: e.BeldeID,
          L_BeldeID: e.L_BeldeID,
          Adres: e.Adres,
          PlakaNo: e.PlakaNo,
          Varsayilan: e.Varsayilan)).toList();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  kayitDegerSetle(){
    final CariKartSaveRequestDto save = CariKartSaveRequestDto(
      ID: cariKartEditResponseDto?.ID ?? 0,
      CariKodu: cariKoduDeger.text,
      CariAdi: cariAdiDeger.text,
      VergiDairesiID: cariKartEditResponseDto?.VergiDairesiID ?? _secilenVergiDaireID,
      TCKNo: tcvkn.text,
      PlakaNo: aracPlaka.text,
      Adres: adres.text,
      IlID: cariKartEditResponseDto?.IlID ?? _secilenIlID,
      IlceID: cariKartEditResponseDto?.IlceID ?? _secilenIlceID,
      BeldeID: cariKartEditResponseDto?.BeldeID ?? _secilenBeldeID,
      CepTel: cepTelefonu.text,
      HKSKayit: false,
      UreticiTipi: cariKartEditResponseDto?.UreticiTipi ?? _secilenCariTurID,
      Isyeri: _isyeriListesi ?? [],
      Sifat: _sifatListesi ?? [],
    );
    print(save);
    setState(() {
      _cariKartSaveRequestDto = save;
    });
  }

  degerSetle(){
    final cariKartEditResponseDto = this.cariKartEditResponseDto;
    if(cariKartEditResponseDto !=null){
      cariAdiDeger.text = cariKartEditResponseDto.CariAdi!;
      tcvkn.text = cariKartEditResponseDto.TCKNo!;
      aracPlaka.text = cariKartEditResponseDto.PlakaNo!;
      adres.text = cariKartEditResponseDto.Adres!;
      cepTelefonu.text = cariKartEditResponseDto.CepTel!;
      cariKoduDeger.text = cariKartEditResponseDto.CariKodu!;
    }else{
      cariAdiDeger.text = "";
      tcvkn.text = "";
      aracPlaka.text = "";
      adres.text = "";
      cepTelefonu.text = "";
      cariKoduDeger.text = "";
    }
  }

  // TODO: Liste çekme methodları

  getVergiDairesiList() {
    _loading = true;

    final VergiDairesiListRequestDto vergiReq = VergiDairesiListRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<VergiDairesiListResponseDto> vergi = _vergiDairesiListService.getVergiDairesiList(vergiReq);

    List gelen;
    vergi.then((value) async {
      if(value.VergiDairesiList != null){
        gelen = value.VergiDairesiList!.toList();
        setState(() {
          vergiDairesiList.addAll(gelen);
        });
      }
      _loading = false;
    });
  }

  getCariTuruList(){
    _loading = true;

    final CariTuruListRequestDto cariReq = CariTuruListRequestDto(
        LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: OnurHalBulutAppSetting().subeID,
        VTAdi: OnurHalBulutAppSetting().vtAdi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);

    Future<CariTuruListResponseDto> cari = _cariTuruListService.getCariTuruList(cariReq);

    List gelen;
    cari.then((value) async {
      if(value.CariTuruList != null){
        gelen = value.CariTuruList!.toList();
        setState(() {
          cariTuruList.addAll(gelen);
        });
      }
      _loading = false;
    });
  }

  getIlList(){
    _loading = true;

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
    _loading = true;

    final IlceListRequestDto ilceReq = IlceListRequestDto(
        IlID: ilIDInfo,
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
    _loading = true;

    final BeldeListRequestDto beldeReq = BeldeListRequestDto(
        IlceID: ilceIDInfo,
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

  getBeldeListParam(int ilceID){
    _loading = true;

    final BeldeListRequestDto beldeReq = BeldeListRequestDto(
        IlceID: ilceID,
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

  getIlceListParam(int ilID){
    _loading = true;

    final IlceListRequestDto ilceReq = IlceListRequestDto(
        IlID: ilID,
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

  // TODO: Filtreleme Methodları


  // TODO : Vergi Filtrele
  List<dynamic> orijinalVergiListe = [];

  void vergiFiltrele(String query) {
    if (orijinalVergiListe.isEmpty) {
      orijinalVergiListe = List.from(vergiDairesiList);
    }

    List<dynamic> temp = [];

    if (query.isEmpty) {
      temp = List.from(orijinalVergiListe);
    } else {
      for (var element in orijinalVergiListe) {
        if (element.DaireAdi.toLowerCase().contains(query.toLowerCase())) {
          temp.add(element);
        }
      }
    }
    vergiDairesiList = temp;
    print(temp);
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

  // TODO : Cari Filtrele
  List<dynamic> orijinalCariListe = [];

  void cariFiltrele (String query){

    if (orijinalCariListe.isEmpty) {
      orijinalCariListe = List.from(cariTuruList);
    }

    List<dynamic> temp = [];

    if(query.isEmpty){
      temp = List.from(orijinalCariListe);
    }else{
      for(var element in cariTuruList){
        if(element.CariTuruAdi.toLowerCase().contains(query.toLowerCase())){
          temp.add(element);
        }
      }
    }
    cariTuruList = temp;
  }


  void setLoadingFalse() async {

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _loading = false;
    });
  }

  // TODO : Validasyon Kontrol Buradan Yapılır

  bool formValid() {
    if (_cariKartSaveRequestDto.CariKodu!.isEmpty) {
      return false;
    } else if (_cariKartSaveRequestDto.CariAdi!.isEmpty) {
      return false;
    } else if (_cariKartSaveRequestDto.VergiDairesiID == 0) {
      return false;
    } else if (_cariKartSaveRequestDto.TCKNo!.isEmpty) {
      return false;
    } else if (_cariKartSaveRequestDto.UreticiTipi == 0) {
      return false;
    } else if (_cariKartSaveRequestDto.IlID == 0) {
      return false;
    } else if (_cariKartSaveRequestDto.IlceID == 0) {
      return false;
    } else if (_cariKartSaveRequestDto.BeldeID == 0) {
      return false;
    } else if (_cariKartSaveRequestDto.CepTel!.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => CariKartListesi()),(Route<dynamic> route) => false);
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
        title: duzenlemeMi ?
        Column(
          children: [
            Text("Cari Kart Bilgileri Düzenle",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.height/40),),
            sayfaIndex == 1 ? Text("Kart Bilgileri",
                style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height/60)) :
            sayfaIndex == 2 ? Text("HKS Sıfat",
                style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height/60)) :
            sayfaIndex == 3 ? Text("HKS İş Yeri",
                style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height/60)) :
            // sayfaIndex == 4 ? Text("Marka",
            //     style: GoogleFonts.poppins(
            //     fontWeight: FontWeight.w500,
            //     fontSize: MediaQuery.of(context).size.height/60))
                //:
            Container()
          ],
        )
            :
            Text("Cari Kart Ekle",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.height/40),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
            child: Image.asset("assets/images/vatan.png",color: Colors.black12,),
          ),
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Padding(
                  padding: duzenlemeMi ? EdgeInsets.only(
                      top: MediaQuery.of(context).size.height/55,
                      bottom: MediaQuery.of(context).size.height/65
                  ) : const EdgeInsets.only(
                      bottom: 0),
                  child: cariKartEditResponseDto !=null ? Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width/23),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sayfaIndex = 1;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/3,
                            height: MediaQuery.of(context).size.height/17,
                            decoration: sayfaIndex == 1 ? BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                color: const Color(0xff10AEE4),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.lightGreenAccent,
                                    width: 1.5)
                            ) : BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                color: const Color(0xcb8b9094),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black,
                                    width: 0.5)
                            ),
                            child: Center(
                              child: Text("Kart Bilgileri",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  color: Colors.white,),),),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/45),
                        GestureDetector(
                          onTap: (){
                            setLoadingFalse();
                            kayitDegerSetle();
                            setState(() {
                              sayfaIndex = 2;
                              duzenlemeMi = true;
                              _loading = true;
                            });
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => HKSSifatEkle(cariKartEditResponseDto: cariKartEditResponseDto)));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/3,
                            height: MediaQuery.of(context).size.height/17,
                            decoration: sayfaIndex == 2 ? BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                color:const Color(0xff10AEE4),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.lightGreenAccent,width: 1.5)
                            ) : BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                color: const Color(0xcb8b9094),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black,width: 0.5)
                            ),
                            child: Center(
                              child: Text("HKS Sıfat",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  color: Colors.white,),),),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/45),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              duzenlemeMi = true;
                              sayfaIndex = 3;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/3,
                            height: MediaQuery.of(context).size.height/17,
                            decoration: sayfaIndex == 3 ? BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                color: const Color(0xff10AEE4),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.lightGreenAccent,
                                    width: 1.5)
                            ) : BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                color: const Color(0xcb8b9094),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black,
                                    width: 0.5)
                            ),
                            child: Center(
                              child: Text("HKS İş Yeri",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  color: Colors.white,),),),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width/23),
                      ],
                    ),
                  ) : Container(),
                ),
              ),
             // TODO : Buraya Gelecek
              Expanded(
                child: SingleChildScrollView(
                  child:
                  sayfaIndex == 2 ? HKSSifatEkle(
                      cariKartEditResponseDto: cariKartEditResponseDto,
                      duzenlemeMi: duzenlemeMi,
                      cariKartSaveRequestDto: _cariKartSaveRequestDto) :
                  sayfaIndex == 3 || gelensayfaIndex == 3 ? HKSIsyeri(
                      cariKartEditResponseDto: cariKartEditResponseDto,
                      duzenlemeMi: duzenlemeMi,
                      cariKartSaveRequestDto: _cariKartSaveRequestDto) :
                  Column(
                    children: [
                      // TODO : Cari Kodu
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/55),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Cari Kodu",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,),textAlign: TextAlign.start,),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/17,
                        width: MediaQuery.of(context).size.width/1.1,
                        decoration: BoxDecoration(
                          border: formCheck ? Border.all(color: Colors.black, width: 0.5)
                              : formCheck! || _cariKoduDeger.isEmpty ? Border.all(color: Colors.red, width: 1)
                              : formCheck! || _cariKoduDeger.isNotEmpty ? Border.all(color: Colors.black, width: 0.5) : null,
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff10AEE4),
                        ),
                        child: TextFormField(
                          controller: cariKoduDeger,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.white,
                          onChanged: (value){
                            setState(() {
                              formCheckKod = true;
                              _cariKoduDeger = value!;
                              cariKartEditResponseDto?.CariKodu = value;
                            });
                          },
                          style: TextStyle(color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Lütfen Cari Kodu Giriniz",
                            hintStyle: TextStyle(color: Colors.white,
                                fontSize: MediaQuery.of(context).size.height/45),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // TODO : Cari Adı
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Cari Adı",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height/45,
                              color: Colors.black,),textAlign: TextAlign.start,),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/17,
                        width: MediaQuery.of(context).size.width/1.1,
                        decoration: BoxDecoration(
                          border: formCheck ? Border.all(color: Colors.black, width: 0.5)
                              : formCheck! || _cariAdiDeger.isEmpty ? Border.all(color: Colors.red, width: 1)
                              : formCheck! || _cariAdiDeger.isNotEmpty ? Border.all(color: Colors.black, width: 0.5) : null,
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff10AEE4),
                        ),
                        child: TextFormField(
                          controller: cariAdiDeger,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.white,
                          onChanged: (value){
                            setState(() {
                              formCheckAd = true;
                              _cariAdiDeger = value!;
                              cariKartEditResponseDto?.CariAdi = value;
                            });
                          },
                          style: TextStyle(color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Lütfen Cari Adı Giriniz",
                            hintStyle: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height/45),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // TODO : Vergi Dairesi
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("Vergi Dairesi",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.black),
                                  textAlign: TextAlign.start))),
                      // TODO : Filtreleme alanlı combobox Popupları !!!
                      GestureDetector(
                        onTap: (){
                          vergiAraController.clear();
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
                                            child: Text("Vergi Dairesi Seçiniz",
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
                                              vergiFiltrele(value);
                                              if(value.isEmpty){
                                                getVergiDairesiList();}
                                            },
                                            controller: vergiAraController,
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
                                                itemCount: vergiDairesiList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          degerDegisti = true;
                                                          secilenVergiDairesi = vergiDairesiList[index].DaireAdi;
                                                          _secilenVergiDaireID = vergiDairesiList[index].ID;
                                                          cariKartEditResponseDto?.VergiDairesiID = _secilenVergiDaireID;
                                                          cariKartEditResponseDto?.L_VergiDairesiID = secilenVergiDairesi;
                                                          cariKartSaveRequestDto?.VergiDairesiID = _secilenVergiDaireID;
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
                                                        child: Center(child: Text(vergiDairesiList[index].DaireAdi,
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
                            border: formCheck ? Border.all(color: Colors.black, width: 0.5)
                                : formCheck! || secilenVergiDairesi.isEmpty ? Border.all(color: Colors.red, width: 1)
                                : formCheck! || secilenVergiDairesi.isNotEmpty ? Border.all(color: Colors.black, width: 0.5) : null,
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child: cariKartEditResponseDto != null && degerDegisti == false ?
                          Center(
                            child: Text(cariKartEditResponseDto!.L_VergiDairesiID.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ) :
                          degerDegisti && secilenVergiDairesi.isNotEmpty ?
                          Center(
                            child: Text(secilenVergiDairesi.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          )
                              :
                          Center(
                            child: Text("Lütfen Seçiniz",
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/45,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      // TODO : TC/VKN
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("TC/VKN",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.black),
                                  textAlign: TextAlign.start))),
                      Container(
                          height: MediaQuery.of(context).size.height/17,
                          width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                            border: formCheck ? Border.all(color: Colors.black, width: 0.5)
                                : formCheck! || _tcvkn.isEmpty ? Border.all(color: Colors.red, width: 1)
                                : formCheck! || _tcvkn.isNotEmpty ? Border.all(color: Colors.black, width: 0.5) : null,
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child: TextFormField(
                              controller: tcvkn,
                              textAlign: TextAlign.center,
                              maxLength: 11,
                              onChanged: (value){
                                setState(() {
                                  _tcvkn = value;
                                  cariKartEditResponseDto?.TCKNo = value;
                                });
                              },
                              cursorColor: Colors.white,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "Lütfen TC / VKN Giriniz",
                                  hintStyle: TextStyle(color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.height/45),
                                  counterText: '',
                                  border: InputBorder.none))),
                      // TODO : Araç Plaka
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("Araç Plaka",
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
                              controller: aracPlaka,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              onChanged: (value){
                                setState(() {
                                  _aracPlaka = value;
                                  cariKartEditResponseDto?.PlakaNo = value;
                                });
                              },
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Lütfen Araç Plakası Giriniz",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.height/45),
                                  border: InputBorder.none))),
                      //TODO : Cari Türü
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("Cari Türü",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.black),
                                  textAlign: TextAlign.start))),
                      GestureDetector(
                        onTap: (){
                          cariTuruAraController.clear();
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
                                            child: Text("Cari Türü Seçiniz",
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
                                              cariFiltrele(value);
                                            },
                                            controller: cariTuruAraController,
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
                                                itemCount: cariTuruList.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/120),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          degerDegisti = true;
                                                          secilenCariTuru = cariTuruList[index].CariTuruAdi;
                                                          _secilenCariTurID = cariTuruList[index].ID;
                                                          cariKartEditResponseDto?.UreticiTipi = _secilenCariTurID;
                                                          cariKartEditResponseDto?.L_UreticiTipi = secilenCariTuru;
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
                                                        child: Center(child: Text(cariTuruList[index].CariTuruAdi,
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
                            border: formCheck ? Border.all(color: Colors.black, width: 0.5)
                                : formCheck! || secilenCariTuru.isEmpty ? Border.all(color: Colors.red, width: 1)
                                : formCheck! || secilenCariTuru.isNotEmpty ? Border.all(color: Colors.black, width: 0.5) : null,
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child: cariKartEditResponseDto != null && degerDegisti == false ? Center(
                            child: Text(
                              cariKartEditResponseDto?.L_UreticiTipi?.toString() ?? "Lütfen Seçiniz",
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 50,
                                color: Colors.white,
                              ),
                            ),
                          ) : degerDegisti && secilenCariTuru.isNotEmpty ? Center(
                            child: Text(secilenCariTuru.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.white,
                              ),
                            ),
                          ) : Center(
                            child: Text(
                              "Lütfen Seçiniz",
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // TODO : Adres
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text("Adres",
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
                              controller: adres,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              onChanged: (value){
                                setState(() {
                                  _adres = value;
                                  cariKartEditResponseDto?.Adres = value;
                                });
                              },
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Lütfen Adres Bilgisi Giriniz",
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
                                                          degerDegisti = true;
                                                          ilIDInfo = ilList[index].ID;
                                                          secilenIl = ilList[index].IlAdi;
                                                          _secilenIlID = ilList[index].ID;
                                                          cariKartEditResponseDto?.IlID = _secilenIlID;
                                                          cariKartEditResponseDto?.L_IlID = secilenIl;
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
                            border: formCheck ? Border.all(color: Colors.black, width: 0.5)
                                : formCheck! || secilenIl.isEmpty ? Border.all(color: Colors.red, width: 1)
                                : formCheck! || secilenIl.isNotEmpty ? Border.all(color: Colors.black, width: 0.5) : null,
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child: cariKartEditResponseDto != null && degerDegisti == false ? Center(
                            child: Text(
                              cariKartEditResponseDto?.L_IlID?.toString() ?? "Lütfen Seçiniz",
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.white,
                              ),
                            ),
                          ) : degerDegisti && secilenIl.isNotEmpty ? Center(
                            child: Text(
                              secilenIl.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.white,
                              ),
                            ),
                          ) : Center(
                            child: Text(
                              "Lütfen Seçiniz",
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.white,
                              ),
                            ),
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
                        onTap: secilenIl.isEmpty && cariKartEditResponseDto == null ? null : (){
                          ilceAraController.clear();
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
                                                iconColor: Colors.black,
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
                                                          degerDegisti = true;
                                                          ilceIDInfo = ilceList[index].ID;
                                                          secilenIlce = ilceList[index].IlceAdi;
                                                          _secilenIlceID = ilceList[index].ID;
                                                          cariKartEditResponseDto?.IlceID = _secilenIlceID;
                                                          cariKartEditResponseDto?.L_IlceID = secilenIlce;
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
                                                        child: Center(child: Text(ilceList[index].IlceAdi,
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
                          decoration: (secilenIl.isEmpty && cariKartEditResponseDto == null)
                              ? BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey,
                          )
                              : BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child: cariKartEditResponseDto != null && degerDegisti == false ? Center(
                            child: Text(
                              cariKartEditResponseDto?.L_IlceID?.toString() ?? "Lütasdfen Seçiniz",
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.white,
                              ),
                            ),
                          ) : degerDegisti && secilenIlce.isNotEmpty ? Center(
                            child: Text(
                              secilenIlce.toString() ?? "Lütfen Seçiniz",
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.white,
                              ),
                            ),
                          )
                              :
                          Center(
                            child: secilenIl.isNotEmpty ? Text("Lütfen Seçiniz",
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.white,
                              ),
                            ) :
                            Text("Lütfen Önce İl Seçiniz",
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.black54,
                              ),
                            ),
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
                        onTap: secilenIlce.isEmpty && cariKartEditResponseDto == null ? null : (){
                          beldeAraController.clear();
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
                                                child: Text("Belde Seçiniz",
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
                                            style: const TextStyle(color: Colors.black),
                                            onChanged: (value) {
                                              beldeFiltrele(value);
                                            },
                                            controller: beldeAraController,
                                            decoration: const InputDecoration(
                                                labelText: "Ara",
                                                hintText: "Ara",
                                                labelStyle: TextStyle(color: Colors.black),
                                                hintStyle: TextStyle(color: Colors.black),
                                                iconColor: Colors.black,
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
                                                          degerDegisti = true;
                                                          secilenBelde = beldeList[index].BeldeAdi;
                                                          _secilenBeldeID = beldeList[index].ID;
                                                          cariKartEditResponseDto?.BeldeID = _secilenBeldeID;
                                                          cariKartEditResponseDto?.L_BeldeID = secilenBelde;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/19,
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: const Color(0xff10AEE4)),
                                                        child: Center(child: Text(beldeList[index].BeldeAdi,
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
                          decoration: (secilenIlce.isEmpty && cariKartEditResponseDto == null)
                              ? BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey,
                          )
                              : BoxDecoration(
                            border:  Border.all(
                                color: Colors.black,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff10AEE4),
                          ),
                          child: cariKartEditResponseDto != null && degerDegisti == false ? Center(
                            child: Text(
                              cariKartEditResponseDto?.L_BeldeID?.toString() ?? "Lütfen Seçiniz",
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.white,
                              ),
                            ),
                          )
                              : degerDegisti && secilenBelde.isNotEmpty ? Center(
                            child: Text(secilenBelde.toString() ?? "Lütfen Seçiniz",
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height / 45,
                                color: Colors.white,
                              ),
                            ),
                          ) : Center(child: secilenIlce.isNotEmpty ? Text("Lütfen Seçiniz",
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height / 45,
                              color: Colors.white,
                            ),
                          )
                              : Text(
                            "Lütfen Önce İlçe Seçiniz",
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height / 45,
                              color: Colors.black54,
                            ),
                          ),
                          ),
                        ),
                      ),
                      // TODO : Cep Telefonu
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Text("Cep Telefonu",
                              style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height/45,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/17,
                        width: MediaQuery.of(context).size.width/1.1,
                        decoration: BoxDecoration(
                          border: formCheck ? Border.all(color: Colors.black, width: 0.5)
                              : formCheck! || _cepTelefon.isEmpty ? Border.all(color: Colors.red, width: 1)
                              : formCheck! || _cepTelefon.isNotEmpty ? Border.all(color: Colors.black, width: 0.5) : null,
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff10AEE4),
                        ),
                        child: TextFormField(
                          controller: cepTelefonu,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.white,
                          onChanged: (value){
                            setState(() {
                              _cepTelefon = value;
                              cariKartEditResponseDto?.CepTel = value;
                            });
                          },
                          inputFormatters: [TextMask(pallet: '+90(###) ### ## ##')],
                          maxLength: 18,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/50),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Lütfen Cep Telefon No Giriniz",
                            counterText: '',
                            hintStyle: TextStyle(color: Colors.white,
                                fontSize: MediaQuery.of(context).size.height/45),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height/21,
                            bottom: MediaQuery.of(context).size.height/21),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                        setState(() {
                                                          cariAdiDeger.clear();
                                                          tcvkn.clear();
                                                          aracPlaka.clear();
                                                          adres.clear();
                                                          cepTelefonu.clear();
                                                          secilenVergiDairesi = "";
                                                          secilenCariTuru = "";
                                                          secilenIl = "";
                                                          secilenIlce = "";
                                                          secilenBelde = "";
                                                        });
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
                                width: MediaQuery.of(context).size.width/3.5,
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
                                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                                            builder: (context) => CariKartListesi()), (route) => false);
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
                                width: MediaQuery.of(context).size.width/3.5,
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
                            // TODO : Kaydet Butonu
                            GestureDetector(
                              onTap: (){
                                // TODO: KAYDET İŞLEMİNDEN SONRA OLACAK
                                kayitDegerSetle();
                                bool isFormValid = formValid();
                                setState(() {
                                  if (duzenlemeMi) {
                                    sayfaIndex = 2;
                                  } else {
                                    if (isFormValid) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => HKSSifatEkle(
                                            duzenlemeMi: duzenlemeMi,
                                            cariKartEditResponseDto: cariKartEditResponseDto,
                                            cariKartSaveRequestDto: _cariKartSaveRequestDto,
                                          ),
                                        ),
                                      );
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
                                  }
                                  _loading = false;
                                });
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height/17,
                                width: MediaQuery.of(context).size.width/3.5,
                                decoration: BoxDecoration(
                                    color: const Color(0xff10AEE4),
                                    border: Border.all(color: Colors.black,width: 0.5),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Text("Kaydet",
                                    style: GoogleFonts.poppins(
                                        fontSize: MediaQuery.of(context).size.height/45,
                                        color: Colors.white),),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
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