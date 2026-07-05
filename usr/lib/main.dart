import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Panel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPanelScreen(),
      },
    );
  }
}

class MainPanelScreen extends StatefulWidget {
  const MainPanelScreen({super.key});

  @override
  State<MainPanelScreen> createState() => _MainPanelScreenState();
}

class _MainPanelScreenState extends State<MainPanelScreen> {
  int _selectedIndex = 0;

  final List<String> _destinations = [
    'Dashboard',
    'Profile',
    'Attendance',
    'Results',
    'Routine',
    'Assignments',
    'Notices',
    'Subjects',
    'Semester Fees',
    'Library',
    'Exam Schedule',
    'Settings',
  ];

  final List<IconData> _destinationIcons = [
    Icons.dashboard,
    Icons.person,
    Icons.check_circle,
    Icons.grade,
    Icons.schedule,
    Icons.assignment,
    Icons.notifications,
    Icons.book,
    Icons.payment,
    Icons.local_library,
    Icons.calendar_month,
    Icons.settings,
  ];

  Widget _buildContent(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _destinationIcons[_destinations.indexOf(title)],
            size: 80,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text('Content for $title goes here'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;
    
    return Scaffold(
      appBar: isDesktop 
          ? null 
          : AppBar(
              title: Text(_destinations[_selectedIndex]),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
      drawer: isDesktop
          ? null
          : Drawer(
              child: _buildDrawerContent(),
            ),
      body: Row(
        children: [
          if (isDesktop)
            Container(
              width: 250,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
              ),
              child: _buildDrawerContent(),
            ),
          Expanded(
            child: SafeArea(
              child: _buildContent(_destinations[_selectedIndex]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerContent() {
    return Column(
      children: [
        UserAccountsDrawerHeader(
          accountName: const Text('Jane Doe'),
          accountEmail: const Text('jane.doe@university.edu'),
          currentAccountPicture: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              'JD',
              style: TextStyle(fontSize: 24.0, color: Colors.blue),
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _destinations.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(_destinationIcons[index]),
                title: Text(_destinations[index]),
                selected: _selectedIndex == index,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  if (MediaQuery.of(context).size.width < 800) {
                    Navigator.pop(context); // Close drawer on mobile
                  }
                },
              );
            },
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Logout', style: TextStyle(color: Colors.red)),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logging out...')),
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
