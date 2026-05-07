import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserService _userService = UserService();

  String uid = FirebaseAuth.instance.currentUser!.uid;
  UserModel? user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    user = await _userService.getUser(uid);
    setState(() => loading = false);
  }

  Widget buildButton(String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            SizedBox(height: 10),
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMingle Home"),
        backgroundColor: Colors.blue,
      ),

      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text("المستوى: ${user!.level}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("النقاط: ${user!.points}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(
                          user!.status == "online"
                              ? "🟢 Online"
                              : "🔴 Offline",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        buildButton("Chat", Icons.chat, "/chat"),
                        buildButton("Gifts", Icons.card_giftcard, "/gifts"),
                        buildButton("Profile", Icons.person, "/profile"),
                        buildButton("Live", Icons.live_tv, "/live"),
                        buildButton("VIP", Icons.star, "/vip"),
                        buildButton("Video", Icons.videocam, "/video"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}