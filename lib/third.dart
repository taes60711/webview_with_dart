import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:piyen/main.dart';
import 'package:provider/provider.dart';


List<String> lists = [
  City.ueno.displayName,
  City.akihabara.displayName,
  City.shinjuku.displayName,
  City.ikebukuro.displayName,
  City.shibuya.displayName,
];
String selectedValue = lists[0];

class Third extends StatelessWidget {
  const Third({super.key});

  @override
  Widget build(BuildContext context) {
    Counter counter = Counter(8);
    
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child:  Column(
        children: [
          CityWidget(),
          TextWidgetA(),
          TextWidgetB(),
          TextWidgetC(),
          TextWidgetD(),
          Text('${counter.countE}')
        ],
      ),
    );
  }
}

class CityWidget extends StatelessWidget {
  const CityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CityProvider cityProvider = context.watch<CityProvider>();
    return Column(
      children: [
        Text('現在は ${cityProvider.value.displayName} が選択されています'),
        DropdownButton(
            items: lists
                .map((String list) =>
                    DropdownMenuItem(value: list, child: Text(list)))
                .toList(),
            value: selectedValue,
            onChanged: (String? value) {
              selectedValue = value ?? '';
              cityProvider.changeCity(City.fromName(selectedValue));
            }),
      ],
    );
  }
}

class TextWidgetA extends StatelessWidget {
  const TextWidgetA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('Built TextWidgetA');
    Counter countProvider = context.watch<Counter>();
    return Center(
      child: Column(
        children: [
          Text('Counter A: ${countProvider.countA}'),
          ElevatedButton(
              onPressed: () {
                context.read<Counter>().incrementCountA();
              },
              child: const Text('increment CountA'))
        ],
      ),
    );
  }
}

class TextWidgetB extends StatelessWidget {
  const TextWidgetB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('Built TextWidgetB');

    return Center(
      child: Column(
        children: [
          Text('Counter B: ${context.read<Counter>().countB}'),
          ElevatedButton(
              onPressed: () {
                context.read<Counter>().incrementCountB();
              },
              child: const Text('increment CountB'))
        ],
      ),
    );
  }
}

class TextWidgetC extends StatelessWidget {
  const TextWidgetC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('Built TextWidgetC');

    return Center(
      child: Column(
        children: [
          Text(
              'Counter C: ${context.select((Counter counter) => counter.countC)}'),
          ElevatedButton(
              onPressed: () {
                context.read<Counter>().incrementCountC();
              },
              child: const Text('increment CountC'))
        ],
      ),
    );
  }
}

class TextWidgetD extends StatelessWidget {
  const TextWidgetD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('Built TextWidgetD');
    Counter counter = Counter();
    return Center(
      child: Column(
        children: [
          Text('Counter D: ${counter.countD}'),
          ElevatedButton(
              onPressed: () {
                counter.incrementCountD();
              },
              child: const Text('increment CountD'))
        ],
      ),
    );
  }
}
