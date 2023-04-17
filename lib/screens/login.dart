import 'package:flutter/material.dart';
import 'package:minibeat/screens/register.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:minibeat/screens/menu.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconImage(),
                TitolPantalla(),
                SubtitolPantalla(),
                SizedBox(height: 20),
                TextFieldUserName(userNameController: _userNameController),
                TextFieldPassword(passwordController: _passwordController),
                SizedBox(height: 50),
                LoginButton(
                  username: _userNameController.text,
                  password: _passwordController.text,
                ),
                SizedBox(height: 20),
                GoToRegisterScreenText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconImage extends StatelessWidget {
  const IconImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, bottom: 38.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: Image.asset(
          'images/miniBeatLogo.PNG',
          width: 125,
          height: 125,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class GoToRegisterScreenText extends StatelessWidget {
  const GoToRegisterScreenText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open register screen
        print('tapped!!');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterScreen()));
      },
      child: Text(
        'Registra\'t',
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationThickness: 0.3,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton(
      {super.key, required this.username, required this.password});

  final String username;
  final String password;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //amagar teclat quan apretes botó
        FocusManager.instance.primaryFocus?.unfocus();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MenuScreen()));
      },
      child: Text(
        'Inicia sessió',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: kMiniBeatMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
      ),
    );
  }
}

class TextFieldPassword extends StatefulWidget {
  const TextFieldPassword({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 12.0, bottom: 12, left: 40, right: 40),
      child: TextField(
        style: TextStyle(color: Colors.white),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.left,
        controller: widget._passwordController,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          hintText: 'Contrassenya',
          border: UnderlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

class TextFieldUserName extends StatefulWidget {
  const TextFieldUserName({
    super.key,
    required TextEditingController userNameController,
  }) : _userNameController = userNameController;

  final TextEditingController _userNameController;

  @override
  State<TextFieldUserName> createState() => _TextFieldUserNameState();
}

class _TextFieldUserNameState extends State<TextFieldUserName> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 12.0, bottom: 12, left: 40, right: 40),
      child: TextField(
        style: TextStyle(color: Colors.white),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.left,
        controller: widget._userNameController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle_rounded,
            color: Colors.white,
          ),
          hintText: 'Nom d\'usuari',
          border: UnderlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

class SubtitolPantalla extends StatelessWidget {
  const SubtitolPantalla({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 12, left: 40, right: 40),
        child: Text(
          'Què bo veure\'t per aqui',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w100,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

class TitolPantalla extends StatelessWidget {
  const TitolPantalla({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 40, right: 40),
        child: Text(
          'Inicia sessió',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
