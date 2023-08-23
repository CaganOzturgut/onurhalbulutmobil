import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateCupertinoPicker extends StatefulWidget{
  const CreateCupertinoPicker({Key? key}) : super(key: key);

  @override
  State<CreateCupertinoPicker> createState() => _CreateCupertinoPickerState();
}

class _CreateCupertinoPickerState extends State<CreateCupertinoPicker>{

  final List = [
    '2020',
    '2021',
    '2022',
    '2023'
  ];

  int index = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
                colors: <Color>[Color(0xff110C5C), Color(0xff155CD6)]
            )
          ),
        ),
        centerTitle: true,
        title: const Text("Dönem Seçiniz"),
      ),
      body: SafeArea(
        child: Center(
          child: CupertinoButton.filled(
              child: Text("Seçilen Dönem : ${List[index]}"),
              onPressed: ()=> showCupertinoModalPopup(
                  context: context,
                  builder: (_) => SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height/3.25,
                          child: CupertinoPicker(
                            backgroundColor: Colors.white,
                            itemExtent: 30,
                            onSelectedItemChanged: (index){
                            setState(() => this.index = index);
                            final item = List[index];
                            print('Seçilen: $item');
                            },
                            scrollController: FixedExtentScrollController(
                              initialItem: 1
                            ),
                            children: List.map((item) =>
                                Center(child: Text(item,
                              style: TextStyle(fontSize: MediaQuery.of(context).size.height/45),),)).toList(),
                          ),
                        ),
                      ],
                    ),
                  ))),
        ),
      ),
    );
  }
}