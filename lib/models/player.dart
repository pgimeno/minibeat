//Classe model per fer el Login
class Player {
  final int? id;
  final int avatarId;
  final String userName;
  final String password;

  Player({
    this.id,
    required this.avatarId,
    required this.userName,
    required this.password,
  });

  Player.empty()
      : id = 0,
        avatarId = 0,
        userName = '',
        password = '';

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      avatarId: json['avatarId'],
      userName: json['userName'],
      password: json['password'],
      id: json['Id'],
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
