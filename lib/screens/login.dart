import 'package:flutter/material.dart';
import 'package:minibeat/screens/register.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:minibeat/screens/menu.dart';

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
      body: SafeArea(
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
              LoginButton(),
              SizedBox(height: 20),
              GoToRegisterScreenText(),
            ],
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
      padding: const EdgeInsets.only(top: 18.0, bottom: 38.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: Image.asset(
          'images/minibeatlogo.JPG',
          width: 145,
          height: 145,
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
          color: Colors.black45,
          fontSize: 18,
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

        //amagar teclat quan apretes botó
        FocusManager.instance.primaryFocus?.unfocus();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MenuScreen()));

      },
      child: Text(
        'Inicia sessió',
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
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        style: TextStyle(color: Colors.black),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.center,
        controller: widget._passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Contrassenya',
          border: UnderlineInputBorder(),
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
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        style: TextStyle(color: Colors.black),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.center,
        controller: widget._userNameController,
        decoration: InputDecoration(
          hintText: 'Nom d\'usuari',
          border: UnderlineInputBorder(),
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
        padding: const EdgeInsets.only(left: 18.0, bottom: 17.0),
        child: Text(
          'Què bo veure\'t per aqui',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w100,
            fontSize: 24,
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
        padding: const EdgeInsets.only(left: 18.0),
        child: Text(
          'Inicia sessió',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
