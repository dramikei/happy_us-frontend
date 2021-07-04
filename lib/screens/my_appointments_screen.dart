import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/appointment.getx.dart';
import 'package:happy_us/repository/appointment_repo.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:happy_us/models/appointment.dart';
import 'package:happy_us/widgets/appointment_card.dart';
import 'package:happy_us/widgets/no_data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Alert(
              title: 'Platform specific steps',
              context: context,
              content: Linkify(
                onOpen: (link) async {
                  if (await canLaunch(link.url))
                    await launch(link.url);
                  else
                    AlertsService.error("Can't launch link");
                },
                text:
                    "\nFor discord, Join this server: https://discord.gg/BZthDJkGS4.\n\nOn appointment acceptance, you will receive the text channel name to join.\n\nFor snapchat, our volunteer will contact you on the ID you provided.\n\nYour selected volunteer will message you at the decided time in case of both the platforms.",
                linkStyle: TextStyle(color: kFocusColor, fontSize: 17),
                style: TextStyle(fontSize: 17),
              ),
            ).show();
          },
          child: Icon(Icons.info),
          tooltip: "Platform specific steps",
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
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kFocusColor),
                  ),
                );
            },
          ),
        ),
      ),
    );
  }
}
