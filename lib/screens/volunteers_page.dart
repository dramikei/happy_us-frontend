import 'package:dough/dough.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:happy_us/models/volunteer.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:happy_us/widgets/volunteer_card.dart';

class VolunteersPage extends StatelessWidget {
  static const id = 'VolunteersPage';

  const VolunteersPage({
    Key? key,
  }) : super(key: key);

  static final _volunteers = [
    Volunteer.fromJson({
      'id': '#1',
      'username': 'user-name',
      'password': 'pass-word',
      'fcmToken': '',
      'type': 'volunteer',
      'age': 20,
      'social': {'discord': 'ABC#123'},
      'hobbies': ['Hobby1', 'Hobby2', 'Hobby3'],
      'aboutMe': 'Hello I am ABC',
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
      'hobbies': ['Hobby1', 'Hobby2', 'Hobby3'],
      'aboutMe': 'Hello I am Snap',
      'imageUrl': '',
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.separated(
          padding: const EdgeInsets.all(10),
          separatorBuilder: (c, i) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            final volunteer = _volunteers[index];
            return VolunteerCard(volunteer);
          },
          itemCount: _volunteers.length,
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
                                color: Colors.red,
                              ),
                              child: Center(
                                child: CustomText(
                                  "Content",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
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
