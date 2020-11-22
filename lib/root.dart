import 'package:flutter/material.dart';

import 'package:responsive_scaffold/responsive_scaffold.dart';

import 'package:portfolio_web/project.dart';
import 'package:portfolio_web/skill.dart';

class RootWidget extends StatefulWidget {
  @override
  State createState() => RootWidgetState();
}

class RootWidgetState extends State<RootWidget> {
  final skills = {
    Skill('Android', {
      Project(
          'Newsbuzz',
          'Upwork order for a REST API client with endless list\nDone in 1 week\nDesign provided',
          [0, 1, 2, 3, 4].map((e) => 'assets/android/newsbuzz/$e.jpg').toSet(),
          playMarketUrl:
              'https://play.google.com/store/apps/details?id=com.indonesia.newsbuzz',
          youtubeVideoId: 'YkE17AlgRxk'),
      Project(
          'SampleLogin',
          'Login blank screen with transitions test\nDone in 1 day\nCustom design',
          [0, 1, 2, 3].map((e) => 'assets/android/samplelogin/$e.jpg').toSet(),
          youtubeVideoId: 'KdL6cgPIfm0'),
      Project(
          'HLUS',
          'Interactive box office for a Hong Kong waffles shop\nProject paused, the customer went bankrupt\nCustom design, colors provided',
          [0, 1, 2, 3, 4, 5, 6, 7]
              .map((e) => 'assets/android/hlus/$e.jpg')
              .toSet()),
      Project(
          'SiteDog',
          'Watch for a changes in site code\nDone in 1 month\nCustom design',
          [0, 1, 2, 3].map((e) => 'assets/android/sitedog/$e.jpg').toSet(),
          youtubeVideoId: '4kaeSD2Rwv0'),
      Project(
        'CityFauna Beta',
        'Have a dog but have no time to walk with it? We can fix it!\nCustom design',
        [0, 1, 2].map((e) => 'assets/android/cf/$e.jpg').toSet(),
      ),
      Project(
          'STAVRIDE',
          'AVR emulator for Android, the final project of Samsung IT School\nFull emulation of MCU\nDone in 1 month\nCustom design',
          [0, 1, 2, 3, 4].map((e) => 'assets/android/stavride/$e.jpg').toSet(),
          youtubeVideoId: 'm2IB5Tn9VvM'),
    }),
    Skill('Flutter', {
      Project(
        'QR scanner',
        'The simplest QR scanner for Google Play Market\nDone in 1 day',
        [0, 1, 2].map((e) => 'assets/flutter/qr_scanner/$e.jpg').toSet(),
      ),
      Project('Portfolio web site', 'This site\nDone in 1 week',
          [0, 1, 2].map((e) => 'assets/flutter/portf/$e.jpg').toSet(),
          githubUrl: 'https://github.com/niktob560/portfolio_web'),
    }),
    Skill('C++', {}),
    Skill('C', {}),
    Skill('Bash', {}),
    Skill('Python', {}),
  };

  Skill _currentSkill;

  Skill get currentSkill =>
      _currentSkill != null ? _currentSkill : skills.first;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text('${currentSkill.name} projects'),
      drawer: ListView(
          children: [
        DrawerHeader(
          child: Text(
            'Skills:',
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          decoration: BoxDecoration(color: Colors.blue),
        )
      ]..addAll(skills
              .map((final e) => ListTile(
                    title: Text(e.name),
                    subtitle: Text('Projects: ${e.projects.length}'),
                    onTap: () => setState(() => _currentSkill = e),
                    selected: e == currentSkill,
                  ))
              .toList())),
      body: Center(
        child: SkillWidget(currentSkill),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1))
        .then((value) => _showDisclaimerDialog());
  }

  Future<void> _showDisclaimerDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Disclaimer'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This site is under development.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
