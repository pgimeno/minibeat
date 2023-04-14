import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minibeat/screens/login.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:minibeat/screens/menu.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordControllerChecker = TextEditingController();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      //Avoid yellow lines
      resizeToAvoidBottomInset: false,
      body: Container(width: MediaQuery.of(context).size.width,
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
                TitolPantalla(),
                SubtitolPantalla(),
                SizedBox(height: 60),
                TextFieldUserName(usernameController: _userNameController),
                TextFieldPassword(passwordController: _passwordController),
                TextFieldPasswordConfirm(
                    passwordControllerChecker: _passwordControllerChecker),
                SizedBox(height: 60),
                RegisterButton(),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    children: [
                      Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          }),
                      AgreementText(),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                GoToLoginScreenText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoToLoginScreenText extends StatelessWidget {
  const GoToLoginScreenText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //amagar teclat quan apretes botó
        FocusManager.instance.primaryFocus?.unfocus();
        // Open register screen
        print('tapped!!');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Ja tens un compte? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: 'Fes login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AgreementText extends StatelessWidget {
  const AgreementText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Estic d\'acord amb el ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text: 'tractament',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: kMiniBeatMainColor,
              ),
            ),
            TextSpan(
              text: ' de les meves dades',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //amagar teclat quan apretes botó
        //FocusManager.instance.primaryFocus?.unfocus();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MenuScreen()));
      },
      child: Text(
        'Registra\'t',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: kMiniBeatMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
      ),
    );
  }
}

class TextFieldPasswordConfirm extends StatefulWidget {
  const TextFieldPasswordConfirm({
    super.key,
    required TextEditingController passwordControllerChecker,
  }) : _passwordControllerChecker = passwordControllerChecker;

  final TextEditingController _passwordControllerChecker;

  @override
  State<TextFieldPasswordConfirm> createState() =>
      _TextFieldPasswordConfirmState();
}

class _TextFieldPasswordConfirmState extends State<TextFieldPasswordConfirm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 12, left: 40, right: 40),
      child: TextField(
        style: TextStyle(color: Colors.black),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.left,
        controller: widget._passwordControllerChecker,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Confirma la contrassenya',
          border: UnderlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          prefixIcon: Icon(
            Icons.lock_rounded,
            color: Colors.white,
          ),
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
      padding: const EdgeInsets.only(top: 5.0, bottom: 12, left: 40, right: 40),
      child: TextField(
        style: TextStyle(color: Colors.black),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.left,
        controller: widget._passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Contrassenya',
          border: UnderlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          prefixIcon: Icon(
            Icons.lock_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TextFieldUserName extends StatefulWidget {
  const TextFieldUserName({
    super.key,
    required TextEditingController usernameController,
  }) : _userNameController = usernameController;

  final TextEditingController _userNameController;

  @override
  State<TextFieldUserName> createState() => _TextFieldUserNameState();
}

class _TextFieldUserNameState extends State<TextFieldUserName> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 12, left: 40, right: 40),
      child: TextField(
        style: TextStyle(color: Colors.black),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.left,
        controller: widget._userNameController,
        decoration: InputDecoration(
          hintText: 'Nom d\'usuari',
          border: UnderlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          prefixIcon: Icon(
            Icons.account_circle,
            color: Colors.white,
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
        padding: const EdgeInsets.only(left: 40.0, top: 100),
        child: Text(
          'Registre',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
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
          'Prepara\'t per ser un autèntic caçatalents!',
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
