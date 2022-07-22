
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Chat.dart';
import 'main.dart';

class NameList extends StatefulWidget {
  const NameList({Key? key}) : super(key: key);

  @override
  State<NameList> createState() => _NameListState();
}

class _NameListState extends State<NameList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blueGrey[900],
      // appBar: AppBar(
      //   title: const Text(
      //     'CHATS',
      //     style: TextStyle(fontWeight: FontWeight.w600),
      //   ),
      //   backgroundColor: Colors.teal,
      // ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('user').where('userid', isNotEqualTo: uId).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return const CircularProgressIndicator();
              
            }
            var data=snapshot.data!.docs;
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return  ChatScreen(
                          index:index.toString(),
                          username:data[index]['username'],
                          userimage:data[index]['userimage'],
                          rid:data[index]['userid'],
                        );
                      }));
                    },
                    child: Card(
                      color: Colors.blueGrey[900],
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(data[index]['userimage']),
                                radius: 25,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.69,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text(data[index]['username'],
                                      style: const TextStyle(fontSize: 18,color: Colors.white),
                                    ),
                                     Text('Last Message',
                                         style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Text(
                                        'Time',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    StreamBuilder<QuerySnapshot>(
                                      stream: null,
                                      builder: (context, snapshot) {
                                        var s=snapshot.data!.docs;

                                        return Padding(
                                          padding: const EdgeInsets.only( top: 3,left: 25),
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(child:
                                            Text("")
                                            ),
                                          ),
                                        );
                                      }
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
// data[index]['chat'].updateData({
// "messageCount":FieldValue.increment(1),
// "${data[index]['user']}messageCount":FieldValue.increment(1),
// })