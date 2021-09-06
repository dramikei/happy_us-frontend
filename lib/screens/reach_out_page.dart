import 'package:dough/dough.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:happy_us/widgets/static_info_card.dart';

class ReachOutPage extends StatelessWidget {
  static const id = 'OrphanPage';

  const ReachOutPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: PressableDough(
          child: FloatingActionButton(
            tooltip: 'Stress ball',
            child: Icon(Icons.circle),
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
                              CustomText(
                                "Stress",
                                style: TextStyle(color: Colors.white),
                              ),
                              CustomText(
                                "Ball",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        body: StaticInfoCard(),
      ),
    );
  }
}
