import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../constant/value.dart';

class SuccessAuth extends StatelessWidget {
  const SuccessAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryBackground,
        body:  Center(
          child: Text(
            'Successfully Authenticated',
            style: TextStyle(color: green, fontSize: fontVeryBig),
          ),
        ),
    );
  }
}
