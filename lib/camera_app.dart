import 'package:flutter/material.dart';

List<dynamic> camera=[];

class Camerapp extends StatefulWidget {
  const Camerapp({Key? key}) : super(key: key);

  @override
  State<Camerapp> createState() => _CamerappState();
}

class _CamerappState extends State<Camerapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){

          },
              child: Text('Camera')),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){

          },

              child: Text('Open Gallery'))
        ],
      ),
    );
  }
}