import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AddCaretakerPage extends StatelessWidget {

  final String pageText;
  AddCaretakerPage(this.pageText);

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text(pageText),),
    body: new Center(

    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 80.0,
          ),
          CircleAvatar(
            backgroundColor: Colors.teal,
            radius: 50.0,
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
            child: Divider(),
            ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Name',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: (value){

              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: 'Phone number',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.local_post_office),
                labelText: 'Postal address',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: MaterialButton(
              child: Text ('Register'),
              color: Colors.blueGrey,
              onPressed: () {
                
              },
            ),
          )
        ],
      ),
    ),

    ),

    );
  }
}
