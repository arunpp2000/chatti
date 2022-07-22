import 'package:badges/badges.dart';
import 'package:chatti/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  const Status({Key? key}) : super(key: key);

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Badge(
              position: BadgePosition.bottomEnd(),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(userdata.photoURL),
              ),
            ),
            Column(
              children: [
                Text('My status'),
                Text('Tap to add status update'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
