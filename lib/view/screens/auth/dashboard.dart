// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socail_media_app/view/screens/auth/login_screen/login_screen.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({Key? key}) : super(key: key);

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  final db = FirebaseFirestore.instance;
  TextEditingController _addInput = TextEditingController();

  final user = <String, dynamic>{
    "first": "Ada",
    "middle": "john",
    "last": "Lovelace",
    "born": 1815
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Simple Todo App')),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    })));
              },
              icon: Icon(Icons.logout_outlined),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Tasks',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: db.collection('users').snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator(
                        strokeAlign: BorderSide.strokeAlignCenter,
                      );
                    default:
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;

                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 3),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green[300]),
                              child: ListTile(
                                title: Text(
                                  data['data'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                      fontSize: 25),
                                ),
                                onTap: () {},
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Confirm Deletion'),
                                            content: Text(
                                                'Are you sure you want to delete this data?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  document.reference.delete();
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Success'),
                                                        content: Text(
                                                            'Data successfully deleted.'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close the success dialog
                                                            },
                                                            child: Text('OK'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          );
                                        });

                                    // show alert "successfully deleted"
                                  },
                                ),
                                iconColor: Colors.red,
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ),
            TextField(
              controller: _addInput,
              decoration: InputDecoration(
                hintText: "To do",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    db.collection('users').add({
                      'data': _addInput.text,
                    }).then(
                      (value) => _addInput.text = "",
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
