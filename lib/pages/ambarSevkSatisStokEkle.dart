import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onurhalbulutmobil/pages/stokKunyesiAl.dart';
import 'package:select_searchable_list/select_searchable_list.dart';

class AmbarSevkSatisStokEkle extends StatefulWidget{

  @override
  AmbarSevkSatisStokEkleState createState() => AmbarSevkSatisStokEkleState();
}

class AmbarSevkSatisStokEkleState extends State<AmbarSevkSatisStokEkle>{

  final TextEditingController _urunTextEditingController = TextEditingController();
  final TextEditingController _stokadetcontroller = TextEditingController();
  final TextEditingController _stokkilocontroller = TextEditingController();
  final TextEditingController _stokbagcontroller = TextEditingController();
  final TextEditingController _stokkasacontroller = TextEditingController();
  final TextEditingController _stokfiyatcontroller = TextEditingController();

  late String girilenAciklama = "";
  late String girilenKilo = "";
  late String girilenKasa = "";
  late String girilenFiyat = "";
  late String girilenAdet = "";


  final List<int> _selectedCategoryValue = [0];
  late bool _loading = false;

  late List<dynamic> stokKartList = [];
  late Map<int,String> urunListesi = {};


  @override
  void initState(){


    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    _urunTextEditingController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: (){
              // TODO : Geri Butonuna bastıktan sonra olacak işlemler
              Navigator.pop(context);
              setState(() {
                _stokfiyatcontroller.clear();
                _stokkasacontroller.clear();
                _stokkilocontroller.clear();
                _stokbagcontroller.clear();
                _stokadetcontroller.clear();
                _urunTextEditingController.clear();
              });
            },
            child: Icon(Icons.arrow_back_ios_new)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xff10AEE4),Color(0xff10AEE4)]
              )
          ),
        ),
        title: Text("Satış Ürün Ekle", style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: MediaQuery.of(context).size.height/40)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
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
                  decoration: const InputDecoration(isDense: true, border: InputBorder.none),
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height/45),
                  textEditingController: _urunTextEditingController,
                  title: '',
                  hint: '',
                  options: urunListesi,
                  isSearchVisible: true,
                  selectedOptions: _selectedCategoryValue,
                  onChanged: (selectedIds) {

                  },
                ),
              ),
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
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xff10AEE4),
                  ),
                  child: TextFormField(
                      controller: _stokadetcontroller,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      onChanged: (value){
                        setState(() {
                          girilenAdet = value;
                        });
                      },
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height/45),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "Kasa/Adet Giriniz",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45),
                          border: InputBorder.none))
              ),
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
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xff10AEE4),
                  ),
                  child: TextFormField(
                      controller: _stokkilocontroller,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      onChanged: (value){
                        setState(() {
                          girilenKilo = value;
                        });
                      },
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height/45),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "Bağ/Kilo Giriniz",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45),
                          border: InputBorder.none))
              ),
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
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height/45),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "Fiyat Giriniz",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height/45),
                          border: InputBorder.none))
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/12,bottom: MediaQuery.of(context).size.height/21 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return Dialog(
                                child: Container(
                                  height: MediaQuery.of(context).size.height/3,
                                  color: Color.fromRGBO(
                                      92, 130, 194, 1.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/21),
                                          child: Container(
                                            child: Text("Girdiğiniz bilgileri temizlemek istediğinize emin misiniz ?",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/45,color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap:(){
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context).size.height/21,
                                                width: MediaQuery.of(context).size.width/3,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Color.fromRGBO(15, 38, 72, 1.0),
                                                ),
                                                child: Center(child: Text("Hayır",
                                                  style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,color: Colors.white),)),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap:(){
                                                setState(() {
                                                  Navigator.pop(context);
                                                  _stokfiyatcontroller.clear();
                                                  _stokkasacontroller.clear();
                                                  _stokkilocontroller.clear();
                                                  _stokbagcontroller.clear();
                                                  _stokadetcontroller.clear();
                                                  _urunTextEditingController.clear();
                                                });
                                              },
                                              child: Container(
                                                  height: MediaQuery.of(context).size.height/21,
                                                  width: MediaQuery.of(context).size.width/3,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Color.fromRGBO(15, 38, 72, 1.0),
                                                  ),
                                                  child: Center(child: Text("Evet",
                                                    style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,color: Colors.white),))
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
                          border: Border.all(
                              color: Colors.black,
                              width: 0.5),
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff10AEE4),
                        ),
                        child: Center(
                          child: Text("Temizle", style: GoogleFonts.poppins(color: Colors.white,fontSize: MediaQuery.of(context).size.height/45,fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return Dialog(
                                child: Container(
                                  height: MediaQuery.of(context).size.height/3,
                                  color: Color.fromRGBO(
                                      92, 130, 194, 1.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/21),
                                          child: Container(
                                            child: Text("Vazgeçmek istediğinize emin misiniz? Girdiğiniz bilgiler kaybolacaktır.",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/45,color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap:(){
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context).size.height/21,
                                                width: MediaQuery.of(context).size.width/3,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Color.fromRGBO(15, 38, 72, 1.0),
                                                ),
                                                child: Center(child: Text("Vazgeç",
                                                  style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,color: Colors.white),)),
                                              ),
                                            ),
                                            Container(
                                                height: MediaQuery.of(context).size.height/21,
                                                width: MediaQuery.of(context).size.width/3,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Color.fromRGBO(15, 38, 72, 1.0),
                                                ),
                                                child: Center(child: Text("Tamam",
                                                  style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/55,color: Colors.white),))
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
                          border: Border.all(
                              color: Colors.black,
                              width: 0.5),
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff10AEE4),
                        ),
                        child: Center(
                          child: Text("Vazgeç", style: GoogleFonts.poppins(color: Colors.white,fontSize: MediaQuery.of(context).size.height/45,fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        // TODO: KAYDET İŞLEMİNDEN SONRA OLACAK
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StokKunyesiAl()));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height/17,
                        width: MediaQuery.of(context).size.width/3.5,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              width: 0.5),
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff10AEE4),
                        ),
                        child: Center(
                          child: Text("Kaydet",
                            style: GoogleFonts.poppins(color: Colors.white,fontSize: MediaQuery.of(context).size.height/45,fontWeight: FontWeight.w500),),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
