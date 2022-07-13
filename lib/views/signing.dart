
import 'package:flutter/material.dart';
import 'package:my_message/services/methods.dart';
import 'package:my_message/views/forgetpassword.dart';
import 'package:my_message/views/signup.dart';

import 'chatRooms.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: isLoading
          ? Center(
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: size.width / 0.5,
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
            ),
            SizedBox(
              height: size.height / 50,
            ),
            Container(
              width: size.width / 1.1,
              child: Text(
                "Hello!",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70
                ),
              ),
            ),
            Container(
              width: size.width / 1.1,
              child: Text(
                "Let's Sign In",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 120,
            ),
        Column(
         mainAxisSize: MainAxisSize.min,
          children: [
            Form(
                key: formKey,
                child: Column(
              children: [
                Container(
                  height: 100,
                  width: size.width / 1.1,
                  color: Colors.black12,
                  child: TextFormField(
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ?
                      null : "Enter correct email";
                    },
                    controller: _email,
                    style: TextStyle(
                        color: Colors.white70,
                      fontWeight: FontWeight.bold
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.white70,),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Container(
                    height: 100,
                    width: size.width / 1.1,
                    child: TextFormField(
                      obscureText: true,
                      validator: (val){
                        return val!.length>6 ? null : "Password greater than 6";
                      },
                      controller: _password,
                      style: TextStyle(
                          color: Colors.white70,
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.white70,),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),
              ],
            ))
          ],
        ),
            
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => Reset())),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            customButton(size),
            SizedBox(
              height: size.height / 40,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => CreateAccount())),

              child: Text(
                "Create Account",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });
        }
          if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
            setState(() {
              isLoading = true;
            });

            logIn(_email.text, _password.text).then((user) {
              if (user != null) {
                print("Login Sucessfull");
                setState(() {
                  isLoading = false;
                });
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              } else {
                print("Login Failed");
                setState(() {
                  isLoading = false;
                });
              }
            });
          } else {
            print("Please fill form correctly");
          }
        },
        child:
        Container(
            height: size.height / 14,
            width: size.width / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white70,
            ),
            alignment: Alignment.center,
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )));

  }

  Widget fieldEmail(
      Size size, String hintText, IconData icon, TextEditingController cont, Color colors) {
    return Container(
      height: 100,
      width: 100,
      child: Form(
        key: formKey,
        child: TextFormField(
          validator: (val){
            return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ?
            null : "Enter correct email";
          },
          controller: cont,
          style: TextStyle(
            color: Colors.white70
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 10, color: Colors.white70)
            ),
            prefixIcon: Icon(icon),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

Widget fieldPassword(
    Size size, String hintText, IconData icon, TextEditingController cont, Color color) {
  return Container(
    height: size.height / 14,
    width: size.width / 1.1,
    child: TextFormField(
      obscureText: true,
      validator: (val){
        return val!.length>6 ? null : "Password greater than 6";
      },
      controller: cont,
      style: TextStyle(
          color: Colors.white70
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.white70)
        ),
        prefixIcon: Icon(icon),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
