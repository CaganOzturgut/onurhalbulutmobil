import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onurhalbulutmobil/dto/subeRequestDto.dart';
import 'package:onurhalbulutmobil/dto/subeResponseDto.dart';
import 'package:onurhalbulutmobil/main.dart';
import 'package:onurhalbulutmobil/services/subeService.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';


class MenuAppBar extends StatefulWidget{

  List<dynamic> idList = [];

  MenuAppBar({required this.idList});


  @override
  State<StatefulWidget> createState() {
    return MenuAppBarState(idList: idList);
  }
}

class MenuAppBarState extends State<MenuAppBar> {

  List<dynamic> idList = [];
  List<Map<String, dynamic>> sonuclar = [];


  MenuAppBarState({required this.idList});

  late bool yetkiKontrol = false;

  List<MenuYetki> menuYetkiListesi = [
    MenuYetki(176,"Varlıklar"),
    MenuYetki(177,"Müşteri Mizan"),
    MenuYetki(178,"Üretici Mizan"),
    MenuYetki(179,"Kasa Defteri"),
    MenuYetki(180,"Günün Özeti"),
    MenuYetki(181,"Karşılaştırmalı Satış Özeti"),
    MenuYetki(182,"Satış İcmali"),
    MenuYetki(183,"Satış Özeti"),
    MenuYetki(184,"Satış Takibi"),
    MenuYetki(185,"Satış Listesi"),
    MenuYetki(186,"Fiyat Bazlı Satış Listesi"),
    MenuYetki(187,"Alış İcmali"),
    MenuYetki(188,"Tahsilat"),
    MenuYetki(189,"Ödeme"),
    MenuYetki(190,"Satış Faturası"),
    MenuYetki(191,"Satış İrsaliyesi"),
    MenuYetki(192,"Sipariş"),
    MenuYetki(222,"Mal Alış"),
    MenuYetki(223,"Mal Satış"),
    MenuYetki(229,"Cari Kart Tanımlama"),
    MenuYetki(230,"Stok Künyesi Al"),
    MenuYetki(232,"Sevk/Satış Künyesi Al"),

  ];

  List<MenuYetki> arananMenuYetkileri = [];

  @override
  void initState(){
    split();
    super.initState();
  }

  kontrolEt(){

    List<MenuYetki> bulunanMenuYetkileri = [];

    // TODO : Her bir aranan menu yetkisini, menuYetkiListesi içinde ara
    for (var arananMenuYetki in arananMenuYetkileri) {
      for (var menuYetki in menuYetkiListesi) {
        if (arananMenuYetki.id == menuYetki.id &&
            arananMenuYetki.ad == menuYetki.ad) {
          // TODO : Bulunan menu yetkisini bulunanMenuYetkileri listesine ekle
          bulunanMenuYetkileri.add(menuYetki);
        }
      }
    }
  }

  nane(){
    menuYetkiListesi.contains(arananMenuYetkileri);
  }

  split(){
    String veri = idList.toString().replaceAll("[", "").replaceAll("]", "");

    List<String> ayirilmisVeri = veri.split(",");

    for (var item in ayirilmisVeri) {
      List<String> parcalanmis = item.split(":");
      if (parcalanmis.length == 2) { // Değerin iki parçaya ayrıldığından emin oluyoruz
        int? anahtar = int.tryParse(parcalanmis[0]);
        String deger = parcalanmis[1];
        if (anahtar != null) {
          Map<String, dynamic> map = {
            "id": anahtar,
            "ad": deger,
          };
          arananMenuYetkileri.add(MenuYetki(anahtar,deger));
        }
      }
    }
    kontrolEt();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 1.02,
                width: MediaQuery.of(context).size.width,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color.fromRGBO(15, 38, 72, 1.0),
                            Color.fromRGBO(92, 130, 194, 1.0)]
                      )),
                  child:  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/75),
                    child: Column(
                        children: <Widget>[
                           Container(
                            height: MediaQuery.of(context).size.height/17,
                            width: MediaQuery.of(context).size.width/1.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white
                            ),
                            child: Center(
                              child: Text("HKS",style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/45,
                                  color: const Color.fromRGBO(15, 38, 72, 1.0))),
                            ),
                          )
                        ]
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                        onTap: (){
                          print("Buna bastım insta!!!");
                        },
                        child: Icon(FontAwesomeIcons.instagram,color: Colors.white70,)),
                  ),
                  GestureDetector(
                      onTap: (){
                        print("Buna bastım tw!!");
                      },
                      child: Icon(FontAwesomeIcons.twitter,color: Colors.white70,)),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Icon(FontAwesomeIcons.facebook,color: Colors.white70,),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Container(
                    height: MediaQuery.of(context).size.height/40,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/vatanlogo.png",color: Colors.white70,)),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MenuYetki {
  int id;
  String ad;

  MenuYetki(this.id, this.ad);
}