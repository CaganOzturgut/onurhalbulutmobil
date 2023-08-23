import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimateContent extends StatefulWidget {


  _AnimateContentState createState() => new _AnimateContentState();

}

class _AnimateContentState extends State<AnimateContent> {
  double _animatedHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        GestureDetector(
          onTap: ()=>setState((){
            _animatedHeight!=0.0?_animatedHeight=0.0:_animatedHeight=50.0;}),
          child:  Container(
            height: MediaQuery.of(context).size.height/17,
            width: MediaQuery.of(context).size.width/1.5,
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("",style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height/45),
                textAlign: TextAlign.end,),
            ),
          ),),
        AnimatedContainer(duration: const Duration(milliseconds: 120),
          height: _animatedHeight,
          color: Colors.black12,
          width: MediaQuery.of(context).size.width/1.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("HKS",style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height/45),
              textAlign: TextAlign.end,),
          ),
        )
      ],
    );
  }
}