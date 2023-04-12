import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minibeat/screens/login.dart';
import 'package:minibeat/screens/ranking.dart';
import 'package:minibeat/utils/constants.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String username = "Username";

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
              AvatarImage(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hola ',
                    style: TextStyle(fontSize: 33),
                  ),
                  UserNameText(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: kMiniBeatMainColor),
                  SizedBox(width: 4),
                  Text('9999', style: TextStyle(fontSize: 23),),
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
    );
  }
}

class UserNameText extends StatefulWidget {
  @override
  State<UserNameText> createState() => _UserNameTextState();
}

class _UserNameTextState extends State<UserNameText> {
  String username = 'Loading...';

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: TextStyle(
          fontSize: 33, color: kMiniBeatMainColor, fontWeight: FontWeight.bold),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    //carregar nom d'usuari de la api
    String userName =
        'Usuari'; //await fetchUserName(); // Call your API method to fetch the user name
    setState(() {
      username = userName;
    });
  }
}

class AvatarImage extends StatefulWidget {
  const AvatarImage({
    super.key,
  });

  @override
  State<AvatarImage> createState() => _AvatarImageState();
}

class _AvatarImageState extends State<AvatarImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0, bottom: 38.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(38.0),
        child: Image.asset(
          'images/avatarSample.jpg',
          width: 145,
          height: 145,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Do something when button is pressed
      },
      child: Text(
        'Comença a jugar!',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: kMiniBeatMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RankingScreen()));
        },
        child: Text(
          'Ranking',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kMiniBeatMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
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
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          // Do something when button is pressed
        },
        child: Text(
          'Comença a jugar!',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kMiniBeatMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
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
                //Navigator.pop(context, true);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
      child: Text(
        'Desconectar',
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationThickness: 0.3,
          fontWeight: FontWeight.bold,
          color: Colors.black45,
          fontSize: 18,
        ),
      ),
    );
  }
}
