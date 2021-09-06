import 'package:dough/dough.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:happy_us/models/volunteer.dart';
import 'package:happy_us/repository/volunteer_repo.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/no_data.dart';
import 'package:happy_us/widgets/volunteer_card.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';

class VolunteersPage extends StatefulWidget {
  static const id = 'VolunteersPage';

  const VolunteersPage({
    Key? key,
  }) : super(key: key);

  @override
  _VolunteersPageState createState() => _VolunteersPageState();
}

class _VolunteersPageState extends State<VolunteersPage> {
  late Future<List<Volunteer>?> _volunteers;

  @override
  void initState() {
    _volunteers = VolunteerRepo.getAllVolunteers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FittedBox(
              child: CustomText(
                "Choose the best fit",
                maxLines: 2,
                style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.87)
                          : null,
                    ),
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _volunteers = VolunteerRepo.getAllVolunteers();
            setState(() {});
          },
          child: FutureBuilder<List<Volunteer>?>(
            future: _volunteers,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty)
                  return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(35, 45, 35, 85),
                    separatorBuilder: (__, _) => SizedBox(
                      height: 40,
                    ),
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (ctx, index) {
                      return index == 0
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                              child: Lottie.asset(
                                'assets/lottie/volunteer.json',
                                width: double.infinity,
                              ),
                            )
                          : VolunteerCard(snapshot.data![index - 1], index - 1);
                    },
                  );
                else {
                  return NoData();
                }
              } else
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kFocusColor),
                  ),
                );
            },
          ),
        ),
        floatingActionButton: kIsWeb
            ? SizedBox.shrink()
            : PressableDough(
                child: FloatingActionButton(
                  tooltip: 'Professional Help?',
                  child: Icon(Icons.medical_services_sharp),
                  onPressed: () {},
                ),
              ),
      ),
    );
  }
}
