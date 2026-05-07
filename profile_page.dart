import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/user_service.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService _userService = UserService();
  final AuthService _auth = AuthService();

  String uid = FirebaseAuth.instance.currentUser!.uid;
  String email = FirebaseAuth.instance.currentUser!.email ?? "";

  UserModel? user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    user = await _userService.getUser(uid);

    if (user == null) {
      await _userService.saveUser(uid, email);
      user = await _userService.getUser(uid);
    }

    setState(() => loading = false);
  }

  void logout() async {
    await _auth.logout();
    await _userService.setStatus(uid, "offline");
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الملف الشخصي"),
        backgroundColor: Colors.deepPurple,
      ),

      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      email[0].toUpperCase(),
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(email,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                  SizedBox(height: 20),

                  infoBox("النقاط", user!.points.toString()),
                  SizedBox(height: 15),
                  infoBox("المستوى", user!.level.toString()),
                  SizedBox(height: 15),
                  infoBox(
                      "الحالة",
                      user!.status == "online"
                          ? "🟢 Online"
                          : "🔴 Offline"),

                  Spacer(),

                  ElevatedButton(
                    onPressed: logout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: Text("تسجيل الخروج",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ],
              ),
            ),
    );
  }

  Widget infoBox(String title, String value) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.deepPurple[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18)),
          Text(value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}