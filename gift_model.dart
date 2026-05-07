class GiftModel {
  String sender;
  String receiver;
  String gift;
  int time;

  GiftModel({
    required this.sender,
    required this.receiver,
    required this.gift,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      "sender": sender,
      "receiver": receiver,
      "gift": gift,
      "time": time,
    };
  }

  factory GiftModel.fromMap(Map data) {
    return GiftModel(
      sender: data["sender"],
      receiver: data["receiver"],
      gift: data["gift"],
      time: data["time"],
    );
  }
}