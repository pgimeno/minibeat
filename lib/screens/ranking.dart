import 'package:flutter/material.dart';
import 'package:minibeat/models/player.dart';
import 'package:minibeat/utils/constants.dart';

class RankingScreen extends StatefulWidget {
  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  List<Player> players = createPlayersTest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kMiniBeatGradientFirst,
              kMiniBeatGradientLast,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 15),
              Text(
                'Ranking',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding:
                          EdgeInsets.only(left: 25, top: 10.0, bottom: 10),
                      leading: Image.asset(players[index].avatarImage),
                      title: Text(
                        '#$index',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              players[index].userName,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Icon(Icons.star, color: kMiniBeatMainColor),
                          ),
                          SizedBox(width: 4),
                          Text(players[index].points),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 5),
              Divider(
                color: Colors.white,
                thickness: 3,
                indent: 23,
                endIndent: 23,
              ),
              Column(
                children: [
                  Text(
                    'La teva posició',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  UserTile(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserTile extends StatefulWidget {
  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 25, top: 10.0, bottom: 10),
      leading: Image.asset('images/avatarSample.jpg'),
      title: Text(
        '#5',
        style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              'User 5',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Icon(Icons.star, color: kMiniBeatMainColor),
          ),
          SizedBox(width: 4),
          Text('1026'),
        ],
      ),
    );
    ;
  }
}
