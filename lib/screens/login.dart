import 'package:flutter/material.dart';
import 'package:minibeat/screens/register.dart';
import 'package:minibeat/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
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
              ),
              Align(
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
              ),
              Align(
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
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Do something when button is pressed
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  // Open register screen
                  print('tapped!!');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
