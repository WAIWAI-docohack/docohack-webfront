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
  int limit = 100;
  int minute = 0;
  int sec = 0;
  String infomsg = "残り時間";
  //bool match_res=false;

  void initState() {
    nextpage();
  }

  void nextpage() async {
    while (limit > 0) {
      await Future.delayed(Duration(milliseconds: 1000));
      setState(() {
        limit -= 1;
        // count();

      });
    }

    print("talk end");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LikeDislike(widget.room_id, widget.auth, widget.target_userid)),
    );
  }

  // void count() {
  //   minute = sec % 60;
  //   sec = limit - sec * 60;
  // }



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
              infomsg + limit.toString(),
              style:TextStyle(fontSize: 20),),

          ],
        ),
      ),
    );
  }
}
