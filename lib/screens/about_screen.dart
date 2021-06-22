import 'package:flutter/material.dart';
import 'package:happy_us/widgets/custom_text.dart';

class AboutScreen extends StatelessWidget {
  static const id = 'AboutScreen';

  static const _initiators = [
    'Apoorav Jain',
    'Shivam Verma',
  ];
  static const _technicalTeam = [
    'Shivam Verma',
    'Rithik Bhandari',
  ];
  static const _superHeroes = 'assets/images/super-heroes.jpeg';

  const AboutScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15),
          physics: const BouncingScrollPhysics(),
          children: [
            CustomText(
              'Who are we?',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            CustomText(
              '''
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
              ''',
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 20),
            CustomText(
              'Initiators',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: List.generate(
                _initiators.length,
                (index) => Expanded(
                  child: _profilePicture(_initiators[index]),
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustomText(
              'Technical Team',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: List.generate(
                _technicalTeam.length,
                (index) => Expanded(
                  child: _profilePicture(_technicalTeam[index]),
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustomText(
              'Our Super Heroes',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              _superHeroes,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profilePicture(String name) {
    final path = 'assets/images/${name.split(' ').first.toLowerCase()}.jpeg';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(path),
            ),
          ),
        ),
        const SizedBox(height: 5),
        FittedBox(
          child: Text(
            name,
            style: TextStyle(fontSize: 17),
          ),
        ),
      ],
    );
  }
}
