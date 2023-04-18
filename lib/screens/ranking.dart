import 'package:flutter/material.dart';
import 'package:minibeat/models/player.dart';
import 'package:minibeat/models/playerRanking.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:minibeat/utils/api.dart';

late Future<List<PlayerRanking>?> players;

PlayerRanking currentPlayer = PlayerRanking.empty();

Future<List<PlayerRanking>?> getRankingFromApi() async {
  try {
    List<PlayerRanking>? ranking = await getRanking();

    for (var player in ranking!) {
      if (player.userName == 'Sandra') {
        currentPlayer = PlayerRanking(
            position: player.position,
            userName: player.userName,
            totalPoints: player.totalPoints,
            avatarId: player.avatarId);

        break;
      }
    }
    return ranking;
  } catch (e) {
    print(e.toString());
  }
}

class RankingScreen extends StatefulWidget {
  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  void initState() {
    super.initState();
    players = getRankingFromApi();
  }

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
              SizedBox(height: 45),
              Text(
                'Ranking',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 5),
              Expanded(
                child: FutureBuilder<List<PlayerRanking>?>(
                  future: players,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            contentPadding: EdgeInsets.only(
                                left: 25, top: 10.0, bottom: 10, right: 25),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image(
                                    image:

                                        ///images/avatars/$player.avatarID
                                        AssetImage('images/avatarSample.jpg'),
                                    height: 60,
                                    width: 60,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '#' +
                                        snapshot.data![index].position
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    snapshot.data![index].userName,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ]),
                                Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: kMiniBeatMainColor),
                                      SizedBox(width: 4),
                                      Text(
                                          snapshot.data![index].totalPoints
                                              .toString(),
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              SizedBox(height: 5),
              Divider(
                color: Colors.white,
                thickness: 1,
                indent: 23,
                endIndent: 23,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      'La teva posició',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  FutureBuilder<List<PlayerRanking>?>(
                    future: players,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        for (var player in snapshot.data!) {
                          if (player.userName == 'Pol') {
                            currentPlayer = PlayerRanking(
                                position: player.position,
                                userName: player.userName,
                                totalPoints: player.totalPoints,
                                avatarId: player.avatarId);
                            break;
                          }
                        }
                        return UserTile(currentPlayer: currentPlayer);
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 8.0, top: 12.0, bottom: 12.0),
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final PlayerRanking currentPlayer;

  const UserTile({Key? key, required this.currentPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          EdgeInsets.only(left: 25, top: 5.0, bottom: 20, right: 40),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Image(
              image: AssetImage('images/avatarSample.jpg'),
              height: 60,
              width: 60,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '#' + currentPlayer.position.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              currentPlayer.userName,
              style: TextStyle(fontSize: 20),
            ),
          ]),
          Row(
            children: [
              Icon(Icons.star, color: kMiniBeatMainColor),
              SizedBox(width: 4),
              Text(currentPlayer.totalPoints.toString()),
            ],
          )
        ],
      ),
    );
  }
}
