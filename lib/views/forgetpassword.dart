import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_message/views/signing.dart';
import 'package:my_message/widgets/widget.dart';



class Reset extends StatefulWidget {

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {

  TextEditingController emailTextEditingControler = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                   child: TextFormField(
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ?
                        null : "Enter correct email";
                      },
                      controller: emailTextEditingControler,
                      style: TextStyle(
                          color: Colors.white
                      ),
                      decoration: textFieldInputDecoration("Email")
                  ),
                ),
                TextButton(onPressed: (){
                  _auth.sendPasswordResetEmail(email: emailTextEditingControler.text);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context)=> LoginScreen()));
                }, child:
                Text('Submit', style: TextStyle(color: Colors.deepOrange, fontSize: 20),)
                )
              ],
            )
        ));
  }
}
