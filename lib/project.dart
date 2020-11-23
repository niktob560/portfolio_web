import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
class Project {
  final String name, description, youtubeVideoId, githubUrl, playMarketUrl;
  final Set<AssetImage> screenshotImages;

  Project(this.name, this.description, Set<String> screenshotAssets,
      {this.youtubeVideoId = '', this.githubUrl = '', this.playMarketUrl = ''})
      : screenshotImages = screenshotAssets.map((e) => AssetImage(e)).toSet();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          youtubeVideoId == other.youtubeVideoId &&
          githubUrl == other.githubUrl &&
          playMarketUrl == other.playMarketUrl &&
          screenshotImages == other.screenshotImages;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      youtubeVideoId.hashCode ^
      githubUrl.hashCode ^
      playMarketUrl.hashCode ^
      screenshotImages.hashCode;
}

class ProjectWidget extends StatelessWidget {
  final Project project;
  final ghImage = AssetImage('assets/github_badge_dark.png'),
      gpmImage = AssetImage('assets/gpm.png'),
      ytImage = AssetImage('assets/yt.png');

  ProjectWidget(this.project);

  @override
  Widget build(BuildContext context) => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              //Title
              project.name,
              style: TextStyle(fontSize: 32),
            ),
            Container(
                width: double.infinity,
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      project.description,
                      style: TextStyle(fontSize: 16),
                    ))),
            (project.screenshotImages.length == 0 &&
                    project.youtubeVideoId.isEmpty)
                ? const SizedBox()
                : SizedBox(
                    //Images carousel
                    height: MediaQuery.of(context).size.longestSide / 3,
                    child: Scrollbar(
                      radius: Radius.circular(2),
                      child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(width: 4),
                            (MediaQuery.of(context).size.longestSide ==
                                        MediaQuery.of(context).size.width &&
                                    project.youtubeVideoId.isNotEmpty)
                                ? Card(
                                    child: YoutubePlayerIFrame(
                                      controller: YoutubePlayerController(
                                          initialVideoId:
                                              project.youtubeVideoId,
                                          params: YoutubePlayerParams(
                                              showControls: false,
                                              autoPlay: false,
                                              loop: true,
                                              showFullscreenButton: false)),
                                      aspectRatio: 9 / 16,
                                    ),
                                  )
                                : project.youtubeVideoId.isNotEmpty
                                    ? GestureDetector(
                                        child: SizedBox(
                                            height: 64,
                                            width: 64,
                                            child: Image(
                                              image: ytImage,
                                              fit: BoxFit.fitWidth,
                                            )),
                                        onTap: () async {
                                          if (await canLaunch(
                                              'https://youtu.be/${project.youtubeVideoId}'))
                                            await launch(
                                                'https://youtu.be/${project.youtubeVideoId}');
                                          else
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text('Failed'),
                                            ));
                                        },
                                      )
                                    : Card()
                          ]..addAll(project.screenshotImages
                              .map((i) => Card(
                                      child: Image(
                                    image: i,
                                    fit: BoxFit.fill,
                                  )))
                              .toList(growable: false))),
                    ),
                  ),
            (project.githubUrl.isNotEmpty || project.playMarketUrl.isNotEmpty)
                ? Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (project.playMarketUrl.isNotEmpty)
                            ? SizedBox(
                                height: 64,
                                child: GestureDetector(
                                    onTap: () async {
                                      if (await canLaunch(
                                          project.playMarketUrl))
                                        await launch(project.playMarketUrl);
                                      else
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Failed'),
                                        ));
                                    },
                                    child: Image(
                                      image: gpmImage,
                                    )))
                            : const SizedBox(),
                        (project.githubUrl.isNotEmpty)
                            ? SizedBox(
                                height: 64,
                                child: GestureDetector(
                                    onTap: () async {
                                      if (await canLaunch(project.githubUrl))
                                        await launch(project.githubUrl);
                                      else
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Failed'),
                                        ));
                                    },
                                    child: Image(
                                      image: ghImage,
                                    )))
                            : const SizedBox(),
                      ]
                          .map((e) => Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: e))
                          .toList(growable: false),
                    ))
                : const Divider()
          ],
        ),
      );
}
