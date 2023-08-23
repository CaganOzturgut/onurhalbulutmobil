import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TarihSeciciWidget extends StatefulWidget {
  @override
  _TarihSeciciWidgetState createState() => _TarihSeciciWidgetState();
}

class _TarihSeciciWidgetState extends State<TarihSeciciWidget> {
  DateTime? _secilenTarih; // Değişkeni null olarak başlatıyoruz

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _tarihSeciciGoster(context);
      },
      child: Container(
        height: MediaQuery.of(context).size.height/17,
        width: MediaQuery.of(context).size.width/1.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xff10AEE4),
            border: Border.all(color: Colors.black,width: 0.5)
        ),
        child: _secilenTarih != null ? Center(
          child: Text(
            "${_secilenTarih!.day}-${_secilenTarih!.month}-${_secilenTarih!.year}",
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height/45,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ) : Center(
          child: Text(
            'Tarih Seçiniz',
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height/45,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _tarihSeciciGoster(BuildContext context) async {
    DateTime? yeniTarih = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: _secilenTarih ?? DateTime.now(),
      locale: const Locale('tr', 'TR'), // Türkçe dil için
    );
    if (yeniTarih != null) {
      setState(() {
        _secilenTarih = yeniTarih;
        print(_secilenTarih);
      });
    }
  }
}