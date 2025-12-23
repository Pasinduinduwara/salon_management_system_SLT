import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          // Example notifications
          ListTile(
            leading: Icon(Icons.notifications_active, color: Colors.blue),
            title: Text('Your appointment with Ms. Silva is confirmed.'),
            subtitle: Text('Today, 11:00 AM'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.campaign, color: Colors.orange),
            title: Text('New promotion: 20% off on all services!'),
            subtitle: Text('Yesterday'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.feedback, color: Colors.green),
            title: Text('You received new feedback.'),
            subtitle: Text('2 days ago'),
          ),
        ],
      ),
    );
  }
}
