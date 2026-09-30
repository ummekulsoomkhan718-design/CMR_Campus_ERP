import 'package:flutter/material.dart';

void main() {
  runApp(const CMRConnectApp());
}

// ============================================================
// APP
// ============================================================

class CMRConnectApp extends StatelessWidget {
  const CMRConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CMR Connect',

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF173F73),
        ),
      ),

      home: const HomePage(),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color primary = Color(0xFF173F73);
  static const Color accent = Color(0xFF00A896);

  // ==========================================================
  // VARIABLES
  // ==========================================================

  bool announcementRead = false;
  int selectedCard = -1;

  // FORM
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController messageController =
  TextEditingController();

  String selectedCategory = 'Academic Support';

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,

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
              showSnackBar(
                'You have 2 new campus notifications',
              );
            },
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              // ==================================================
              // PROFILE HEADER
              // ==================================================

              Container(
                width: double.infinity,
                height: 190,

                margin: const EdgeInsets.only(
                  bottom: 24,
                ),

                padding: const EdgeInsets.all(20),

                alignment: Alignment.centerLeft,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,

                    colors: [
                      Color(0xFF173F73),
                      Color(0xFF2C69A6),
                    ],
                  ),

                  borderRadius:
                  BorderRadius.circular(22),

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: [

                    Row(
                      children: [

                        Container(
                          width: 62,
                          height: 62,

                          alignment:
                          Alignment.center,

                          decoration:
                          BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),

                          child: const Icon(
                            Icons.person,
                            color: primary,
                            size: 36,
                          ),
                        ),

                        const SizedBox(width: 14),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                'Good Morning, Aisha 👋',

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 5),

                              Text(
                                'CMRU-CSE-247',

                                style: TextStyle(
                                  color:
                                  Colors.white70,
                                  fontSize: 13,
                                ),
                              ),

                              SizedBox(height: 3),

                              Text(
                                'B.Tech Computer Science & Engineering',

                                style: TextStyle(
                                  color:
                                  Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 7,
                      ),

                      decoration:
                      BoxDecoration(
                        color:
                        Colors.white.withOpacity(
                          0.16,
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          30,
                        ),

                        border: Border.all(
                          color: Colors.white24,
                        ),
                      ),

                      child: const Text(
                        'SEMESTER 7  •  2026–2027',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // ACADEMIC SNAPSHOT
              // ==================================================

              sectionHeader(
                'Academic Snapshot',
                'Your current academic information',
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(14),

                margin: const EdgeInsets.only(
                  bottom: 24,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(20),

                  border: Border.all(
                    color:
                    const Color(0xFFD9E2EC),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(
                        0.05,
                      ),
                      blurRadius: 8,
                      offset:
                      const Offset(0, 3),
                    ),
                  ],
                ),

                child: LayoutBuilder(
                  builder:
                      (context, constraints) {

                    double cardWidth =
                        (constraints.maxWidth - 10) /
                            2;

                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,

                      children: [

                        SizedBox(
                          width: cardWidth,

                          child: academicCard(
                            '8.60',
                            'CGPA',
                            Icons.grade,
                            const Color(
                              0xFFEAF1FA,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: cardWidth,

                          child: academicCard(
                            '92%',
                            'Attendance',
                            Icons.check_circle,
                            const Color(
                              0xFFE7F7F3,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: cardWidth,

                          child: academicCard(
                            '126',
                            'Credits',
                            Icons.auto_stories,
                            const Color(
                              0xFFFFF1E1,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: cardWidth,

                          child: academicCard(
                            '7',
                            'Semester',
                            Icons.school,
                            const Color(
                              0xFFF0EAF8,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // ==================================================
              // QUICK ACCESS
              // ==================================================

              sectionHeader(
                'Quick Access',
                'Common campus services',
              ),

              const SizedBox(height: 12),

              LayoutBuilder(
                builder:
                    (context, constraints) {

                  double cardWidth =
                      (constraints.maxWidth - 12) /
                          2;

                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,

                    children: [

                      SizedBox(
                        width: cardWidth,
                        child: serviceCard(
                          0,
                          Icons.calendar_month,
                          'Timetable',
                          'Class schedule',
                        ),
                      ),

                      SizedBox(
                        width: cardWidth,
                        child: serviceCard(
                          1,
                          Icons.bar_chart,
                          'Results',
                          'Exam results',
                        ),
                      ),

                      SizedBox(
                        width: cardWidth,
                        child: serviceCard(
                          2,
                          Icons.fact_check,
                          'Attendance',
                          'Track attendance',
                        ),
                      ),

                      SizedBox(
                        width: cardWidth,
                        child: serviceCard(
                          3,
                          Icons.local_library,
                          'Library',
                          'Books & resources',
                        ),
                      ),

                      SizedBox(
                        width: cardWidth,
                        child: serviceCard(
                          4,
                          Icons.account_balance_wallet,
                          'Fees',
                          'Fee details',
                        ),
                      ),

                      SizedBox(
                        width: cardWidth,
                        child: serviceCard(
                          5,
                          Icons.support_agent,
                          'Helpdesk',
                          'Get assistance',
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 26),

              // ==================================================
              // ANNOUNCEMENT
              // ==================================================

              sectionHeader(
                'Campus Announcement',
                'Important reminder',
              ),

              const SizedBox(height: 12),

              GestureDetector(
                onTap: () {

                  setState(() {
                    announcementRead =
                    !announcementRead;
                  });

                  showSnackBar(
                    announcementRead
                        ? 'Announcement marked as read'
                        : 'Announcement marked as unread',
                  );
                },

                child: Container(
                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(18),

                  margin:
                  const EdgeInsets.only(
                    bottom: 26,
                  ),

                  decoration:
                  BoxDecoration(
                    color: announcementRead
                        ? const Color(
                      0xFFEAF1FA,
                    )
                        : const Color(
                      0xFFFFF7E1,
                    ),

                    borderRadius:
                    BorderRadius.circular(
                      18,
                    ),

                    border: Border.all(
                      color: announcementRead
                          ? const Color(
                        0xFFD3E0EE,
                      )
                          : const Color(
                        0xFFF0D58A,
                      ),
                    ),
                  ),

                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Container(
                        width: 48,
                        height: 48,

                        alignment:
                        Alignment.center,

                        decoration:
                        BoxDecoration(
                          color: announcementRead
                              ? const Color(
                            0xFFDDEAF7,
                          )
                              : const Color(
                            0xFFFFE5A5,
                          ),

                          borderRadius:
                          BorderRadius.circular(
                            14,
                          ),
                        ),

                        child: Icon(
                          announcementRead
                              ? Icons.mark_email_read
                              : Icons.campaign,

                          color: primary,
                          size: 25,
                        ),
                      ),

                      const SizedBox(width: 13),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              'Course Registration Reminder',

                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 7),

                            Text(
                              'Complete your elective registration before Friday, 5:00 PM through the student portal.',

                              style: TextStyle(
                                color:
                                Colors.black54,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),

                            SizedBox(height: 9),

                            Text(
                              'Deadline: Friday, 5:00 PM',

                              style: TextStyle(
                                color: primary,
                                fontSize: 11,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),

                        decoration:
                        BoxDecoration(
                          color:
                          const Color(
                            0xFFFFE4A3,
                          ),

                          borderRadius:
                          BorderRadius.circular(
                            20,
                          ),
                        ),

                        child: const Text(
                          'DUE',

                          style: TextStyle(
                            fontSize: 9,
                            fontWeight:
                            FontWeight.bold,
                            color:
                            Color(0xFF765500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ==================================================
              // STUDENT LIFE
              // ==================================================

              sectionHeader(
                'Student Life',
                'Upcoming campus event',
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,

                padding:
                const EdgeInsets.all(16),

                margin:
                const EdgeInsets.only(
                  bottom: 26,
                ),

                decoration:
                BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(
                        0.06,
                      ),

                      blurRadius: 9,

                      offset:
                      const Offset(0, 4),
                    ),
                  ],
                ),

                child: Row(
                  children: [

                    Container(
                      width: 70,
                      height: 78,

                      alignment:
                      Alignment.center,

                      decoration:
                      BoxDecoration(
                        color: primary,

                        borderRadius:
                        BorderRadius.circular(
                          16,
                        ),
                      ),

                      child: const Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,

                        children: [

                          Text(
                            '12',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          Text(
                            'OCT',

                            style: TextStyle(
                              color:
                              Colors.white70,
                              fontSize: 11,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(
                            'Tech & Innovation Day',

                            style: TextStyle(
                              fontSize: 17,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'Student Innovation Club',

                            style: TextStyle(
                              color: accent,
                              fontSize: 12,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 8),

                          Row(
                            children: [

                              Icon(
                                Icons.access_time,
                                size: 14,
                                color:
                                Colors.grey,
                              ),

                              SizedBox(width: 5),

                              Text(
                                '10:00 AM – 3:00 PM',

                                style: TextStyle(
                                  color:
                                  Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4),

                          Row(
                            children: [

                              Icon(
                                Icons.location_on,
                                size: 14,
                                color:
                                Colors.grey,
                              ),

                              SizedBox(width: 5),

                              Text(
                                'Innovation Centre',

                                style: TextStyle(
                                  color:
                                  Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        showSnackBar(
                          'Tech & Innovation Day selected',
                        );
                      },

                      borderRadius:
                      BorderRadius.circular(
                        30,
                      ),

                      child: Container(
                        width: 46,
                        height: 46,

                        alignment:
                        Alignment.center,

                        decoration:
                        const BoxDecoration(
                          color:
                          Color(0xFFE7F7F3),

                          shape:
                          BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.arrow_forward,
                          color: accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // ATTENDANCE
              // ==================================================

              sectionHeader(
                'Attendance Progress',
                'Keep your attendance on track',
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,

                padding:
                const EdgeInsets.all(18),

                margin:
                const EdgeInsets.only(
                  bottom: 26,
                ),

                decoration:
                BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),

                  border: Border.all(
                    color:
                    const Color(0xFFD9E2EC),
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                      children: [

                        const Text(
                          'Overall Attendance',

                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        Container(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),

                          decoration:
                          BoxDecoration(
                            color:
                            const Color(
                              0xFFE7F7F3,
                            ),

                            borderRadius:
                            BorderRadius
                                .circular(
                              20,
                            ),
                          ),

                          child: const Text(
                            '92%',

                            style: TextStyle(
                              color: accent,
                              fontSize: 12,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(
                        20,
                      ),

                      child:
                      const LinearProgressIndicator(
                        value: 0.92,
                        minHeight: 10,

                        backgroundColor:
                        Color(0xFFE5EAF0),

                        color: accent,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'You are above the minimum attendance requirement.',

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // ⭐ NEW FORM WIDGET CUSTOMISATION
              // ==================================================

              sectionHeader(
                'Student Support Form',
                'Send a request or feedback to the campus team',
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,

                padding:
                const EdgeInsets.all(20),

                margin:
                const EdgeInsets.only(
                  bottom: 26,
                ),

                decoration:
                BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(
                    22,
                  ),

                  border: Border.all(
                    color:
                    const Color(0xFFD9E2EC),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(
                        0.06,
                      ),

                      blurRadius: 10,

                      offset:
                      const Offset(0, 4),
                    ),
                  ],
                ),

                // ==================================================
                // FORM WIDGET
                // ==================================================

                child: Form(
                  key: _formKey,

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      // FORM TITLE
                      Row(
                        children: [

                          Container(
                            width: 48,
                            height: 48,

                            alignment:
                            Alignment.center,

                            decoration:
                            BoxDecoration(
                              color:
                              const Color(
                                0xFFE7F7F3,
                              ),

                              borderRadius:
                              BorderRadius.circular(
                                14,
                              ),
                            ),

                            child: const Icon(
                              Icons.edit_note,
                              color: accent,
                              size: 27,
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                Text(
                                  'Contact Campus Support',

                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 17,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 3),

                                Text(
                                  'Fill in the details below',

                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ==================================================
                      // NAME FIELD
                      // ==================================================

                      const Text(
                        'Student Name',

                        style: TextStyle(
                          color: primary,
                          fontSize: 13,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 7),

                      TextFormField(
                        controller: nameController,

                        textInputAction:
                        TextInputAction.next,

                        decoration:
                        InputDecoration(
                          hintText:
                          'Enter your name',

                          prefixIcon:
                          const Icon(
                            Icons.person_outline,
                            color: primary,
                          ),

                          filled: true,

                          fillColor:
                          const Color(
                            0xFFF4F7FB,
                          ),

                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                              14,
                            ),

                            borderSide:
                            BorderSide.none,
                          ),

                          focusedBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                              14,
                            ),

                            borderSide:
                            const BorderSide(
                              color: accent,
                              width: 2,
                            ),
                          ),

                          contentPadding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                        ),

                        validator: (value) {

                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your name';
                          }

                          if (value.trim().length < 3) {
                            return 'Name must contain at least 3 characters';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // ==================================================
                      // EMAIL FIELD
                      // ==================================================

                      const Text(
                        'Student Email',

                        style: TextStyle(
                          color: primary,
                          fontSize: 13,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 7),

                      TextFormField(
                        controller: emailController,

                        keyboardType:
                        TextInputType.emailAddress,

                        textInputAction:
                        TextInputAction.next,

                        decoration:
                        InputDecoration(
                          hintText:
                          'example@cmr.edu.in',

                          prefixIcon:
                          const Icon(
                            Icons.email_outlined,
                            color: primary,
                          ),

                          filled: true,

                          fillColor:
                          const Color(
                            0xFFF4F7FB,
                          ),

                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                              14,
                            ),

                            borderSide:
                            BorderSide.none,
                          ),

                          focusedBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                              14,
                            ),

                            borderSide:
                            const BorderSide(
                              color: accent,
                              width: 2,
                            ),
                          ),

                          contentPadding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                        ),

                        validator: (value) {

                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your email';
                          }

                          if (!value.contains('@') ||
                              !value.contains('.')) {
                            return 'Please enter a valid email';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // ==================================================
                      // CATEGORY DROPDOWN
                      // ==================================================

                      const Text(
                        'Request Category',

                        style: TextStyle(
                          color: primary,
                          fontSize: 13,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 7),

                      DropdownButtonFormField<String>(
                        value: selectedCategory,

                        decoration:
                        InputDecoration(
                          prefixIcon:
                          const Icon(
                            Icons.category_outlined,
                            color: primary,
                          ),

                          filled: true,

                          fillColor:
                          const Color(
                            0xFFF4F7FB,
                          ),

                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                              14,
                            ),

                            borderSide:
                            BorderSide.none,
                          ),

                          focusedBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                              14,
                            ),

                            borderSide:
                            const BorderSide(
                              color: accent,
                              width: 2,
                            ),
                          ),
                        ),

                        items: const [

                          DropdownMenuItem(
                            value:
                            'Academic Support',

                            child: Text(
                              'Academic Support',
                            ),
                          ),

                          DropdownMenuItem(
                            value:
                            'Technical Issue',

                            child: Text(
                              'Technical Issue',
                            ),
                          ),

                          DropdownMenuItem(
                            value:
                            'Library',

                            child: Text(
                              'Library',
                            ),
                          ),

                          DropdownMenuItem(
                            value:
                            'Fees',

                            child: Text(
                              'Fees',
                            ),
                          ),

                          DropdownMenuItem(
                            value:
                            'General Feedback',

                            child: Text(
                              'General Feedback',
                            ),
                          ),
                        ],

                        onChanged: (value) {

                          if (value != null) {
                            setState(() {
                              selectedCategory =
                                  value;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 16),

                      // ==================================================
                      // MESSAGE FIELD
                      // ==================================================

                      const Text(
                        'Message / Feedback',

                        style: TextStyle(
                          color: primary,
                          fontSize: 13,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 7),

                      TextFormField(
                        controller:
                        messageController,

                        maxLines: 4,

                        keyboardType:
                        TextInputType.multiline,

                        decoration:
                        InputDecoration(
                          hintText:
                          'Write your message here...',

                          prefixIcon:
                          const Padding(
                            padding:
                            EdgeInsets.only(
                              bottom: 65,
                            ),

                            child: Icon(
                              Icons
                                  .chat_bubble_outline,
                              color: primary,
                            ),
                          ),

                          filled: true,

                          fillColor:
                          const Color(
                            0xFFF4F7FB,
                          ),

                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                              14,
                            ),

                            borderSide:
                            BorderSide.none,
                          ),

                          focusedBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                              14,
                            ),

                            borderSide:
                            const BorderSide(
                              color: accent,
                              width: 2,
                            ),
                          ),

                          contentPadding:
                          const EdgeInsets.all(
                            15,
                          ),
                        ),

                        validator: (value) {

                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your message';
                          }

                          if (value.trim().length < 10) {
                            return 'Message should contain at least 10 characters';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // ==================================================
                      // SUBMIT BUTTON
                      // ==================================================

                      SizedBox(
                        width: double.infinity,
                        height: 52,

                        child: ElevatedButton.icon(
                          onPressed: submitForm,

                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),

                          label: const Text(
                            'Submit Request',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            primary,

                            foregroundColor:
                            Colors.white,

                            elevation: 2,

                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                14,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Center(
                        child: Text(
                          'Your information is used only for campus support.',
                          textAlign:
                          TextAlign.center,

                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ==================================================
              // FOOTER
              // ==================================================

              Container(
                width: double.infinity,

                padding:
                const EdgeInsets.all(20),

                alignment:
                Alignment.center,

                decoration:
                BoxDecoration(
                  color: primary,

                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),
                ),

                child: const Column(
                  children: [

                    Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 30,
                    ),

                    SizedBox(height: 7),

                    Text(
                      'CMR Connect',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      'Your campus, your progress, your journey.',

                      textAlign:
                      TextAlign.center,

                      style: TextStyle(
                        color:
                        Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FORM SUBMISSION
  // ============================================================

  void submitForm() {

    // Validate the complete form
    if (_formKey.currentState!.validate()) {

      // Close keyboard
      FocusScope.of(context).unfocus();

      showSnackBar(
        'Request submitted successfully!',
      );

      // Clear form after submission
      nameController.clear();
      emailController.clear();
      messageController.clear();

      setState(() {
        selectedCategory =
        'Academic Support';
      });
    }
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget sectionHeader(
      String title,
      String subtitle,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(
          title,

          style: const TextStyle(
            color: primary,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          subtitle,

          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ACADEMIC CARD
  // ============================================================

  Widget academicCard(
      String value,
      String label,
      IconData icon,
      Color background,
      ) {
    return Container(
      height: 125,

      padding:
      const EdgeInsets.all(13),

      decoration:
      BoxDecoration(
        color: background,

        borderRadius:
        BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Container(
            width: 34,
            height: 34,

            alignment:
            Alignment.center,

            decoration:
            const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: primary,
              size: 18,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            value,

            style: const TextStyle(
              color: primary,
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          Text(
            label,

            style: const TextStyle(
              color: Colors.black54,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SERVICE CARD
  // ============================================================

  Widget serviceCard(
      int index,
      IconData icon,
      String title,
      String subtitle,
      ) {

    bool selected =
        selectedCard == index;

    return InkWell(
      onTap: () {

        setState(() {
          selectedCard = index;
        });

        showSnackBar(
          '$title opened',
        );
      },

      borderRadius:
      BorderRadius.circular(18),

      child: Container(
        height: 145,

        padding:
        const EdgeInsets.all(15),

        decoration:
        BoxDecoration(
          color: selected
              ? const Color(0xFFE7F7F3)
              : Colors.white,

          borderRadius:
          BorderRadius.circular(18),

          border: Border.all(
            color: selected
                ? accent
                : const Color(0xFFD9E2EC),

            width:
            selected ? 2 : 1,
          ),

          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(
                0.04,
              ),

              blurRadius: 7,

              offset:
              const Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Container(
              width: 46,
              height: 46,

              alignment:
              Alignment.center,

              decoration:
              BoxDecoration(
                color: selected
                    ? accent
                    : const Color(
                  0xFFEAF1FA,
                ),

                borderRadius:
                BorderRadius.circular(
                  13,
                ),
              ),

              child: Icon(
                icon,

                color: selected
                    ? Colors.white
                    : primary,

                size: 24,
              ),
            ),

            const Spacer(),

            Text(
              title,

              style: TextStyle(
                color: selected
                    ? accent
                    : primary,

                fontSize: 15,

                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              subtitle,

              style:
              const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),

            const SizedBox(height: 5),

            Align(
              alignment:
              Alignment.centerRight,

              child: Icon(
                selected
                    ? Icons.check_circle
                    : Icons.arrow_forward,

                size: 17,

                color: selected
                    ? accent
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SNACKBAR
  // ============================================================

  void showSnackBar(
      String message,
      ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),

          behavior:
          SnackBarBehavior.floating,

          duration:
          const Duration(
            seconds: 2,
          ),
        ),
      );
  }
}