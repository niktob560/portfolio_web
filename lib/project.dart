import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

@immutable
class Project {
  final String name, description, youtubeVideoId, githubUrl, playMarketUrl;
  final Set<String> screenshotAssets;

  List<Widget> _carousel;

  List<Widget> get carousel => _carousel;

  Project(this.name, this.description, this.screenshotAssets,
      {this.youtubeVideoId = '', this.githubUrl = '', this.playMarketUrl = ''});

  draw(context) {
    _carousel = [
      const SizedBox(width: 4),
      (MediaQuery.of(context).size.longestSide ==
                  MediaQuery.of(context).size.width &&
              youtubeVideoId.isNotEmpty)
          ? Card(
              child: YoutubePlayerIFrame(
                controller: YoutubePlayerController(
                    initialVideoId: youtubeVideoId,
                    params: YoutubePlayerParams(
                        showControls: false,
                        autoPlay: false,
                        loop: true,
                        showFullscreenButton: false)),
                aspectRatio: 9 / 16,
              ),
            )
          : youtubeVideoId.isNotEmpty
              ? GestureDetector(
                  child: SizedBox(
                      height: 64,
                      width: 64,
                      child: CachedNetworkImage(
                        imageUrl: 'assets/yt.png',
                        fit: BoxFit.fitWidth,
                        placeholder: (context, uri) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          size: 64,
                        ),
                      )),
                  onTap: () async {
                    if (await canLaunch('https://youtu.be/${youtubeVideoId}'))
                      await launch('https://youtu.be/${youtubeVideoId}');
                    else
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Failed'),
                      ));
                  },
                )
              : Card()
    ]..addAll(screenshotAssets
        .map((i) => Card(
                child: CachedNetworkImage(
              imageUrl: i,
              fit: BoxFit.fill,
              placeholder: (context, uri) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                size: 128,
              ),
            )))
        .toList(growable: false));
  }

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
          screenshotAssets == other.screenshotAssets;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      youtubeVideoId.hashCode ^
      githubUrl.hashCode ^
      playMarketUrl.hashCode ^
      screenshotAssets.hashCode;
}

class ProjectWidget extends StatelessWidget {
  final Project project;

  ProjectWidget(this.project);

  @override
  Widget build(BuildContext context) => ListView(
        children: [Text(project.name, textAlign: TextAlign.center)],
      );
}
