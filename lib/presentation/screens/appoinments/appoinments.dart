import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/home/bottom_nav_bar.dart';
import '../../widgets/appoinments/appointments_calendar.dart';
import '../../widgets/appoinments/appointments_list.dart';
import '../../utils/appointment_utils.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments>
    with TickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  AnimationController? _calendarController;

  final List<Map<String, dynamic>> appointments = sampleAppointments;

  @override
  void initState() {
    super.initState();
    _calendarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _calendarController?.forward();
  }

  @override
  void dispose() {
    _calendarController?.dispose();
    super.dispose();
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _navigateMonth(int direction) {
    setState(() {
      selectedDate = navigateMonth(selectedDate, direction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Appointments',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppColors.darkText,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppointmentsCalendar(
              selectedDate: selectedDate,
              onDateSelected: _onDateSelected,
              calendarController: _calendarController,
              appointments: appointments,
              navigateMonth: _navigateMonth,
            ),
            const SizedBox(height: 16),
            AppointmentsList(
              selectedDate: selectedDate,
              appointments: appointments,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
