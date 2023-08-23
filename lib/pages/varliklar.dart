import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Varliklar extends StatefulWidget {
  @override
  VarliklarState createState() => VarliklarState();
}
class VarliklarState extends State<Varliklar> {

  late int _sayfaIndex = 0;

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
        color: const Color.fromRGBO(
            175, 185, 231, 1.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/5),
            child: Container(
              child: Image.asset("assets/images/arkaplan.png",color: Colors.white30,),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: DataTable2(
                  columnSpacing: 8,
                  horizontalMargin: 12,
                  minWidth: 600,
                  dividerThickness: 3,
                  columns:  [
                    DataColumn2(
                      fixedWidth: MediaQuery.of(context).size.width/3.7,
                      label: Text('Açıklama',style: GoogleFonts.poppins(
                          color: Color.fromRGBO(23, 60, 108, 1.0),
                          fontSize: MediaQuery.of(context).size.height/55,
                          fontWeight: FontWeight.w500),),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      fixedWidth: MediaQuery.of(context).size.width/4,
                      label: Text('Borç',style: GoogleFonts.poppins(
                          color: Color.fromRGBO(23, 60, 108, 1.0),
                          fontSize: MediaQuery.of(context).size.height/55,
                          fontWeight: FontWeight.w500),),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      size: ColumnSize.S,
                      fixedWidth: MediaQuery.of(context).size.width/4,
                      label: Text('Alacak',style: GoogleFonts.poppins(
                          color: Color.fromRGBO(23, 60, 108, 1.0),
                          fontSize: MediaQuery.of(context).size.height/55,
                          fontWeight: FontWeight.w500),),
                    ),
                    DataColumn2(
                      size: ColumnSize.S,
                      fixedWidth: MediaQuery.of(context).size.width/4,
                      label: Text('Bakiye',style: GoogleFonts.poppins(
                          color: Color.fromRGBO(23, 60, 108, 1.0),
                          fontSize: MediaQuery.of(context).size.height/55,
                          fontWeight: FontWeight.w500),),
                    ),
                  ],
                  rows: List<DataRow>.generate(2, (index) => const DataRow(
                      cells: [
                        DataCell(Text('Üretici Bakiyesi')),
                        DataCell(Text('48.427')),
                        DataCell(Text('59.549')),
                        DataCell(Text('-11.064')),
                      ]))),
            ),
          ),
        ],
      ),
    );

  }


}