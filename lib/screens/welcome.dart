import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studentdemoapp/model/UserModel.dart';
import 'package:studentdemoapp/utils/DatabaseHelper.dart';
import 'package:url_launcher/url_launcher.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {
      getUserList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  DatabaseHelper db = new DatabaseHelper();

  List<User> userList;
  void getUserList() async {
    userList = (await db.getUserList());
    setState(() {});

  }

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      // drawer: new SideDrawer(currentSelectedIndex: 1),
      appBar: AppBar(title: Text("Home")),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/register', (Route<dynamic> route) => false);        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        //      alignment: Alignment.bottomCenter,
        children: <Widget>[
          userList == null
              ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'No Student added.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ))
              : _showUserList(context)
        ],
      ),
    );
  }

  Widget _showUserList(context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(child: _showUserListItem(index));
          }),
    );
  }

  Widget _showUserListItem(int index) {
    return Card(
      shape: new RoundedRectangleBorder(
          side: new BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(10.0)),
      elevation: 10,
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(userList[index].name,textAlign: TextAlign.left,overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
              Text(userList[index].email),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Class: "+userList[index].sClass),
                    Text("Brach: "+userList[index].branch)
                  ],
                ),

              ),
              Container(
                margin: EdgeInsets.only(top:10,left: 8,right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(userList[index].mobile),
                    GestureDetector(
                      onTap: (){
                        openMap(double.parse(userList[index].lat),double.parse(userList[index].lang));
                      },
                      child: Icon(Icons.directions,size: 35,)),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

}
