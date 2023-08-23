import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onurhalbulutmobil/helperwidgets/helperStorage.dart';
import 'package:onurhalbulutmobil/pages/loginpage.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';

class ProfileAppBar extends StatefulWidget{

  @override
  ProfileAppBarState createState() => ProfileAppBarState();
}

class ProfileAppBarState extends State<ProfileAppBar> {


  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                          begin: Alignment.topRight,
                          end: Alignment.topRight,
                          colors: <Color>[Color(0xff10AEE4),Color(0xff10AEE4)]
                      )),
                  child:  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/75),
                    child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height/5,
                            width: MediaQuery.of(context).size.width/1.5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.rectangle
                            ),
                            child: Center(
                              child: Image.asset("assets/images/onurhal_bulut.png",color: Colors.white,height: MediaQuery.of(context).size.height/5,)
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/27),
                            child: Container(
                                height: MediaQuery.of(context).size.height/21,
                                width: MediaQuery.of(context).size.width/1.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.person,color: Colors.white70,size: MediaQuery.of(context).size.height/25,),
                                    Padding(
                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/6.5),
                                      child: Text(OnurHalBulutAppSetting().kullaniciAdi,
                                        style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/40,
                                            color: Colors.white),),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/27),
                            child: Container(
                                width: MediaQuery.of(context).size.width/1.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.key,color: Colors.white70,size: MediaQuery.of(context).size.height/25,),
                                    Padding(
                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/6.5),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Text(OnurHalBulutAppSetting().lisansAdi,
                                          style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,
                                              color: Colors.white),),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/27),
                            child: Container(
                                height: MediaQuery.of(context).size.height/21,
                                width: MediaQuery.of(context).size.width/1.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.home,color: Colors.white70,size: MediaQuery.of(context).size.height/25,),
                                    Padding(
                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/6.5),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Text("${OnurHalBulutAppSetting().donemAdi} / ${OnurHalBulutAppSetting().subeAdi}",
                                          style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height/55,
                                              color: Colors.white),),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11),
                            child: Column(
                              children: <Widget>[
                                // GestureDetector(
                                //   onTap: (){
                                //     showDialog(
                                //         context: context,
                                //         builder: (BuildContext context){
                                //           return Dialog(
                                //             child: Container(
                                //               height: MediaQuery.of(context).size.height/3,
                                //               width: MediaQuery.of(context).size.width,
                                //               color: Colors.white38,
                                //               child: Column(
                                //                 mainAxisAlignment: MainAxisAlignment.center,
                                //                 children: <Widget>[
                                //                   Container(
                                //                     width: MediaQuery.of(context).size.width/2,
                                //                     child: Text("Dönem değiştirmek istediğinize emin misiniz ?",
                                //                         textAlign: TextAlign.center,
                                //                         style: GoogleFonts.poppins(
                                //                             fontSize: MediaQuery.of(context).size.height/55,
                                //                             color: const Color(0xff2C4875))),
                                //                   ),
                                //                   Padding(
                                //                     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/17),
                                //                     child: Row(
                                //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //                       children: <Widget>[
                                //                         GestureDetector(
                                //                           onTap: (){
                                //                             Navigator.pushNamed(context, '/donemsec');
                                //                             },
                                //                           child: Container(
                                //                             height: MediaQuery.of(context).size.height/21,
                                //                             width: MediaQuery.of(context).size.width/3,
                                //                             decoration: BoxDecoration(
                                //                                 borderRadius: BorderRadius.circular(12),
                                //                                 color: const Color.fromRGBO(
                                //                                     92, 130, 194, 1.0)
                                //                             ),
                                //                             child: Center(child: Text("Evet",style: GoogleFonts.poppins(
                                //                                 fontSize: MediaQuery.of(context).size.height/55,
                                //                                 color: Colors.white)),),
                                //                           ),
                                //                         ),
                                //                         GestureDetector(
                                //                           onTap: (){
                                //                             Navigator.pop(context);
                                //                           },
                                //                           child: Container(
                                //                             height: MediaQuery.of(context).size.height/21,
                                //                             width: MediaQuery.of(context).size.width/3,
                                //                             decoration: BoxDecoration(
                                //                                 borderRadius: BorderRadius.circular(12),
                                //                                 color: const Color.fromRGBO(
                                //                                     92, 130, 194, 1.0)
                                //                             ),
                                //                             child: Center(child: Text("Hayır",style: GoogleFonts.poppins(
                                //                                 fontSize: MediaQuery.of(context).size.height/55,
                                //                                 color: Colors.white)),),
                                //                           ),
                                //                         )
                                //                       ],
                                //                     ),
                                //                   )
                                //                 ],
                                //               ),
                                //             ),
                                //           );
                                //         });
                                //   },
                                //   child: Container(
                                //     height: MediaQuery.of(context).size.height/17,
                                //     width: MediaQuery.of(context).size.width/1.3,
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(12),
                                //       color: Colors.white,
                                //     ),
                                //     child: Center(
                                //       child: Text("Dönem Değiştir",
                                //           style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,
                                //           fontWeight: FontWeight.w500,
                                //           color: const Color(0xff062449))),
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/21),
                                  child: GestureDetector(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context){
                                            return Dialog(
                                              child: Container(
                                                height: MediaQuery.of(context).size.height/3,
                                                width: MediaQuery.of(context).size.width,
                                                color: Colors.white38,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      width: MediaQuery.of(context).size.width/2,
                                                      child: Text("Çıkış yapmak istediğinize emin misiniz ?",
                                                          textAlign: TextAlign.center,
                                                          style: GoogleFonts.poppins(
                                                              fontSize: MediaQuery.of(context).size.height/45,
                                                              color: Colors.black)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/17),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: (){
                                                              UserStorage().deleteUser();
                                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                                                  builder: (BuildContext context) => Login()), (route) => false);
                                                            },
                                                            child: Container(
                                                              height: MediaQuery.of(context).size.height/17,
                                                              width: MediaQuery.of(context).size.width/3,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                  border: Border.all(color: Colors.black,
                                                                      width: 0.5),
                                                                  color: const Color(0xff10AEE4)
                                                              ),
                                                              child: Center(child: Text("Evet",
                                                                  style: GoogleFonts.poppins(
                                                                  fontSize: MediaQuery.of(context).size.height/45,
                                                                  color: Colors.white)),),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: (){
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              height: MediaQuery.of(context).size.height/17,
                                                              width: MediaQuery.of(context).size.width/3,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                  border: Border.all(color: Colors.black,
                                                                      width: 0.5),
                                                                  color: const Color(0xff10AEE4)
                                                              ),
                                                              child: Center(child: Text("Hayır",
                                                                  style: GoogleFonts.poppins(
                                                                  fontSize: MediaQuery.of(context).size.height/45,
                                                                  color: Colors.white)),),
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
                                      width: MediaQuery.of(context).size.width/1.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Text("Çıkış Yap",style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff062449))),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
    );
  }

}