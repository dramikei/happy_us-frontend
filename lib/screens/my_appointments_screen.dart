import 'package:flutter/material.dart';
import 'package:happy_us/models/appointment.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/appointment_card.dart';

class MyAppointmentsScreen extends StatelessWidget {
  static const id = 'MyAppointmentsScreen';

  const MyAppointmentsScreen({
    Key? key,
  }) : super(key: key);

  static final appointments = [
    Appointment.fromJson({
      "userSocial": {"discord": "lol"},
      "status": "212121",
      "_id": "1212",
      "time": "2021-06-24 00:00:00.000",
      "userId": "212",
      "volunteerId": "1",
      "message": "test msg",
    })
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccentColor,
        title: Text('My Appointments'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
            padding: const EdgeInsets.all(50),
            physics: BouncingScrollPhysics(),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              return AppointmentCard(
                appointment: appointments[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
