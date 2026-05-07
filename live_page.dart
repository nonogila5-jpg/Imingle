import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class LivePage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  final RTCVideoRenderer _local = RTCVideoRenderer();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    initLive();
  }

  void initLive() async {
    await _local.initialize();

    final stream = await navigator.mediaDevices.getUserMedia({
      "video": true,
      "audio": true,
    });

    _local.srcObject = stream;

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Stream"),
        backgroundColor: Colors.red,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : RTCVideoView(_local),
    );
  }
}