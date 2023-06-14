import 'package:flutter/material.dart';
import 'package:gp2023/main.dart';
import 'package:gp2023/shared/constants/constants.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.5,
              color: Colors.black54,
            ),
          ),
          child: SingleChildScrollView(child: Text(IS_APPLICANT ? help_applicant : help_hr)),
        ),
      ),
    );
  }
}