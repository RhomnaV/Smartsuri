import 'package:flutter/material.dart';
import 'scan_page.dart'; // Import the ScanPage

class HomePage extends StatelessWidget {
  final String userName;

  HomePage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Welcome, $userName!',
          style: TextStyle(color: Colors.green, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.green),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Earn Points'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Find Events'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Make Something New!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Recycle for a cause today!',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the ScanPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScanPage(),
                      ),
                    );
                  },
                  child: Text('Find a Material'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Recycled Items Trend:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10, // Replace with actual item count
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the specific page for this item
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(itemIndex: index),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Item $index', // Replace with actual item title
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Best Innovation:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle click event for the first innovation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InnovationDetailPage(innovation: 'Table Glass Lamp'),
                        ),
                      );
                    },
                    child: buildInnovationCard(
                      'Table Glass Lamp',
                      'A new aesthetic fit for your home.',
                      'URL_to_image_of_table_lamp',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle click event for the second innovation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InnovationDetailPage(innovation: 'Tire to Table'),
                        ),
                      );
                    },
                    child: buildInnovationCard(
                      'Tire to Table',
                      'An unexpected yet beautiful furniture for your living room.',
                      'URL_to_image_of_tire_table',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to browse more innovations
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrowseMorePage(),
                      ),
                    );
                  },
                  child: Text('Browse More'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInnovationCard(String title, String subtitle, String imageUrl) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

// Example page for detailed information about an item
class DetailPage extends StatelessWidget {
  final int itemIndex;

  DetailPage({required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item $itemIndex Details'),
      ),
      body: Center(
        child: Text('Details for item $itemIndex'),
      ),
    );
  }
}

// Example page for detailed information about an innovation
class InnovationDetailPage extends StatelessWidget {
  final String innovation;

  InnovationDetailPage({required this.innovation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$innovation Details'),
      ),
      body: Center(
        child: Text('Details about $innovation'),
      ),
    );
  }
}

// Example page for browsing more innovations
class BrowseMorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse More Innovations'),
      ),
      body: Center(
        child: Text('Browse more innovations here'),
      ),
    );
  }
}
