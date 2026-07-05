import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Panels',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RoleSelectionScreen(),
        '/student': (context) => const StudentPanelScreen(),
        '/teacher': (context) => const TeacherPanelScreen(),
      },
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Portal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/student'),
              icon: const Icon(Icons.school),
              label: const Text('Student Panel'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/teacher'),
              icon: const Icon(Icons.co_present),
              label: const Text('Teacher Panel'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentPanelScreen extends StatefulWidget {
  const StudentPanelScreen({super.key});

  @override
  State<StudentPanelScreen> createState() => _StudentPanelScreenState();
}

class _StudentPanelScreenState extends State<StudentPanelScreen> {
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
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class TeacherPanelScreen extends StatefulWidget {
  const TeacherPanelScreen({super.key});

  @override
  State<TeacherPanelScreen> createState() => _TeacherPanelScreenState();
}

class _TeacherPanelScreenState extends State<TeacherPanelScreen> {
  int _selectedIndex = 0;

  final List<String> _destinations = [
    'Dashboard',
    'Take Attendance',
    'Upload Result',
    'Upload Assignment',
    'Class Routine',
    'Student List',
    'Notice Upload',
    'Messages',
    'Profile',
  ];

  final List<IconData> _destinationIcons = [
    Icons.dashboard,
    Icons.how_to_reg,
    Icons.upload_file,
    Icons.assignment_add,
    Icons.schedule,
    Icons.people,
    Icons.campaign,
    Icons.message,
    Icons.person,
  ];

  Widget _buildContent(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _destinationIcons[_destinations.indexOf(title)],
            size: 80,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
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
          accountName: const Text('Prof. Smith'),
          accountEmail: const Text('smith@university.edu'),
          currentAccountPicture: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              'PS',
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
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

