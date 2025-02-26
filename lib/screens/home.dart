import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Homeee extends StatelessWidget {
   Homeee({super.key});
 final TextEditingController textt = TextEditingController();
  
  void uploadd() async {
    try{
   await FirebaseFirestore.instance.collection("comment").add({
      "comment":textt.text.trim()
    });
  }
    catch(e){
     print(e);
     
    }
    }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You are logged in"),
      ),
      body: Column(
        children: [
           TextField(
              controller:textt ,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'text',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
              ElevatedButton(
              onPressed: () {
                uploadd();
              },
              child: Text('uploadeed'),
            ),
            Container(
            width: 200,
            height: 200,
            color: Colors.amber,
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
          
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (snapshot.hasData) {
                  User? user = snapshot.data;
                  return Center(
                    child: Text('Logged in as: ${user?.email ?? "No email"}'),
                  );
                } else {
                  return Center(
                    child: Text('No user is logged in'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
