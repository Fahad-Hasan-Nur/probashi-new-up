import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool login = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController userIdController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailFiled = Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: RequiredValidator(errorText: 'UserID is required'),
          controller: userIdController,
          decoration: InputDecoration(
            labelText: 'UserID',
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(),
          ),
        ));

    final passFiled = Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: passController,
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter you password";
            }
          },
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(),
          ),
        ));
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    return Material(
      child: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottom),
              child: Column(children: [
                Image.asset(
                  "assets/images/loginLogo.jpeg",
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome ",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          emailFiled,
                          passFiled,
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            hoverColor: Colors.orange,
                            onTap: () {
                              checkLogin(context);
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              alignment: Alignment.center,
                              height: 30,
                              width: login ? 30 : 70,
                              child: login
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  final spinkit =
      SpinKitFadingCircle(itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Color.fromARGB(255, 227, 149, 66) : Colors.green,
      ),
    );
  });
  checkLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => spinkit,
          fullscreenDialog: true,
        ),
      );
      LoginController ob = Get.put(LoginController());
      ob.authenticateUser(userIdController.text, passController.text);
    }
  }
}
