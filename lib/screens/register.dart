import 'package:flutter/material.dart';
import 'package:minibeat/screens/login.dart';
import 'package:minibeat/utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordControllerChecker = TextEditingController();
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
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
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  cursorColor: kMiniBeatMainColor,
                  cursorWidth: 3,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  cursorColor: kMiniBeatMainColor,
                  cursorWidth: 3,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Contrassenya',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  cursorColor: kMiniBeatMainColor,
                  cursorWidth: 3,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  controller: _passwordControllerChecker,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirma la contrassenya',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Do something when button is pressed
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(value: _isChecked,
                      onChanged: (bool? value){
                    setState(() {
                      _isChecked = value ?? false;
                    });

                  }),

                  Expanded(
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

                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  // Open register screen
                  print('tapped!!');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()));
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
