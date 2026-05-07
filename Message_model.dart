class MessageModel {
  String sender;
  String text;
  int time;

  MessageModel({
    required this.sender,
    required this.text,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      "sender": sender,
      "text": text,
      "time": time,
    };
  }

  factory MessageModel.fromMap(Map data) {
    return MessageModel(
      sender: data["sender"],
      text: data["text"],
      time: data["time"],
    );
  }
}