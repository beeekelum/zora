import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zora/auth/model/user_obj.model.dart';
import 'package:zora/auth/user.service.dart';
import 'package:zora/profile/views/complete_profile.view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return StreamBuilder<UserObject>(
        stream: UserService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          var user = snapshot.data;
          if (user?.profilePercentage == 100) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Home'),
              ),
            );
          } else {
            return CompleteProfile();
          }
        });

  }
}
