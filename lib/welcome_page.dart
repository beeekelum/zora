import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zora/auth/auth.controller.dart';
import 'package:zora/styles_n_widgets/styles.dart';

class WelcomePage extends StatelessWidget {

  final AuthController authController = AuthController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/joinusbg.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.3),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appNameHeader(),
              appLogo(),
              sizedBoxWidget(15),
              textWidget("Join As: ", 25),
              sizedBoxWidget(15),
              Container(
                width: 250,
                height: 50,
                child: RaisedButton.icon(
                    label: Text(
                      "School",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    icon: Icon(Icons.school, color: Colors.white,),
                    onPressed: () {
                      Get.toNamed('/register/School/view');
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0))),
              ),
              sizedBoxWidget(15),
              Container(
                width: 250,
                height: 50,
                child: RaisedButton.icon(
                    label: Text(
                      "Parent/Guardian",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    icon: Icon(Icons.wc_rounded, color: Colors.white,),
                    onPressed: () {
                      Get.toNamed('/register/ParentOrGuardian/view');
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0))),
              ),
              sizedBoxWidget(15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Get.toNamed('/login');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member? ",
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        "Login",
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget textWidget(String value, double fontSize){
    return Text(
      value,
      style: TextStyle(fontSize: fontSize),
    );
  }

  Widget sizedBoxWidget(double height){
   return SizedBox(
      height: height,
    );
  }
}

