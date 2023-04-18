//Classe model per fer el Login
class Player {
  final int avatarId;
  final String userName;
  final String password;

  Player({
    required this.avatarId,
    required this.userName,
    required this.password,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      avatarId: json['avatarId'],
      userName: json['userName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      'avatarId': avatarId,
    };
  }
}
