//VERIFICATION PARA SA LOGIN
import 'package:flutter/material.dart';
import 'package:smartsuri/home_page.dart';

class VerificationPage extends StatelessWidget {
  final String email;

  VerificationPage({required this.email});

  @override
  Widget build(BuildContext context) {
    final TextEditingController codeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.green[100],
              ),
              child: Icon(Icons.verified, size: 50, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              'VERIFICATION SENT',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              'Please enter the 6 digit code sent to',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              email,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                controller: codeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter code',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Replace this with your actual verification logic
                String enteredCode = codeController.text;

                if (enteredCode == '123456') { // Example: assuming '123456' is the correct code
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(userName: email),
                    ),
                  );
                } else {
                  // Show an error message if the code is incorrect
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid verification code')),
                  );
                }
              },
              child: Text('VERIFY'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                primary: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
