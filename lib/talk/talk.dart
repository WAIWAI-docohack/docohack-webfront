import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:ring_sns/api/auth.dart';
import 'package:flutter/material.dart';
import 'package:ring_sns/page/chat.dart';
import 'package:ring_sns/page/home.dart';
import 'package:flutter/rendering.dart';
import 'package:ring_sns/page/like-dislike.dart';

class Talk extends StatefulWidget {
  Talk(this.auth, this.room_id, this.target_userid);
  Auth auth;
  String room_id;
  String target_userid;

  @override
  State<StatefulWidget> createState() => _Talk();
}

class _Talk extends State<Talk> {
  int sec = 10;
  String infomsg = "残り時間";
  //bool match_res=false;

  void initState() {
    nextpage();
  }

  void nextpage() async {
    while (sec > 0) {
      await Future.delayed(Duration(milliseconds: 1000));
      setState(() {
        sec -= 1;
      });
    }

    print("talk end");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LikeDislike(widget.room_id, widget.auth, widget.target_userid)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                  widget.auth.getUserIdBackgroundURL(widget.target_userid)),
              radius: 100,
            ),
            Text(
              '${widget.target_userid}さんとトーク中です',
              style: Theme.of(context).textTheme.headline6,

            ),

            Text(
              infomsg + sec.toString(),
              style:TextStyle(fontSize: 20),),

          ],
        ),
      ),
    );
  }
}
