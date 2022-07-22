
import 'package:chatti/Front.dart';
import 'package:chatti/calls.dart';
import 'package:chatti/camera_app.dart';
import 'package:chatti/status.dart';
import 'package:flutter/material.dart';
class chatti extends StatefulWidget {
  const chatti({Key? key}) : super(key: key);

  @override
  State<chatti> createState() => _chattiState();
}

class _chattiState extends State<chatti> {

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: Scaffold(
          appBar: AppBar(
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.search_rounded),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.more_vert_outlined),
              )
            ],
            toolbarHeight: 68,
            backgroundColor: Colors.black54,
            title: const Text(
              "whatsapp",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            bottom:   TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.green,
                isScrollable: true,
                tabs: [
                   SizedBox(
                     width: w/15,
                       child: Tab(icon: Icon(Icons.camera_alt))),
                  SizedBox(
                    width: w/5,
                      child: Tab(text: "CHATS")),
                  Container(
                      width: w/5,
                      child: Tab(text: "STATUS")),
                  Container(
                      width: w/5,child: Tab(text: "CALLS")),
                ]),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child:   const TabBarView(
                children: [
              Camerapp(),
              NameList(),
              Status(),
              Calls(),
            ]),
          ),
        ),
      ),
    );
  }
}
