import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      child: Container(
        color: Colors.white, // Set drawer background to white
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // User profile section
              Container(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
                color: Colors.blue[50], // Optional: light background for header
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://example.com/path/to/user/image.jpg'), // Replace with your image
                      child:
                          Icon(Icons.person, size: 40), // Fallback if no image
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'John Doe', // Replace with user's name
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'john.doe@example.com', // Replace with user's email
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Menu items
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home_outlined,
                        color: Colors.black), // Set icon color
                    title: const Text('Home',
                        style:
                            TextStyle(color: Colors.black)), // Set text color
                    onTap: () {
                      // Add navigation logic here
                    },
                  ),
                  // Add more menu items as needed
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.black),
                    title: const Text('Settings',
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      // Add navigation logic here
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
