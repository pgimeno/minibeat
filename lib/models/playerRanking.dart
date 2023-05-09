//Classe model per fer el ranking i omplir el menú
class PlayerRanking {
  //final int avatarId;

  String userName;
  int totalPoints;
  int position;
  int avatarId;

  PlayerRanking.empty()
      : position = 0,
        userName = '',
        totalPoints = 0,
        avatarId = 0;

  PlayerRanking({
    required this.position,
    required this.userName,
    required this.totalPoints,
    required this.avatarId,
  });


  factory PlayerRanking.fromJson(Map<String, dynamic> json) {
    return PlayerRanking(
      position: json['position'],
      userName: json['userName'],
      totalPoints: json['totalPoints'],
      avatarId: json['avatarId']
    );
  }
}
