import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/gift_service.dart';

class GiftsPage extends StatefulWidget {
  @override
  _GiftsPageState createState() => _GiftsPageState();
}

class _GiftsPageState extends State<GiftsPage> {
  final GiftService _gift = GiftService();
  String myId = FirebaseAuth.instance.currentUser!.uid;

  List<Map> gifts = [
    {"name": "Rose", "icon": "🌹", "points": 5},
    {"name": "Heart", "icon": "❤️", "points": 10},
    {"name": "Star", "icon": "⭐", "points": 15},
    {"name": "Diamond", "icon": "💎", "points": 30},
  ];

  void sendGift(Map gift) async {
    await _gift.sendGift(myId, "receiver123", gift["name"]);
    await _gift.addPoints(myId, gift["points"]);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("أرسلت ${gift["name"]} +${gift["points"]} نقطة")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMingle Gifts"),
        backgroundColor: Colors.pink,
      ),

      body: GridView.builder(
        padding: EdgeInsets.all(20),
        itemCount: gifts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          var gift = gifts[index];

          return GestureDetector(
            onTap: () => sendGift(gift),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(gift["icon"], style: TextStyle(fontSize: 50)),
                  SizedBox(height: 10),
                  Text(
                    gift["name"],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("+${gift["points"]} نقاط"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}