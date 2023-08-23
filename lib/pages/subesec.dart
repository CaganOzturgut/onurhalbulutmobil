import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:onurhalbulutmobil/dto/loginResponseDto.dart';
import 'package:onurhalbulutmobil/dto/subeRequestDto.dart';
import 'package:onurhalbulutmobil/dto/subeResponseDto.dart';
import 'package:onurhalbulutmobil/helperwidgets/helperStorage.dart';
import 'package:onurhalbulutmobil/main.dart';
import 'package:onurhalbulutmobil/pages/homepage.dart';
import 'package:onurhalbulutmobil/services/subeService.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';

class SubeSec extends StatefulWidget{

  final LoginResponseDto loginResponseDto;
  final String vtadi;
  final int subeID;

  SubeSec({required this.loginResponseDto,required this.vtadi,required this.subeID});

  @override
  State<StatefulWidget> createState() {
    return SubeSecState(loginResponseDto: loginResponseDto,vtadi: vtadi,subeID: subeID);
  }
}

class SubeSecState extends State<SubeSec> with SingleTickerProviderStateMixin{

  final LoginResponseDto loginResponseDto;
  final String vtadi;
  final int subeID;


  SubeSecState({required this.loginResponseDto,required this.vtadi,required this.subeID});

  late bool _loading;
  late SubeService _subeService;

  int? _lisansID;

  List<dynamic> Subeler = [];
  List<String> yetkiListesi = [];

  getParametres(){
    loginResponseDto.LisansList?.forEach((element) {
      _lisansID = element.ID;
    });
    getSubeler();
  }

  getSubeler(){
    _loading = true;

    final SubeRequestDto sube = SubeRequestDto(
      LisansID: OnurHalBulutAppSetting().lisansID,
        SubeID: 0,
        VTAdi: vtadi,
        UserName: OnurHalBulutApp.userDto.UserName,
        UserPass: OnurHalBulutApp.userDto.UserPass);
    Future<SubeResponseDto> user = _subeService.getSube(sube);
    print(user);
    List gelen;
    user.then((value) async {
      if(value.SubeList != null){
        gelen = value.SubeList!.toList();
        setState(() {
          Subeler.addAll(gelen);
        });
        if(Subeler.length <= 1){
          setState(() {
            UserStorage().subeInfo(value.SubeList!.first.SubeAdi);
            UserStorage().subeIDInfo(value.SubeList!.first.ID);
            subeYetki(value.SubeList!.first.ID);
          });
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(yetkiListesi: yetkiListesi)),
          );
        }
        print(Subeler);
      }
      _loading = false;
    });
  }

  @override
  void initState() {
    _subeService = SubeService();
    yetkiListesi.clear();
    getParametres();
    super.initState();
  }


  List<String> subeYetki(int subeID) {
    List<String> yetkiListesi = [];
    for (var veri in Subeler) {
      if (veri.ID == subeID) {
        yetkiListesi.add(veri.MenuYetki);
      }
    }
    UserStorage().yetkiListesiInfo(yetkiListesi);
    print(yetkiListesi);
    return yetkiListesi;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },

          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff10AEE4), Color(0xff10AEE4)]
              )
          ),
        ),
        title: Text("Şube Seçiniz",
          style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/40),),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                  child: Image.asset("assets/images/vatan.png",color: Colors.black12,),
                ),
                Subeler.length > 1 ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: Subeler.length,
                    itemBuilder: (context, int index){
                      Subeler[index];
                      return Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height/55),
                        child: GestureDetector(
                          onTap: () {
                            UserStorage().subeInfo(Subeler[index].SubeAdi);
                            UserStorage().subeIDInfo(Subeler[index].ID);
                            subeYetki(Subeler[index].ID,);
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => HomePage(yetkiListesi: yetkiListesi)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff10AEE4),
                            ),
                            height: MediaQuery.of(context).size.height/16,
                            width: MediaQuery.of(context).size.width/1.5,
                            child: Center(
                              child: Text(Subeler[index].SubeAdi,
                                  style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/45,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      );
                    }) : Container(),
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
                      child: Container(
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
