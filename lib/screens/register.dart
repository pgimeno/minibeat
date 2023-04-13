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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitolPantalla(),
              SizedBox(height: 40),
              TextFieldUserName(usernameController: _userNameController),
              TextFieldPassword(passwordController: _passwordController),
              TextFieldPasswordConfirm(
                  passwordControllerChecker: _passwordControllerChecker),
              SizedBox(height: 50),
              RegisterButton(),
              SizedBox(height: 20),
              Row(
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
              SizedBox(height: 20),
              GoToLoginScreenText(),
            ],
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
                color: Colors.black45,
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: 'Fes login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 16,
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
                color: Colors.black,
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
                color: Colors.black,
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
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        style: TextStyle(color: Colors.black),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.center,
        controller: widget._passwordControllerChecker,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Confirma la contrassenya',
          border: UnderlineInputBorder(),
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

class TitolPantalla extends StatelessWidget {
  const TitolPantalla({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 50),
        child: Text(
          'Registre',
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
