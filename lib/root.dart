import 'package:flutter/material.dart';

import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:portfolio_web/project.dart';
import 'package:portfolio_web/skill.dart';

class RootWidget extends StatefulWidget {
  @override
  State createState() => RootWidgetState();
}

class RootWidgetState extends State<RootWidget> {
  final Set<Skill> skills = {
    Skill('Android', {
      Project(
          'Newsbuzz',
          'Upwork order for a REST API client with endless list\nDone in 1 week\nDesign provided',
          [0, 1, 2, 3, 4].map((e) => 'android/newsbuzz/$e.jpg').toSet(),
          playMarketUrl:
              'https://play.google.com/store/apps/details?id=com.indonesia.newsbuzz',
          youtubeVideoId: 'YkE17AlgRxk'),
      Project(
          'SampleLogin',
          'Login blank screen with transitions test\nDone in 1 day\nCustom design',
          [0, 1, 2, 3].map((e) => 'android/samplelogin/$e.jpg').toSet(),
          youtubeVideoId: 'KdL6cgPIfm0'),
      Project(
          'HLUS',
          'Interactive box office for a Hong Kong waffles shop\nProject paused, the customer went bankrupt\nCustom design, colors provided',
          [0, 1, 2, 3, 4, 5, 6, 7].map((e) => 'android/hlus/$e.jpg').toSet()),
      Project(
          'SiteDog',
          'Watch for a changes in site code\nDone in 1 month\nCustom design',
          [0, 1, 2, 3].map((e) => 'android/sitedog/$e.jpg').toSet(),
          youtubeVideoId: '4kaeSD2Rwv0'),
      Project(
        'CityFauna Beta',
        'Have a dog but have no time to walk with it? We can fix it!\nCustom design',
        [0, 1, 2].map((e) => 'android/cf/$e.jpg').toSet(),
      ),
      Project(
          'STAVRIDE',
          'AVR emulator for Android, the final project of Samsung IT School\nFull emulation of MCU\nDone in 1 month\nCustom design',
          [0, 1, 2, 3, 4].map((e) => 'android/stavride/$e.jpg').toSet(),
          youtubeVideoId: 'm2IB5Tn9VvM'),
    }),
    Skill('Flutter', {
      Project('Portfolio web site', 'This site\nDone in 1 week',
          [0, 1, 2].map((e) => 'flutter/portf/$e.jpg').toSet(),
          githubUrl: 'https://github.com/niktob560/portfolio_web'),
      Project(
        'QR scanner',
        'The simplest QR scanner for Google Play Market\nDone in 1 day',
        [0, 1, 2].map((e) => 'flutter/qr_scanner/$e.jpg').toSet(),
      ),
      Project('Automator', 'GTD management system app', {},
          youtubeVideoId: '1MU9qRKeUvM',
          githubUrl: 'https://github.com/niktob560/automator'),
    }),
    Skill('C++', {
      Project(
          'AVRAPI',
          'Zerocost hardware abstraction layer for AVR MCU`s written in C++ with constexpr usage',
          [2, 1, 0, 3, 4].map((e) => 'cpp/avrapi/$e.jpg').toSet(),
          githubUrl: 'https://github.com/niktob560/avrapi'),
      Project(
          'fantastictrain',
          'Navigation system written in C++ based on Dijkstra`s algorithm with a GLUT monitor\nWas developed for running in AVR MCU, but project was paused',
          [0].map((e) => 'cpp/fantastictrain/$e.jpg').toSet(),
          githubUrl: 'https://github.com/niktob560/fantastictrain'),
      Project('MCU command coder',
          'Binary protocol coder that provides multiMCU data transmission', {},
          githubUrl: 'https://github.com/niktob560/fantastictrain'),
    }),
    Skill('C', {
      Project(
          'Coursework 2020',
          'Firmware for a desktop clock with TTF touch screen written in C99 in compliance with the CERT standard',
          [1, 0].map((e) => 'c/cursach/$e.jpg').toSet(),
          githubUrl: 'https://github.com/niktob560/cursach_2020')
    }),
    Skill('Bash', {
      Project(
          'netcat gpg chat',
          'GPGencrypted chat based on tmux and netcat written in bash',
          [0, 1].map((e) => 'bash/ncgpgchat/$e.jpg').toSet(),
          githubUrl: 'https://github.com/niktob560/ncbashgpgchat'),
      Project(
          'MCU command highlighter and coder',
          'MCU commandline additional tools for mcuterminaltranslator C++ project',
          {'bash/mcuterminal/0.jpg'},
          youtubeVideoId: '96oaPGxbNkg',
          githubUrl:
              'https://github.com/niktob560/mcuterminaltranslatorhighlighter')
    }),
    Skill('Python', {
      Project(
          'Crewmarine API server',
          'API server for https://crewmarine.eu web site written with djangoninja',
          {},
          githubUrl: 'https://github.com/niktob560/seajobs_server'),
      Project(
          'GTD API server',
          'API server for automator flutter app written with djangoninja',
          {'python/gtd/0.jpg'},
          githubUrl: 'https://github.com/niktob560/GTDautomate'),
    }),
  };
  Skill _currentSkill;
  final ghImage = AssetImage('assets/github_badge_dark.png'),
      gpmImage = AssetImage('assets/gpm.png'),
      ytImage = AssetImage('assets/yt.png');

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text('${_currentSkill.name} projects'),
      drawer: ListView(
          children: [
        DrawerHeader(
          child: Text(
            'Skills:',
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          decoration: BoxDecoration(color: Colors.blue),
        )
      ]
            ..addAll(skills
                .map((final e) => ListTile(
                      title: Text(e.name),
                      subtitle: Text('Projects: ${e.projects.length}'),
                      onTap: () {
                        print('Tap $e');
                        setState(() => _currentSkill = e);
                      },
                      selected: e == _currentSkill,
                    ))
                .toList())
            ..addAll([
              const Divider(),
              Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'Only large projects are presented here\n\nMade with flutter',
                    style: TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  )),
              Padding(
                  padding: EdgeInsets.all(32),
                  child: GestureDetector(
                    child: SizedBox(
                        height: 64,
                        child: GestureDetector(
                            onTap: () async {
                              if (await canLaunch(
                                  'https://github.com/niktob560'))
                                await launch('https://github.com/niktob560');
                              else
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Failed'),
                                ));
                            },
                            child: Image(
                              image: ghImage,
                              fit: BoxFit.fitHeight,
                            ))),
                  )),
            ])),
      body: Center(
        child: SkillWidget(_currentSkill),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _currentSkill = skills.first;
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
