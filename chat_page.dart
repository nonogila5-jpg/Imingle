import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/chat_service.dart';
import '../services/user_service.dart';
import '../models/message_model.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chat = ChatService();
  final UserService _userService = UserService();
  final TextEditingController messageController = TextEditingController();

  String myId = FirebaseAuth.instance.currentUser!.uid;
  String otherId = "receiver123"; // ثابت مؤقتاً

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("IMingle Chat"),
            StreamBuilder(
              stream: _userService.getUserStatus(otherId),
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.data!.snapshot.value == null) {
                  return Text("🔴 Offline",
                      style: TextStyle(fontSize: 14));
                }

                Map data = snapshot.data!.snapshot.value;
                String status = data["status"];

                return Text(
                  status == "online" ? "🟢 Online" : "🔴 Offline",
                  style: TextStyle(fontSize: 14),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _chat.getMessages(),
              builder: (context, snapshot) {
                if (!