import 'package:flutter/material.dart';
import '../manage/add_staff_screen.dart';
import '../manage/add_service_screen.dart';
import '../feedbacks/feedbacks.dart';
import '../notifications/notification_page.dart';
import '../../widgets/home/dashboard_appointment_card.dart';
import '../../widgets/home/dashboard_action_button.dart';
import '../promotions/promotions_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Sample today's appointments data
  final List<Map<String, dynamic>> _todayAppointments = [
    {'time': '10:00 AM', 'customer': 'Mr. Perera', 'status': 'Completed'},
    {'time': '11:00 AM', 'customer': 'Ms. Silva', 'status': 'In Progress'},
    {'time': '12:30 PM', 'customer': 'Mr. Alwis', 'status': 'Upcoming'},
  ];

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header with greeting and profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Salon Owner',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                  // Profile avatar with notification badge
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationPage(),
                        ),
                      );
                    },
                    child: const Stack(
                      children: [
                        CircleAvatar(
                          radius: 23,
                          backgroundColor: Color(0xFFF5F5F5),
                          child: Icon(
                            Icons.notifications,
                            color: Color(0xFF666666),
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Revenue Today & Occupancy Cards Row
              Row(
                children: [
                  // Revenue Today Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7B68EE), Color(0xFF9370DB)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Wave decoration - top right curve
                          Positioned(
                            right: -16,
                            top: -18,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.15),
                                    Colors.white.withOpacity(0.05),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                          ),
                          // Wave decoration - bottom right curve
                          Positioned(
                            right: 100,
                            bottom: -40,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.1),
                                    Colors.white.withOpacity(0.03),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ),
                          // Wave decoration - middle right curve
                          Positioned(
                            right: -30,
                            top: 20,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: Colors.white.withOpacity(0.08),
                              ),
                            ),
                          ),
                          // Content
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Revenue Today',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xD9FFFFFF),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Rs 45,000',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '+12% vs last Sun',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xCCFFFFFF),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Today's Appointments Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8A855),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Diamond shape decoration
                          Positioned(
                            right: -10,
                            top: -15,
                            child: Transform.rotate(
                              angle: 0.5,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          // Small square decoration - bottom right
                          Positioned(
                            right: 15,
                            bottom: -12,
                            child: Transform.rotate(
                              angle: 0.3,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white.withOpacity(0.15),
                                ),
                              ),
                            ),
                          ),
                          // Dot pattern decoration
                          Positioned(
                            right: 5,
                            top: 25,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.25),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 25,
                            top: 5,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                          ),
                          // Content
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Today's Appointments",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF1A1A1A),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1A1A1A),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    '3/12 Completed',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF4A4A4A),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Actions Section Title
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 16),

              // Actions Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F3F0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardActionButton(
                      icon: Icons.content_cut_outlined,
                      label: 'Add\nService',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddServiceScreen(),
                          ),
                        );
                      },
                    ),
                    DashboardActionButton(
                      icon: Icons.person_add_outlined,
                      label: 'Add\nStaff',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AddStaffScreen(availableServices: []),
                          ),
                        );
                      },
                    ),
                    DashboardActionButton(
                      icon: Icons.local_offer_outlined,
                      label: 'Add\nPromotions',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PromotionsPage(),
                          ),
                        );
                      },
                    ),
                    DashboardActionButton(
                      icon: Icons.rate_review_outlined,
                      label: 'Feedbacks',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FeedbacksPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Today's Appointments Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Appointments",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  Text(
                    _getTodayDate(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Appointments List
              Expanded(
                child: ListView.builder(
                  itemCount: _todayAppointments.length,
                  itemBuilder: (context, index) {
                    final appointment = _todayAppointments[index];
                    return DashboardAppointmentCard(
                      time: appointment['time'],
                      customer: appointment['customer'],
                      status: appointment['status'],
                      isInProgress: appointment['status'] == 'In Progress',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTodayDate() {
    final now = DateTime.now();
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[now.month - 1]} ${now.day}';
  }
}
