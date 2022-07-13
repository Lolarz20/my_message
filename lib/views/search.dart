import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_message/services/methods.dart';

import 'conversation.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(

      ),
      appBar: AppBar(
        title: Text("Messages", style: TextStyle(
          fontWeight: FontWeight.w900
        ),),
        leading: Text("Messages", style: TextStyle(
            fontWeight: FontWeight.w900
        ),),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
        ],
      ),

      body: isLoading
          ? Center(
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(),
        ),
      )
          : Column(
        children: [
          SizedBox(
              height: size.height/20
          ),
          Row(
              children:[
                Container(
                  height: size.height/14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Row(
                      children: [
                        Container(
                          height: size.height/14,
                          width: size.width/1.15,
                          child: TextField(
                            controller: _search,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold
                            ),
                            decoration: InputDecoration(
                              hintText: "Search...",
                              hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Colors.blueGrey)
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            child: IconButton(
                                onPressed: onSearch, icon: Icon(Icons.search), iconSize: 37, color: Colors.white70))
                      ]
                  ),
                )
              ]
          ),
          userMap != null
              ? SingleChildScrollView(
            child: ListTile(
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.deepOrange, width: 5), borderRadius: BorderRadius.circular(5)),
              onTap: () {
                String roomId = chatRoomId(
                    _auth.currentUser!.displayName!,
                    userMap!['email']);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChatRoom(
                      chatRoomId: roomId,
                      userMap: userMap!,
                    ),
                  ),
                );
              },
              leading: Icon(Icons.account_box, color: Colors.deepOrange),
              title: Text(
                userMap!['name'],
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(userMap!['email'],
                style: TextStyle(
                    color: Colors.deepOrange
                ),
              ),
              trailing: Icon(Icons.chat, color: Colors.deepOrange),
            ),
          )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.group),
          onPressed: () {}
      ),
    );
  }
}
