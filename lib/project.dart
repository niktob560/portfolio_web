import 'package:flutter/cupertino.dart';

@immutable
class Project {
  final String name, description, youtubeVideoId, githubUrl, playMarketUrl;
  final Set<String> screenshotAssets;

  Project(this.name, this.description, this.screenshotAssets, {this.youtubeVideoId = '', this.githubUrl = '', this.playMarketUrl = ''});
}

class ProjectWidget extends StatelessWidget {
  final Project project;

  ProjectWidget(this.project);

  @override
  Widget build(BuildContext context) => ListView(
        children: [Text(project.name, textAlign: TextAlign.center)],
      );
}
