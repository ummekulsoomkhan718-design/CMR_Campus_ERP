import 'package:flutter/material.dart';

void main() {
  runApp(const CMRStudentHub());
}

class CMRStudentHub extends StatelessWidget {
  const CMRStudentHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CMR Student Hub',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF123B72),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF123B72),
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: false,
        ),

        cardTheme: CardThemeData(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      ),

      home: const StudentHomePage(),
    );
  }
}

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int currentIndex = 0;

  int reminderCount = 0;

  String searchQuery = '';

  String selectedCategory = 'All';

  final Set<String> registeredEvents = {};
  final Set<String> favouriteEvents = {};

  // ------------------------------------------------------------
  // EVENT DATA
  // ------------------------------------------------------------

  final List<Map<String, dynamic>> events = [
    {
      'title': 'Coding Workshop',
      'date': '25 September',
      'time': '10:00 AM',
      'location': 'Innovation Lab',
      'category': 'Academic',
      'icon': Icons.code,
      'description':
      'Learn practical programming concepts and problem-solving techniques.',
    },
    {
      'title': 'Career Development Talk',
      'date': '28 September',
      'time': '2:00 PM',
      'location': 'Seminar Hall',
      'category': 'Career',
      'icon': Icons.business_center,
      'description':
      'Learn about career preparation, interviews and industry opportunities.',
    },
    {
      'title': 'Inter College Sports Meet',
      'date': '29 September',
      'time': '4:00 PM',
      'location': 'Sports Ground',
      'category': 'Sports',
      'icon': Icons.sports_soccer,
      'description':
      'A student sports event featuring multiple college teams.',
    },
    {
      'title': 'Cultural Night',
      'date': '2 October',
      'time': '6:00 PM',
      'location': 'Main Auditorium',
      'category': 'Cultural',
      'icon': Icons.music_note,
      'description':
      'An evening celebrating student talent, music, dance and culture.',
    },
    {
      'title': 'Entrepreneurship Meetup',
      'date': '5 October',
      'time': '11:00 AM',
      'location': 'Innovation Centre',
      'category': 'Career',
      'icon': Icons.lightbulb,
      'description':
      'Explore startup ideas, innovation and entrepreneurship.',
    },
  ];

  // ------------------------------------------------------------
  // HOME PAGE
  // ------------------------------------------------------------

  Widget buildHomePage() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 700));

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dashboard refreshed successfully'),
          ),
        );
      },

      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),

        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // LOGO
            Center(
              child: Image.asset(
                'assets/images/img.png',
                height: 75,
              ),
            ),

            const SizedBox(height: 12),

            // WELCOME
            const Text(
              'Good Morning, Student 👋',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF123B72),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Welcome back to your CMR Student Hub.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            // STUDENT DASHBOARD CARD
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF123B72),
                    Color(0xFF245A9A),
                  ],
                ),

                borderRadius: BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Row(
                children: [

                  const CircleAvatar(
                    radius: 32,

                    backgroundColor: Colors.white,

                    child: Icon(
                      Icons.school,
                      size: 34,
                      color: Color(0xFF123B72),
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          'CMR University',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
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

                        SizedBox(height: 4),

                        Text(
                          'Student Dashboard',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // QUICK STATISTICS
            Row(
              children: [

                Expanded(
                  child: statisticCard(
                    Icons.event,
                    '${events.length}',
                    'Events',
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: statisticCard(
                    Icons.star,
                    '${favouriteEvents.length}',
                    'Favourites',
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: statisticCard(
                    Icons.alarm,
                    '$reminderCount',
                    'Reminders',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // QUICK ACCESS
            sectionTitle('Quick Access'),

            const SizedBox(height: 12),

            Row(
              children: [

                Expanded(
                  child: serviceCard(
                    Icons.library_books,
                    'Library',
                    'Books & resources',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: serviceCard(
                    Icons.calendar_month,
                    'Timetable',
                    'Class schedule',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [

                Expanded(
                  child: serviceCard(
                    Icons.location_on,
                    'Campus Map',
                    'Find locations',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: serviceCard(
                    Icons.groups,
                    'Clubs',
                    'Student clubs',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ANNOUNCEMENT
            sectionTitle('Campus Announcement'),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Container(
                      padding: const EdgeInsets.all(11),

                      decoration: BoxDecoration(
                        color: const Color(0xFFE8EEF7),
                        borderRadius:
                        BorderRadius.circular(12),
                      ),

                      child: const Icon(
                        Icons.campaign,
                        color: Color(0xFF123B72),
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(
                            'Academic Update',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'Check your upcoming academic activities, events and important campus updates.',
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // UPCOMING ACTIVITIES
            sectionTitle('Upcoming Activities'),

            const SizedBox(height: 12),

            ...events.take(3).map(
                  (event) => activityCard(event),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // STATISTIC CARD
  // ------------------------------------------------------------

  Widget statisticCard(
      IconData icon,
      String value,
      String label,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 8,
        ),

        child: Column(
          children: [

            Icon(
              icon,
              color: const Color(0xFF123B72),
              size: 25,
            ),

            const SizedBox(height: 7),

            Text(
              value,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // SECTION TITLE
  // ------------------------------------------------------------

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ------------------------------------------------------------
  // SERVICE CARD
  // ------------------------------------------------------------

  Widget serviceCard(
      IconData icon,
      String title,
      String subtitle,
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),

      onTap: () {
        showServiceDialog(title);
      },

      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(17),

          child: Column(
            children: [

              Container(
                padding: const EdgeInsets.all(11),

                decoration: BoxDecoration(
                  color: const Color(0xFFE8EEF7),
                  borderRadius:
                  BorderRadius.circular(12),
                ),

                child: Icon(
                  icon,
                  size: 30,
                  color: const Color(0xFF123B72),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // SERVICE DIALOG
  // ------------------------------------------------------------

  void showServiceDialog(String service) {
    String message;

    switch (service) {
      case 'Library':
        message =
        'Library services include books, study resources and academic materials.';
        break;

      case 'Timetable':
        message =
        'Your class timetable and upcoming academic schedule can be accessed here.';
        break;

      case 'Campus Map':
        message =
        'Campus Map helps students locate classrooms, labs, halls and facilities.';
        break;

      case 'Clubs':
        message =
        'Explore student clubs, societies and extracurricular activities.';
        break;

      default:
        message = 'Campus service selected.';
    }

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text(service),

          content: Text(message),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // ACTIVITY CARD
  // ------------------------------------------------------------

  Widget activityCard(
      Map<String, dynamic> event,
      ) {
    final String title = event['title'];
    final bool isRegistered =
    registeredEvents.contains(title);

    final bool isFavourite =
    favouriteEvents.contains(title);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: Padding(
        padding: const EdgeInsets.all(14),

        child: Column(
          children: [

            Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                CircleAvatar(
                  radius: 25,

                  backgroundColor:
                  const Color(0xFFE8EEF7),

                  child: Icon(
                    event['icon'],
                    color: const Color(0xFF123B72),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        '${event['date']} • ${event['time']}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Row(
                        children: [

                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey,
                          ),

                          const SizedBox(width: 3),

                          Expanded(
                            child: Text(
                              event['location'],
                              style:
                              const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                IconButton(
                  tooltip: 'Favourite',

                  icon: Icon(
                    isFavourite
                        ? Icons.star
                        : Icons.star_border,

                    color: isFavourite
                        ? Colors.orange
                        : Colors.grey,
                  ),

                  onPressed: () {
                    setState(() {
                      if (isFavourite) {
                        favouriteEvents.remove(title);
                      } else {
                        favouriteEvents.add(title);
                      }
                    });

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        duration:
                        const Duration(seconds: 1),

                        content: Text(
                          isFavourite
                              ? '$title removed from favourites'
                              : '$title added to favourites',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              event['description'],
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [

                Expanded(
                  child: OutlinedButton.icon(
                    icon: Icon(
                      isRegistered
                          ? Icons.check
                          : Icons.event_available,
                    ),

                    label: Text(
                      isRegistered
                          ? 'Registered'
                          : 'Register',
                    ),

                    onPressed: () {
                      setState(() {
                        if (isRegistered) {
                          registeredEvents.remove(title);
                        } else {
                          registeredEvents.add(title);
                        }
                      });

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            isRegistered
                                ? 'Registration cancelled'
                                : 'Successfully registered for $title',
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF123B72),
                      foregroundColor: Colors.white,
                    ),

                    onPressed: () {
                      showEventDetails(event);
                    },

                    child: const Text('Details'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // EVENT DETAILS
  // ------------------------------------------------------------

  void showEventDetails(
      Map<String, dynamic> event,
      ) {
    showModalBottomSheet(
      context: context,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),

      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Row(
                children: [

                  CircleAvatar(
                    radius: 25,

                    backgroundColor:
                    const Color(0xFFE8EEF7),

                    child: Icon(
                      event['icon'],
                      color: const Color(0xFF123B72),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      event['title'],
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ListTile(
                leading:
                const Icon(Icons.calendar_month),

                title: const Text('Date & Time'),

                subtitle: Text(
                  '${event['date']} • ${event['time']}',
                ),
              ),

              ListTile(
                leading:
                const Icon(Icons.location_on),

                title: const Text('Location'),

                subtitle: Text(
                  event['location'],
                ),
              ),

              ListTile(
                leading: const Icon(Icons.category),

                title: const Text('Category'),

                subtitle: Text(
                  event['category'],
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // ACTIVITIES PAGE
  // ------------------------------------------------------------

  Widget buildActivitiesPage() {
    final filteredEvents = events.where((event) {

      final matchesSearch =
      event['title']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      final matchesCategory =
          selectedCategory == 'All' ||
              event['category'] == selectedCategory;

      return matchesSearch && matchesCategory;

    }).toList();

    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(
            16,
            18,
            16,
            8,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const Text(
                'Campus Activities',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF123B72),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Discover events and activities happening around CMR University.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 15),

              // SEARCH
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },

                decoration: InputDecoration(
                  hintText: 'Search activities...',

                  prefixIcon:
                  const Icon(Icons.search),

                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                    icon:
                    const Icon(Icons.clear),

                    onPressed: () {
                      setState(() {
                        searchQuery = '';
                      });
                    },
                  )
                      : null,

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(15),

                    borderSide:
                    BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // CATEGORY FILTER
              SizedBox(
                height: 42,

                child: ListView(
                  scrollDirection:
                  Axis.horizontal,

                  children: [
                    categoryChip('All'),
                    categoryChip('Academic'),
                    categoryChip('Career'),
                    categoryChip('Sports'),
                    categoryChip('Cultural'),
                  ],
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: filteredEvents.isEmpty
              ? const Center(
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                Icon(
                  Icons.search_off,
                  size: 55,
                  color: Colors.grey,
                ),

                SizedBox(height: 10),

                Text(
                  'No activities found',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Try another search or category.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )

              : ListView.builder(
            padding:
            const EdgeInsets.fromLTRB(
              16,
              5,
              16,
              100,
            ),

            itemCount:
            filteredEvents.length,

            itemBuilder:
                (context, index) {
              return activityCard(
                filteredEvents[index],
              );
            },
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // CATEGORY CHIP
  // ------------------------------------------------------------

  Widget categoryChip(String category) {
    final bool selected =
        selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
      ),

      child: ChoiceChip(
        label: Text(category),

        selected: selected,

        selectedColor:
        const Color(0xFF123B72),

        labelStyle: TextStyle(
          color: selected
              ? Colors.white
              : Colors.black,
        ),

        onSelected: (_) {
          setState(() {
            selectedCategory = category;
          });
        },
      ),
    );
  }

  // ------------------------------------------------------------
  // PROFILE PAGE
  // ------------------------------------------------------------

  Widget buildProfilePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [

          const SizedBox(height: 15),

          const CircleAvatar(
            radius: 58,

            backgroundColor:
            Color(0xFF123B72),

            child: Icon(
              Icons.person,
              size: 65,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'CMR Student',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'B.Tech Computer Science & Engineering',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Column(
              children: [

                profileTile(
                  Icons.person,
                  'Student Name',
                  'Your Name',
                ),

                profileTile(
                  Icons.badge,
                  'Student ID',
                  'CMRU-CSE-001',
                ),

                profileTile(
                  Icons.school,
                  'Programme',
                  'B.Tech Computer Science & Engineering',
                ),

                profileTile(
                  Icons.email,
                  'Email',
                  'student@cmr.edu.in',
                ),

                profileTile(
                  Icons.location_city,
                  'University',
                  'CMR University, Bengaluru',
                ),

                profileTile(
                  Icons.calendar_month,
                  'Academic Year',
                  '2026 - 2027',
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // PROFILE ACTION BUTTON
          SizedBox(
            width: double.infinity,

            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit),

              label: const Text(
                'Edit Profile',
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF123B72),

                foregroundColor: Colors.white,

                padding:
                const EdgeInsets.symmetric(
                  vertical: 14,
                ),
              ),

              onPressed: () {
                showEditProfileDialog();
              },
            ),
          ),

          const SizedBox(height: 20),

          // STUDENT ACTIVITY SUMMARY
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Text(
                    'My Campus Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,

                    children: [

                      summaryItem(
                        Icons.event_available,
                        '${registeredEvents.length}',
                        'Registered',
                      ),

                      summaryItem(
                        Icons.star,
                        '${favouriteEvents.length}',
                        'Favourites',
                      ),

                      summaryItem(
                        Icons.alarm,
                        '$reminderCount',
                        'Reminders',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // PROFILE TILE
  // ------------------------------------------------------------

  Widget profileTile(
      IconData icon,
      String title,
      String subtitle,
      ) {
    return Column(
      children: [

        ListTile(
          leading: CircleAvatar(
            backgroundColor:
            const Color(0xFFE8EEF7),

            child: Icon(
              icon,
              color: const Color(0xFF123B72),
            ),
          ),

          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          subtitle: Text(subtitle),
        ),

        const Divider(
          height: 1,
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // SUMMARY ITEM
  // ------------------------------------------------------------

  Widget summaryItem(
      IconData icon,
      String value,
      String label,
      ) {
    return Column(
      children: [

        Icon(
          icon,
          color: const Color(0xFF123B72),
        ),

        const SizedBox(height: 5),

        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // EDIT PROFILE
  // ------------------------------------------------------------

  void showEditProfileDialog() {
    final nameController =
    TextEditingController(
      text: 'Your Name',
    );

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Edit Profile',
          ),

          content: TextField(
            controller: nameController,

            decoration:
            const InputDecoration(
              labelText: 'Student Name',
              border: OutlineInputBorder(),
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Profile updated successfully',
                    ),
                  ),
                );
              },

              child: const Text(
                'Save',
              ),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // DRAWER
  // ------------------------------------------------------------

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,

        children: [

          // DRAWER HEADER
          Container(
            height: 220,

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF123B72),
                  Color(0xFF245A9A),
                ],
              ),
            ),

            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Image.asset(
                      'assets/images/img.png',
                      height: 55,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'CMR Student Hub',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'B.Tech CSE Student',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                    const Text(
                      'Student Portal',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          drawerItem(
            Icons.home,
            'Home',
            0,
          ),

          drawerItem(
            Icons.event,
            'Campus Activities',
            1,
          ),

          drawerItem(
            Icons.person,
            'My Profile',
            2,
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.book,
              color: Color(0xFF123B72),
            ),

            title: const Text(
              'My Courses',
            ),

            subtitle: const Text(
              'View enrolled subjects',
            ),

            onTap: () {
              Navigator.pop(context);
              showCoursesDialog();
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.location_on,
              color: Color(0xFF123B72),
            ),

            title: const Text(
              'Campus Map',
            ),

            subtitle: const Text(
              'Find campus facilities',
            ),

            onTap: () {
              Navigator.pop(context);
              showCampusMapDialog();
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.notifications,
              color: Color(0xFF123B72),
            ),

            title: const Text(
              'Notifications',
            ),

            onTap: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    'You have no new notifications',
                  ),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Color(0xFF123B72),
            ),

            title: const Text(
              'Settings',
            ),

            onTap: () {
              Navigator.pop(context);
              showSettingsDialog();
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.help,
              color: Color(0xFF123B72),
            ),

            title: const Text(
              'Help Centre',
            ),

            onTap: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    'Help Centre opened',
                  ),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.info_outline,
            ),

            title: const Text(
              'About CMR Student Hub',
            ),

            onTap: () {
              Navigator.pop(context);
              showAboutDialog();
            },
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // DRAWER ITEM
  // ------------------------------------------------------------

  Widget drawerItem(
      IconData icon,
      String title,
      int index,
      ) {
    final bool selected =
        currentIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: selected
            ? const Color(0xFF123B72)
            : Colors.grey,
      ),

      title: Text(
        title,
        style: TextStyle(
          fontWeight: selected
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),

      selected: selected,

      selectedTileColor:
      const Color(0xFFE8EEF7),

      onTap: () {
        setState(() {
          currentIndex = index;
        });

        Navigator.pop(context);
      },
    );
  }

  // ------------------------------------------------------------
  // COURSES DIALOG
  // ------------------------------------------------------------

  void showCoursesDialog() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'My Courses',
          ),

          content: const Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              ListTile(
                leading: Icon(
                  Icons.computer,
                ),
                title: Text(
                  'Computer Science',
                ),
              ),

              ListTile(
                leading: Icon(
                  Icons.storage,
                ),
                title: Text(
                  'Database Management',
                ),
              ),

              ListTile(
                leading: Icon(
                  Icons.cloud,
                ),
                title: Text(
                  'Cloud Computing',
                ),
              ),

              ListTile(
                leading: Icon(
                  Icons.security,
                ),
                title: Text(
                  'Cyber Security',
                ),
              ),
            ],
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // CAMPUS MAP
  // ------------------------------------------------------------

  void showCampusMapDialog() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Campus Map',
          ),

          content: const Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              ListTile(
                leading: Icon(
                  Icons.school,
                  color: Color(0xFF123B72),
                ),
                title: Text(
                  'Main Academic Block',
                ),
              ),

              ListTile(
                leading: Icon(
                  Icons.local_library,
                  color: Color(0xFF123B72),
                ),
                title: Text(
                  'Central Library',
                ),
              ),

              ListTile(
                leading: Icon(
                  Icons.sports_soccer,
                  color: Color(0xFF123B72),
                ),
                title: Text(
                  'Sports Ground',
                ),
              ),

              ListTile(
                leading: Icon(
                  Icons.restaurant,
                  color: Color(0xFF123B72),
                ),
                title: Text(
                  'Cafeteria',
                ),
              ),
            ],
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // SETTINGS
  // ------------------------------------------------------------

  void showSettingsDialog() {
    bool notificationsEnabled = true;

    showDialog(
      context: context,

      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Settings',
              ),

              content: Column(
                mainAxisSize: MainAxisSize.min,

                children: [

                  SwitchListTile(
                    title: const Text(
                      'Notifications',
                    ),

                    subtitle: const Text(
                      'Receive campus updates',
                    ),

                    value: notificationsEnabled,

                    onChanged: (value) {
                      setDialogState(() {
                        notificationsEnabled =
                            value;
                      });
                    },
                  ),

                  const ListTile(
                    leading: Icon(
                      Icons.language,
                    ),

                    title: Text(
                      'Language',
                    ),

                    subtitle: Text(
                      'English',
                    ),
                  ),
                ],
              ),

              actions: [

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: const Text(
                    'Done',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ------------------------------------------------------------
  // ABOUT
  // ------------------------------------------------------------

  void showAboutDialog() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'CMR Student Hub',
          ),

          content: const Text(
            'A student-focused mobile application designed to provide quick access to campus information, activities, services and student resources.',
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // MAIN SCREEN
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      buildHomePage(),
      buildActivitiesPage(),
      buildProfilePage(),
    ];

    return Scaffold(

      // APP BAR
      appBar: AppBar(

        title: const Text(
          'CMR Student Hub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          IconButton(
            tooltip: 'Notifications',

            icon: const Icon(
              Icons.notifications_outlined,
            ),

            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    'No new notifications',
                  ),
                ),
              );
            },
          ),

          IconButton(
            tooltip: 'Search Activities',

            icon: const Icon(
              Icons.search,
            ),

            onPressed: () {
              setState(() {
                currentIndex = 1;
              });
            },
          ),
        ],
      ),

      // DRAWER
      drawer: buildDrawer(),

      // BODY
      body: pages[currentIndex],

      // FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton.extended(

        backgroundColor:
        const Color(0xFF123B72),

        foregroundColor: Colors.white,

        tooltip: 'Add Reminder',

        icon: const Icon(
          Icons.add_alert,
        ),

        label: Text(
          reminderCount == 0
              ? 'Reminder'
              : '$reminderCount Reminder${reminderCount > 1 ? 's' : ''}',
        ),

        onPressed: () {

          setState(() {
            reminderCount++;
          });

          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(
                'Reminder created successfully! Total reminders: $reminderCount',
              ),

              duration:
              const Duration(seconds: 2),
            ),
          );
        },
      ),

// BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        selectedItemColor: const Color(0xFF123B72),

        unselectedItemColor: Colors.grey,

        backgroundColor: Colors.white,

        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            activeIcon: Icon(Icons.event),
            label: 'Activities',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}