import 'package:dough/dough.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:happy_us/models/volunteer.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/responsive_grid_view.dart';
import 'package:happy_us/widgets/volunteer_card.dart';

class VolunteersPage extends StatelessWidget {
  static const id = 'VolunteersPage';

  const VolunteersPage({
    Key? key,
  }) : super(key: key);

  static final __volunteers = [
    Volunteer.fromJson({
      'id': '#1',
      'username': 'user-name',
      'password': 'pass-word',
      'fcmToken': '',
      'type': 'volunteer',
      'age': 20,
      'social': {'discord': 'ABC#123'},
      'hobbies': ['Hobby1' * 12, 'Hobby2', 'Hobby3' * 5],
      'aboutMe': 'Hello I am ABC' * 7,
      'imageUrl': '',
    }),
    Volunteer.fromJson({
      'id': '#2',
      'username': 'user-name2',
      'password': 'pass-word2',
      'fcmToken': '',
      'type': 'volunteer',
      'age': 22,
      'social': {'snapchat': 'Snap#123'},
      'hobbies': ['Hobby1', 'Hobby2' * 8, 'Hobby3'],
      'aboutMe': 'Hello I am Snap' * 5,
      'imageUrl': '',
    }),
    Volunteer.fromJson({
      'id': '#3',
      'username': 'user-name2',
      'password': 'pass-word2',
      'fcmToken': '',
      'type': 'volunteer',
      'age': 22,
      'social': {'snapchat': 'Snap#123'},
      'hobbies': ['Hobby1', 'Hobby2' * 8, 'Hobby3'],
      'aboutMe': 'Hello I am Snap' * 5,
      'imageUrl': '',
    }),
  ];

  static final _volunteers = [
    ...__volunteers,
    ...__volunteers,
    ...__volunteers,
    ...__volunteers,
    ...__volunteers,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < SMALL_SCREEN_WIDTH;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Always happy to listen",
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 3));
          },
          child: ResponsiveGridList(
            padding: const EdgeInsets.symmetric(vertical: 50),
            minSpacing: 50,
            desiredItemWidth: isSmallScreen ? 270 : 350,
            children: List.generate(_volunteers.length, (index) {
              final volunteer = _volunteers[index];
              return VolunteerCard(volunteer);
            }),
          ),
        ),
        floatingActionButton: kIsWeb
            ? SizedBox.shrink()
            : PressableDough(
                child: FloatingActionButton(
                  child: Icon(Icons.games_sharp),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PressableDough(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 50,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kFocusColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(50),
                                child: FittedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Stress",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "Ball",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
      ),
    );
  }
}
