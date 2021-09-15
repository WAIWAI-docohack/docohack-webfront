import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:ring_sns/api/auth.dart';
import 'package:flutter/material.dart';
import 'package:ring_sns/page/chat.dart';
import 'package:ring_sns/page/home.dart';
import 'package:flutter/rendering.dart';
import 'package:ring_sns/page/like-dislike.dart';

import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "aa46abd9d4f04d06a57b2804ec0135c9";
const token = "006aa46abd9d4f04d06a57b2804ec0135c9IABuEWUcFXiUJ4i3aLjoEOJsZZWNkYuJ5UvdeaX+DzZSewx+f9gAAAAAIgD+bihbzk5CYQQAAQCzTkJhAgCzTkJhAwCzTkJhBACzTkJh";


class Talk extends StatefulWidget {
  Talk(this.auth, this.room_id, this.target_userid);
  Auth auth;
  String room_id;
  String target_userid;

  @override
  State<StatefulWidget> createState() => _Talk();
}

class _Talk extends State<Talk> {
  int limit = 10;
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
              radius: 10,
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


class Talk_ver2 extends StatefulWidget {
  Talk_ver2(this.auth, this.room_id, this.target_userid);
  Auth auth;
  String room_id;
  String target_userid;

  @override
  _Talk_ver2 createState() => _Talk_ver2();
}

class _Talk_ver2 extends State<Talk_ver2> {
  int _remoteUid = 0;
  bool _localUserJoined = false;
  RtcEngine _engine;

  int limit = 10;
  int minute = 0;
  int sec = 0;
  String infomsg = "残り時間";

  @override
  void initState() {
    super.initState();
    initAgora();
    nextpage();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.joinChannel(token, "test", null, 0);
    // nextpage();
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
    _engine.leaveChannel();
    _engine.stopPreview();
    _engine.destroy();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LikeDislike(widget.room_id, widget.auth, widget.target_userid)),
    );
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(infomsg + limit.toString(),),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? RtcLocalView.SurfaceView()
                    : CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null && _remoteUid != 0) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}