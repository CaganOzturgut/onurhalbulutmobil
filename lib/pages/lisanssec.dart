import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onurhalbulutmobil/dto/loginResponseDto.dart';
import 'package:onurhalbulutmobil/helperwidgets/helperStorage.dart';
import 'package:onurhalbulutmobil/pages/donemsec.dart';

class LisansSec extends StatefulWidget{

  final LoginResponseDto loginResponseDto;

  LisansSec({required this.loginResponseDto});

  @override
  State<StatefulWidget> createState() {
    return LisansSecState(loginResponseDto: this.loginResponseDto);
  }
}

class LisansSecState extends State{

  final LoginResponseDto loginResponseDto;

  LisansSecState({required this.loginResponseDto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff10AEE4), Color(0xff10AEE4)]
              )
          ),
        ),
        title: Text("Lisans Seçiniz",
          style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/40),),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
              child: Image.asset("assets/images/vatan.png",color: Colors.black12,),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: loginResponseDto.LisansList?.length,
                itemBuilder: (context, int index){
                  return Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/55),
                    child: GestureDetector(
                      onTap: (){
                        UserStorage().lisansInfo(loginResponseDto.LisansList![index].FirmaAdi);
                        UserStorage().lisansID(loginResponseDto.LisansList![index].ID);
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DonemSec(loginResponseDto: loginResponseDto)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff10AEE4),
                        ),
                        height: MediaQuery.of(context).size.height/16,
                        width: MediaQuery.of(context).size.width/1.5,
                        child: Center(
                          child: Text(loginResponseDto.LisansList![index].FirmaAdi,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/45,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

}