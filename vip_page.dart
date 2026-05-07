import 'package:flutter/material.dart';
import '../services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VipPage extends StatefulWidget {
  @override
  _VipPageState createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> {
  final UserService _userService = UserService();
  String uid = FirebaseAuth.instance.currentUser!.uid;

  List<Map> vipList = [
    {"name": "VIP 1", "color": Colors.yellow, "points": 50},
    {"name": "VIP 2", "color": Colors.orange, "points": 120},
    {"name": "VIP 3", "color": Colors.red, "points": 250},
  ];

  void buyVIP(Map vip) async {
    int newLevel = vip["points"] ~/ 10;
    await _userService.updateLevel(uid, newLevel);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم شراء ${vip["name"]}! المستوى الجديد: $newLevel")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VIP Membership"),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: vipList.length,
        itemBuilder: (context, index) {
          var vip = vipList[index];

          return Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: vip["color"],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  vip["name"],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text("Bonus Points: ${vip["points"]}"),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => buyVIP(vip),
                  child: Text("شراء"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}