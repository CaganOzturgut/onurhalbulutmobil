import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onurhalbulutmobil/pages/cariekstrepage.dart';

class MusteriCariMizanRapor extends StatefulWidget{

  @override
  MusteriCariMizanRaporState createState() => MusteriCariMizanRaporState();
}

class MusteriCariMizanRaporState extends State<MusteriCariMizanRapor> {

  TextEditingController editingController = TextEditingController();

  final MusteriMizanList = List<String>.generate(5, (i) => "Musteri Mizan $i");

  var items = <String>[];

  @override
  void initState() {
    items.addAll(MusteriMizanList);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(MusteriMizanList);
    if(query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(MusteriMizanList);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Müşteri Cari Mizan",
            style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height/40)),
        centerTitle: true,
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
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(color: Color.fromRGBO(15, 38, 72, 1.0)),
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: const InputDecoration(
                    labelText: "Ara",
                    hintText: "Ara",
                    labelStyle: TextStyle(color: Color.fromRGBO(15, 38, 72, 1.0)),
                    hintStyle: TextStyle(color: Color.fromRGBO(15, 38, 72, 1.0)),
                    iconColor: Color.fromRGBO(15, 38, 72, 1.0),
                    prefixIcon: Icon(Icons.search,color: Color.fromRGBO(15, 38, 72, 1.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(15, 38, 72, 1.0),width: 1)
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(15, 38, 72, 1.0),width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/17,
              width: MediaQuery.of(context).size.width/1.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Cari Kodu",style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height/55)),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/6),
                    child: Text("Bakiye",style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height/55)),
                  ),
                  Text("Son Tahsilat",style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height/55))
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/2.4,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> CariEkstre(musteriMizan: items,)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height/17,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width/3,
                              child:  Center(child: Text("LoremIpsumDolerSitamet",style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height/55))),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width/5,
                                child: Center(child: Text("15000000",style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.of(context).size.height/55)))),
                            Container(
                                width: MediaQuery.of(context).size.width/5,
                                child: Center(child: Text("17.06.2023 ",style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height/55))))
                          ],
                        )
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/17,
              width: MediaQuery.of(context).size.width/1.05,
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
                color: const Color.fromRGBO(
                    92, 130, 194, 1.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/35),
                    child: Container(
                      child: Center(child: Text("Toplam :",style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.height/55)),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/4),
                    child: Container(
                      width: MediaQuery.of(context).size.width/5,
                      child: Center(child: Text("45000000",style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.height/55)),),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
