import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/screens/register_screen.dart';
import 'package:happy_us/widgets/custom_text.dart';

class AboutScreen extends StatelessWidget {
  static const id = 'AboutScreen';

  static const _initiators = [
    'Apoorav Jain',
    'Shivam Verma',
  ];
  static const _usefulGuys = [
    {
      'name': 'Rithik Bhandari',
      'post': 'Technical Head',
      'img': 'assets/images/rithik.jpeg'
    },
    {
      'name': 'Chetna dua',
      'post': 'Creative Head',
      'img': 'assets/images/creative_head.jpeg'
    },
    {
      'name': 'Aashie chaudhary',
      'post': 'Communication Head',
      'img': 'assets/images/communication_head.jpeg'
    },
    {
      'name': 'Rishabh pandey',
      'post': 'Social Media Head',
      'img': 'assets/images/social_media_head.jpeg'
    },
    {
      'name': 'Bhanvi aggarwal',
      'post': 'HR Head',
      'img': 'assets/images/hr_head.jpeg'
    },
    {
      'name': 'Kshtij Vaibhav',
      'post': 'Operations Head\n(or was he?)',
      'img': 'assets/images/operation_head.jpeg'
    },
  ];
  static const _superHeroes = 'assets/images/super-heroes.jpg';

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
The motto of HAPPY US is creating awareness about mental health and Spreading happiness. 

From staying indoors to ensure safety to recurrent upsurges in corona cases, losses both family and financial has buckled our head with plenty of stress and anxiety. Looking at overwhelming concerns, we felt a need to share people's plight. This app enables you to share your emotions and thoughts on this social platform without revealing your identity. 

Do you feel the need to talk without being judged and also not get handful of lessons in return? Well, here is a solution. We provide you with volunteers who can be your listening partners on a platform of your choice. Also, on the application, you will find plentiful of authentic information on procedures dealing with seeking assistance for children who have lost parents in corona pandemic. you need to know one thing. 

We, HAPPY US, are here for you.
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
              'Asm guys, who tagged along',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.8),
              children: List.generate(
                _usefulGuys.length,
                (index) => _headPicture(_usefulGuys[index]),
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
            const SizedBox(height: 20),
            underlineText(
              context: context,
              text: "App Version: 1.1.1+1",
              onTap: null,
            )
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
          height: 160,
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

  Widget _headPicture(Map<String, dynamic> head) {
    final path = head['img'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: 138,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(path),
            ),
          ),
        ),
        const SizedBox(height: 5),
        FittedBox(
          child: Text(
            head['name'],
            style: TextStyle(fontSize: 17),
          ),
        ),
        const SizedBox(height: 5),
        FittedBox(
          child: Text(
            head['post'],
            style: TextStyle(fontSize: 15, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
