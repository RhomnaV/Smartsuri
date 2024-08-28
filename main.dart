import 'package:flutter/material.dart';
import 'login_page.dart';
import 'sign_up_page.dart';

void main() {
  runApp(SmartSortApp());
}

class SmartSortApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartSort',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: IndexPage(),
    );
  }
}

class IndexPage extends StatelessWidget {
  void showEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Send Email"),
          content: Text("Would you like to send an email to yunoooo217@gmail.com?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add your email sending logic here
              },
              child: Text("Send"),
            ),
          ],
        );
      },
    );
  }

  void showCallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Make a Call"),
          content: Text("Would you like to call 09772066294?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add your call logic here
              },
              child: Text("Call"),
            ),
          ],
        );
      },
    );
  }

  void navigateToPage(BuildContext context, String pageName) {
    // Add logic to navigate to the respective page or show a dialog
    // For now, just showing a dialog for demo purposes
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(pageName),
          content: Text("Navigating to $pageName page..."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.grey[300], // Placeholder for logo
              child: Icon(Icons.image, size: 50, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              'WELCOME TO SMARTSORT',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Log-in'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Sign-up'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.email, color: Colors.black),
                  onPressed: () {
                    showEmailDialog(context);
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.phone, color: Colors.black),
                  onPressed: () {
                    showCallDialog(context);
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.contact_page, color: Colors.black),
                  onPressed: () {
                    navigateToPage(context, "Google");
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                navigateToPage(context, "About Us");
              },
              child: Text(
                'About Us  |  Terms and Conditions  |  Privacy Policy',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Copyright © 2024 SmartSort. All Rights Reserved.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


