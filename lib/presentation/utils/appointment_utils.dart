import '../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum AppointmentStatus { completed, upcoming, blocked, none }

List<Map<String, dynamic>> getAppointmentsForDate(
  DateTime date,
  List<Map<String, dynamic>> appointments,
) {
  final dateStr =
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  return appointments.where((apt) => apt['date'] == dateStr).toList();
}

AppointmentStatus getDateStatus(
  DateTime date,
  List<Map<String, dynamic>> appointments,
) {
  final dateStr =
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  final dayAppointments = appointments
      .where((apt) => apt['date'] == dateStr)
      .toList();

  if (dayAppointments.isEmpty) return AppointmentStatus.none;

  bool hasCompleted = dayAppointments.any(
    (apt) => apt['status'] == 'completed',
  );
  bool hasUpcoming = dayAppointments.any((apt) => apt['status'] == 'upcoming');
  bool hasBlocked = dayAppointments.any((apt) => apt['status'] == 'blocked');

  if (hasCompleted) return AppointmentStatus.completed;
  if (hasUpcoming) return AppointmentStatus.upcoming;
  if (hasBlocked) return AppointmentStatus.blocked;

  return AppointmentStatus.none;
}

Color getStatusColor(AppointmentStatus status) {
  switch (status) {
    case AppointmentStatus.completed:
      return AppColors.completedDot;
    case AppointmentStatus.upcoming:
      return AppColors.upcomingDot;
    case AppointmentStatus.blocked:
      return AppColors.blockedDot;
    case AppointmentStatus.none:
      return Colors.transparent;
  }
}

String getMonthName(int month) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return months[month - 1];
}

String getMonthAbbr(int month) {
  const months = [
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
  return months[month - 1];
}

List<Map<String, dynamic>> sampleAppointments = [
  {
    'time': '10:00 AM',
    'professional': 'Mr. Perera',
    'service': 'Haircut',
    'status': 'completed',
    'date': '2025-12-21',
  },
  {
    'time': '11:00 AM',
    'professional': 'Ms. Silva',
    'service': 'Coloring',
    'status': 'upcoming',
    'date': '2025-12-21',
  },
  {
    'time': '12:30 PM',
    'professional': 'Mr. Alwis',
    'service': 'Manicure',
    'status': 'blocked',
    'date': '2025-12-21',
  },
  {
    'time': '2:00 PM',
    'professional': 'Staff Meeting',
    'service': '',
    'status': 'blocked',
    'date': '2025-12-21',
  },
  {
    'time': '9:00 AM',
    'professional': 'Mr. Perera',
    'service': 'Haircut',
    'status': 'completed',
    'date': '2025-12-01',
  },
  {
    'time': '10:00 AM',
    'professional': 'Ms. Silva',
    'service': 'Facial',
    'status': 'completed',
    'date': '2025-12-05',
  },
  {
    'time': '2:00 PM',
    'professional': 'Mr. Alwis',
    'service': 'Massage',
    'status': 'completed',
    'date': '2025-12-06',
  },
  {
    'time': '11:00 AM',
    'professional': 'Ms. Silva',
    'service': 'Coloring',
    'status': 'upcoming',
    'date': '2025-12-10',
  },
  {
    'time': '3:00 PM',
    'professional': 'Mr. Perera',
    'service': 'Haircut',
    'status': 'upcoming',
    'date': '2025-12-16',
  },
  {
    'time': '10:00 AM',
    'professional': 'Mr. Alwis',
    'service': 'Manicure',
    'status': 'blocked',
    'date': '2025-12-17',
  },
  {
    'time': '2:00 PM',
    'professional': 'Ms. Silva',
    'service': 'Facial',
    'status': 'upcoming',
    'date': '2025-12-19',
  },
  {
    'time': '11:00 AM',
    'professional': 'Mr. Perera',
    'service': 'Haircut',
    'status': 'upcoming',
    'date': '2025-12-23',
  },
];

DateTime navigateMonth(DateTime selectedDate, int direction) {
  final newMonth = selectedDate.month + direction;
  final newYear = newMonth > 12
      ? selectedDate.year + 1
      : newMonth < 1
      ? selectedDate.year - 1
      : selectedDate.year;
  final actualMonth = newMonth > 12
      ? 1
      : newMonth < 1
      ? 12
      : newMonth;
  final lastDayOfNewMonth = DateTime(newYear, actualMonth + 1, 0).day;
  final newDay = selectedDate.day > lastDayOfNewMonth
      ? lastDayOfNewMonth
      : selectedDate.day;
  return DateTime(newYear, actualMonth, newDay);
}
