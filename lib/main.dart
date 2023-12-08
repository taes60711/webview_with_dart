import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:piyen/fourth.dart';
import 'package:piyen/second.dart';
import 'package:piyen/third.dart';
import 'package:provider/provider.dart';

enum City {
  ueno('上野', 'ueno'),
  shinjuku('新宿', 'shinjuku'),
  akihabara('秋葉原', 'akihabara'),
  ikebukuro('池袋', 'ikebukuro'),
  shibuya('渋谷', 'shibuya');

  factory City.fromName(String name) {
    if (name == City.ueno.displayName) {
      return City.ueno;
    } else if (name == City.akihabara.displayName) {
      return City.akihabara;
    } else if (name == City.shinjuku.displayName) {
      return City.shinjuku;
    } else if (name == City.ikebukuro.displayName) {
      return City.ikebukuro;
    } else {
      return City.shibuya;
    }
  }

  final String displayName;
  final String cityName;
  const City(this.displayName, this.cityName);
}

class CityProvider extends ChangeNotifier {
  City value = City.ueno;

  void changeCity(City newValue) {
    value = newValue;
    notifyListeners();
  }
}



class Counter extends ChangeNotifier {
  int countA = 0;
  int countB = 0;
  int countC = 0;
  int countD = 0;
  final int? _countE;
  Counter([this._countE]);

  int get countE {
    return _countE ?? 0;
  }

  incrementCountA() {
    countA++;
    notifyListeners();
  }

  incrementCountB() {
    countB++;
    notifyListeners();
  }

  incrementCountC() {
    countC++;
    notifyListeners();
  }

  incrementCountD() {
    countD++;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CityProvider()),
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: MyHomePage(),
    ),
  );
}

class Rectangle {
  num height;
  num? _width;
  Rectangle(this.height, [this._width]);

  num get width {
    return _width ??= 0;
  }

  set width(num n) {
    if (n > 0 && n < 11) {
      _width = n;
    } else {
      log('$n:文字数を1文字以上10文字以下にしてください。');
    }
  }
}

class FunClass {
  Function f2;
  Function f3;
  FunClass(this.f2, this.f3);
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final keyCounter = GlobalKey<SecondState>();

  void fun(List strList, Function(String testStr) fun) {
    for (String e in strList) {
      fun(e);
    }
  }

  void funB(String testStr) {
    anonymousfun(testStr, 1);
  }

  Function anonymousfun = (String testStr, [int? index]) {
    log('anonymousfun testStr : $testStr index: $index ');
  };

  void funC(String testStr, {int? index}) {
    index ??= 2;
    log('FunC testStr : $testStr index: $index ');
  }

  FunClass f1(num n) {
    var num1 = n;

    num f2(num n2) {
      num1 += n2;
      return num1;
    }

    num f3(num n3) {
      var num2 = n;
      num2 += n3;
      return num2;
    }

    FunClass funClassInstance = FunClass(f2, f3);

    return funClassInstance;
  }

  @override
  Widget build(BuildContext context) {
    log('homePage');
   
    Function func = fun;
    Rectangle rectangle = Rectangle(10)..height = 10;

    inspect(rectangle.width);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Fourth(),
        // body: Column(children: [
        //   Second(key: keyCounter),
        //   ElevatedButton(
        //       onPressed: () {
        //         List<String> strList1 = ['1', '2'];
        //         func(strList1, funB);
        //         for (var element in strList1) {
        //           funC(element);
        //           funC(element, index: 5);
        //         }
        //         var result = f1(3);
        //         log(result.f2(5).toString());
        //         log(result.f2(5).toString());
        //         log(result.f3(0).toString());
        //       },
        //       child: const Text('test')),
        //   const Third(),
        // ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            SecondState? state = keyCounter.currentState;
            state?.incrementCounter();
                        log('${state?.counter}');
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
