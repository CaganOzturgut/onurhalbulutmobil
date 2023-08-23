import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onurhalbulutmobil/helperwidgets/profileAppBar.dart';
import 'package:onurhalbulutmobil/pages/ambarSatisListesi.dart';
import 'package:onurhalbulutmobil/pages/cariKartListesi.dart';
import 'package:onurhalbulutmobil/pages/sevkSatisKunyesiAl.dart';
import 'package:onurhalbulutmobil/pages/stokKunyesiAl.dart';

class HomePage extends StatefulWidget {

  List<dynamic> yetkiListesi = [];

  HomePage({required this.yetkiListesi});

  @override
  HomePageState createState() => HomePageState(yetkiListesi: yetkiListesi);
}

class HomePageState extends State<HomePage> {

  List<dynamic> yetkiListesi = [];

  HomePageState({required this.yetkiListesi});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ProfileAppBar(),
      // endDrawer: MenuAppBar(idList: OnurHalBulutAppSetting().yetkiListesi),
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width,
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
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[Color(0xff10AEE4), Color(0xff10AEE4)]
                              )),
                          child:  Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/75),
                            child: Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        Navigator.pop(context);
                                        showDialog(context: context, builder: (BuildContext context){
                                          return Container(
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            color: Colors.transparent,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap:(){
                                                    setState(() {
                                                      Navigator.pop(context);
                                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CariKartListesi()));
                                                    });
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height/7,
                                                    width: MediaQuery.of(context).size.width/1.5,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12.withOpacity(0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 7,
                                                          offset: const Offset(0,5), // changes position of shadow
                                                        ),
                                                      ],
                                                      borderRadius: BorderRadius.circular(12),
                                                      color: const Color(0xff10AEE4),
                                                    ),
                                                    child: Center(child: Text("Cari Kart Listesi",style: GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(context).size.height/45,
                                                        color: Colors.white,decoration: TextDecoration.none
                                                    ),)),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap:(){
                                                    setState(() {
                                                      Navigator.pop(context);
                                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                    });
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height/7,
                                                    width: MediaQuery.of(context).size.width/1.5,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12.withOpacity(0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 7,
                                                          offset: const Offset(0,5), // changes position of shadow
                                                        ),
                                                      ],
                                                      borderRadius: BorderRadius.circular(12),
                                                      color: const Color(0xff10AEE4),
                                                    ),
                                                    child: Center(child: Text("Stok Künyesi Al",style: GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(context).size.height/45,
                                                        color: Colors.white,decoration: TextDecoration.none
                                                    ),)),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap:(){
                                                    setState(() {
                                                      Navigator.pop(context);
                                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SevkSatisKunyesiAl()));
                                                    });
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height/7,
                                                    width: MediaQuery.of(context).size.width/1.5,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12.withOpacity(0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 7,
                                                          offset: const Offset(0,5), // changes position of shadow
                                                        ),
                                                      ],
                                                      borderRadius: BorderRadius.circular(12),
                                                      color: const Color(0xff10AEE4),
                                                    ),
                                                    child: Center(child: Text("Sevk/Satış Künyesi Al",style: GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(context).size.height/45,
                                                        color: Colors.white,decoration: TextDecoration.none
                                                    ),)),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap:(){
                                                    setState(() {
                                                      Navigator.pop(context);
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (BuildContext context) => SevkSatisKunyesiList()));
                                                    });
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height/7,
                                                    width: MediaQuery.of(context).size.width/1.5,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12.withOpacity(0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 7,
                                                          offset: const Offset(0,5), // changes position of shadow
                                                        ),
                                                      ],
                                                      borderRadius: BorderRadius.circular(12),
                                                      color: const Color(0xff10AEE4),
                                                    ),
                                                    child: Center(child: Text("Sevk/Satış Künyesi Listesi",
                                                      style: GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(context).size.height/45,
                                                        color: Colors.white,decoration: TextDecoration.none
                                                    ),)),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap:(){
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height/21,
                                                    width: MediaQuery.of(context).size.width/1.5,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12)
                                                    ),
                                                    child: Center(child: Text("Kapat",
                                                      style: GoogleFonts.poppins(
                                                          fontSize: MediaQuery.of(context).size.height/45,
                                                          decoration: TextDecoration.none,
                                                          color: Colors.white
                                                      ),
                                                    )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/16,
                                      width: MediaQuery.of(context).size.width/1.5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.black)
                                      ),
                                      child: Center(
                                        child: Text("Cari Kart - HKS",style: GoogleFonts.poppins(
                                            fontSize: MediaQuery.of(context).size.height/45,
                                            fontWeight: FontWeight.w500,color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          // _sayfaIndex = 2;
                                          Navigator.pop(context);
                                        });
                                        // TODO Satış Alt Menü Dialog
                                        showDialog(context: context, builder: (BuildContext context){
                                          return Container(
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            color: Colors.transparent,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height : MediaQuery.of(context).size.height/17,
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Center(child: Text("Yakında Hizmetinizde !",style: GoogleFonts.poppins(
                                                      fontSize: MediaQuery.of(context).size.height/45,
                                                      color: Colors.white,decoration: TextDecoration.none
                                                  )),),
                                                ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //       bottom: MediaQuery.of(context).size.height/21,top: MediaQuery.of(context).size.height/13),
                                                //   child: GestureDetector(
                                                //     onTap:(){
                                                //       setState(() {
                                                //         Navigator.pop(context);
                                                //        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MusteriMizanSayfasi()));
                                                //       });
                                                //     },
                                                //     child: Container(
                                                //       height: MediaQuery.of(context).size.height/9,
                                                //       width: MediaQuery.of(context).size.width/1.5,
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.black12.withOpacity(0.5),
                                                //             spreadRadius: 2,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 5), // changes position of shadow
                                                //           ),
                                                //         ],
                                                //         borderRadius: BorderRadius.circular(12),
                                                //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //       ),
                                                //       child: Center(child: Text("Satış Faturası Listesi",style: GoogleFonts.poppins(
                                                //           fontSize: MediaQuery.of(context).size.height/45,
                                                //           color: Colors.white,decoration: TextDecoration.none
                                                //       ),)),
                                                //     ),
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                //   child: GestureDetector(
                                                //     onTap : (){
                                                //       setState(() {
                                                //         Navigator.pop(context);
                                                //        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //       });
                                                //       // TODO Satış Alt Menüler
                                                //       showDialog(context: context, builder: (BuildContext context){
                                                //         return Container(
                                                //           height: MediaQuery.of(context).size.height,
                                                //           width: MediaQuery.of(context).size.width,
                                                //           color: Colors.transparent,
                                                //           child: Column(
                                                //             mainAxisAlignment: MainAxisAlignment.center,
                                                //             children: <Widget>[
                                                //               Padding(
                                                //                 padding: EdgeInsets.only(
                                                //                     bottom: MediaQuery.of(context).size.height/27,
                                                //                     top: MediaQuery.of(context).size.height/13),
                                                //                 child: GestureDetector(
                                                //                   onTap:(){
                                                //                     setState(() {
                                                //                       Navigator.pop(context);
                                                //                       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MusteriMizanSayfasi()));
                                                //                     });
                                                //                   },
                                                //                   child: Container(
                                                //                     height: MediaQuery.of(context).size.height/17,
                                                //                     width: MediaQuery.of(context).size.width/1.5,
                                                //                     decoration: BoxDecoration(
                                                //                       boxShadow: [
                                                //                         BoxShadow(
                                                //                           color: Colors.black12.withOpacity(0.5),
                                                //                           spreadRadius: 2,
                                                //                           blurRadius: 7,
                                                //                           offset: Offset(0, 5), // changes position of shadow
                                                //                         ),
                                                //                       ],
                                                //                       borderRadius: BorderRadius.circular(12),
                                                //                       color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //                     ),
                                                //                     child: Center(child: Text("Marka Satış İcmali",style: GoogleFonts.poppins(
                                                //                         fontSize: MediaQuery.of(context).size.height/45,
                                                //                         color: Colors.white,decoration: TextDecoration.none
                                                //                     ),)),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               Padding(
                                                //                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/27),
                                                //                 child: GestureDetector(
                                                //                   onTap : (){
                                                //                     setState(() {
                                                //                       Navigator.pop(context);
                                                //                       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //                     });
                                                //
                                                //                   },
                                                //                   child: Container(
                                                //                     height: MediaQuery.of(context).size.height/17,
                                                //                     width: MediaQuery.of(context).size.width/1.5,
                                                //                     decoration: BoxDecoration(
                                                //                       boxShadow: [
                                                //                         BoxShadow(
                                                //                           color: Colors.black12.withOpacity(0.5),
                                                //                           spreadRadius: 2,
                                                //                           blurRadius: 7,
                                                //                           offset: Offset(0, 5), // changes position of shadow
                                                //                         ),
                                                //                       ],
                                                //                       borderRadius: BorderRadius.circular(12),
                                                //                       color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //                     ),
                                                //                     child: Center(child: Text("Satış Takibi",style: GoogleFonts.poppins(
                                                //                         fontSize: MediaQuery.of(context).size.height/45,
                                                //                         color: Colors.white,
                                                //                         decoration: TextDecoration.none
                                                //                     ),)),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               Padding(
                                                //                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/27),
                                                //                 child: GestureDetector(
                                                //                   onTap : (){
                                                //                     setState(() {
                                                //                       Navigator.pop(context);
                                                //                       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //                     });
                                                //
                                                //                   },
                                                //                   child: Container(
                                                //                     height: MediaQuery.of(context).size.height/17,
                                                //                     width: MediaQuery.of(context).size.width/1.5,
                                                //                     decoration: BoxDecoration(
                                                //                       boxShadow: [
                                                //                         BoxShadow(
                                                //                           color: Colors.black12.withOpacity(0.5),
                                                //                           spreadRadius: 2,
                                                //                           blurRadius: 7,
                                                //                           offset: Offset(0, 5), // changes position of shadow
                                                //                         ),
                                                //                       ],
                                                //                       borderRadius: BorderRadius.circular(12),
                                                //                       color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //                     ),
                                                //                     child: Center(child: Text("Satış Fatura Listesi",style: GoogleFonts.poppins(
                                                //                         fontSize: MediaQuery.of(context).size.height/45,
                                                //                         color: Colors.white,
                                                //                         decoration: TextDecoration.none
                                                //                     ),)),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               Padding(
                                                //                 padding: EdgeInsets.only(
                                                //                     bottom: MediaQuery.of(context).size.height/27),
                                                //                 child: GestureDetector(
                                                //                   onTap : (){
                                                //                     setState(() {
                                                //                       Navigator.pop(context);
                                                //                       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //                     });
                                                //
                                                //                   },
                                                //                   child: Container(
                                                //                     height: MediaQuery.of(context).size.height/17,
                                                //                     width: MediaQuery.of(context).size.width/1.5,
                                                //                     decoration: BoxDecoration(
                                                //                       boxShadow: [
                                                //                         BoxShadow(
                                                //                           color: Colors.black12.withOpacity(0.5),
                                                //                           spreadRadius: 2,
                                                //                           blurRadius: 7,
                                                //                           offset: Offset(0, 5), // changes position of shadow
                                                //                         ),
                                                //                       ],
                                                //                       borderRadius: BorderRadius.circular(12),
                                                //                       color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //                     ),
                                                //                     child: Center(child: Text("Satış Künye Listesi",style: GoogleFonts.poppins(
                                                //                         fontSize: MediaQuery.of(context).size.height/45,
                                                //                         color: Colors.white,
                                                //                         decoration: TextDecoration.none
                                                //                     ),)),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               Padding(
                                                //                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/27),
                                                //                 child: GestureDetector(
                                                //                   onTap : (){
                                                //                     setState(() {
                                                //                       Navigator.pop(context);
                                                //                       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //                     });
                                                //
                                                //                   },
                                                //                   child: Container(
                                                //                     height: MediaQuery.of(context).size.height/17,
                                                //                     width: MediaQuery.of(context).size.width/1.5,
                                                //                     decoration: BoxDecoration(
                                                //                       boxShadow: [
                                                //                         BoxShadow(
                                                //                           color: Colors.black12.withOpacity(0.5),
                                                //                           spreadRadius: 2,
                                                //                           blurRadius: 7,
                                                //                           offset: Offset(0, 5), // changes position of shadow
                                                //                         ),
                                                //                       ],
                                                //                       borderRadius: BorderRadius.circular(12),
                                                //                       color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //                     ),
                                                //                     child: Center(child: Text("Satış İcmali",style: GoogleFonts.poppins(
                                                //                         fontSize: MediaQuery.of(context).size.height/45,
                                                //                         color: Colors.white,
                                                //                         decoration: TextDecoration.none
                                                //                     ),)),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               Padding(
                                                //                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/27),
                                                //                 child: GestureDetector(
                                                //                   onTap : (){
                                                //                     setState(() {
                                                //                       Navigator.pop(context);
                                                //                       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //                     });
                                                //
                                                //                   },
                                                //                   child: Container(
                                                //                     height: MediaQuery.of(context).size.height/17,
                                                //                     width: MediaQuery.of(context).size.width/1.5,
                                                //                     decoration: BoxDecoration(
                                                //                       boxShadow: [
                                                //                         BoxShadow(
                                                //                           color: Colors.black12.withOpacity(0.5),
                                                //                           spreadRadius: 2,
                                                //                           blurRadius: 7,
                                                //                           offset: Offset(0, 5), // changes position of shadow
                                                //                         ),
                                                //                       ],
                                                //                       borderRadius: BorderRadius.circular(12),
                                                //                       color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //                     ),
                                                //                     child: Center(child: Text("Satış Özet",style: GoogleFonts.poppins(
                                                //                         fontSize: MediaQuery.of(context).size.height/45,
                                                //                         color: Colors.white,
                                                //                         decoration: TextDecoration.none
                                                //                     ),)),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               Padding(
                                                //                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/27),
                                                //                 child: GestureDetector(
                                                //                   onTap : (){
                                                //                     setState(() {
                                                //                       Navigator.pop(context);
                                                //                       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //                     });
                                                //
                                                //                   },
                                                //                   child: Container(
                                                //                     height: MediaQuery.of(context).size.height/17,
                                                //                     width: MediaQuery.of(context).size.width/1.5,
                                                //                     decoration: BoxDecoration(
                                                //                       boxShadow: [
                                                //                         BoxShadow(
                                                //                           color: Colors.black12.withOpacity(0.5),
                                                //                           spreadRadius: 2,
                                                //                           blurRadius: 7,
                                                //                           offset: Offset(0, 5), // changes position of shadow
                                                //                         ),
                                                //                       ],
                                                //                       borderRadius: BorderRadius.circular(12),
                                                //                       color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //                     ),
                                                //                     child: Center(child: Text("Satış İrsaliye Listesi",style: GoogleFonts.poppins(
                                                //                         fontSize: MediaQuery.of(context).size.height/45,
                                                //                         color: Colors.white,
                                                //                         decoration: TextDecoration.none
                                                //                     ),)),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               Padding(
                                                //                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/27),
                                                //                 child: GestureDetector(
                                                //                   onTap : (){
                                                //                     setState(() {
                                                //                       Navigator.pop(context);
                                                //                       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //                     });
                                                //
                                                //                   },
                                                //                   child: Container(
                                                //                     height: MediaQuery.of(context).size.height/17,
                                                //                     width: MediaQuery.of(context).size.width/1.5,
                                                //                     decoration: BoxDecoration(
                                                //                       boxShadow: [
                                                //                         BoxShadow(
                                                //                           color: Colors.black12.withOpacity(0.5),
                                                //                           spreadRadius: 2,
                                                //                           blurRadius: 7,
                                                //                           offset: Offset(0, 5), // changes position of shadow
                                                //                         ),
                                                //                       ],
                                                //                       borderRadius: BorderRadius.circular(12),
                                                //                       color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //                     ),
                                                //                     child: Center(child: Text("Satış Mizan",style: GoogleFonts.poppins(
                                                //                         fontSize: MediaQuery.of(context).size.height/45,
                                                //                         color: Colors.white,
                                                //                         decoration: TextDecoration.none
                                                //                     ),)),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               Padding(
                                                //                 padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                                                //                 child: GestureDetector(
                                                //                   onTap:(){
                                                //                     Navigator.pop(context);
                                                //                   },
                                                //                   child: Container(
                                                //                     height: MediaQuery.of(context).size.height/21,
                                                //                     width: MediaQuery.of(context).size.width/1.5,
                                                //                     decoration: BoxDecoration(
                                                //                         borderRadius: BorderRadius.circular(12)
                                                //                     ),
                                                //                     child: Center(child: Text("Kapat",
                                                //                       style: GoogleFonts.poppins(
                                                //                           fontSize: MediaQuery.of(context).size.height/55,
                                                //                           decoration: TextDecoration.none,
                                                //                           color: Colors.white
                                                //                       ),
                                                //                     )),
                                                //                   ),
                                                //                 ),
                                                //               )
                                                //             ],
                                                //           ),
                                                //         );
                                                //       });
                                                //
                                                //     },
                                                //     child: Container(
                                                //       height: MediaQuery.of(context).size.height/9,
                                                //       width: MediaQuery.of(context).size.width/1.5,
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.black12.withOpacity(0.5),
                                                //             spreadRadius: 2,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 5), // changes position of shadow
                                                //           ),
                                                //         ],
                                                //         borderRadius: BorderRadius.circular(12),
                                                //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //       ),
                                                //       child: Center(child: Text("Satış Raporları",style: GoogleFonts.poppins(
                                                //           fontSize: MediaQuery.of(context).size.height/45,
                                                //           color: Colors.white,
                                                //           decoration: TextDecoration.none
                                                //       ),)),
                                                //     ),
                                                //   ),
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  child: GestureDetector(
                                                    onTap:(){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: MediaQuery.of(context).size.height/21,
                                                      width: MediaQuery.of(context).size.width/1.5,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(12)
                                                      ),
                                                      child: Center(child: Text("Kapat",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: MediaQuery.of(context).size.height/55,
                                                            decoration: TextDecoration.none,
                                                            color: Colors.white
                                                        ),
                                                      )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height/16,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: Center(
                                          child: Text("Satış",style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/45,
                                              fontWeight: FontWeight.w500,color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                         // _sayfaIndex = 2;
                                          Navigator.pop(context);
                                        });
                                        showDialog(context: context, builder: (BuildContext context){
                                          return Container(
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            color: Colors.transparent,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height : MediaQuery.of(context).size.height/17,
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Center(child: Text("Yakında Hizmetinizde !",style: GoogleFonts.poppins(
                                                      fontSize: MediaQuery.of(context).size.height/45,
                                                      color: Colors.white,decoration: TextDecoration.none
                                                  )),),
                                                ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //       bottom: MediaQuery.of(context).size.height/21,top: MediaQuery.of(context).size.height/13),
                                                //   child: GestureDetector(
                                                //     onTap:(){
                                                //       setState(() {
                                                //         Navigator.pop(context);
                                                //         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MusteriMizanSayfasi()));
                                                //       });
                                                //     },
                                                //     child: Container(
                                                //       height: MediaQuery.of(context).size.height/9,
                                                //       width: MediaQuery.of(context).size.width/1.5,
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.black12.withOpacity(0.5),
                                                //             spreadRadius: 2,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 5), // changes position of shadow
                                                //           ),
                                                //         ],
                                                //         borderRadius: BorderRadius.circular(12),
                                                //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //       ),
                                                //       child: Center(child: Text("Ham Madde Alış",style: GoogleFonts.poppins(
                                                //           fontSize: MediaQuery.of(context).size.height/45,
                                                //           color: Colors.white,decoration: TextDecoration.none
                                                //       ),)),
                                                //     ),
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                //   child: GestureDetector(
                                                //     onTap : (){
                                                //       setState(() {
                                                //         Navigator.pop(context);
                                                //        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //       });
                                                //     },
                                                //     child: Container(
                                                //       height: MediaQuery.of(context).size.height/9,
                                                //       width: MediaQuery.of(context).size.width/1.5,
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.black12.withOpacity(0.5),
                                                //             spreadRadius: 2,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 5), // changes position of shadow
                                                //           ),
                                                //         ],
                                                //         borderRadius: BorderRadius.circular(12),
                                                //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //       ),
                                                //       child: Center(child: Text("Mal Alış",style: GoogleFonts.poppins(
                                                //           fontSize: MediaQuery.of(context).size.height/45,
                                                //           color: Colors.white,
                                                //           decoration: TextDecoration.none
                                                //       ),)),
                                                //     ),
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                //   child: GestureDetector(
                                                //     onTap : (){
                                                //       setState(() {
                                                //         Navigator.pop(context);
                                                //         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //       });
                                                //     },
                                                //     child: Container(
                                                //       height: MediaQuery.of(context).size.height/9,
                                                //       width: MediaQuery.of(context).size.width/1.5,
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.black12.withOpacity(0.5),
                                                //             spreadRadius: 2,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 5), // changes position of shadow
                                                //           ),
                                                //         ],
                                                //         borderRadius: BorderRadius.circular(12),
                                                //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //       ),
                                                //       child: Center(child: Text("Mal Satış",style: GoogleFonts.poppins(
                                                //           fontSize: MediaQuery.of(context).size.height/45,
                                                //           color: Colors.white,
                                                //           decoration: TextDecoration.none
                                                //       ),)),
                                                //     ),
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                //   child: GestureDetector(
                                                //     onTap : (){
                                                //       setState(() {
                                                //         Navigator.pop(context);
                                                //         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //       });
                                                //     },
                                                //     child: Container(
                                                //       height: MediaQuery.of(context).size.height/9,
                                                //       width: MediaQuery.of(context).size.width/1.5,
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.black12.withOpacity(0.5),
                                                //             spreadRadius: 2,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 5), // changes position of shadow
                                                //           ),
                                                //         ],
                                                //         borderRadius: BorderRadius.circular(12),
                                                //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //       ),
                                                //       child: Center(child: Text("Bekleyen Mal Satış",style: GoogleFonts.poppins(
                                                //           fontSize: MediaQuery.of(context).size.height/45,
                                                //           color: Colors.white,
                                                //           decoration: TextDecoration.none
                                                //       ),)),
                                                //     ),
                                                //   ),
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  child: GestureDetector(
                                                    onTap:(){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: MediaQuery.of(context).size.height/21,
                                                      width: MediaQuery.of(context).size.width/1.5,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(12)
                                                      ),
                                                      child: Center(child: Text("Kapat",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: MediaQuery.of(context).size.height/55,
                                                            decoration: TextDecoration.none,
                                                            color: Colors.white
                                                        ),
                                                      )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });

                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height/16,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: Center(
                                          child: Text("Sipariş",style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/45,
                                              fontWeight: FontWeight.w500,color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          // _sayfaIndex = 2;
                                          Navigator.pop(context);
                                        });
                                        // TODO Mal Alış Satış Dialog
                                        showDialog(context: context, builder: (BuildContext context){
                                          return Container(
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            color: Colors.transparent,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height : MediaQuery.of(context).size.height/17,
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Center(child: Text("Yakında Hizmetinizde !",style: GoogleFonts.poppins(
                                                      fontSize: MediaQuery.of(context).size.height/45,
                                                      color: Colors.white,decoration: TextDecoration.none
                                                  )),),
                                                ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //       bottom: MediaQuery.of(context).size.height/21,top: MediaQuery.of(context).size.height/13),
                                                //   child: GestureDetector(
                                                //     onTap:(){
                                                //       setState(() {
                                                //         Navigator.pop(context);
                                                //         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MusteriMizanSayfasi()));
                                                //       });
                                                //     },
                                                //     child: Container(
                                                //       height: MediaQuery.of(context).size.height/9,
                                                //       width: MediaQuery.of(context).size.width/1.5,
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.black12.withOpacity(0.5),
                                                //             spreadRadius: 2,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 5), // changes position of shadow
                                                //           ),
                                                //         ],
                                                //         borderRadius: BorderRadius.circular(12),
                                                //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //       ),
                                                //       child: Center(child: Text("Ham Madde Alış",style: GoogleFonts.poppins(
                                                //           fontSize: MediaQuery.of(context).size.height/45,
                                                //           color: Colors.white,decoration: TextDecoration.none
                                                //       ),)),
                                                //     ),
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                //   child: GestureDetector(
                                                //     onTap : (){
                                                //       setState(() {
                                                //         Navigator.pop(context);
                                                //        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //       });
                                                //     },
                                                //     child: Container(
                                                //       height: MediaQuery.of(context).size.height/9,
                                                //       width: MediaQuery.of(context).size.width/1.5,
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.black12.withOpacity(0.5),
                                                //             spreadRadius: 2,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 5), // changes position of shadow
                                                //           ),
                                                //         ],
                                                //         borderRadius: BorderRadius.circular(12),
                                                //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //       ),
                                                //       child: Center(child: Text("Mal Alış",style: GoogleFonts.poppins(
                                                //           fontSize: MediaQuery.of(context).size.height/45,
                                                //           color: Colors.white,
                                                //           decoration: TextDecoration.none
                                                //       ),)),
                                                //     ),
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                //   child: GestureDetector(
                                                //     onTap : (){
                                                //       setState(() {
                                                //         Navigator.pop(context);
                                                //         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //       });
                                                //     },
                                                //     child: Container(
                                                //       height: MediaQuery.of(context).size.height/9,
                                                //       width: MediaQuery.of(context).size.width/1.5,
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.black12.withOpacity(0.5),
                                                //             spreadRadius: 2,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 5), // changes position of shadow
                                                //           ),
                                                //         ],
                                                //         borderRadius: BorderRadius.circular(12),
                                                //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //       ),
                                                //       child: Center(child: Text("Mal Satış",style: GoogleFonts.poppins(
                                                //           fontSize: MediaQuery.of(context).size.height/45,
                                                //           color: Colors.white,
                                                //           decoration: TextDecoration.none
                                                //       ),)),
                                                //     ),
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                //   child: GestureDetector(
                                                //     onTap : (){
                                                //       setState(() {
                                                //         Navigator.pop(context);
                                                //         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //       });
                                                //     },
                                                //     child: Container(
                                                //       height: MediaQuery.of(context).size.height/9,
                                                //       width: MediaQuery.of(context).size.width/1.5,
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.black12.withOpacity(0.5),
                                                //             spreadRadius: 2,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 5), // changes position of shadow
                                                //           ),
                                                //         ],
                                                //         borderRadius: BorderRadius.circular(12),
                                                //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //       ),
                                                //       child: Center(child: Text("Bekleyen Mal Satış",style: GoogleFonts.poppins(
                                                //           fontSize: MediaQuery.of(context).size.height/45,
                                                //           color: Colors.white,
                                                //           decoration: TextDecoration.none
                                                //       ),)),
                                                //     ),
                                                //   ),
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  child: GestureDetector(
                                                    onTap:(){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: MediaQuery.of(context).size.height/21,
                                                      width: MediaQuery.of(context).size.width/1.5,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(12)
                                                      ),
                                                      child: Center(child: Text("Kapat",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: MediaQuery.of(context).size.height/55,
                                                            decoration: TextDecoration.none,
                                                            color: Colors.white
                                                        ),
                                                      )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height/16,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: Center(
                                          child: Text("Mal Alış - Mal Satış",style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/45,
                                              fontWeight: FontWeight.w500,color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          // _sayfaIndex = 2;
                                          Navigator.pop(context);
                                        });
                                        showDialog(context: context, builder: (BuildContext context){
                                          return Container(
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            color: Colors.transparent,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height : MediaQuery.of(context).size.height/17,
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Center(child: Text("Yakında Hizmetinizde !",style: GoogleFonts.poppins(
                                                      fontSize: MediaQuery.of(context).size.height/45,
                                                      color: Colors.white,decoration: TextDecoration.none
                                                  )),),
                                                ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                //   child: GestureDetector(
                                                //     onTap:(){
                                                //       setState(() {
                                                //         Navigator.pop(context);
                                                //       });
                                                //     },
                                                //     child: Container(
                                                //       height: MediaQuery.of(context).size.height/9,
                                                //       width: MediaQuery.of(context).size.width/1.5,
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.black12.withOpacity(0.5),
                                                //             spreadRadius: 2,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 5), // changes position of shadow
                                                //           ),
                                                //         ],
                                                //         borderRadius: BorderRadius.circular(12),
                                                //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //       ),
                                                //       child: Center(child: Text("Rehin Takibi",style: GoogleFonts.poppins(
                                                //           fontSize: MediaQuery.of(context).size.height/45,
                                                //           color: Colors.white,decoration: TextDecoration.none
                                                //       ),)),
                                                //     ),
                                                //   ),
                                                // ),
                                                // GestureDetector(
                                                //   onTap : (){
                                                //     setState(() {
                                                //       Navigator.pop(context);
                                                //       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                //     });
                                                //   },
                                                //   child: Container(
                                                //     height: MediaQuery.of(context).size.height/9,
                                                //     width: MediaQuery.of(context).size.width/1.5,
                                                //     decoration: BoxDecoration(
                                                //       boxShadow: [
                                                //         BoxShadow(
                                                //           color: Colors.black12.withOpacity(0.5),
                                                //           spreadRadius: 2,
                                                //           blurRadius: 7,
                                                //           offset: Offset(0, 5), // changes position of shadow
                                                //         ),
                                                //       ],
                                                //       borderRadius: BorderRadius.circular(12),
                                                //       color: Color.fromRGBO(92, 130, 194, 1.0),
                                                //     ),
                                                //     child: Center(child: Text("Rehin Ekstre",style: GoogleFonts.poppins(
                                                //         fontSize: MediaQuery.of(context).size.height/45,
                                                //         color: Colors.white,
                                                //         decoration: TextDecoration.none
                                                //     ),)),
                                                //   ),
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  child: GestureDetector(
                                                    onTap:(){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: MediaQuery.of(context).size.height/21,
                                                      width: MediaQuery.of(context).size.width/1.5,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(12)
                                                      ),
                                                      child: Center(child: Text("Kapat",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: MediaQuery.of(context).size.height/55,
                                                            decoration: TextDecoration.none,
                                                            color: Colors.white
                                                        ),
                                                      )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height/16,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: Center(
                                          child: Text("Rehin",style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/45,
                                              fontWeight: FontWeight.w500,color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          // _sayfaIndex = 2;
                                          Navigator.pop(context);
                                        });
                                        showDialog(context: context, builder: (BuildContext context){
                                          return Container(
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    height : MediaQuery.of(context).size.height/17,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Center(child: Text("Yakında Hizmetinizde !",style: GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(context).size.height/45,
                                                        color: Colors.white,decoration: TextDecoration.none
                                                    )),),
                                                  ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //   child: GestureDetector(
                                                  //     onTap:(){
                                                  //       setState(() {
                                                  //         Navigator.pop(context);
                                                  //       });
                                                  //     },
                                                  //     child: Container(
                                                  //       height: MediaQuery.of(context).size.height/13,
                                                  //       width: MediaQuery.of(context).size.width/1.5,
                                                  //       decoration: BoxDecoration(
                                                  //         boxShadow: [
                                                  //           BoxShadow(
                                                  //             color: Colors.black12.withOpacity(0.5),
                                                  //             spreadRadius: 2,
                                                  //             blurRadius: 7,
                                                  //             offset: Offset(0, 5), // changes position of shadow
                                                  //           ),
                                                  //         ],
                                                  //         borderRadius: BorderRadius.circular(12),
                                                  //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //       ),
                                                  //       child: Center(child: Text("Cari Hesaplar",style: GoogleFonts.poppins(
                                                  //           fontSize: MediaQuery.of(context).size.height/45,
                                                  //           color: Colors.white,decoration: TextDecoration.none
                                                  //       ),)),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //   child: GestureDetector(
                                                  //     onTap : (){
                                                  //       setState(() {
                                                  //         Navigator.pop(context);
                                                  //         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                  //       });
                                                  //     },
                                                  //     child: Container(
                                                  //       height: MediaQuery.of(context).size.height/13,
                                                  //       width: MediaQuery.of(context).size.width/1.5,
                                                  //       decoration: BoxDecoration(
                                                  //         boxShadow: [
                                                  //           BoxShadow(
                                                  //             color: Colors.black12.withOpacity(0.5),
                                                  //             spreadRadius: 2,
                                                  //             blurRadius: 7,
                                                  //             offset: Offset(0, 5), // changes position of shadow
                                                  //           ),
                                                  //         ],
                                                  //         borderRadius: BorderRadius.circular(12),
                                                  //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //       ),
                                                  //       child: Center(child: Text("Tahsilat",style: GoogleFonts.poppins(
                                                  //           fontSize: MediaQuery.of(context).size.height/45,
                                                  //           color: Colors.white,
                                                  //           decoration: TextDecoration.none
                                                  //       ),)),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //   child: GestureDetector(
                                                  //     onTap : (){
                                                  //       setState(() {
                                                  //         Navigator.pop(context);
                                                  //         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                  //       });
                                                  //     },
                                                  //     child: Container(
                                                  //       height: MediaQuery.of(context).size.height/13,
                                                  //       width: MediaQuery.of(context).size.width/1.5,
                                                  //       decoration: BoxDecoration(
                                                  //         boxShadow: [
                                                  //           BoxShadow(
                                                  //             color: Colors.black12.withOpacity(0.5),
                                                  //             spreadRadius: 2,
                                                  //             blurRadius: 7,
                                                  //             offset: Offset(0, 5), // changes position of shadow
                                                  //           ),
                                                  //         ],
                                                  //         borderRadius: BorderRadius.circular(12),
                                                  //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //       ),
                                                  //       child: Center(child: Text("Ödeme",style: GoogleFonts.poppins(
                                                  //           fontSize: MediaQuery.of(context).size.height/45,
                                                  //           color: Colors.white,
                                                  //           decoration: TextDecoration.none
                                                  //       ),)),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //   child: GestureDetector(
                                                  //     onTap : (){
                                                  //       setState(() {
                                                  //         Navigator.pop(context);
                                                  //         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                  //       });
                                                  //     },
                                                  //     child: Container(
                                                  //       height: MediaQuery.of(context).size.height/13,
                                                  //       width: MediaQuery.of(context).size.width/1.5,
                                                  //       decoration: BoxDecoration(
                                                  //         boxShadow: [
                                                  //           BoxShadow(
                                                  //             color: Colors.black12.withOpacity(0.5),
                                                  //             spreadRadius: 2,
                                                  //             blurRadius: 7,
                                                  //             offset: Offset(0, 5), // changes position of shadow
                                                  //           ),
                                                  //         ],
                                                  //         borderRadius: BorderRadius.circular(12),
                                                  //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //       ),
                                                  //       child: Center(child: Text("Alış İcmali",style: GoogleFonts.poppins(
                                                  //           fontSize: MediaQuery.of(context).size.height/45,
                                                  //           color: Colors.white,
                                                  //           decoration: TextDecoration.none
                                                  //       ),)),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // GestureDetector(
                                                  //   onTap : (){
                                                  //     setState(() {
                                                  //       Navigator.pop(context);
                                                  //       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                                                  //     });
                                                  //   },
                                                  //   child: Container(
                                                  //     height: MediaQuery.of(context).size.height/13,
                                                  //     width: MediaQuery.of(context).size.width/1.5,
                                                  //     decoration: BoxDecoration(
                                                  //       boxShadow: [
                                                  //         BoxShadow(
                                                  //           color: Colors.black12.withOpacity(0.5),
                                                  //           spreadRadius: 2,
                                                  //           blurRadius: 7,
                                                  //           offset: Offset(0, 5), // changes position of shadow
                                                  //         ),
                                                  //       ],
                                                  //       borderRadius: BorderRadius.circular(12),
                                                  //       color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //     ),
                                                  //     child: Center(child: Text("Cari Hesap Raporlar",style: GoogleFonts.poppins(
                                                  //         fontSize: MediaQuery.of(context).size.height/45,
                                                  //         color: Colors.white,
                                                  //         decoration: TextDecoration.none
                                                  //     ),)),
                                                  //   ),
                                                  // ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                    child: GestureDetector(
                                                      onTap:(){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/21,
                                                        width: MediaQuery.of(context).size.width/1.5,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12)
                                                        ),
                                                        child: Center(child: Text("Kapat",
                                                          style: GoogleFonts.poppins(
                                                              fontSize: MediaQuery.of(context).size.height/55,
                                                              decoration: TextDecoration.none,
                                                              color: Colors.white
                                                          ),
                                                        )),
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
                                        height: MediaQuery.of(context).size.height/16,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: Center(
                                          child: Text("Cari Hesap",style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/45,
                                              fontWeight: FontWeight.w500,color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          // _sayfaIndex = 2;
                                          Navigator.pop(context);
                                        });
                                        showDialog(context: context, builder: (BuildContext context){
                                          return Container(
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    height : MediaQuery.of(context).size.height/17,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Center(child: Text("Yakında Hizmetinizde !",style: GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(context).size.height/45,
                                                        color: Colors.white,decoration: TextDecoration.none
                                                    )),),
                                                  ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //   child: GestureDetector(
                                                  //     onTap:(){
                                                  //       setState(() {
                                                  //         Navigator.pop(context);
                                                  //       });
                                                  //     },
                                                  //     child: Container(
                                                  //       height: MediaQuery.of(context).size.height/9,
                                                  //       width: MediaQuery.of(context).size.width/1.5,
                                                  //       decoration: BoxDecoration(
                                                  //         boxShadow: [
                                                  //           BoxShadow(
                                                  //             color: Colors.black12.withOpacity(0.5),
                                                  //             spreadRadius: 2,
                                                  //             blurRadius: 7,
                                                  //             offset: Offset(0, 5), // changes position of shadow
                                                  //           ),
                                                  //         ],
                                                  //         borderRadius: BorderRadius.circular(12),
                                                  //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //       ),
                                                  //       child: Center(child: Text("Mizan (Ekstre)",style: GoogleFonts.poppins(
                                                  //           fontSize: MediaQuery.of(context).size.height/45,
                                                  //           color: Colors.white,decoration: TextDecoration.none
                                                  //       ),)),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                    child: GestureDetector(
                                                      onTap:(){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/21,
                                                        width: MediaQuery.of(context).size.width/1.5,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12)
                                                        ),
                                                        child: Center(child: Text("Kapat",
                                                          style: GoogleFonts.poppins(
                                                              fontSize: MediaQuery.of(context).size.height/55,
                                                              decoration: TextDecoration.none,
                                                              color: Colors.white
                                                          ),
                                                        )),
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
                                        height: MediaQuery.of(context).size.height/16,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: Center(
                                          child: Text("Genel Gider",style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/45,
                                              fontWeight: FontWeight.w500,color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          // _sayfaIndex = 2;
                                          Navigator.pop(context);
                                        });
                                        showDialog(context: context, builder: (BuildContext context){
                                          return Container(
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    height : MediaQuery.of(context).size.height/17,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Center(child: Text("Yakında Hizmetinizde !",style: GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(context).size.height/45,
                                                        color: Colors.white,decoration: TextDecoration.none
                                                    )),),
                                                  ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //   child: GestureDetector(
                                                  //     onTap:(){
                                                  //       setState(() {
                                                  //         Navigator.pop(context);
                                                  //       });
                                                  //      //TODO Müşteri Çekleri Alt Menüler
                                                  //       showDialog(context: context, builder: (BuildContext context){
                                                  //         return Container(
                                                  //           height: MediaQuery.of(context).size.height,
                                                  //           width: MediaQuery.of(context).size.width,
                                                  //           color: Colors.transparent,
                                                  //           child: Padding(
                                                  //             padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  //             child: Column(
                                                  //               mainAxisAlignment: MainAxisAlignment.center,
                                                  //               children: <Widget>[
                                                  //                 Padding(
                                                  //                   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //                   child: GestureDetector(
                                                  //                     onTap:(){
                                                  //                       setState(() {
                                                  //                         Navigator.pop(context);
                                                  //                       });
                                                  //                     },
                                                  //                     child: Container(
                                                  //                       height: MediaQuery.of(context).size.height/9,
                                                  //                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                       decoration: BoxDecoration(
                                                  //                         boxShadow: [
                                                  //                           BoxShadow(
                                                  //                             color: Colors.black12.withOpacity(0.5),
                                                  //                             spreadRadius: 2,
                                                  //                             blurRadius: 7,
                                                  //                             offset: Offset(0, 5), // changes position of shadow
                                                  //                           ),
                                                  //                         ],
                                                  //                         borderRadius: BorderRadius.circular(12),
                                                  //                         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //                       ),
                                                  //                       child: Center(child: Text("Bekleyen Çekler",style: GoogleFonts.poppins(
                                                  //                           fontSize: MediaQuery.of(context).size.height/45,
                                                  //                           color: Colors.white,decoration: TextDecoration.none
                                                  //                       ),)),
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //                 Padding(
                                                  //                   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //                   child: GestureDetector(
                                                  //                     onTap:(){
                                                  //                       setState(() {
                                                  //                         Navigator.pop(context);
                                                  //                       });
                                                  //                     },
                                                  //                     child: Container(
                                                  //                       height: MediaQuery.of(context).size.height/9,
                                                  //                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                       decoration: BoxDecoration(
                                                  //                         boxShadow: [
                                                  //                           BoxShadow(
                                                  //                             color: Colors.black12.withOpacity(0.5),
                                                  //                             spreadRadius: 2,
                                                  //                             blurRadius: 7,
                                                  //                             offset: Offset(0, 5), // changes position of shadow
                                                  //                           ),
                                                  //                         ],
                                                  //                         borderRadius: BorderRadius.circular(12),
                                                  //                         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //                       ),
                                                  //                       child: Center(child: Text("İşlem Gören Çekler",style: GoogleFonts.poppins(
                                                  //                           fontSize: MediaQuery.of(context).size.height/45,
                                                  //                           color: Colors.white,decoration: TextDecoration.none
                                                  //                       ),)),
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //                 Padding(
                                                  //                   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //                   child: GestureDetector(
                                                  //                     onTap:(){
                                                  //                       setState(() {
                                                  //                         Navigator.pop(context);
                                                  //                       });
                                                  //                       // TODO Çek Rapor Alt
                                                  //                       showDialog(context: context, builder: (BuildContext context){
                                                  //                         return Container(
                                                  //                           height: MediaQuery.of(context).size.height,
                                                  //                           width: MediaQuery.of(context).size.width,
                                                  //                           color: Colors.transparent,
                                                  //                           child: Padding(
                                                  //                             padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  //                             child: Column(
                                                  //                               mainAxisAlignment: MainAxisAlignment.center,
                                                  //                               children: <Widget>[
                                                  //                                 Padding(
                                                  //                                   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //                                   child: GestureDetector(
                                                  //                                     onTap:(){
                                                  //                                       setState(() {
                                                  //                                         Navigator.pop(context);
                                                  //                                       });
                                                  //                                     },
                                                  //                                     child: Container(
                                                  //                                       height: MediaQuery.of(context).size.height/9,
                                                  //                                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                                       decoration: BoxDecoration(
                                                  //                                         boxShadow: [
                                                  //                                           BoxShadow(
                                                  //                                             color: Colors.black12.withOpacity(0.5),
                                                  //                                             spreadRadius: 2,
                                                  //                                             blurRadius: 7,
                                                  //                                             offset: Offset(0, 5), // changes position of shadow
                                                  //                                           ),
                                                  //                                         ],
                                                  //                                         borderRadius: BorderRadius.circular(12),
                                                  //                                         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //                                       ),
                                                  //                                       child: Center(child: Text("Vadeli Çekler (Dönem)",style: GoogleFonts.poppins(
                                                  //                                           fontSize: MediaQuery.of(context).size.height/45,
                                                  //                                           color: Colors.white,decoration: TextDecoration.none
                                                  //                                       ),)),
                                                  //                                     ),
                                                  //                                   ),
                                                  //                                 ),
                                                  //                                 Padding(
                                                  //                                   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //                                   child: GestureDetector(
                                                  //                                     onTap:(){
                                                  //                                       setState(() {
                                                  //                                         Navigator.pop(context);
                                                  //                                       });
                                                  //                                     },
                                                  //                                     child: Container(
                                                  //                                       height: MediaQuery.of(context).size.height/9,
                                                  //                                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                                       decoration: BoxDecoration(
                                                  //                                         boxShadow: [
                                                  //                                           BoxShadow(
                                                  //                                             color: Colors.black12.withOpacity(0.5),
                                                  //                                             spreadRadius: 2,
                                                  //                                             blurRadius: 7,
                                                  //                                             offset: Offset(0, 5), // changes position of shadow
                                                  //                                           ),
                                                  //                                         ],
                                                  //                                         borderRadius: BorderRadius.circular(12),
                                                  //                                         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //                                       ),
                                                  //                                       child: Center(child: Text("Çek Raporu",style: GoogleFonts.poppins(
                                                  //                                           fontSize: MediaQuery.of(context).size.height/45,
                                                  //                                           color: Colors.white,decoration: TextDecoration.none
                                                  //                                       ),)),
                                                  //                                     ),
                                                  //                                   ),
                                                  //                                 ),
                                                  //                                 Padding(
                                                  //                                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  //                                   child: GestureDetector(
                                                  //                                     onTap:(){
                                                  //                                       Navigator.pop(context);
                                                  //                                     },
                                                  //                                     child: Container(
                                                  //                                       height: MediaQuery.of(context).size.height/21,
                                                  //                                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                                       decoration: BoxDecoration(
                                                  //                                           borderRadius: BorderRadius.circular(12)
                                                  //                                       ),
                                                  //                                       child: Center(child: Text("Kapat",
                                                  //                                         style: GoogleFonts.poppins(
                                                  //                                             fontSize: MediaQuery.of(context).size.height/55,
                                                  //                                             decoration: TextDecoration.none,
                                                  //                                             color: Colors.white
                                                  //                                         ),
                                                  //                                       )),
                                                  //                                     ),
                                                  //                                   ),
                                                  //                                 )
                                                  //                               ],
                                                  //                             ),
                                                  //                           ),
                                                  //                         );
                                                  //                       });
                                                  //                     },
                                                  //                     child: Container(
                                                  //                       height: MediaQuery.of(context).size.height/9,
                                                  //                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                       decoration: BoxDecoration(
                                                  //                         boxShadow: [
                                                  //                           BoxShadow(
                                                  //                             color: Colors.black12.withOpacity(0.5),
                                                  //                             spreadRadius: 2,
                                                  //                             blurRadius: 7,
                                                  //                             offset: Offset(0, 5), // changes position of shadow
                                                  //                           ),
                                                  //                         ],
                                                  //                         borderRadius: BorderRadius.circular(12),
                                                  //                         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //                       ),
                                                  //                       child: Center(child: Text("Müşteri Çek Rapor",style: GoogleFonts.poppins(
                                                  //                           fontSize: MediaQuery.of(context).size.height/45,
                                                  //                           color: Colors.white,decoration: TextDecoration.none
                                                  //                       ),)),
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //                 Padding(
                                                  //                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  //                   child: GestureDetector(
                                                  //                     onTap:(){
                                                  //                       Navigator.pop(context);
                                                  //                     },
                                                  //                     child: Container(
                                                  //                       height: MediaQuery.of(context).size.height/21,
                                                  //                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                       decoration: BoxDecoration(
                                                  //                           borderRadius: BorderRadius.circular(12)
                                                  //                       ),
                                                  //                       child: Center(child: Text("Kapat",
                                                  //                         style: GoogleFonts.poppins(
                                                  //                             fontSize: MediaQuery.of(context).size.height/55,
                                                  //                             decoration: TextDecoration.none,
                                                  //                             color: Colors.white
                                                  //                         ),
                                                  //                       )),
                                                  //                     ),
                                                  //                   ),
                                                  //                 )
                                                  //               ],
                                                  //             ),
                                                  //           ),
                                                  //         );
                                                  //       });
                                                  //     },
                                                  //     child: Container(
                                                  //       height: MediaQuery.of(context).size.height/9,
                                                  //       width: MediaQuery.of(context).size.width/1.5,
                                                  //       decoration: BoxDecoration(
                                                  //         boxShadow: [
                                                  //           BoxShadow(
                                                  //             color: Colors.black12.withOpacity(0.5),
                                                  //             spreadRadius: 2,
                                                  //             blurRadius: 7,
                                                  //             offset: Offset(0, 5), // changes position of shadow
                                                  //           ),
                                                  //         ],
                                                  //         borderRadius: BorderRadius.circular(12),
                                                  //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //       ),
                                                  //       child: Center(child: Text("Müşteri Çekleri",style: GoogleFonts.poppins(
                                                  //           fontSize: MediaQuery.of(context).size.height/45,
                                                  //           color: Colors.white,decoration: TextDecoration.none
                                                  //       ),)),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //   child: GestureDetector(
                                                  //     onTap:(){
                                                  //       setState(() {
                                                  //         Navigator.pop(context);
                                                  //       });
                                                  //       //TODO Firma Çekleri Alt Menü
                                                  //       showDialog(context: context, builder: (BuildContext context){
                                                  //         return Container(
                                                  //           height: MediaQuery.of(context).size.height,
                                                  //           width: MediaQuery.of(context).size.width,
                                                  //           color: Colors.transparent,
                                                  //           child: Padding(
                                                  //             padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  //             child: Column(
                                                  //               mainAxisAlignment: MainAxisAlignment.center,
                                                  //               children: <Widget>[
                                                  //                 Padding(
                                                  //                   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //                   child: GestureDetector(
                                                  //                     onTap:(){
                                                  //                       setState(() {
                                                  //                         Navigator.pop(context);
                                                  //                       });
                                                  //                     },
                                                  //                     child: Container(
                                                  //                       height: MediaQuery.of(context).size.height/9,
                                                  //                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                       decoration: BoxDecoration(
                                                  //                         boxShadow: [
                                                  //                           BoxShadow(
                                                  //                             color: Colors.black12.withOpacity(0.5),
                                                  //                             spreadRadius: 2,
                                                  //                             blurRadius: 7,
                                                  //                             offset: Offset(0, 5), // changes position of shadow
                                                  //                           ),
                                                  //                         ],
                                                  //                         borderRadius: BorderRadius.circular(12),
                                                  //                         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //                       ),
                                                  //                       child: Center(child: Text("Bekleyen Firma Çekleri",style: GoogleFonts.poppins(
                                                  //                           fontSize: MediaQuery.of(context).size.height/45,
                                                  //                           color: Colors.white,decoration: TextDecoration.none
                                                  //                       ),)),
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //                 Padding(
                                                  //                   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //                   child: GestureDetector(
                                                  //                     onTap:(){
                                                  //                       setState(() {
                                                  //                         Navigator.pop(context);
                                                  //                       });
                                                  //                       //TODO Firma Çek Rapor ALt Menü
                                                  //                       showDialog(context: context, builder: (BuildContext context){
                                                  //                         return Container(
                                                  //                           height: MediaQuery.of(context).size.height,
                                                  //                           width: MediaQuery.of(context).size.width,
                                                  //                           color: Colors.transparent,
                                                  //                           child: Padding(
                                                  //                             padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  //                             child: Column(
                                                  //                               mainAxisAlignment: MainAxisAlignment.center,
                                                  //                               children: <Widget>[
                                                  //                                 Padding(
                                                  //                                   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //                                   child: GestureDetector(
                                                  //                                     onTap:(){
                                                  //                                       setState(() {
                                                  //                                         Navigator.pop(context);
                                                  //                                       });
                                                  //                                     },
                                                  //                                     child: Container(
                                                  //                                       height: MediaQuery.of(context).size.height/9,
                                                  //                                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                                       decoration: BoxDecoration(
                                                  //                                         boxShadow: [
                                                  //                                           BoxShadow(
                                                  //                                             color: Colors.black12.withOpacity(0.5),
                                                  //                                             spreadRadius: 2,
                                                  //                                             blurRadius: 7,
                                                  //                                             offset: Offset(0, 5), // changes position of shadow
                                                  //                                           ),
                                                  //                                         ],
                                                  //                                         borderRadius: BorderRadius.circular(12),
                                                  //                                         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //                                       ),
                                                  //                                       child: Center(child: Text("Vadeli Firma Çeki",style: GoogleFonts.poppins(
                                                  //                                           fontSize: MediaQuery.of(context).size.height/45,
                                                  //                                           color: Colors.white,decoration: TextDecoration.none
                                                  //                                       ),)),
                                                  //                                     ),
                                                  //                                   ),
                                                  //                                 ),
                                                  //                                 Padding(
                                                  //                                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  //                                   child: GestureDetector(
                                                  //                                     onTap:(){
                                                  //                                       Navigator.pop(context);
                                                  //                                     },
                                                  //                                     child: Container(
                                                  //                                       height: MediaQuery.of(context).size.height/21,
                                                  //                                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                                       decoration: BoxDecoration(
                                                  //                                           borderRadius: BorderRadius.circular(12)
                                                  //                                       ),
                                                  //                                       child: Center(child: Text("Kapat",
                                                  //                                         style: GoogleFonts.poppins(
                                                  //                                             fontSize: MediaQuery.of(context).size.height/55,
                                                  //                                             decoration: TextDecoration.none,
                                                  //                                             color: Colors.white
                                                  //                                         ),
                                                  //                                       )),
                                                  //                                     ),
                                                  //                                   ),
                                                  //                                 )
                                                  //                               ],
                                                  //                             ),
                                                  //                           ),
                                                  //                         );
                                                  //                       });
                                                  //                     },
                                                  //                     child: Container(
                                                  //                       height: MediaQuery.of(context).size.height/9,
                                                  //                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                       decoration: BoxDecoration(
                                                  //                         boxShadow: [
                                                  //                           BoxShadow(
                                                  //                             color: Colors.black12.withOpacity(0.5),
                                                  //                             spreadRadius: 2,
                                                  //                             blurRadius: 7,
                                                  //                             offset: Offset(0, 5), // changes position of shadow
                                                  //                           ),
                                                  //                         ],
                                                  //                         borderRadius: BorderRadius.circular(12),
                                                  //                         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //                       ),
                                                  //                       child: Center(child: Text("Firma Çek Rapor",style: GoogleFonts.poppins(
                                                  //                           fontSize: MediaQuery.of(context).size.height/45,
                                                  //                           color: Colors.white,decoration: TextDecoration.none
                                                  //                       ),)),
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //                 Padding(
                                                  //                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                  //                   child: GestureDetector(
                                                  //                     onTap:(){
                                                  //                       Navigator.pop(context);
                                                  //                     },
                                                  //                     child: Container(
                                                  //                       height: MediaQuery.of(context).size.height/21,
                                                  //                       width: MediaQuery.of(context).size.width/1.5,
                                                  //                       decoration: BoxDecoration(
                                                  //                           borderRadius: BorderRadius.circular(12)
                                                  //                       ),
                                                  //                       child: Center(child: Text("Kapat",
                                                  //                         style: GoogleFonts.poppins(
                                                  //                             fontSize: MediaQuery.of(context).size.height/55,
                                                  //                             decoration: TextDecoration.none,
                                                  //                             color: Colors.white
                                                  //                         ),
                                                  //                       )),
                                                  //                     ),
                                                  //                   ),
                                                  //                 )
                                                  //               ],
                                                  //             ),
                                                  //           ),
                                                  //         );
                                                  //       });
                                                  //     },
                                                  //     child: Container(
                                                  //       height: MediaQuery.of(context).size.height/9,
                                                  //       width: MediaQuery.of(context).size.width/1.5,
                                                  //       decoration: BoxDecoration(
                                                  //         boxShadow: [
                                                  //           BoxShadow(
                                                  //             color: Colors.black12.withOpacity(0.5),
                                                  //             spreadRadius: 2,
                                                  //             blurRadius: 7,
                                                  //             offset: Offset(0, 5), // changes position of shadow
                                                  //           ),
                                                  //         ],
                                                  //         borderRadius: BorderRadius.circular(12),
                                                  //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //       ),
                                                  //       child: Center(child: Text("Firma Çekleri",style: GoogleFonts.poppins(
                                                  //           fontSize: MediaQuery.of(context).size.height/45,
                                                  //           color: Colors.white,decoration: TextDecoration.none
                                                  //       ),)),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                    child: GestureDetector(
                                                      onTap:(){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/21,
                                                        width: MediaQuery.of(context).size.width/1.5,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12)
                                                        ),
                                                        child: Center(child: Text("Kapat",
                                                          style: GoogleFonts.poppins(
                                                              fontSize: MediaQuery.of(context).size.height/55,
                                                              decoration: TextDecoration.none,
                                                              color: Colors.white
                                                          ),
                                                        )),
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
                                        height: MediaQuery.of(context).size.height/16,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: Center(
                                          child: Text("Çek",style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/45,
                                              fontWeight: FontWeight.w500,color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          // _sayfaIndex = 2;
                                          Navigator.pop(context);
                                        });
                                        showDialog(context: context, builder: (BuildContext context){
                                          return Container(
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    height : MediaQuery.of(context).size.height/17,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Center(child: Text("Yakında Hizmetinizde !",style: GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(context).size.height/45,
                                                        color: Colors.white,decoration: TextDecoration.none
                                                    )),),
                                                  ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //   child: GestureDetector(
                                                  //     onTap:(){
                                                  //       setState(() {
                                                  //         Navigator.pop(context);
                                                  //       });
                                                  //     },
                                                  //     child: Container(
                                                  //       height: MediaQuery.of(context).size.height/9,
                                                  //       width: MediaQuery.of(context).size.width/1.5,
                                                  //       decoration: BoxDecoration(
                                                  //         boxShadow: [
                                                  //           BoxShadow(
                                                  //             color: Colors.black12.withOpacity(0.5),
                                                  //             spreadRadius: 2,
                                                  //             blurRadius: 7,
                                                  //             offset: Offset(0, 5), // changes position of shadow
                                                  //           ),
                                                  //         ],
                                                  //         borderRadius: BorderRadius.circular(12),
                                                  //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //       ),
                                                  //       child: Center(child: Text("HKS Ambar Oluştur",style: GoogleFonts.poppins(
                                                  //           fontSize: MediaQuery.of(context).size.height/45,
                                                  //           color: Colors.white,decoration: TextDecoration.none
                                                  //       ),)),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/21),
                                                  //   child: GestureDetector(
                                                  //     onTap:(){
                                                  //       setState(() {
                                                  //         Navigator.pop(context);
                                                  //       });
                                                  //     },
                                                  //     child: Container(
                                                  //       height: MediaQuery.of(context).size.height/9,
                                                  //       width: MediaQuery.of(context).size.width/1.5,
                                                  //       decoration: BoxDecoration(
                                                  //         boxShadow: [
                                                  //           BoxShadow(
                                                  //             color: Colors.black12.withOpacity(0.5),
                                                  //             spreadRadius: 2,
                                                  //             blurRadius: 7,
                                                  //             offset: Offset(0, 5), // changes position of shadow
                                                  //           ),
                                                  //         ],
                                                  //         borderRadius: BorderRadius.circular(12),
                                                  //         color: Color.fromRGBO(92, 130, 194, 1.0),
                                                  //       ),
                                                  //       child: Center(child: Text("Stok Alış Künyesi Al",style: GoogleFonts.poppins(
                                                  //           fontSize: MediaQuery.of(context).size.height/45,
                                                  //           color: Colors.white,decoration: TextDecoration.none
                                                  //       ),)),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                                                    child: GestureDetector(
                                                      onTap:(){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/21,
                                                        width: MediaQuery.of(context).size.width/1.5,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12)
                                                        ),
                                                        child: Center(child: Text("Kapat",
                                                          style: GoogleFonts.poppins(
                                                              fontSize: MediaQuery.of(context).size.height/55,
                                                              decoration: TextDecoration.none,
                                                              color: Colors.white
                                                          ),
                                                        )),
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
                                        height: MediaQuery.of(context).size.height/16,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: Center(
                                          child: Text("HKS Fatura",style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/45,
                                              fontWeight: FontWeight.w500,color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                  child: Icon(FontAwesomeIcons.instagram,color: Colors.white,)),
                            ),
                            GestureDetector(
                                onTap: (){
                                  print("Buna bastım tw!!");
                                },
                                child: Icon(FontAwesomeIcons.twitter,color: Colors.white,)),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Icon(FontAwesomeIcons.facebook,color: Colors.white,),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height/40,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset("assets/images/vatanlogo.png",color: Colors.white,)),
                        )
                      ],
                  ),
                ],
              ),
            ),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height/11,
        leading: GestureDetector(
          onTap: (){
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Image.asset("assets/images/profile.png",
              scale: MediaQuery.of(context).size.height/65,
              color: Colors.white,),
          )
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff10AEE4),Color(0xff10AEE4)])
          ),
        ),
        title: Text("",
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height/40,
          fontWeight: FontWeight.w500)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height/3.5,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Image.asset("assets/images/onurhal_bulut.png"),
        ),
      ),
    );
  }
}
