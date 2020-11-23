import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              controller: _scrollController,
              children: skill.projects
                  .map((e) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ProjectWidget(e),
                      ))
                  .toList(growable: false),
            )),
        decoration: BoxDecoration(color: Colors.blueGrey),
      );
}
