import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:onurhalbulutmobil/dto/loginRequestDto.dart';
import 'package:onurhalbulutmobil/dto/loginResponseDto.dart';
import 'package:onurhalbulutmobil/pages/donemsec.dart';
import 'package:onurhalbulutmobil/pages/lisanssec.dart';
import 'package:onurhalbulutmobil/services/loginService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> with SingleTickerProviderStateMixin {

  final kullaniciAdiController = TextEditingController();
  final sifreController = TextEditingController();
  late bool _loading = false;
  late LoginService _loginService;
  late bool _passwordVisible;
  bool _rememberMe = false;

  @override
  void initState() {
    _passwordVisible = false;
    _loginService = LoginService();
    super.initState();

    _checkRememberMeStatus();

  }

  Future<void> _checkRememberMeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('rememberMe') ?? false;
    setState(() {
      _rememberMe = rememberMe;
      if (!_rememberMe) {
        final username = prefs.getString('username');
        kullaniciAdiController.text = username ?? '';
      } else {
        final username = prefs.getString('username');
        final password = prefs.getString('password');
        kullaniciAdiController.text = username ?? '';
        sifreController.text = password ?? '';
      }
    });
  }

  // _saveRememberMeStatus fonksiyonunu ekleyin
  Future<void> _saveRememberMeStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', value);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child:  Scaffold(
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      // decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/blue.jpg"),
                      //   fit: BoxFit.cover)),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: <Color>[Color(0xff10AEE4), Colors.white]
                          )
                      ),
                      // color: const Color.fromRGBO(41, 68, 115, 1.0),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height/4,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height/2.8,
                                          width: MediaQuery.of(context).size.width,
                                          child: Image.asset("assets/images/onurhal_bulut.png",scale: 0.7,),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4.2),
                                      //   child: Center(
                                      //     child: Container(
                                      //       child: Text("Kurumsal Yapı - Hızlı Çözüm - Güvenilir Hizmet",
                                      //         style: GoogleFonts.poppins(color: Colors.white,
                                      //             fontSize: MediaQuery.of(context).size.height/100,
                                      //             fontWeight: FontWeight.bold),),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  //  child: Image.asset("assets/images/ceplogo.png"),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height/2,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/9),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height/18,
                                        width: MediaQuery.of(context).size.width/1.2,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff0A85C3),
                                            borderRadius: BorderRadius.circular(12)),
                                        child: Center(
                                          child: TextFormField(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context).size.height/50),
                                            controller: kullaniciAdiController,
                                            keyboardType: TextInputType.visiblePassword,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: const EdgeInsets.only(left: 10, bottom: 10,top: 15),
                                                hintText: "E-Posta Adresi",
                                                hintStyle: GoogleFonts.poppins(
                                                    fontSize: MediaQuery.of(context).size.height/50,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height/18,
                                        width: MediaQuery.of(context).size.width/1.2,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff0A85C3),
                                            borderRadius: BorderRadius.circular(12)),
                                        child: Center(
                                          child: TextFormField(
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context).size.height/50),
                                            obscureText: !_passwordVisible,
                                            controller: sifreController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  size: MediaQuery.of(context).size.height/35,
                                                  _passwordVisible ? Icons.visibility :
                                                  Icons.visibility_off,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _passwordVisible = !_passwordVisible;
                                                  });
                                                },
                                              ),
                                              contentPadding: const EdgeInsets.only(left: 10, bottom: 10,top: 15),
                                              hintText: "Şifre",
                                              hintStyle:
                                              TextStyle(
                                                  fontSize: MediaQuery.of(context).size.height/50,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/1.2,
                                      child: Row(
                                        children: [
                                          Text(
                                            'Beni Hatırla',
                                            style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context).size.height / 50,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Checkbox(
                                            side: BorderSide(color: Colors.black,width: 2),
                                            value: _rememberMe ?? false,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _rememberMe = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                                      child: GestureDetector(
                                        onTap: () async {
                                          //  Navigator.of(context).pushReplacement(
                                          //    MaterialPageRoute(
                                          //      builder: (BuildContext context) => const DonemSec()));
                                          final prefs = await SharedPreferences.getInstance();
                                          prefs.setString('username', kullaniciAdiController.text);
                                          if (_rememberMe) {
                                            prefs.setString('password', sifreController.text);
                                          } else {
                                            prefs.remove('password'); // Şifreyi kaldırmak için önce silelim
                                          }
                                          if(kullaniciAdiController.text.isNotEmpty && sifreController.text.isNotEmpty){
                                            setState(() {
                                              _loading = true;
                                            });
                                            final LoginRequestDto2 login = LoginRequestDto2(
                                                UserName: kullaniciAdiController.text,
                                                UserPass: sifreController.text);
                                            Future<LoginResponseDto> user = _loginService.getLogin(login);
                                            print(user);
                                            String gelenID;
                                            user.then((value) async {
                                              setState(() {
                                                _loading = false;
                                              });
                                              if(value.Error == "Kullanıcı Adı ve ya Şifre hatalı !"){
                                                setState(() {
                                                  _loading = false;

                                                });
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
                                                              Text("Kullanıcı Adı ya da Şifre hatalı !",
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
                                              }else if(value.LisansList!.isNotEmpty){
                                                gelenID = value.ID.toString();
                                                Navigator.of(context).pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext context) =>
                                                            LisansSec(loginResponseDto: value)),
                                                        (Route<dynamic> route) => false);
                                              }else{
                                                Navigator.of(context).pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext context) =>
                                                            DonemSec(loginResponseDto: value)),
                                                        (Route<dynamic> route) => false);
                                              }
                                              _saveRememberMeStatus(_rememberMe);
                                            });
                                          }else{
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
                                                          Text("Lütfen kullanıcı bilgilerini doğru ve eksiksiz giriniz.",
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
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height/19,
                                          width: MediaQuery.of(context).size.width/1.2,
                                          decoration: BoxDecoration(
                                              color: Colors.black87,
                                              borderRadius: BorderRadius.circular(12)),
                                          child: Center(
                                            child: Text("Giriş Yap" ,
                                              style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/45,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                                    //   child: Container(
                                    //     child: Text("Şifremi Unuttum",style: GoogleFonts.poppins(color: Colors.white,fontSize: MediaQuery.of(context).size.height/60),),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
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
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Icon(FontAwesomeIcons.facebook,color: Colors.white,),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  height: MediaQuery.of(context).size.height/40,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset("assets/images/vatanlogo.png",color: Colors.white,))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
            ),
            if (_loading) ...[
              Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: Colors.black38),
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
      ),
    );
  }
}