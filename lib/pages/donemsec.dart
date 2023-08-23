import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onurhalbulutmobil/helperwidgets/helperStorage.dart';
import 'package:onurhalbulutmobil/pages/subesec.dart';
import '../dto/loginResponseDto.dart';

class DonemSec extends StatefulWidget{

  final LoginResponseDto loginResponseDto;

  DonemSec({required this.loginResponseDto});

  @override
  State<StatefulWidget> createState() {
    return DonemSecState(loginResponseDto: this.loginResponseDto);
  }
}

class DonemSecState extends State{

  final LoginResponseDto loginResponseDto;

  DonemSecState({required this.loginResponseDto});

  late List<dynamic> _donemler = [];
  late int subeAdet;

  donemleriAl(){
    loginResponseDto.LisansList?.forEach((element) {
      element.vtList.forEach((element) {
        _donemler.add(element);
        print(_donemler);
      });
    });
  }


  @override
  void initState() {
    donemleriAl();
    super.initState();
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
        title: Text("Dönem Seçiniz",
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
                itemCount: _donemler.length,
                itemBuilder: (context, int index){
                  _donemler[index];
                  return Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height/55),
                    child: GestureDetector(
                      onTap: (){
                        UserStorage().donemInfo(_donemler[index].DBAdi);
                        UserStorage().vtAdiInfo(_donemler[index].VTAdi);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SubeSec(
                              loginResponseDto: loginResponseDto,
                              vtadi: _donemler[index].VTAdi,
                              subeID: _donemler[index].ID)),
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
                          child: Text(_donemler[index].DBAdi,
                              style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height/45,
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
