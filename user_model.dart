class UserModel {
  String uid;
  String email;
  int points;
  int level;
  String status;
  int lastSeen;

  UserModel({
    required this.uid,
    required this.email,
    required this.points,
    required this.level,
    required this.status,
    required this.lastSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "points": points,
      "level": level,
      "status": status,
      "lastSeen": lastSeen,
    };
  }

  factory UserModel.fromMap(String uid, Map data) {
    return UserModel(
      uid: uid,
      email: data["email"] ?? "",
      points: data["points"] ?? 0,
      level: data["level"] ?? 1,
      status: data["status"] ?? "offline",
      lastSeen: data["lastSeen"] ?? 0,
    );
  }
}