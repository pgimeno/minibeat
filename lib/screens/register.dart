import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:minibeat/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minibeat/utils/constants.dart';

import '../models/player.dart';
import '../utils/api.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordControllerChecker = TextEditingController();
  bool _isChecked = false;

  Future<void> registerUser() async {
    final String username = _userNameController.text.trim();
    final String password = _passwordController.text.trim();
    final String passwordChecker = _passwordControllerChecker.text.trim();
    final bool isChecked = _isChecked;

    if (username.isNotEmpty &&
        password.isNotEmpty &&
        passwordChecker.isNotEmpty) {
      if (password == passwordChecker && password.length >= 8) {
        if (isChecked) {
          String sanitizedUsername =
              Utilities().validateInput(username, context);
          if (sanitizedUsername.isNotEmpty) {
            //Check if user exists - Avisar
            try {
              Player? playerExists = await checkUser(username);
              if (playerExists == null) {
                int avatarId = Random().nextInt(20) + 1;
                String hashPassword = Utilities().hashPassword(password);

                Player playerInsert = Player(
                    avatarId: avatarId,
                    userName: username,
                    password: hashPassword);

                try {
                  Player? playerInserted = await registerUserApi(playerInsert);
                  if (playerInserted != null) {
                    showRegisterOkDialog(context);
                  }
                } catch (e) {
                  Utilities().showMessageDialog(context, 'Error inesperat R01',
                      'S\'ha produit un error inesperat en el registre, espera uns minuts i torna a intentar\-ho');
                }
              } else {
                Utilities().showMessageDialog(context, 'L\'usuari ja existeix',
                    'El nom d\'usuari indicat ja ha estat escollit, prova amb un altre');
              }
            } catch (e) {
              Utilities().showMessageDialog(context, 'Error inesperat R02',
                  'S\'ha produit un error inesperat en el registre, espera uns minuts i torna a intentar\-ho');
            }
          }
        } else {
          Utilities().showMessageDialog(context, 'Accepta els termes',
              'Marca la opció per acceptar els termes i condicions per poder continuar');
        }
      } else {
        Utilities().showMessageDialog(context, 'Contrasenyes incorrectes',
            'Les contrasenyes han de coincidir i han de tenir una mida mínima de 8 caracters.');
      }
    } else {
      Utilities().showMessageDialog(context, 'Dades incomplertes',
          'Siusplau, emplena totes les dades necesàries pel registre');
    }
  }

  showRegisterOkDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pushNamed(context, '/login', arguments: {
          'username': _userNameController.text,
          'password': _passwordController.text
        });
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Registre correcte",
        style: TextStyle(color: Colors.black),
      ),
      content: const Text(
        "Ja pots iniciar sessió i començar a jugar!",
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      //Avoid yellow lines
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
                const TitolPantalla(),
                const SubtitolPantalla(),
                const SizedBox(height: 60),
                TextFieldUserName(usernameController: _userNameController),
                TextFieldPassword(passwordController: _passwordController),
                TextFieldPasswordConfirm(
                    passwordControllerChecker: _passwordControllerChecker),
                const SizedBox(height: 60),
                RegisterButton(registerCallback: registerUser),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          }),
                      const AgreementText(),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                const GoToLoginScreenText(),
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
        //Amagar teclat quan apretes botó
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.pushNamed(context, '/login');
      },
      child: RichText(
        text: const TextSpan(
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
                color: kMiniBeatMainColorLighter,

              ),recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: kMiniBeatGradientLast,
                      title: Text('Termes i condicions', style: TextStyle(color: Colors.white),),
                      content: SingleChildScrollView(
                        child: Text(kTermsOfService,  textAlign: TextAlign.left, style: TextStyle(color: Colors.white,),),
                      ),
                      actions: [
                        TextButton(
                          child: Text('D\'acord!', style: TextStyle(color: Colors.white),),

                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            ),
            TextSpan(
              text: ' de les meves dades.',
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
  Function registerCallback;

  RegisterButton({super.key, required this.registerCallback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        registerCallback();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kMiniBeatMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
      ),
      child: const Text(
        'Registra\'t',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
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
        inputFormatters: [
          LengthLimitingTextInputFormatter(16),
        ],
        style: const TextStyle(color: Colors.white),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.left,
        controller: widget._passwordControllerChecker,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Confirma la contrasenya',
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
        inputFormatters: [
          LengthLimitingTextInputFormatter(16),
        ],
        style: const TextStyle(color: Colors.white),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.left,
        controller: widget._passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Contrasenya',
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
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        style: const TextStyle(color: Colors.white),
        cursorColor: kMiniBeatMainColor,
        cursorWidth: 3,
        maxLines: 1,
        textAlign: TextAlign.left,
        controller: widget._userNameController,
        decoration: const InputDecoration(
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
    return const Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.only(left: 40.0, top: 90),
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
    return const Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 12, left: 40, right: 40),
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
