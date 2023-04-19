import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minibeat/models/playerRanking.dart';
import 'package:minibeat/screens/login.dart';
import 'package:minibeat/screens/ranking.dart';
import 'package:minibeat/screens/radar.dart';
import 'package:minibeat/utils/api.dart';
import 'package:minibeat/utils/constants.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  PlayerRanking? playerInSession;

  @override
  void initState() {
    super.initState();
    getPlayerLogged();
  }

  Future<void> getPlayerLogged() async {
    try {
      final player = await getPlayer('Pol');
      setState(() {
        playerInSession = player;
      });
      print(player.toString());
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              'Sortir de l\'aplicació.',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: Text(
              'Vols desconnectar-te?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false),
                child: Text('Si'),
              ),
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                playerInSession != null
                    ? AvatarImage(playerInSession!)
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hola, ',
                      style: TextStyle(fontSize: 33, color: Colors.white),
                    ),
                    Text(
                      playerInSession?.userName ?? '',
                      style: TextStyle(
                          fontSize: 33,
                          color: kMiniBeatMainColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: kMiniBeatMainColor),
                    SizedBox(width: 4),
                    Text(
                      playerInSession?.totalPoints.toString() ?? '',
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                StartPlayButton(),
                RankingButton(),
                DisconnectButtonText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  final PlayerRanking player;

  const AvatarImage(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 85.0, bottom: 38.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(38.0),
        child: Image.asset(
          'images/avatars/${player.avatarId}.png',
          width: 145,
          height: 145,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class RankingButton extends StatelessWidget {
  const RankingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RankingScreen()));
        },
        child: Text(
          'Ranking',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kMiniBeatMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
        ),
      ),
    );
  }
}

class StartPlayButton extends StatelessWidget {
  const StartPlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RadarScreen()));
        },
        child: Text(
          'Comença a jugar!',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kMiniBeatMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
        ),
      ),
    );
  }
}

class DisconnectButtonText extends StatelessWidget {
  const DisconnectButtonText({
    super.key,
  });

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'T\'estas a punt de desconectar.',
            style: TextStyle(color: Colors.black),
          ),
          content:
              Text('N\'estas segur/a?', style: TextStyle(color: Colors.black)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                //TODO: fer logout aqui

                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
              child: Text('Si'),
            ),
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        // LOG OUT DE l'USUARI!!!
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _logout(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Text(
          'Desconectar',
          style: TextStyle(
            decoration: TextDecoration.underline,
            decorationThickness: 0.3,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
