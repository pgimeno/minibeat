import 'package:flutter/material.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:http/http.dart';

import '../models/player.dart';
import '../utils/api.dart';
import '../utils/hashPassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      final String? username = args['username'];
      final String? password = args['password'];

      _userNameController.text = username!!;
      _passwordController.text = password!!;
    }
  }

  Future<void> loginUser() async {
    final String username = _userNameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      //Check if user exists - Avisar
      try {
        Player? playerExists = await checkUser(username);
        if (playerExists != null ) {
          String hashPassword = HashMaker().hashPassword(password);
          if(hashPassword == playerExists.password){
            Navigator.pushNamed(context, '/menu', arguments: {'userNamePassed': username});
          }else{
            showMessageDialog(context, 'Informació incorrecte', 'Indica un nom d\'usuari i contrasenya vàlids');
          }
        } else {
          showMessageDialog(context, 'Informació incorrecte', 'Indica un nom d\'usuari i contrasenya vàlids');
        }
      } catch (e) {
        showMessageDialog(context, 'Error inesperat', 'No s\'ha pogut');
      }
    } else {
      showMessageDialog(context, 'Informació incompleta', 'Has d\'indicar un nom d\'usuari i una contrasenya');
    }
  }


  showMessageDialog(BuildContext context, String title, String subtitle) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      content:  Text(
        subtitle,
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
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
                const IconImage(),
                const TitolPantalla(),
                const SubtitolPantalla(),
                const SizedBox(height: 20),
                TextFieldUserName(userNameController: _userNameController),
                TextFieldPassword(passwordController: _passwordController),
                const SizedBox(height: 50),
                LoginButton(
                  loginCallback: loginUser,
                ),
                const SizedBox(height: 20),
                const GoToRegisterScreenText(),
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
        Navigator.pushNamed(context, '/register');
      },
      child: const Text(
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
  Function loginCallback;
  LoginButton(
      {super.key, required this.loginCallback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //Amagar teclat al fer click al botó
        FocusManager.instance.primaryFocus?.unfocus();
        loginCallback();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kMiniBeatMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
      ),
      child: const Text(
        'Inicia sessió',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
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
        style: const TextStyle(color: Colors.white),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.left,
        controller: widget._passwordController,
        obscureText: true,
        decoration: const InputDecoration(
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
        style: const TextStyle(color: Colors.white),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.left,
        controller: widget._userNameController,
        decoration: const InputDecoration(
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
    return const Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding:
            EdgeInsets.only(top: 5.0, bottom: 12, left: 40, right: 40),
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
    return const Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.only(top: 12.0, left: 40, right: 40),
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
