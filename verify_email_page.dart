import 'package:flutter/material.dart';
import 'signup_success_page.dart';  // Import SignupSuccessPage

class VerifyEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Navigate back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Text(
              'VERIFY EMAIL',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Please enter the 6-digit code sent to your email.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter code',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // After verification, navigate to SignupSuccessPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupSuccessPage()),
                );
              },
              child: Text('VERIFY'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
