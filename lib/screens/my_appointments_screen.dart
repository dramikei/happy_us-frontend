import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/appointment.getx.dart';
import 'package:happy_us/repository/appointment_repo.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:happy_us/models/appointment.dart';
import 'package:happy_us/widgets/appointment_card.dart';
import 'package:happy_us/widgets/no_data.dart';

class MyAppointmentsScreen extends StatefulWidget {
  static const id = 'MyAppointmentsScreen';

  const MyAppointmentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppointmentsScreenState createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  late Future<List<Appointment>?> _appointments;

  @override
  void initState() {
    _appointments = AppointmentRepo.getUserAppointments();
    super.initState();
  }

  Future<void> refreshPage() async {
    _appointments = AppointmentRepo.getUserAppointments();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appointmentController = Get.find<AppointmentController>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? kFocusColor
              : Colors.transparent,
          elevation: 0,
          title: CustomText(
            'My Appointments',
          ),
        ),
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: FutureBuilder<List<Appointment>?>(
            future: _appointments,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                appointmentController.insertAppointments(snapshot.data!);
                return snapshot.data!.length > 0
                    ? ListView.builder(
                        padding: const EdgeInsets.all(20),
                        physics: BouncingScrollPhysics(),
                        itemCount: appointmentController.appointments.length,
                        itemBuilder: (context, index) {
                          return AppointmentCard(
                            appointment:
                                appointmentController.appointments[index],
                          );
                        },
                      )
                    : NoData();
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ),
      ),
    );
  }
}
