import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:zora/auth/auth.controller.dart';
import 'package:zora/styles_n_widgets/styles.dart';

class RegisterPage extends StatelessWidget {

  final AuthController authController = AuthController.to;
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${Get.parameters["user_type"]}"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/loginbg.png'),
                  fit: BoxFit.cover),),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.3),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),),
          ),
          Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        appNameHeader(),
                        appLogo(),
                        _paddingWidget(_buildEmail(context)),
                        _paddingWidget(_buildPassword(context)),
                        _paddingWidget(_buildConfirmPassword(context)),
                        _paddingWidget(_buildSubmitButton()),
                        _paddingWidget(_buildAlreadyHaveAnAccount()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: FormBuilderTextField(
        controller: _emailController,
        decoration: textInputDecoration.copyWith(
            labelText: 'Email address',
            prefixIcon: Icon(
              Icons.mail,
              color: Colors.black,
            )),
        onChanged: (value) {},
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: FormBuilderTextField(
        controller: _passwordController,
        obscureText: true,
        decoration: textInputDecoration.copyWith(
            labelText: 'Password',
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: (){})
        ),
        onChanged: (value) {},
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
      ),
    );
  }

  Widget _buildConfirmPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: FormBuilderTextField(
        obscureText: true,
        decoration: textInputDecoration.copyWith(
            labelText: 'Confirm Password',
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: (){})
        ),
        onChanged: (value) {},
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
      ),
    );
  }

  Widget _buildAlreadyHaveAnAccount() {
    return GestureDetector(
      onTap: (){
        Get.toNamed('/login');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Already a member? ', style: TextStyle(fontSize: 17),),
          Text(
            'Login',
            style: TextStyle(color: Colors.black, fontSize: 19),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: 250,
      height: 50,
      child: RaisedButton.icon(
        icon: Icon(
          Icons.app_registration,
          color: Colors.white,
        ),
        label: Text(
          "Register",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () {
          _formKey.currentState.save();
          if (_formKey.currentState.validate()) {
            authController.handleSignUp(
              _emailController,
              _passwordController,
                Get.parameters["user_type"]
            );
          } else {
            print("validation failed");
          }
        },
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),),),
    );
  }

  Widget _paddingWidget(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}
