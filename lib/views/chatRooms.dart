
import 'dart:collection';
import 'dart:ffi';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_message/modal/Constants.dart';
import 'package:my_message/services/methods.dart';
import 'package:provider/provider.dart';

import '../ad_state.dart';
import 'conversation.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int licznik = 0;
  List userList = [];

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
  void lastChats(String lastChats) async{
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "chats": lastChats,
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

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("name", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
        licznik++;
      });
      print(userMap);
      print(licznik);
      print(userList);
    });

    for (int i = 0; i < _search.text.length; i++)
      userList.add({
        "email": _search.text
      });

    _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "chats": FieldValue.arrayUnion(userList),
    });
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0]
        .toLowerCase()
        .codeUnits[0] >
        user2
            .toLowerCase()
            .codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  late BannerAd bannerAd;
  late BannerAd bannerAd2;
  late BannerAd bannerAd3;
  late BannerAd bannerAd4;
  late BannerAd bannerAd5;

  @override

  void didChangeDependencies(){
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status){
      setState(() {
        bannerAd=BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
        bannerAd2=BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
        bannerAd3=BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
        bannerAd4=BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
        bannerAd5=BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();

      });
    });
  }

  @override
  void dispose() {
    bannerAd.dispose();
    bannerAd2.dispose();
    bannerAd3.dispose();
    bannerAd4.dispose();
    bannerAd5.dispose();

  }

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    String data = "";
    List<String> split = data.split("");
    split.sort();
    
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("Messages", style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white
          )),
          actions:[
           IconButton(icon: Icon(Icons.logout, color: Colors.white,),
                  onPressed: () => logOut(context)),
    ],
            leading: IconButton(icon: Icon(Icons.search, color: Colors.white,),
        onPressed: _scaffoldKey.currentState?.openDrawer),
        ),
        drawer: Drawer(
          backgroundColor: Colors.black,
            child: Container(
              padding: EdgeInsets.only(top: 75),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height / 14,
                          width: size.width / 1.30,
                          alignment: Alignment.center,
                          child: Row(
                              children: [
                                Container(
                                  height: size.height / 14,
                                  width: size.width / 1.65,
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
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.blueGrey)
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    child: IconButton(
                                        onPressed: onSearch,
                                        icon: Icon(Icons.search),
                                        iconSize: 37,
                                        color: Colors.white70))
                              ]
                          ),
                        ),
                        SizedBox(height: 25,)
                      ]
                  ),
                  userMap != null
                      ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 25,),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 5),
                              borderRadius: BorderRadius.circular(5)),
                          onTap: () {
                            String roomId = chatRoomId(
                                _auth.currentUser!.displayName!,
                                userMap?['email']);
                            data = roomId;
                            List<String> split = data.split("");
                            split.sort();
                              Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    ChatRoom(
                                      chatRoomId: split.toString(),
                                      userMap: userMap!,
                                    ),
                              ),
                            );
                          },
                          leading: Icon(Icons.account_box, color: Colors.white70),
                          title: Text(
                            userMap?['name'],
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(userMap?['email'],
                            style: TextStyle(
                                color: Colors.white70
                            ),
                          ),
                          trailing: Icon(Icons.chat, color: Colors.white70),
                        ),
                      ],
                    ),
                  )
                      : Container(),
                ],
              ),
            )),
        body: isLoading
            ? Center(
          child: Container(
            height: size.height / 20,
            width: size.height / 20,
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Text('Slide to search for users', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),)),
              SizedBox(height: 15),
              Container(
                  height: 50,
                  child: AdWidget(ad: bannerAd,)
                ),
              SizedBox(height: 15),
              Container(
                  height: 50,
                  child: AdWidget(ad: bannerAd2,)
              ),
              SizedBox(height: 15),
              Container(
                  height: 50,
                  child: AdWidget(ad: bannerAd3,)
              ),
              SizedBox(height: 15),
              Container(
                  height: 50,
                  child: AdWidget(ad: bannerAd4,)
              ),
              SizedBox(height: 15),
              Container(
                  height: 50,
                  child: AdWidget(ad: bannerAd5,)
              ),
              SizedBox(height: 15),
            ],
          ),
        )

        );
  }
}

