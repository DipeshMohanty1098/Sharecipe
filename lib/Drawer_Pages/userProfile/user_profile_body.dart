import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/shared/loading.dart';

class UserProfileBody extends StatefulWidget {
  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    try {
      userData.photoURL;
    } catch (e) {
      return Loading();
    }
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                userData.photoURL,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text("${userData.name}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Recipes Published",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              SizedBox(
                width: 30.0,
              ),
              Text("${userData.recipes}",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}
