import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const CMRConnectApp());
  } catch (e) {
    runApp(FirebaseErrorApp(error: e.toString()));
  }
}

// ============================================================
// FIREBASE ERROR APP
// ============================================================

class FirebaseErrorApp extends StatelessWidget {
  final String error;

  const FirebaseErrorApp({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_off,
                  size: 70,
                  color: Colors.red,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Firebase Initialization Failed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Make sure you have run flutterfire configure.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                SelectableText(
                  error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// ROUTES
// ============================================================

class AppRoutes {
  static const home = '/';
  static const timetable = '/timetable';
  static const services = '/services';
  static const events = '/events';
  static const profile = '/profile';
  static const supportForm = '/support-form';
  static const requests = '/requests';
}

// ============================================================
// MODELS
// ============================================================

class CampusService {
  final String name;
  final String description;
  final String location;
  final String openingHours;
  final String contact;
  final IconData icon;
  final Color color;

  const CampusService({
    required this.name,
    required this.description,
    required this.location,
    required this.openingHours,
    required this.contact,
    required this.icon,
    required this.color,
  });
}

class CampusEvent {
  final String title;
  final String date;
  final String time;
  final String venue;
  final String description;

  const CampusEvent({
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
    required this.description,
  });
}

// ============================================================
// SAMPLE DATA
// ============================================================

const List<CampusService> campusServices = [
  CampusService(
    name: 'Accommodation Office',
    description:
    'Get help with hostel applications, room allocation, maintenance requests and accommodation enquiries.',
    location: 'Student Centre, Level 2',
    openingHours: '8:30 AM - 5:00 PM',
    contact: 'accommodation@cmr.edu.in',
    icon: Icons.home_work_outlined,
    color: Color(0xFF173F73),
  ),
  CampusService(
    name: 'Academic Support',
    description:
    'Receive academic guidance, course registration assistance and academic planning support.',
    location: 'Academic Block, Room 204',
    openingHours: '9:00 AM - 4:30 PM',
    contact: 'academics@cmr.edu.in',
    icon: Icons.school_outlined,
    color: Color(0xFF00A896),
  ),
  CampusService(
    name: 'IT Help Desk',
    description:
    'Get assistance with Wi-Fi, student portals, computer labs, passwords and technical issues.',
    location: 'Digital Learning Centre',
    openingHours: '8:00 AM - 6:00 PM',
    contact: 'ithelp@cmr.edu.in',
    icon: Icons.computer_outlined,
    color: Color(0xFF7B4B94),
  ),
  CampusService(
    name: 'Student Wellness',
    description:
    'Access student wellbeing resources, counselling information and general support services.',
    location: 'Wellness Centre',
    openingHours: '9:00 AM - 5:00 PM',
    contact: 'wellness@cmr.edu.in',
    icon: Icons.favorite_outline,
    color: Color(0xFFE76F51),
  ),
  CampusService(
    name: 'Library Services',
    description:
    'Find information about books, digital resources, borrowing and study spaces.',
    location: 'Central Library',
    openingHours: '8:00 AM - 8:00 PM',
    contact: 'library@cmr.edu.in',
    icon: Icons.local_library_outlined,
    color: Color(0xFF3A7D44),
  ),
];

const List<CampusEvent> campusEvents = [
  CampusEvent(
    title: 'Tech Innovation Meetup',
    date: '10 October 2026',
    time: '2:00 PM - 4:00 PM',
    venue: 'Innovation Lab',
    description:
    'A student meetup focused on emerging technologies, projects and innovation opportunities.',
  ),
  CampusEvent(
    title: 'Cultural Evening',
    date: '15 October 2026',
    time: '5:30 PM - 8:00 PM',
    venue: 'Main Auditorium',
    description:
    'An evening celebrating student talent through music, dance and cultural activities.',
  ),
  CampusEvent(
    title: 'Career Preparation Workshop',
    date: '22 October 2026',
    time: '10:00 AM - 1:00 PM',
    venue: 'Seminar Hall',
    description:
    'Learn resume building, interview preparation and practical placement strategies.',
  ),
];

// ============================================================
// MAIN APP
// ============================================================

class CMRConnectApp extends StatefulWidget {
  const CMRConnectApp({super.key});

  static const Color primary = Color(0xFF173F73);
  static const Color accent = Color(0xFF00A896);

  @override
  State<CMRConnectApp> createState() => _CMRConnectAppState();
}

class _CMRConnectAppState extends State<CMRConnectApp> {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme(bool value) {
    setState(() {
      themeMode = value ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CMR Connect',
      initialRoute: AppRoutes.home,
      themeMode: themeMode,

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: CMRConnectApp.primary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: CMRConnectApp.primary,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
            borderSide: BorderSide(
              color: CMRConnectApp.accent,
              width: 2,
            ),
          ),
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CMRConnectApp.primary,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF102B4C),
          foregroundColor: Colors.white,
        ),
      ),

      routes: {
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.timetable: (_) => const TimetableScreen(),
        AppRoutes.services: (_) => const ServicesScreen(),
        AppRoutes.events: (_) => const EventsScreen(),
        AppRoutes.profile: (_) => ProfileScreen(
          isDarkMode: themeMode == ThemeMode.dark,
          onThemeChanged: toggleTheme,
        ),
        AppRoutes.supportForm: (_) => const SupportFormScreen(),
        AppRoutes.requests: (_) => const RequestsScreen(),
      },
    );
  }
}

// ============================================================
// SECTION TITLE
// ============================================================

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withOpacity(.65),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ============================================================
// APP NAVIGATION DRAWER
// ============================================================

class CMRConnectDrawer extends StatelessWidget {
  const CMRConnectDrawer({super.key});

