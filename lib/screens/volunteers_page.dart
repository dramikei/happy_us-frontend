import 'package:dough/dough.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class VolunteersPage extends StatelessWidget {
  static const id = 'VolunteersPage';

  const VolunteersPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('VolunteersPage'),
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
                                child: Text(
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
