import 'package:flutter/material.dart';
import '../../widgets/appoinments/appointments_calendar.dart';
import '../../widgets/appoinments/appointments_list.dart';
import '../../utils/appointment_utils.dart';
import '../booking/book_an_appoinment.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Appointments',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookAnAppointment(),
                  ),
                );
              },
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F1FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF3D2EFF), width: 1),
                ),
                child: const Center(
                  child: Text(
                    'Bookings',
                    style: TextStyle(
                      color: Color(0xFF3D2EFF),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        toolbarHeight: 70,
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
    );
  }
}
