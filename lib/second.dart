// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:developer';
import 'package:flutter/material.dart';

abstract class Animal {
  String name;
  int? age;
  Animal(this.name, {this.age});
  void move() {
    log('$name move');
  }
}

class Eat {
  num eatSpeed = 5;

  void eat() {
    log('Eat $eatSpeed');
  }
}

class Person extends Animal implements Eat {
  String name;
  num eatSpeed = 6;
  int? age;
  Person(this.name, {this.age}) : super(name, age: age);

  eat() {
    super.move();
    log('$name Age $age EatSpeed $eatSpeed');
  }
}

class MyCustomContainer extends Container {
  MyCustomContainer({
    super.key,
    super.child,
  }) : super(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.symmetric(vertical:10,horizontal: 50),
          color: Colors.blue,
        );
}

class MyCustomText extends Text {
  const MyCustomText(super.data, {super.key})
      : super(
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            color: Colors.purple,
          ),
        );
}

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => SecondState();
}

class SecondState extends State<Second> {
  int counter = 0;
  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Animal a = Person('PersonA', age: 5);
    // s.move();
    log('Animal Instance type: ${a.runtimeType}');
    Person p = Person('PersonA', age: 3);
    log('Person Instance type: ${p.runtimeType}');
    // p.move();
    p.eat();
    Eat().eat();
    log('second');
    return Column(
      children: [
        Text(counter.toString()),
        MyCustomContainer(
          child:const MyCustomText('CustomText'),
        ),
      ],
    );
  }
}
