import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  filled: true,
  // fillColor: Colors.black,
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.black)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.black)),
);

// final inputFieldTextStyle = TextStyle(fontSize: 16, color: Colors.white);

Widget containingWidget(Widget _txtFormField) {
  return Container(
    height: 50,
    margin: EdgeInsets.only(left: 40, right: 40),
    child: _txtFormField,
  );
}

Widget spaceWidget(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.015,
  );
}

Widget appLogo() {
  return Image.asset(
    'assets/images/rocket.png',
    height: 120,
  );
}

Widget appNameHeader(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'ZoRa',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textScaleFactor: 3,
      ),
      // Image.asset('assets/images/star.png',)
    ],
  );
}
