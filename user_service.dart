import 'package:firebase_database/firebase_database.dart';
import '../models/user_model.dart';

class UserService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref("users");

  Future<void> saveUser(String uid, String email) async {
    UserModel user = UserModel(
      uid: uid,
      email: email,
      points: 0,
      level: 1,
      status: "online",
      lastSeen: DateTime.now().millisecondsSinceEpoch,
    );
    await _db.child(uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final snapshot = await _db.child(uid).get();
    if (!snapshot.exists) return null;
    return UserModel.fromMap(uid, snapshot.value as Map);
  }

  Future<void> updateLevel(String uid, int level) async {
    await _db.child(uid).update({"level": level});
  }

  Future<void> updatePoints(String uid, int points) async {
    await _db.child(uid).update({"points": points});
  }

  Future<void> setStatus(String uid, String status) async {
    await _db.child(uid).update({
      "status": status,
      "lastSeen": DateTime.now().millisecondsSinceEpoch,
    });
  }

  Stream<DatabaseEvent> getUserStatus(String uid) {
    return _db.child(uid).onValue;
  }
}