  void _navigate(BuildContext context, String route) {
    final navigator = Navigator.of(context);
    navigator.pop();
    navigator.pushNamedAndRemoveUntil(
      route,
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
              color: CMRConnectApp.primary,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.school,
                      color: CMRConnectApp.primary,
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'CMR Connect',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Your campus, all in one place',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerItem(
                    icon: Icons.home_outlined,
                    title: 'Home',
                    onTap: () => _navigate(context, AppRoutes.home),
                  ),
                  _DrawerItem(
                    icon: Icons.calendar_month_outlined,
                    title: 'Timetable',
                    onTap: () => _navigate(context, AppRoutes.timetable),
                  ),
                  _DrawerItem(
                    icon: Icons.miscellaneous_services_outlined,
                    title: 'Campus Services',
                    onTap: () => _navigate(context, AppRoutes.services),
                  ),
                  _DrawerItem(
                    icon: Icons.event_outlined,
                    title: 'Campus Events',
                    onTap: () => _navigate(context, AppRoutes.events),
                  ),
                  const Divider(indent: 16, endIndent: 16),
                  _DrawerItem(
                    icon: Icons.add_task_outlined,
                    title: 'Create Support Request',
                    onTap: () => _navigate(context, AppRoutes.supportForm),
                  ),
                  _DrawerItem(
                    icon: Icons.receipt_long_outlined,
                    title: 'My Requests',
                    onTap: () => _navigate(context, AppRoutes.requests),
                  ),
                  _DrawerItem(
                    icon: Icons.person_outline,
                    title: 'Student Profile',
                    onTap: () => _navigate(context, AppRoutes.profile),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CMRConnectDrawer(),
      appBar: AppBar(
        title: const Text(
          'CMR Connect',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'You have 2 new campus notifications.',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF173F73),
                      Color(0xFF2C69A6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 29,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 34,
                        color: CMRConnectApp.primary,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Good Morning, Aisha 👋',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'B.Tech Computer Science & Engineering',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Your campus, your progress, your journey.',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              const SectionTitle(
                title: 'Today at CMR',
                subtitle: 'Your quick campus overview',
              ),

              Row(
                children: const [
                  Expanded(
                    child: DashboardStat(
                      icon: Icons.menu_book_outlined,
                      value: '3',
                      label: 'Classes',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DashboardStat(
                      icon: Icons.event_outlined,
                      value: '2',
                      label: 'Events',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DashboardStat(
                      icon: Icons.task_alt,
                      value: '4',
                      label: 'Tasks',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const SectionTitle(
                title: 'Campus Areas',
                subtitle: 'Choose a section to explore',
              ),

              LayoutBuilder(
                builder: (context, constraints) {
                  final desktop = constraints.maxWidth >= 900;

                  return GridView.count(
                    crossAxisCount: desktop ? 4 : 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: desktop ? 1.55 : 1.3,
                    children: [
                      DashboardCard(
                        icon: Icons.calendar_month_outlined,
                        title: 'Timetable',
                        subtitle: 'View your classes',
                        color: CMRConnectApp.primary,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.timetable,
                          );
                        },
                      ),
                      DashboardCard(
                        icon: Icons.miscellaneous_services_outlined,
                        title: 'Services',
                        subtitle: 'Campus support',
                        color: CMRConnectApp.accent,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.services,
                          );
                        },
                      ),
                      DashboardCard(
                        icon: Icons.event_available_outlined,
                        title: 'Events',
                        subtitle: 'Upcoming activities',
                        color: const Color(0xFF7B4B94),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.events,
                          );
                        },
                      ),
                      DashboardCard(
                        icon: Icons.person_outline,
                        title: 'Profile',
                        subtitle: 'Student information',
                        color: const Color(0xFFE76F51),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.profile,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              const SectionTitle(
                title: 'Need Help?',
                subtitle: 'Submit a campus service request',
              ),

              Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                    CMRConnectApp.accent.withOpacity(.15),
                    child: const Icon(
                      Icons.support_agent,
                      color: CMRConnectApp.accent,
                    ),
                  ),
                  title: const Text(
                    'Create Support Request',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    'Report an issue or request campus assistance.',
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.supportForm,
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: CMRConnectApp.primary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'CMR Connect',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Your campus, your progress, your journey.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// DASHBOARD STAT
// ============================================================

class DashboardStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const DashboardStat({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Column(
          children: [
            Icon(
              icon,
              color: CMRConnectApp.primary,
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DASHBOARD CARD
// ============================================================

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color.withOpacity(.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// TIMETABLE
// ============================================================

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final classes = [
      ['Monday', '10:00 AM - 11:00 AM', 'Machine Learning', 'A-204'],
      ['Tuesday', '12:00 PM - 1:00 PM', 'Cloud Computing', 'B-105'],
      ['Wednesday', '11:00 AM - 12:00 PM', 'Data Science', 'C-301'],
      ['Thursday', '9:00 AM - 10:00 AM', 'Software Engineering', 'A-105'],
      ['Friday', '10:00 AM - 11:00 AM', 'Project Work', 'Innovation Lab'],
    ];

    return Scaffold(
      drawer: const CMRConnectDrawer(),
      appBar: AppBar(
        title: const Text('Timetable'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: classes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = classes[index];

          return Card(
            elevation: 0,
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: CircleAvatar(
                backgroundColor:
                CMRConnectApp.primary.withOpacity(.12),
                child: const Icon(
                  Icons.schedule,
                  color: CMRConnectApp.primary,
                ),
              ),
              title: Text(
                item[2],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${item[0]} • ${item[1]}\nRoom: ${item[3]}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// SERVICES
// ============================================================

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CMRConnectDrawer(),
      appBar: AppBar(
        title: const Text('Campus Services'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: campusServices.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final service = campusServices[index];

          return Card(
            elevation: 0,
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: CircleAvatar(
                radius: 27,
                backgroundColor: service.color.withOpacity(.12),
                child: Icon(
                  service.icon,
                  color: service.color,
                ),
              ),
              title: Text(
                service.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${service.location}\n${service.description}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
              isThreeLine: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ServiceDetailScreen(
                      service: service,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// SERVICE DETAIL
// ============================================================

class ServiceDetailScreen extends StatelessWidget {
  final CampusService service;

  const ServiceDetailScreen({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CMRConnectDrawer(),
      appBar: AppBar(
        title: const Text('Service Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: service.color.withOpacity(.12),
              child: Icon(
                service.icon,
                color: service.color,
                size: 45,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              service.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              service.description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            InfoTile(
              icon: Icons.location_on_outlined,
              title: 'Location',
              value: service.location,
            ),
            InfoTile(
              icon: Icons.access_time,
              title: 'Opening Hours',
              value: service.openingHours,
            ),
            InfoTile(
              icon: Icons.email_outlined,
              title: 'Contact',
              value: service.contact,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// EVENTS
// ============================================================

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CMRConnectDrawer(),
      appBar: AppBar(
        title: const Text('Campus Events'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: campusEvents.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final event = campusEvents[index];

          return Card(
            elevation: 0,
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: Container(
                width: 55,
                height: 60,
                decoration: BoxDecoration(
                  color: CMRConnectApp.primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.event,
                  color: CMRConnectApp.primary,
                ),
              ),
              title: Text(
                event.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${event.date}\n${event.time} • ${event.venue}',
              ),
              isThreeLine: true,
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EventDetailScreen(
                      event: event,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// EVENT DETAIL
// ============================================================

class EventDetailScreen extends StatelessWidget {
  final CampusEvent event;

  const EventDetailScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CMRConnectDrawer(),
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    CMRConnectApp.primary,
                    Color(0xFF2C69A6),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.event_available,
                color: Colors.white,
                size: 65,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            InfoTile(
              icon: Icons.calendar_today,
              title: 'Date',
              value: event.date,
            ),
            InfoTile(
              icon: Icons.access_time,
              title: 'Time',
              value: event.time,
            ),
            InfoTile(
              icon: Icons.location_on_outlined,
              title: 'Venue',
              value: event.venue,
            ),
            const SizedBox(height: 15),
            const Text(
              'About the Event',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              event.description,
              style: const TextStyle(
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// INFO TILE
// ============================================================

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(
          Icons.info_outline,
          color: CMRConnectApp.primary,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(value),
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfileScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CMRConnectDrawer(),
      appBar: AppBar(
        title: const Text('Student Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: CMRConnectApp.primary,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 52,
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Center(
            child: Text(
              'Aisha Khan',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text(
              'B.Tech Computer Science & Engineering',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 22),

          Card(
            elevation: 0,
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(
                    Icons.badge_outlined,
                    color: CMRConnectApp.primary,
                  ),
                  title: Text('Student ID'),
                  subtitle: Text('23CSE027'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    color: CMRConnectApp.primary,
                  ),
                  title: Text('Campus Email'),
                  subtitle: Text('aisha.khan@cmr.edu.in'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(
                    Icons.school_outlined,
                    color: CMRConnectApp.primary,
                  ),
                  title: Text('Programme'),
                  subtitle: Text('B.Tech CSE'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Card(
            elevation: 0,
            child: SwitchListTile(
              title: const Text(
                'Dark Mode',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Change the app appearance',
              ),
              secondary: const Icon(
                Icons.dark_mode_outlined,
              ),
              value: isDarkMode,
              onChanged: onThemeChanged,
            ),
          ),

          const SizedBox(height: 10),

          Card(
            elevation: 0,
            child: ListTile(
              leading: const Icon(
                Icons.support_agent,
                color: CMRConnectApp.accent,
              ),
              title: const Text(
                'Campus Support',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Submit a new service request',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.supportForm,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SUPPORT FORM
// ============================================================

class SupportFormScreen extends StatefulWidget {
  const SupportFormScreen({super.key});

  @override
  State<SupportFormScreen> createState() =>
      _SupportFormScreenState();
}

class _SupportFormScreenState
    extends State<SupportFormScreen> {
  final GlobalKey<FormState> _formKey =
  GlobalKey<FormState>();

  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _studentIdController =
  TextEditingController();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _phoneController =
  TextEditingController();

  final TextEditingController _subjectController =
  TextEditingController();

  final TextEditingController _detailsController =
  TextEditingController();

  String? _selectedCategory;
  String? _selectedUrgency;
  String? _selectedContact;
  DateTime? _preferredDate;

  bool _declaration = false;
  bool _isSubmitting = false;

  String? _requestId;

  final List<String> categories = [
    'Academic Support',
    'Accommodation',
    'IT Help Desk',
    'Library Services',
    'Student Wellness',
    'Other Campus Service',
  ];

  @override
  void initState() {
    super.initState();

    _detailsController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  // ==========================================================
  // DATE PICKER
  // ==========================================================

  Future<void> _selectDate() async {
    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final selected = await showDatePicker(
      context: context,
      initialDate: _preferredDate ?? today,
      firstDate: today,
      lastDate: DateTime(
        today.year + 1,
        today.month,
        today.day,
      ),
      helpText: 'Select preferred support date',
    );

    if (selected != null) {
      setState(() {
        _preferredDate = selected;
      });
    }
  }

  // ==========================================================
  // SUBMIT TO FIRESTORE
  // ==========================================================

  Future<void> _submitForm() async {
    if (_isSubmitting) return;

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please correct the highlighted fields.',
          ),
        ),
      );
      return;
    }

    if (_preferredDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a preferred date.',
          ),
        ),
      );
      return;
    }

    if (!_declaration) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please accept the declaration.',
          ),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Anonymous Firebase Authentication.
      final auth = FirebaseAuth.instance;

      User? user = auth.currentUser;

      if (user == null) {
        final credential =
        await auth.signInAnonymously();

        user = credential.user;
      }

      if (user == null) {
        throw Exception(
          'Firebase anonymous authentication failed.',
        );
      }

      // Create a Firestore document.
      final document = FirebaseFirestore.instance
          .collection('campusRequests')
          .doc();

      final requestData = {
        'ownerUid': user.uid,
        'studentName':
        _nameController.text.trim(),
        'studentId':
        _studentIdController.text.trim(),
        'email':
        _emailController.text.trim(),
        'phone':
        _phoneController.text.trim(),
        'serviceCategory':
        _selectedCategory,
        'subject':
        _subjectController.text.trim(),
        'description':
        _detailsController.text.trim(),
        'urgency':
        _selectedUrgency,
        'preferredContact':
        _selectedContact,
        'preferredDate':
        Timestamp.fromDate(_preferredDate!),
        'declaration':
        _declaration,
        'status':
        'submitted',
        'createdAt':
        FieldValue.serverTimestamp(),
      };

      await document.set(requestData);

      if (!mounted) return;

      setState(() {
        _requestId = document.id;
      });

      // Read the same document back from Firestore.
      final snapshot = await document.get(
        const GetOptions(
          source: Source.server,
        ),
      );

      if (!mounted) return;

      if (snapshot.exists) {
        await _showSuccessDialog(
          document.id,
          snapshot.data()!,
        );
      } else {
        throw Exception(
          'Request saved but could not be verified.',
        );
      }
    } on FirebaseException catch (e) {
      if (!mounted) return;

      String message;

      if (e.code == 'permission-denied') {
        message =
        'Permission denied. Check Firebase Authentication and Firestore rules.';
      } else if (e.code ==
          'network-request-failed') {
        message =
        'Network error. Please check your internet connection.';
      } else {
        message =
        'Firebase error: ${e.code}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Submission failed: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  // ==========================================================
  // SUCCESS DIALOG
  // ==========================================================

  Future<void> _showSuccessDialog(
      String requestId,
      Map<String, dynamic> data,
      ) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.verified,
                color: CMRConnectApp.accent,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Request Submitted',
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your campus support request has been successfully saved to Firebase Firestore.',
                ),
                const SizedBox(height: 18),

                SummaryLine(
                  label: 'Reference ID',
                  value: requestId,
                ),

                SummaryLine(
                  label: 'Category',
                  value:
                  data['serviceCategory']
                      ?.toString() ??
                      '',
                ),

                SummaryLine(
                  label: 'Subject',
                  value:
                  data['subject']
                      ?.toString() ??
                      '',
                ),

                SummaryLine(
                  label: 'Urgency',
                  value:
                  data['urgency']
                      ?.toString() ??
                      '',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        RequestSummaryScreen(
                          requestId: requestId,
                        ),
                  ),
                );
              },
              child: const Text(
                'View Saved Request',
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // RESET
  // ==========================================================

  void _resetForm() {
    if (_isSubmitting) return;

    _formKey.currentState?.reset();

    _nameController.clear();
    _studentIdController.clear();
    _emailController.clear();
    _phoneController.clear();
    _subjectController.clear();
    _detailsController.clear();

    setState(() {
      _selectedCategory = null;
      _selectedUrgency = null;
      _selectedContact = null;
      _preferredDate = null;
      _declaration = false;
      _requestId = null;
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Choose a preferred date';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  // ==========================================================
  // FORM UI
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final detailsLength =
        _detailsController.text.length;

    return Scaffold(
      drawer: const CMRConnectDrawer(),
      appBar: AppBar(
        title: const Text(
          'Campus Support Request',
        ),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,

          autovalidateMode:
          AutovalidateMode.onUserInteraction,

          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),

            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior
                .onDrag,

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                // ==================================================
                // INTRO
                // ==================================================

                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.all(17),

                  decoration: BoxDecoration(
                    color: CMRConnectApp.primary
                        .withOpacity(.08),

                    borderRadius:
                    BorderRadius.circular(17),
                  ),

                  child: const Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [
                      Icon(
                        Icons.support_agent,
                        color:
                        CMRConnectApp.primary,
                        size: 31,
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Request Campus Assistance',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              'Complete the form below and our campus team will review your request.',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 23),

                // ==================================================
                // STUDENT INFORMATION
                // ==================================================

                const SectionTitle(
                  title: 'Student Information',
                ),

                // NAME

                TextFormField(
                  controller:
                  _nameController,

                  textInputAction:
                  TextInputAction.next,

                  keyboardType:
                  TextInputType.name,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Student Name',
                    hintText:
                    'Enter your full name',
                    prefixIcon:
                    Icon(
                      Icons.person_outline,
                    ),
                  ),

                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return
                        'Please enter your full name';
                    }

                    if (text.split(
                      RegExp(r'\s+'),
                    ).length <
                        2) {
                      return
                        'Enter your first and last name';
                    }

                    if (text.length > 100) {
                      return
                        'Name is too long';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 13),

                // STUDENT ID

                TextFormField(
                  controller:
                  _studentIdController,

                  textInputAction:
                  TextInputAction.next,

                  textCapitalization:
                  TextCapitalization.characters,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Student ID',
                    hintText:
                    'Example: 23CSE027',
                    prefixIcon:
                    Icon(
                      Icons.badge_outlined,
                    ),
                  ),

                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return
                        'Please enter your student ID';
                    }

                    if (text.length < 6 ||
                        text.length > 15) {
                      return
                        'Student ID must be 6–15 characters';
                    }

                    if (!RegExp(
                      r'^[A-Za-z0-9-]+$',
                    ).hasMatch(text)) {
                      return
                        'Use letters, numbers or hyphens only';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 13),

                // EMAIL

                TextFormField(
                  controller:
                  _emailController,

                  textInputAction:
                  TextInputAction.next,

                  keyboardType:
                  TextInputType.emailAddress,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Campus Email',
                    hintText:
                    'name@campus.edu',
                    prefixIcon:
                    Icon(
                      Icons.email_outlined,
                    ),
                  ),

                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return
                        'Please enter your email';
                    }

                    final regex = RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    );

                    if (!regex.hasMatch(text)) {
                      return
                        'Enter a valid email address';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 13),

                // PHONE

                TextFormField(
                  controller:
                  _phoneController,

                  textInputAction:
                  TextInputAction.next,

                  keyboardType:
                  TextInputType.phone,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Phone Number (Optional)',
                    hintText:
                    '+60 12 345 6789',
                    prefixIcon:
                    Icon(
                      Icons.phone_outlined,
                    ),
                  ),

                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return null;
                    }

                    final digits =
                    text.replaceAll(
                      RegExp(
                        r'[\s()+-]',
                      ),
                      '',
                    );

                    if (!RegExp(
                      r'^\d{7,15}$',
                    ).hasMatch(digits)) {
                      return
                        'Enter a valid phone number';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 25),

                // ==================================================
                // REQUEST DETAILS
                // ==================================================

                const SectionTitle(
                  title: 'Request Details',
                ),

                // CATEGORY

                DropdownButtonFormField<
                    String>(
                  value:
                  _selectedCategory,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Service Category',
                    prefixIcon:
                    Icon(
                      Icons.category_outlined,
                    ),
                  ),

                  items:
                  categories.map(
                        (category) {
                      return DropdownMenuItem<
                          String>(
                        value: category,
                        child:
                        Text(category),
                      );
                    },
                  ).toList(),

                  onChanged: (value) {
                    setState(() {
                      _selectedCategory =
                          value;
                    });
                  },

                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return
                        'Please select a service category';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 13),

                // SUBJECT

                TextFormField(
                  controller:
                  _subjectController,

                  textInputAction:
                  TextInputAction.next,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Request Subject',
                    hintText:
                    'Briefly describe your request',
                    prefixIcon:
                    Icon(
                      Icons.subject_outlined,
                    ),
                  ),

                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return
                        'Please enter a subject';
                    }

                    if (text.length < 5) {
                      return
                        'Subject should be at least 5 characters';
                    }

                    if (text.length > 100) {
                      return
                        'Subject is too long';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 13),

                // DETAILS

                TextFormField(
                  controller:
                  _detailsController,

                  keyboardType:
                  TextInputType.multiline,

                  minLines: 5,
                  maxLines: 8,
                  maxLength: 500,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Request Details',
                    hintText:
                    'Explain your request clearly...',
                    alignLabelWithHint:
                    true,

                    prefixIcon: Padding(
                      padding:
                      EdgeInsets.only(
                        bottom: 70,
                      ),
                      child: Icon(
                        Icons
                            .description_outlined,
                      ),
                    ),
                  ),

                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return
                        'Please describe your request';
                    }

                    if (text.length < 20) {
                      return
                        'Details should contain at least 20 characters';
                    }

                    if (text.length > 500) {
                      return
                        'Details cannot exceed 500 characters';
                    }

                    return null;
                  },
                ),

                Align(
                  alignment:
                  Alignment.centerRight,

                  child: Text(
                    '$detailsLength / 500 characters',
                    style:
                    const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 23),

                // ==================================================
                // URGENCY
                // ==================================================

                const SectionTitle(
                  title: 'Urgency',
                  subtitle:
                  'How quickly do you need assistance?',
                ),

                FormField<String>(
                  validator: (_) {
                    if (_selectedUrgency ==
                        null) {
                      return
                        'Please select an urgency level';
                    }

                    return null;
                  },

                  builder: (field) {
                    return Column(
                      children: [
                        RadioListTile<String>(
                          contentPadding:
                          EdgeInsets.zero,

                          title:
                          const Text(
                            'Low',
                          ),

                          subtitle:
                          const Text(
                            'Can be handled within a week',
                          ),

                          value: 'Low',

                          groupValue:
                          _selectedUrgency,

                          onChanged: (value) {
                            setState(() {
                              _selectedUrgency =
                                  value;
                            });

                            field.didChange(
                              value,
                            );
                          },
                        ),

                        RadioListTile<String>(
                          contentPadding:
                          EdgeInsets.zero,

                          title:
                          const Text(
                            'Normal',
                          ),

                          subtitle:
                          const Text(
                            'Needed within a few days',
                          ),

                          value: 'Normal',

                          groupValue:
                          _selectedUrgency,

                          onChanged: (value) {
                            setState(() {
                              _selectedUrgency =
                                  value;
                            });

                            field.didChange(
                              value,
                            );
                          },
                        ),

                        RadioListTile<String>(
                          contentPadding:
                          EdgeInsets.zero,

                          title:
                          const Text(
                            'High',
                          ),

                          subtitle:
                          const Text(
                            'Requires prompt attention',
                          ),

                          value: 'High',

                          groupValue:
                          _selectedUrgency,

                          onChanged: (value) {
                            setState(() {
                              _selectedUrgency =
                                  value;
                            });

                            field.didChange(
                              value,
                            );
                          },
                        ),

                        if (field.hasError)
                          Align(
                            alignment:
                            Alignment
                                .centerLeft,

                            child: Text(
                              field.errorText!,
                              style:
                              TextStyle(
                                color:
                                Theme.of(
                                  context,
                                )
                                    .colorScheme
                                    .error,

                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                // ==================================================
                // CONTACT
                // ==================================================

                const SectionTitle(
                  title:
                  'Preferred Contact',
                  subtitle:
                  'How should the campus team contact you?',
                ),

                FormField<String>(
                  validator: (_) {
                    if (_selectedContact ==
                        null) {
                      return
                        'Please select a contact method';
                    }

                    if (_selectedContact ==
                        'Phone' &&
                        _phoneController
                            .text
                            .trim()
                            .isEmpty) {
                      return
                        'Phone contact requires a phone number';
                    }

                    return null;
                  },

                  builder: (field) {
                    return Column(
                      children: [
                        RadioListTile<String>(
                          contentPadding:
                          EdgeInsets.zero,

                          title:
                          const Text(
                            'Email',
                          ),

                          value: 'Email',

                          groupValue:
                          _selectedContact,

                          onChanged: (value) {
                            setState(() {
                              _selectedContact =
                                  value;
                            });

                            field.didChange(
                              value,
                            );
                          },
                        ),

                        RadioListTile<String>(
                          contentPadding:
                          EdgeInsets.zero,

                          title:
                          const Text(
                            'Phone',
                          ),

                          value: 'Phone',

                          groupValue:
                          _selectedContact,

                          onChanged: (value) {
                            setState(() {
                              _selectedContact =
                                  value;
                            });

                            field.didChange(
                              value,
                            );
                          },
                        ),

                        if (field.hasError)
                          Align(
                            alignment:
                            Alignment
                                .centerLeft,

                            child: Text(
                              field.errorText!,
                              style:
                              TextStyle(
                                color:
                                Theme.of(
                                  context,
                                )
                                    .colorScheme
                                    .error,

                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                // ==================================================
                // DATE
                // ==================================================

                const SectionTitle(
                  title:
                  'Preferred Date',
                  subtitle:
                  'Choose today or a future date',
                ),

                FormField<DateTime>(
                  validator: (_) {
                    if (_preferredDate ==
                        null) {
                      return
                        'Please choose a preferred date';
                    }

                    return null;
                  },

                  builder: (field) {
                    return InkWell(
                      onTap: () async {
                        await _selectDate();

                        field.didChange(
                          _preferredDate,
                        );
                      },

                      borderRadius:
                      BorderRadius.circular(
                        14,
                      ),

                      child: InputDecorator(
                        decoration:
                        InputDecoration(
                          labelText:
                          'Preferred Date',

                          prefixIcon:
                          const Icon(
                            Icons
                                .calendar_today,
                          ),

                          errorText:
                          field.errorText,
                        ),

                        child: Text(
                          _formatDate(
                            _preferredDate,
                          ),

                          style: TextStyle(
                            color:
                            _preferredDate ==
                                null
                                ? Colors.grey
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // ==================================================
                // DECLARATION
                // ==================================================

                FormField<bool>(
                  initialValue: false,

                  validator: (value) {
                    if (value != true) {
                      return
                        'Please accept the declaration';
                    }

                    return null;
                  },

                  builder: (field) {
                    return Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [
                        CheckboxListTile(
                          contentPadding:
                          EdgeInsets.zero,

                          value:
                          field.value ??
                              false,

                          onChanged: (value) {
                            field.didChange(
                              value,
                            );

                            setState(() {
                              _declaration =
                                  value ??
                                      false;
                            });
                          },

                          controlAffinity:
                          ListTileControlAffinity
                              .leading,

                          title:
                          const Text(
                            'I confirm that the information provided is accurate and complete.',
                          ),
                        ),

                        if (field.hasError)
                          Padding(
                            padding:
                            const EdgeInsets
                                .only(
                              left: 16,
                            ),

                            child: Text(
                              field.errorText!,
                              style:
                              TextStyle(
                                color:
                                Theme.of(
                                  context,
                                )
                                    .colorScheme
                                    .error,

                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 22),

                // ==================================================
                // FIREBASE STATUS
                // ==================================================

                if (_isSubmitting)
                  const Card(
                    elevation: 0,
                    child: ListTile(
                      leading:
                      SizedBox(
                        width: 24,
                        height: 24,
                        child:
                        CircularProgressIndicator(
                          strokeWidth: 2.5,
                        ),
                      ),
                      title: Text(
                        'Saving request...',
                        style:
                        TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Uploading your request to Firebase Firestore.',
                      ),
                    ),
                  ),

                if (_requestId != null &&
                    !_isSubmitting)
                  Card(
                    elevation: 0,
                    color: CMRConnectApp.accent
                        .withOpacity(.10),

                    child: ListTile(
                      leading:
                      const Icon(
                        Icons.verified,
                        color:
                        CMRConnectApp.accent,
                      ),

                      title:
                      const Text(
                        'Request saved successfully',
                        style:
                        TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        'Reference: $_requestId',
                      ),

                      trailing:
                      IconButton(
                        icon:
                        const Icon(
                          Icons
                              .visibility_outlined,
                        ),

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  RequestSummaryScreen(
                                    requestId:
                                    _requestId!,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                const SizedBox(height: 10),

                // ==================================================
                // SUBMIT
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child:
                  FilledButton.icon(
                    onPressed:
                    _isSubmitting || _requestId != null
                        ? null
                        : _submitForm,

                    icon: Icon(
                      _isSubmitting
                          ? Icons.cloud_upload
                          : Icons.send,
                    ),

                    label: Text(
                      _isSubmitting
                          ? 'Saving...'
                          : _requestId != null
                          ? 'Request Saved • Reset to Submit Another'
                          : 'Submit Request',

                      style:
                      const TextStyle(
                        fontSize: 15,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ==================================================
                // RESET
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child:
                  OutlinedButton.icon(
                    onPressed:
                    _isSubmitting
                        ? null
                        : _resetForm,

                    icon:
                    const Icon(
                      Icons.refresh,
                    ),

                    label:
                    const Text(
                      'Reset Form',
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                const Center(
                  child: Text(
                    'Your information is used only for campus support.',
                    textAlign:
                    TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// MY REQUESTS: LIST ALL SAVED REQUESTS FOR THIS USER
// ============================================================

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _ensureSignedIn();
  }

  Future<User> _ensureSignedIn() async {
    final auth = FirebaseAuth.instance;
    final existingUser = auth.currentUser;
    if (existingUser != null) return existingUser;

    final credential = await auth.signInAnonymously();
    final user = credential.user;
    if (user == null) {
      throw Exception('Could not establish a Firebase user session.');
    }
    return user;
  }

  DateTime _createdAt(Map<String, dynamic> data) {
    final value = data['createdAt'];
    if (value is Timestamp) return value.toDate();
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  String _dateLabel(Map<String, dynamic> data) {
    final date = _createdAt(data);
    if (date.millisecondsSinceEpoch == 0) return 'Just submitted';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CMRConnectDrawer(),
      appBar: AppBar(
        title: const Text('My Requests'),
      ),
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (userSnapshot.hasError || !userSnapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off, size: 54),
                    const SizedBox(height: 12),
                    const Text(
                      'Could not connect to your requests.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () {
                        setState(() => _userFuture = _ensureSignedIn());
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final user = userSnapshot.data!;
          final requestsStream = FirebaseFirestore.instance
              .collection('campusRequests')
              .where('ownerUid', isEqualTo: user.uid)
              .snapshots();

          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: requestsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Could not load saved requests. Check your internet connection and Firestore rules.\n\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              final docs = [...?snapshot.data?.docs];
              docs.sort((a, b) =>
                  _createdAt(b.data()).compareTo(_createdAt(a.data())));

              if (docs.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.inbox_outlined, size: 58),
                        const SizedBox(height: 14),
                        const Text(
                          'No saved requests yet',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Submit a campus support form and it will appear here.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            AppRoutes.supportForm,
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text('Create Request'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: docs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final data = doc.data();
                  final subject = data['subject']?.toString() ?? 'Campus request';
                  final category = data['serviceCategory']?.toString() ?? 'Uncategorised';
                  final status = data['status']?.toString() ?? 'submitted';

                  return Card(
                    elevation: 0,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(14),
                      leading: CircleAvatar(
                        backgroundColor: CMRConnectApp.primary.withOpacity(.1),
                        child: const Icon(
                          Icons.receipt_long_outlined,
                          color: CMRConnectApp.primary,
                        ),
                      ),
                      title: Text(
                        subject,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '$category • ${_dateLabel(data)}\nStatus: $status\nReference: ${doc.id}',
                        ),
                      ),
                      isThreeLine: true,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RequestSummaryScreen(requestId: doc.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

// ============================================================
// REQUEST SUMMARY
// ============================================================

class RequestSummaryScreen
    extends StatefulWidget {
  final String requestId;

  const RequestSummaryScreen({
    super.key,
    required this.requestId,
  });

  @override
  State<RequestSummaryScreen>
  createState() =>
      _RequestSummaryScreenState();
}

class _RequestSummaryScreenState
    extends State<RequestSummaryScreen> {
  late Future<
      DocumentSnapshot<Map<String, dynamic>>>
  _requestFuture;

  @override
  void initState() {
    super.initState();

    _requestFuture =
        FirebaseFirestore.instance
            .collection('campusRequests')
            .doc(widget.requestId)
            .get(
          const GetOptions(
            source: Source.server,
          ),
        );
  }

  void _reload() {
    setState(() {
      _requestFuture =
          FirebaseFirestore.instance
              .collection('campusRequests')
              .doc(widget.requestId)
              .get(
            const GetOptions(
              source: Source.server,
            ),
          );
    });
  }

  String formatDate(dynamic value) {
    if (value is Timestamp) {
      final date = value.toDate();

      return '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';
    }

    return 'Not available';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CMRConnectDrawer(),
      appBar: AppBar(
        title:
        const Text('Saved Request'),
      ),

      body: FutureBuilder<
          DocumentSnapshot<
              Map<String, dynamic>>>(
        future: _requestFuture,

        builder:
            (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding:
                const EdgeInsets.all(25),

                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,

                  children: [
                    const Icon(
                      Icons.cloud_off,
                      size: 60,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    const Text(
                      'Unable to retrieve the request.',
                      textAlign:
                      TextAlign.center,

                      style:
                      TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      'Reference: ${widget.requestId}',
                      textAlign:
                      TextAlign.center,
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    FilledButton.icon(
                      onPressed:
                      _reload,

                      icon:
                      const Icon(
                        Icons.refresh,
                      ),

                      label:
                      const Text(
                        'Try Again',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData ||
              !snapshot.data!.exists) {
            return Center(
              child: Text(
                'No request found.',
              ),
            );
          }

          final data =
          snapshot.data!.data()!;

          return ListView(
            padding:
            const EdgeInsets.all(18),

            children: [
              Card(
                elevation: 0,

                color:
                CMRConnectApp.accent
                    .withOpacity(.10),

                child: const ListTile(
                  leading: Icon(
                    Icons.verified,
                    color:
                    CMRConnectApp.accent,
                  ),

                  title: Text(
                    'Firestore Record Retrieved',
                    style:
                    TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    'This information was read back from Firebase.',
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              SummaryLine(
                label: 'Document ID',
                value:
                widget.requestId,
              ),

              SummaryLine(
                label: 'Student Name',
                value:
                data['studentName']
                    ?.toString() ??
                    '',
              ),

              SummaryLine(
                label: 'Student ID',
                value:
                data['studentId']
                    ?.toString() ??
                    '',
              ),

              SummaryLine(
                label: 'Email',
                value:
                data['email']
                    ?.toString() ??
                    '',
              ),

              SummaryLine(
                label: 'Phone',
                value:
                data['phone']
                    ?.toString() ??
                    '',
              ),

              SummaryLine(
                label: 'Category',
                value:
                data['serviceCategory']
                    ?.toString() ??
                    '',
              ),

              SummaryLine(
                label: 'Subject',
                value:
                data['subject']
                    ?.toString() ??
                    '',
              ),

              SummaryLine(
                label: 'Description',
                value:
                data['description']
                    ?.toString() ??
                    '',
              ),

              SummaryLine(
                label: 'Urgency',
                value:
                data['urgency']
                    ?.toString() ??
                    '',
              ),

              SummaryLine(
                label: 'Preferred Contact',
                value:
                data['preferredContact']
                    ?.toString() ??
                    '',
              ),

              SummaryLine(
                label: 'Preferred Date',
                value: formatDate(
                  data['preferredDate'],
                ),
              ),

              SummaryLine(
                label: 'Status',
                value:
                data['status']
                    ?.toString() ??
                    '',
              ),

              SummaryLine(
                label: 'Declaration',
                value:
                data['declaration'] ==
                    true
                    ? 'Confirmed'
                    : 'Not confirmed',
              ),
            ],
          );
        },
      ),
    );
  }
}

// ============================================================
// SUMMARY LINE
// ============================================================

class SummaryLine
    extends StatelessWidget {
  final String label;
  final String value;

  const SummaryLine({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,

      margin:
      const EdgeInsets.only(
        bottom: 10,
      ),

      child: Padding(
        padding:
        const EdgeInsets.all(14),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            Text(
              label,

              style: TextStyle(
                fontSize: 11,
                color:
                Theme.of(context)
                    .colorScheme
                    .primary,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 4,
            ),

            SelectableText(
              value,

              style:
              const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
