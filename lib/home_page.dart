import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
  
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: const Text('Assignment'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.green,
            tabs: [
              Tab(text: 'PAPER ASSIGNMENT'),
              Tab(text: 'PHYSICAL ASSIGNMENT'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _paperAssignment(),
            _phyicalAssignment(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/assignment_filter');
          },
          backgroundColor: Colors.yellow,
          child: const Icon(Icons.menu),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notification',
            ),
          ],
        ),
      ),
    );
  }

  _paperAssignment() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 250),
          child: Icon(Icons.book, size: 50),
        ),
        Text(
          'No Assignment at the moment',
          style: TextStyle(color: Colors.green, fontSize: 20),
        ),
        SizedBox(height: 12),
        Text('Wait for the new assignments from your instructor'),
      ],
    );
  }

  _phyicalAssignment() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 250),
          child: Icon(Icons.book, size: 50),
        ),
        Text(
          'No Assignment at the moment',
          style: TextStyle(color: Colors.green, fontSize: 20),
        ),
        SizedBox(height: 12),
        Text('Wait for the new assignments from your instructor'),
      ],
    );
  }
}
