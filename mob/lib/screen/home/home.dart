import 'package:flutter/material.dart';

import 'package:mob/const/color.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: PRIMARY_COLOR,
        title: Text('Home', style: TextStyle(color: TEXT_COLOR_W),),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: PRIMARY_COLOR,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}