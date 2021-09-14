import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:ring_sns/api/chatAPI.dart';
import 'package:ring_sns/api/auth.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:ring_sns/api/chatAPI.dart';
import 'package:ring_sns/page/home.dart';




class Continue extends StatefulWidget{
  Continue(this.auth);
  Auth auth;
  @override
  State<StatefulWidget> createState() => _Continue();
}

class _Continue extends State<Continue>{


  final TextStyle style1 = TextStyle(
      fontSize: 20.0,
      color: Colors.black
  );
  final TextStyle style2 = TextStyle(
      fontSize: 15.0,
      color: Colors.black
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('続けますか？終了しますか？'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //続ける
            Padding(
              padding: EdgeInsets.all(30),
              child:ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 250, height: 70),
                child:ElevatedButton(
                    child: Text('続ける'),
                    style: ElevatedButton.styleFrom(

                      primary: Colors.white,
                      onPrimary: Colors.green,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: (){
                      print('continue');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home(widget.auth)),
                      );
                    }
                ),
              ),
            ),

            //終了する
            Padding(
              padding: EdgeInsets.all(30),
              child:ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 250, height: 70),
                child:ElevatedButton(
                    child: Text('通話を終了する'),
                    style: ElevatedButton.styleFrom(

                      primary: Colors.white,
                      onPrimary: Colors.green,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: (){
                      print('end');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Continue(widget.auth)),
                      // );
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
