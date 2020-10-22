import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Project {
  String image;
  String name;
  String description;
  String link;
  Project(
      {@required this.image,
      @required this.name,
      @required this.description,
      this.link});
}
