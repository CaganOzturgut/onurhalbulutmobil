import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';

class CariEkstreRaporDetay extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return CariEkstreRaporDetayState();
  }
}

class CariEkstreRaporDetayState extends State<CariEkstreRaporDetay>{

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }


  @override
  void initState(){
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test", style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height/40)),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              share();
            },
            child: Container(
                height: MediaQuery.of(context).size.height/17,
                width: MediaQuery.of(context).size.width/7,
                child: Icon(Icons.share)),
          )
        ],
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color.fromRGBO(15, 38, 72, 1.0), Color.fromRGBO(
                      92, 130, 194, 1.0)]
              )
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(
            175, 185, 231, 1.0),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Center(child: Text("Tarih",style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height/55)),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                    child: Container(
                      child: Center(child: Text("Giriş",style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.height/55)),),
                    ),
                  ),
                  Container(
                    child: Center(child: Text("Çıkış",style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height/55)),),
                  ),
                  Container(
                    child: Center(child: Text("Bakiye",style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height/55)),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/6.5,
                    child: Center(child: Text("Rehin Bakiye",textAlign: TextAlign.center,style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height/55)),),
                  ),
                ],
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height/15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 5), // changes position of shadow
                              ),
                            ],
                            color: const Color.fromRGBO(92, 130, 194, 1.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width/5.5,
                                    child:  Center(child: Text("31.12.2022",style: GoogleFonts.poppins(
                                        fontSize: MediaQuery.of(context).size.height/55))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/45),
                                    child: Container(
                                        width: MediaQuery.of(context).size.width/6.5,
                                        child: Center(child: Text("1500",style: GoogleFonts.poppins(
                                            fontSize: MediaQuery.of(context).size.height/55)))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/60),
                                    child: Container(
                                        width: MediaQuery.of(context).size.width/6.5,
                                        child: Center(child: Text("500000 ",style: GoogleFonts.poppins(
                                            fontSize: MediaQuery.of(context).size.height/55)))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/20),
                                    child: Container(
                                        width: MediaQuery.of(context).size.width/6.5,
                                        child: Center(child: Text("150000 ",style: GoogleFonts.poppins(
                                            fontSize: MediaQuery.of(context).size.height/55)))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/20),
                                    child: Container(
                                        width: MediaQuery.of(context).size.width/6.5,
                                        child: Center(child: Text("150000",style: GoogleFonts.poppins(
                                            fontSize: MediaQuery.of(context).size.height/55)))),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Center(child: Text("LoremIpsumDolerSitAmet", style: GoogleFonts.poppins(
                                        fontSize: MediaQuery.of(context).size.height/55,color: Colors.red[
                                          800])),),
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}