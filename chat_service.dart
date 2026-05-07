import 'package:firebase_database/firebase_database.dart';
import '../models/message_model.dart';

class ChatService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref("messages");

  Future<void> sendMessage(String senderId, String text) async {
    MessageModel msg = MessageModel(
      sender: senderId,
      text: text,
      time: DateTime.now().millisecondsSinceEpoch,
    );
    await _db.push().set(msg.toMap());
  }

  Stream<DatabaseEvent> getMessages() {
    return _db.orderByChild("time").onValue;
  }
}