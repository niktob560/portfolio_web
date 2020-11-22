import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:portfolio_web/project.dart';

@immutable
class Skill {
  final String name;
  final Set<Project> projects;

  Skill(this.name, this.projects);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Skill &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          projects == other.projects;

  @override
  int get hashCode => name.hashCode ^ projects.hashCode;

  @override
  String toString() {
    return 'Skill{name: $name, projects: ${projects.toString()}}';
  }
}

class SkillWidget extends StatelessWidget {
  final Skill skill;

  SkillWidget(this.skill);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) => Container(
        child: Scrollbar(
            radius: Radius.circular(2),
            isAlwaysShown: true,
            controller: _scrollController,
            child: ListView(
              children: skill.projects
                  .map((e) => Padding(
                      padding: EdgeInsets.all(8),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              //Title
                              e.name,
                              style: TextStyle(fontSize: 32),
                            ),
                            Container(
                                width: double.infinity,
                                child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      e.description,
                                      style: TextStyle(fontSize: 16),
                                    ))),
                            (e.screenshotAssets.length == 0 &&
                                    e.youtubeVideoId.isEmpty)
                                ? const SizedBox()
                                : SizedBox(
                                    //Images carousel
                                    height: MediaQuery.of(context)
                                            .size
                                            .longestSide /
                                        3,
                                    child: Scrollbar(
                                      radius: Radius.circular(2),
                                      child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: <Widget>[
                                            const SizedBox(width: 4),
                                            (MediaQuery.of(context)
                                                            .size
                                                            .longestSide ==
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width &&
                                                    e.youtubeVideoId.isNotEmpty)
                                                ? Card(
                                                    child: YoutubePlayerIFrame(
                                                      controller: YoutubePlayerController(
                                                          initialVideoId:
                                                              e.youtubeVideoId,
                                                          params: YoutubePlayerParams(
                                                              showControls:
                                                                  false,
                                                              autoPlay: false,
                                                              loop: true,
                                                              showFullscreenButton:
                                                                  false)),
                                                      aspectRatio: 9 / 16,
                                                    ),
                                                  )
                                                : e.youtubeVideoId.isNotEmpty
                                                    ? GestureDetector(
                                                        child: SizedBox(
                                                            height: 64,
                                                            width: 64,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  'assets/yt.png',
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                              placeholder: (context,
                                                                      uri) =>
                                                                  Center(
                                                                      child:
                                                                          CircularProgressIndicator()),
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      Icon(
                                                                Icons.error,
                                                                size: 64,
                                                              ),
                                                            )),
                                                        onTap: () async {
                                                          if (await canLaunch(
                                                              'https://youtu.be/${e.youtubeVideoId}'))
                                                            await launch(
                                                                'https://youtu.be/${e.youtubeVideoId}');
                                                          else
                                                            Scaffold.of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                  'Failed'),
                                                            ));
                                                        },
                                                      )
                                                    : Card()
                                          ]..addAll(e.screenshotAssets
                                              .map((i) => Card(
                                                      child: CachedNetworkImage(
                                                    imageUrl: i,
                                                    fit: BoxFit.fill,
                                                    placeholder: (context,
                                                            uri) =>
                                                        Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons.error,
                                                      size: 128,
                                                    ),
                                                  )))
                                              .toList(growable: false))),
                                    ),
                                  ),
                            (e.githubUrl.isNotEmpty ||
                                    e.playMarketUrl.isNotEmpty)
                                ? Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        (e.playMarketUrl.isNotEmpty)
                                            ? SizedBox(
                                                height: 64,
                                                child: GestureDetector(
                                                    onTap: () async {
                                                      if (await canLaunch(
                                                          e.playMarketUrl))
                                                        await launch(
                                                            e.playMarketUrl);
                                                      else
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content:
                                                              Text('Failed'),
                                                        ));
                                                    },
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          'assets/gpm.png',
                                                      fit: BoxFit.fill,
                                                      placeholder: (context,
                                                              uri) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
                                                        Icons.error,
                                                        size: 64,
                                                      ),
                                                    )))
                                            : const SizedBox(),
                                        (e.githubUrl.isNotEmpty)
                                            ? SizedBox(
                                                height: 64,
                                                child: GestureDetector(
                                                    onTap: () async {
                                                      if (await canLaunch(
                                                          e.githubUrl))
                                                        await launch(
                                                            e.githubUrl);
                                                      else
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content:
                                                              Text('Failed'),
                                                        ));
                                                    },
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          'assets/github_badge_dark.png',
                                                      fit: BoxFit.fill,
                                                      placeholder: (context,
                                                              uri) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
                                                        Icons.error,
                                                        size: 64,
                                                      ),
                                                    )))
                                            : const SizedBox(),
                                      ]
                                          .map((e) => Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: e))
                                          .toList(growable: false),
                                    ))
                                : const Divider()
                          ],
                        ),
                        elevation: 8,
                      )))
                  .toList(growable: false),
            )),
        decoration: BoxDecoration(color: Colors.blueGrey),
      );
}
