import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  CameraController? controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async {
    try {
      final cameras = await availableCameras();
      controller = CameraController(
        cameras[0],
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller!.initialize();
      setState(() => loading = false);
    } catch (e) {
      print("Camera Error: $e");
      setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Camera"),
        backgroundColor: Colors.black,
      ),

      body: loading
          ? Center(child: CircularProgressIndicator())
          : controller == null || !controller!.value.isInitialized
              ? Center(child: Text("تعذر تشغيل الكاميرا"))
              : CameraPreview(controller!),
    );
  }
}