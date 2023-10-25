import 'package:amazon_clone/common/utils/shared_prefs.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //tmpUser =await SharedPrefUtisl.getToken() as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: FutureBuilder<User?>(
        future: SharedPrefUtisl.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the data, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If an error occurs, you can handle it here
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // If data is available, display it
            return Center(
                child: Column(
              children: [
                Text(snapshot.data!.email),
                Text(snapshot.data!.name),
                Text(snapshot.data!.type),
              ],
            ));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
