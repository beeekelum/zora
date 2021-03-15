import 'package:flutter/material.dart';

class CompleteProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
