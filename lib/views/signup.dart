
import 'package:flutter/material.dart';
import 'package:my_message/services/methods.dart';

import 'chatRooms.dart';



class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
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
                "Welcome",
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
                "Create Account to Continue",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 20,
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
                            child: TextFormField(
                              validator: (val){
                                return val!.length>2 ? null : "Name greater than 3";
                              },
                              controller: _name,
                              style: TextStyle(
                                  color: Colors.white70,
                                fontWeight: FontWeight.bold
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: "Name",
                                hintStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 3,color: Colors.blueGrey)
                                ),
                              ),
                            )),
                        Container(
                          height: 100,
                          width: size.width / 1.1,
                          child: TextFormField(
                            validator: (val){
                              return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ?
                              null : "Enter correct email";
                            },
                            controller: _email,
                            style: TextStyle(
                                color: Colors.white70
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Colors.blueGrey)
                              ),
                              prefixIcon: Icon(Icons.person),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
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
                                  color: Colors.white70
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 3, color: Colors.blueGrey)
                                ),
                                prefixIcon: Icon(Icons.lock),
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )),
                      ],
                    ))
              ],
            ),
            SizedBox(
              height: size.height / 20,
            ),
            customButton(size),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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

        if (_name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });


          createAccount(_name.text, _email.text, _password.text).then((user) {

            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
              print("Account Created Sucessfull");
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please enter Fields");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white70,
          ),
          alignment: Alignment.center,
          child: Text(
            "Create Account",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
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
}