import 'package:flutter/material.dart';
import 'package:minibeat/models/playerRanking.dart';
import 'package:minibeat/utils/api.dart';

class WinnersScreen extends StatefulWidget {
  const WinnersScreen({Key? key}) : super(key: key);

  @override
  State<WinnersScreen> createState() => _WinnersScreenState();
}

class _WinnersScreenState extends State<WinnersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Row(children: [
                
              ],),
            ],
          ),
        ),
      ),
    );
  }
}
