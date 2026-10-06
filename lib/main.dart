import 'package:flutter/material.dart';

void main() {
  runApp(const CMRConnectApp());
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
  static const serviceDetail = '/service-detail';
}

// ============================================================
// CAMPUS SERVICE MODEL
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

// ============================================================
// EVENT MODEL
// ============================================================

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
// SAMPLE SERVICES
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

// ============================================================
// SAMPLE EVENTS
// ============================================================

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
      },

      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.serviceDetail) {
          final service = settings.arguments as CampusService;

          return MaterialPageRoute(
            builder: (_) => ServiceDetailScreen(
              service: service,
            ),
            settings: settings,
          );
        }

        return null;
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => UnknownRouteScreen(
            routeName: settings.name ?? 'Unknown',
          ),
        );
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
                    ?.withOpacity(0.65),
              ),
            ),
          ],
        ],
      ),
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
      appBar: AppBar(
        title: const Text(
          'CMR Connect',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(
              Icons.notifications_outlined,
            ),
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

              // ==================================================
              // WELCOME CARD
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF173F73),
                      Color(0xFF2C69A6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
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
                        fontSize: 13,
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      'Your campus, your progress, your journey.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ==================================================
              // QUICK STATS
              // ==================================================

              const SectionTitle(
                title: 'Today at CMR',
                subtitle: 'Your quick campus overview',
              ),

              Row(
                children: [
                  Expanded(
                    child: _DashboardStat(
                      icon: Icons.menu_book_outlined,
                      value: '3',
                      label: 'Classes',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _DashboardStat(
                      icon: Icons.event_outlined,
                      value: '2',
                      label: 'Events',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _DashboardStat(
                      icon: Icons.task_alt,
                      value: '4',
                      label: 'Tasks',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ==================================================
              // CAMPUS AREAS
              // ==================================================

              const SectionTitle(
                title: 'Campus Areas',
                subtitle: 'Choose a section to explore',
              ),

              // Responsive grid:
              // Desktop = 4 smaller cards in one row.
              // Mobile = 2 cards per row.
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool isDesktop =
                      constraints.maxWidth >= 900;

                  return GridView.count(
                    crossAxisCount: isDesktop ? 4 : 2,
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,

                    // Larger value = shorter/smaller cards.
                    childAspectRatio:
                    isDesktop ? 1.55 : 1.30,

                    children: [
                      _DashboardCard(
                        icon:
                        Icons.calendar_month_outlined,
                        title: 'Timetable',
                        subtitle: 'View your classes',
                        color:
                        CMRConnectApp.primary,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.timetable,
                          );
                        },
                      ),

                      _DashboardCard(
                        icon: Icons
                            .miscellaneous_services_outlined,
                        title: 'Services',
                        subtitle: 'Campus support',
                        color:
                        CMRConnectApp.accent,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.services,
                          );
                        },
                      ),

                      _DashboardCard(
                        icon:
                        Icons.event_available_outlined,
                        title: 'Events',
                        subtitle: 'Upcoming activities',
                        color:
                        const Color(0xFF7B4B94),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.events,
                          );
                        },
                      ),

                      _DashboardCard(
                        icon: Icons.person_outline,
                        title: 'Profile',
                        subtitle: 'Student information',
                        color:
                        const Color(0xFFE76F51),
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

              // ==================================================
              // SUPPORT CARD
              // ==================================================

              const SectionTitle(
                title: 'Need Help?',
                subtitle:
                'Submit a campus service request',
              ),

              Card(
                elevation: 0,
                child: ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: CircleAvatar(
                    backgroundColor:
                    CMRConnectApp.accent
                        .withOpacity(0.15),
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

              // ==================================================
              // FOOTER
              // ==================================================

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
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// DASHBOARD STAT CARD
// ============================================================

class _DashboardStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _DashboardStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 6,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: CMRConnectApp.primary,
              size: 21,
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
// SMALL DASHBOARD CARD
// ============================================================

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
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
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 2),

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
// TIMETABLE SCREEN
// ============================================================

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final classes = [
      [
        'Monday',
        '10:00 AM - 11:00 AM',
        'Machine Learning',
        'A-204'
      ],
      [
        'Tuesday',
        '12:00 PM - 1:00 PM',
        'Cloud Computing',
        'B-105'
      ],
      [
        'Wednesday',
        '11:00 AM - 12:00 PM',
        'Data Science',
        'C-301'
      ],
      [
        'Thursday',
        '9:00 AM - 10:00 AM',
        'Software Engineering',
        'A-105'
      ],
      [
        'Friday',
        '10:00 AM - 11:00 AM',
        'Project Work',
        'Innovation Lab'
      ],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: classes.length,
        separatorBuilder: (_, __) =>
        const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = classes[index];

          return Card(
            elevation: 0,
            child: ListTile(
              contentPadding:
              const EdgeInsets.all(14),
              leading: CircleAvatar(
                backgroundColor:
                CMRConnectApp.primary
                    .withOpacity(0.12),
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
              subtitle: Padding(
                padding:
                const EdgeInsets.only(top: 5),
                child: Text(
                  '${item[0]} • ${item[1]}\nRoom: ${item[3]}',
                ),
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
// SERVICES SCREEN
// ============================================================

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  Future<void> openService(
      BuildContext context,
      CampusService service,
      ) async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.serviceDetail,
      arguments: service,
    );

    if (!context.mounted) return;

    if (result == 'requested') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${service.name} request recorded successfully.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Services'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: campusServices.length,
        separatorBuilder: (_, __) =>
        const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final service = campusServices[index];

          return Card(
            elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                openService(context, service);
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundColor:
                      service.color
                          .withOpacity(0.12),
                      child: Icon(
                        service.icon,
                        color: service.color,
                        size: 26,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service.location,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service.description,
                            maxLines: 2,
                            overflow:
                            TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// SERVICE DETAIL SCREEN
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
      appBar: AppBar(
        title: const Text('Service Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 43,
                backgroundColor:
                service.color.withOpacity(0.12),
                child: Icon(
                  service.icon,
                  color: service.color,
                  size: 42,
                ),
              ),
            ),

            const SizedBox(height: 18),

            Center(
              child: Text(
                service.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'About this service',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              service.description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 22),

            _InfoTile(
              icon: Icons.location_on_outlined,
              title: 'Location',
              value: service.location,
            ),

            _InfoTile(
              icon: Icons.access_time,
              title: 'Opening Hours',
              value: service.openingHours,
            ),

            _InfoTile(
              icon: Icons.email_outlined,
              title: 'Contact',
              value: service.contact,
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(
                    context,
                    'requested',
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text(
                  'Request This Service',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
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

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
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
        leading: Icon(
          icon,
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
// EVENTS SCREEN
// ============================================================

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  Future<void> openEvent(
      BuildContext context,
      CampusEvent event,
      ) async {
    // Direct MaterialPageRoute required by the assignment.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventDetailScreen(
          event: event,
        ),
      ),
    );

    if (!context.mounted) return;

    if (result == 'registered') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You are registered for ${event.title}.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Events'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: campusEvents.length,
        separatorBuilder: (_, __) =>
        const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final event = campusEvents[index];

          return Card(
            elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                openEvent(context, event);
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 60,
                      decoration: BoxDecoration(
                        color: CMRConnectApp.primary
                            .withOpacity(0.1),
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.event,
                        color: CMRConnectApp.primary,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            event.date,
                            style: const TextStyle(
                              color:
                              CMRConnectApp.accent,
                              fontWeight:
                              FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${event.time} • ${event.venue}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// EVENT DETAIL SCREEN
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
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    CMRConnectApp.primary,
                    Color(0xFF2C69A6),
                  ],
                ),
                borderRadius:
                BorderRadius.circular(18),
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

            _InfoTile(
              icon: Icons.calendar_today,
              title: 'Date',
              value: event.date,
            ),

            _InfoTile(
              icon: Icons.access_time,
              title: 'Time',
              value: event.time,
            ),

            _InfoTile(
              icon: Icons.location_on_outlined,
              title: 'Venue',
              value: event.venue,
            ),

            const SizedBox(height: 12),

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
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(
                    context,
                    'registered',
                  );
                },
                icon: const Icon(
                  Icons.check_circle_outline,
                ),
                label: const Text(
                  'Register for Event',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE SCREEN
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
      appBar: AppBar(
        title: const Text('Student Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor:
              CMRConnectApp.primary,
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
                  subtitle:
                  Text('aisha.khan@cmr.edu.in'),
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
  // GlobalKey connects the form to FormState.
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

  String _savedCategory = '';
  String _savedUrgency = '';

  @override
  void initState() {
    super.initState();

    _detailsController.addListener(() {
      setState(() {});
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
    final today = DateTime.now();

    final selected = await showDatePicker(
      context: context,
      initialDate: today,
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
  // SUBMIT
  // ==========================================================

  void _submitForm() {
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

    // Save all validated form values.
    _formKey.currentState!.save();

    FocusScope.of(context).unfocus();

    final reference =
        'CMR-${DateTime.now().millisecondsSinceEpoch % 1000000}';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: CMRConnectApp.accent,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text('Request Submitted'),
              ),
            ],
          ),
          content: Text(
            'Your campus support request has been submitted successfully.\n\n'
                'Reference: $reference\n\n'
                'Category: $_savedCategory\n'
                'Urgency: $_savedUrgency',
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
                _resetForm();
              },
              child: const Text('New Request'),
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
    });

    FocusScope.of(context).unfocus();
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
            ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                // ==================================================
                // FORM INTRO
                // ==================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: CMRConnectApp.primary
                        .withOpacity(0.08),
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

                const SectionTitle(
                  title: 'Student Information',
                ),

                // ==================================================
                // NAME
                // ==================================================

                TextFormField(
                  controller: _nameController,
                  textInputAction:
                  TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Student Name',
                    hintText:
                    'Enter your full name',
                    prefixIcon:
                    Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return 'Please enter your full name';
                    }

                    if (text.split(' ').length < 2) {
                      return 'Enter at least your first and last name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 13),

                // ==================================================
                // STUDENT ID
                // ==================================================

                TextFormField(
                  controller: _studentIdController,
                  textInputAction:
                  TextInputAction.next,
                  textCapitalization:
                  TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: 'Student ID',
                    hintText: 'Example: 23CSE027',
                    prefixIcon:
                    Icon(Icons.badge_outlined),
                  ),
                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return 'Please enter your student ID';
                    }

                    if (text.length < 6 ||
                        text.length > 15) {
                      return 'Student ID must be 6–15 characters';
                    }

                    if (!RegExp(
                      r'^[A-Za-z0-9-]+$',
                    ).hasMatch(text)) {
                      return 'Use letters, numbers or hyphens only';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 13),

                // ==================================================
                // EMAIL
                // ==================================================

                TextFormField(
                  controller: _emailController,
                  textInputAction:
                  TextInputAction.next,
                  keyboardType:
                  TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Campus Email',
                    hintText:
                    'name@campus.edu',
                    prefixIcon:
                    Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return 'Please enter your campus email';
                    }

                    final emailRegex = RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    );

                    if (!emailRegex.hasMatch(text)) {
                      return 'Enter a valid email address';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 13),

                // ==================================================
                // PHONE
                // ==================================================

                TextFormField(
                  controller: _phoneController,
                  textInputAction:
                  TextInputAction.next,
                  keyboardType:
                  TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText:
                    'Phone Number (Optional)',
                    hintText:
                    '+60 12 345 6789',
                    prefixIcon:
                    Icon(Icons.phone_outlined),
                  ),
                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return null;
                    }

                    final digits =
                    text.replaceAll(
                      RegExp(r'[\s()+-]'),
                      '',
                    );

                    if (!RegExp(
                      r'^\d{7,15}$',
                    ).hasMatch(digits)) {
                      return 'Enter a valid phone number';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 25),

                const SectionTitle(
                  title: 'Request Details',
                ),

                // ==================================================
                // CATEGORY
                // ==================================================

                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText:
                    'Service Category',
                    prefixIcon:
                    Icon(Icons.category_outlined),
                  ),
                  items: const [
                    'Academic Support',
                    'Accommodation',
                    'IT Help Desk',
                    'Library Services',
                    'Student Wellness',
                    'Other Campus Service',
                  ].map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please select a service category';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _savedCategory = value ?? '';
                  },
                ),

                const SizedBox(height: 13),

                // ==================================================
                // SUBJECT
                // ==================================================

                TextFormField(
                  controller: _subjectController,
                  textInputAction:
                  TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText:
                    'Request Subject',
                    hintText:
                    'Briefly describe your request',
                    prefixIcon:
                    Icon(Icons.subject_outlined),
                  ),
                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return 'Please enter a subject';
                    }

                    if (text.length < 5) {
                      return 'Subject should be at least 5 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 13),

                // ==================================================
                // DETAILS
                // ==================================================

                TextFormField(
                  controller: _detailsController,
                  keyboardType:
                  TextInputType.multiline,
                  textInputAction:
                  TextInputAction.newline,
                  minLines: 5,
                  maxLines: 8,
                  maxLength: 500,
                  decoration: const InputDecoration(
                    labelText:
                    'Request Details',
                    hintText:
                    'Explain your request clearly...',
                    alignLabelWithHint: true,
                    prefixIcon: Padding(
                      padding:
                      EdgeInsets.only(bottom: 70),
                      child: Icon(
                        Icons.description_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    final text =
                        value?.trim() ?? '';

                    if (text.isEmpty) {
                      return 'Please describe your request';
                    }

                    if (text.length < 20) {
                      return 'Details should contain at least 20 characters';
                    }

                    if (text.length > 500) {
                      return 'Details cannot exceed 500 characters';
                    }

                    return null;
                  },
                ),

                Align(
                  alignment:
                  Alignment.centerRight,
                  child: Text(
                    '$detailsLength / 500 characters',
                    style: const TextStyle(
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
                    if (_selectedUrgency == null) {
                      return 'Please select an urgency level';
                    }

                    return null;
                  },
                  onSaved: (_) {
                    _savedUrgency =
                        _selectedUrgency ?? '';
                  },
                  builder: (field) {
                    return Column(
                      children: [
                        RadioListTile<String>(
                          contentPadding:
                          EdgeInsets.zero,
                          title:
                          const Text('Low'),
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
                            field.didChange(value);
                          },
                        ),

                        RadioListTile<String>(
                          contentPadding:
                          EdgeInsets.zero,
                          title:
                          const Text('Medium'),
                          subtitle:
                          const Text(
                            'Needed within a few days',
                          ),
                          value: 'Medium',
                          groupValue:
                          _selectedUrgency,
                          onChanged: (value) {
                            setState(() {
                              _selectedUrgency =
                                  value;
                            });
                            field.didChange(value);
                          },
                        ),

                        RadioListTile<String>(
                          contentPadding:
                          EdgeInsets.zero,
                          title:
                          const Text('High'),
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
                            field.didChange(value);
                          },
                        ),

                        if (field.hasError)
                          Align(
                            alignment:
                            Alignment.centerLeft,
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Theme.of(
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
                ),

                FormField<String>(
                  validator: (_) {
                    if (_selectedContact == null) {
                      return 'Please select a contact method';
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
                          const Text('Email'),
                          value: 'Email',
                          groupValue:
                          _selectedContact,
                          onChanged: (value) {
                            setState(() {
                              _selectedContact =
                                  value;
                            });
                            field.didChange(value);
                          },
                        ),

                        RadioListTile<String>(
                          contentPadding:
                          EdgeInsets.zero,
                          title:
                          const Text('Phone'),
                          value: 'Phone',
                          groupValue:
                          _selectedContact,
                          onChanged: (value) {
                            setState(() {
                              _selectedContact =
                                  value;
                            });
                            field.didChange(value);
                          },
                        ),

                        RadioListTile<String>(
                          contentPadding:
                          EdgeInsets.zero,
                          title: const Text(
                            'Student Portal',
                          ),
                          value: 'Student Portal',
                          groupValue:
                          _selectedContact,
                          onChanged: (value) {
                            setState(() {
                              _selectedContact =
                                  value;
                            });
                            field.didChange(value);
                          },
                        ),

                        if (field.hasError)
                          Align(
                            alignment:
                            Alignment.centerLeft,
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Theme.of(
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
                    if (_preferredDate == null) {
                      return 'Please choose a preferred date';
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
                      BorderRadius.circular(14),
                      child: InputDecorator(
                        decoration:
                        InputDecoration(
                          labelText:
                          'Preferred Date',
                          prefixIcon:
                          const Icon(
                            Icons.calendar_today,
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
                      return 'Please accept the declaration';
                    }

                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                          contentPadding:
                          EdgeInsets.zero,
                          value:
                          field.value ?? false,
                          onChanged: (value) {
                            field.didChange(value);
                          },
                          controlAffinity:
                          ListTileControlAffinity
                              .leading,
                          title: const Text(
                            'I confirm that the information provided is accurate and complete.',
                          ),
                        ),

                        if (field.hasError)
                          Padding(
                            padding:
                            const EdgeInsets.only(
                              left: 16,
                            ),
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Theme.of(
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
                // SUBMIT
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.send),
                    label: const Text(
                      'Submit Request',
                      style: TextStyle(
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
                  child: OutlinedButton.icon(
                    onPressed: _resetForm,
                    icon: const Icon(
                      Icons.refresh,
                    ),
                    label:
                    const Text('Reset Form'),
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
// UNKNOWN ROUTE
// ============================================================

class UnknownRouteScreen extends StatelessWidget {
  final String routeName;

  const UnknownRouteScreen({
    super.key,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text('Page Not Found'),
      ),
      body: Center(
        child: Padding(
          padding:
          const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 75,
                color: Colors.orange,
              ),

              const SizedBox(height: 18),

              const Text(
                'Oops! Page not found',
                textAlign:
                TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'The route "$routeName" could not be opened.',
                textAlign:
                TextAlign.center,
              ),

              const SizedBox(height: 22),

              FilledButton.icon(
                onPressed: () {
                  Navigator
                      .pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.home,
                        (route) => false,
                  );
                },
                icon:
                const Icon(Icons.home),
                label: const Text(
                  'Back to Dashboard',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}