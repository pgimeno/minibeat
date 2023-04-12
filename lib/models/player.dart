
class Player {
  final String avatarImage;
  final String userName;
  final String points;

  Player({
    required this.avatarImage,
    required this.userName,
    required this.points,
  });

}

List<Player> createPlayersTest() {
  String avatarImage = 'images/avatarSample.jpg';
  List<Player> players = [];

  for (int i = 0; i < 10; i++) {
    String userName = 'User ${i+1}';
    String points = '${(i+1)*171}';
    Player player = Player(
      avatarImage: avatarImage,
      userName: userName,
      points: points,
    );
    players.add(player);
  }

  return players;
}
