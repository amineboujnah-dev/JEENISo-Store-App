import 'package:flutter/material.dart';

enum Gender { Male, Female }

class Animal {
  String name;
  String type;
  String age;
  String gender;
  String description;
  String imageUrl;
  Color backgroundColor;

  Animal(
    this.name,
    this.type,
    this.age,
    this.description,
    this.gender,
    this.imageUrl,
    this.backgroundColor,
  );
}
