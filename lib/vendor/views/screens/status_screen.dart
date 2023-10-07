import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _updateStatus(bool status) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      await _firestore
          .collection('vendors')
          .doc(uid)
          .update({'status': status});
    } else {
      // หากไม่มีผู้ใช้ล็อกอิน
      print('ผู้ใช้ไม่ได้ล็อกอิน');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Page'),
        backgroundColor: Colors.blue, // สีของ AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _updateStatus(true); // อัปเดต status เป็น true
              },
              child: Text(
                'Open',
                style: TextStyle(fontSize: 18), // ขนาดตัวอักษร
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // สีของปุ่มเมื่อปกติ
                onPrimary: Colors.white, // สีของตัวอักษรบนปุ่ม
              ),
            ),
            SizedBox(height: 20), // ระยะห่างระหว่างปุ่ม
            ElevatedButton(
              onPressed: () {
                _updateStatus(false); // อัปเดต status เป็น false
              },
              child: Text(
                'Close',
                style: TextStyle(fontSize: 18), // ขนาดตัวอักษร
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // สีของปุ่มเมื่อปกติ
                onPrimary: Colors.white, // สีของตัวอักษรบนปุ่ม
              ),
            ),
          ],
        ),
      ),
    );
  }
}
