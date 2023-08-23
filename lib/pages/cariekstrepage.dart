import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onurhalbulutmobil/pages/cariekstrerapordetay.dart';

class CariEkstre extends StatefulWidget{

  final List musteriMizan;

  CariEkstre({required this.musteriMizan});

  @override
  State<StatefulWidget> createState() {
    return CariEkstreState(this.musteriMizan);
  }
}

class CariEkstreState extends State<CariEkstre>{

  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime(2023, 8, 10),
    DateTime(2023, 8, 13),
  ];

  final List musteriMizan;

  CariEkstreState(this.musteriMizan);

  @override
  void initState(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cari Ekstre", style: GoogleFonts.poppins(
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
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/55),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromRGBO(
                        92, 130, 194, 1.0)
                  ),
                  height: MediaQuery.of(context).size.height/21,
                  width: MediaQuery.of(context).size.width/1.05,
                  child: Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/35,top: MediaQuery.of(context).size.height/145 ),
                    child: Text(this.musteriMizan.first,style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height/45,color: Colors.white)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/45),
                child: Container(
                    height: MediaQuery.of(context).size.height/17,
                    width: MediaQuery.of(context).size.width,
                    child: _buildCalendarDialogButton()
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/21,
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromRGBO(
                          92, 130, 194, 1.0)
                    ),
                    child: Text(""),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/21,
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(
                            92, 130, 194, 1.0)
                    ),
                    child: Text(""),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/27),
                child:GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> CariEkstreRaporDetay()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height/17,
                    width: MediaQuery.of(context).size.width/1.05,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[Color.fromRGBO(15, 38, 72, 1.0), Color.fromRGBO(
                                92, 130, 194, 1.0)]
                        ),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Center(
                      child: Text("Rapor Al",style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/45,color: Colors.white),),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values) {
    values = values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }
    return valueText;
  }

  _buildCalendarDialogButton() {
    const dayTextStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final weekendTextStyle =
    TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: const Color.fromRGBO(15, 38, 72, 1.0),
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.5),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected == true
                            ? Colors.white
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            final values = await showCalendarDatePicker2Dialog(
              context: context,
              config: config,
              dialogSize: const Size(325, 400),
              borderRadius: BorderRadius.circular(15),
              value: _dialogCalendarPickerValue,
              dialogBackgroundColor: Color.fromRGBO(
                  175, 185, 231, 1.0),
            );
            if (values != null) {
              // ignore: avoid_print
              print(_getValueText(
                config.calendarType,
                values,
              ));
              setState(() {
                _dialogCalendarPickerValue = values;
              });
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height/21,
            width: MediaQuery.of(context).size.width/1.05,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Color.fromRGBO(15, 38, 72, 1.0), Color.fromRGBO(
                        92, 130, 194, 1.0)]
                ),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Center(
              child: Text("Tarih Seçiniz",style: GoogleFonts.poppins(fontSize: MediaQuery.of(context).size.height/45,color: Colors.white),),
            ),
          ),
        ),
      ],
    );
  }
}
