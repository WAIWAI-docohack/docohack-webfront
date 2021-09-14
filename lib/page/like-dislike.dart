import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:ring_sns/api/chatAPI.dart';
import 'package:ring_sns/api/auth.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:ring_sns/api/chatAPI.dart';
import 'package:ring_sns/page/continue.dart';

class LikeDislike extends StatefulWidget{
  LikeDislike(this.roomId, this.auth, this.target_userid);
  String roomId;
  Auth auth;
  String target_userid;
  @override
  State<StatefulWidget> createState() => _LikeDislike();
}

class _LikeDislike extends State<LikeDislike>{


  final TextStyle style1 = TextStyle(
      fontSize: 35.0,
      color: Colors.black
  );
  final TextStyle style2 = TextStyle(
      fontSize: 20.0,
      color: Colors.black
  );

  ChatAPI chatapi;

  void initState(){
    ChatAPI chatapi = new ChatAPI(widget.auth.getBearer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会話終了です'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child:CircleAvatar(
                backgroundImage: NetworkImage(
                    widget.auth.getUserIdBackgroundURL(widget.target_userid)),
                radius: 100,
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: Text('通話が終了しました．', style: style1,),
            ),

            Align(
              alignment: Alignment.center,
              child: Text('${widget.target_userid}さんとの会話はいかがでしたか？', style: style2,),
            ),

            Padding(
              padding: EdgeInsets.all(30),
              child:ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 250, height: 70),
                child:ElevatedButton(
                    child: Text('♡いいねする！',
                        style:TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                        )
                    ),
                    style: ElevatedButton.styleFrom(

                      primary: Colors.white,
                      onPrimary: Colors.red,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: (){
                      chatapi = new ChatAPI(widget.auth.getBearer());
                      if(chatapi.postLike(widget.target_userid,true) == 'ok'){
                        print('like');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Continue(widget.auth)),
                        );
                      };

                    }
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(30),
              child:ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 250, height: 70),
                child:ElevatedButton(
                    child: Text('閉じる',
                    style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    )),

                    style: ElevatedButton.styleFrom(

                      primary: Colors.white,
                      onPrimary: Colors.blue,

                      shape: const StadiumBorder(),
                    ),
                    onPressed: (){
                      print('dislike');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Continue(widget.auth)),
                      );
                    }
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}

