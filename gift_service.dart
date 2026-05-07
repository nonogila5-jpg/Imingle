import 'package:firebase_database/firebase_database.dart';
import '../models/gift_model.dart';

class GiftService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref("gifts");

  Future<void> sendGift(String senderId, String receiverId, String giftName) async {
    GiftModel gift = GiftModel(
      sender: senderId,
      receiver: receiverId,
      gift: giftName,
      time: DateTime.now().millisecondsSinceEpoch,
    );
    await _db.push().set(gift.toMap());
  }

  Future<void> addPoints(String userId, int points) async {
    final userRef = FirebaseDatabase.instance.ref("users/$userId/points");
    final snapshot = await userRef.get();
    int current = snapshot.exists ? snapshot.value as int : 0;
    await userRef.set(current + points);
  }
}