import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final String userimage;
  final String index;
  final String rid;
  const ChatScreen({
    Key? key,
    required this.username,
    required this.userimage,
    required this.index,
    required this.rid,
  }) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textData = TextEditingController();

  var loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        leadingWidth: 90, //MediaQuery.of(context).size.width,
        leading: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff101010),
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.userimage),
          ),
        ]),
        title: Text(widget.username),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:
                    // Container()
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('chat')
                            .orderBy('sendTime', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          var data = snapshot.data!.docs;
                          return ListView.builder(
                              reverse: true,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                Timestamp t = data[index]['sendTime'];
                                DateTime d = t.toDate();
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }
                                if ((data[index]['receiverId'] == uId ||
                                        data[index]['senderId'] == uId) &&
                                    (data[index]['receiverId'] == widget.rid ||
                                        data[index]['senderId'] ==
                                            widget.rid)) {
                                  return Align(
                                    alignment: (data[index]['senderId'] == uId
                                        ? Alignment.topRight
                                        : Alignment.topLeft),
                                    child: (ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              45,
                                          minWidth: 110),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: (data[index]["senderId"] == uId
                                            ? Colors.blue[200]
                                            : Colors.grey.shade200),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 30,
                                                top: 5,
                                                bottom: 20,
                                              ),
                                              child: Text(
                                                data[index]["message"],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 4,
                                              right: 10,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    DateFormat('h:mm a')
                                                        .format(d)
                                                        .toLowerCase(),
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    data[index]["senderId"] ==
                                                            uId
                                                        ? Icons.done_all
                                                        : null,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                  );
                                }
                                return const SizedBox();
                              });
                        }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.793,
                    child: TextFormField(
                      autofocus: false,
                      controller: textData,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                width: 0, color: Colors.white)),
                        prefixIcon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Message',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ), // color: Colors.teal,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: FloatingActionButton(
                      backgroundColor: Colors.teal,
                      onPressed: () {
                        if (textData.text.isNotEmpty) {
                          FirebaseFirestore.instance.collection('chat').add({
                            'message': textData.text,
                            'isRead': false,
                            'receiverId': widget.rid,
                            'sendTime': DateTime.now(),
                            'senderId': uId,
                          }).then((value) {
                            value.update({'msgId': value.id});
                          });
                          textData.clear();
                          setState(() {});
                        } else {
                          setState(() {});
                        }
                      },
                      // child: const Icon(Icons.send),
                      child: Icon(textData.text.isNotEmpty
                          ? Icons.send
                          : Icons.keyboard_voice),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
