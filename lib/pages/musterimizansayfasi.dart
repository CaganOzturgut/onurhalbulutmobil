import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onurhalbulutmobil/pages/cariekstrepage.dart';

class MusteriMizanSayfasi extends StatefulWidget{

  @override
  MusteriMizanSayfasiState createState() => MusteriMizanSayfasiState();
}

class MusteriMizanSayfasiState extends State<MusteriMizanSayfasi> {


  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios,color: Colors.white),
        ),
        title: Text("Müşteri Mizan",
          style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/45,color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(
                  175, 185, 231, 1.0),

            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                        color: Colors.transparent,
                      border: Border.all(color: Color.fromRGBO(15, 38, 72, 1.0))
                    ),
                      height: MediaQuery.of(context).size.height/17,
                      width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.search),
                        Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          child: Center(
                            child: TextFormField(
                              cursorColor: Colors.white,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height/45),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Arama",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: MediaQuery.of(context).size.height/45),
                                  contentPadding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height/90),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height/17,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(
                          92, 130, 194, 1.0),
                      border: Border.all(color: const Color.fromRGBO(15, 38, 72, 1.0))
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            dragDismissible: false,
                            motion: StretchMotion(),
                            dismissible: DismissiblePane(onDismissed: (){},),
                            children: const [
                              SlidableAction(
                                onPressed: doNothing,
                                backgroundColor: Colors.black38,
                                foregroundColor: Colors.white,
                                icon: Icons.design_services,
                                label: 'Cari Ekstre',
                              ),
                            ],
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height/17,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 5), // changes position of shadow
                                ),
                              ],
                              color: Color.fromRGBO(92, 130, 194, 1.0),
                            ),
                            child: Center(
                              child: ListTile(
                                title: Text('aa',style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

doNothing(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> CariEkstre(musteriMizan: [],)));
}
