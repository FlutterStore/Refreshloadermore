// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLastPage = false;

  List? list;
  int page = 1;

  @override
  void initState() {
    super.initState();
    loadFirstData();
  }

  Future<void> loadFirstData() async {
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        list = [
          'Apple',
          'Mango',
          'Orange',
          'Hala Fruit',
          'Guava',
          'Raisin',
          'Gooseberry',
          'Goji berry',
          'Elderberry',
          'Durian',
          'Egg Fruit',
          'Chico fruit',
          'Chiku',
          'Banana',
          'Strawberry',
          'Avocado',
          'Grapes',
          'Purple mangosteen',
          'Pomelo',
          'Redcurrant',
          'Rose apple',
          'Salal berry'
          'Salak',
          'Satsuma',
          'Tamarillo',
          'White currant',
          'Ximenia',
          'Yuzu',
        ];
        isLastPage = false;
        page = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RefreshLoadmore",style: TextStyle(fontSize: 15,),),
        centerTitle: true,
      ),
      body: list != null
        ? RefreshLoadmore(
          onRefresh: loadFirstData,
          onLoadmore: () async {
            await Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                list!.addAll(['123', '234', '457']);
                page++;
              });
              print(page);
              if (page >= 3) {
                setState(() {
                  isLastPage = true;
                });
              }
            });
          },
          noMoreWidget: Text(
            'No more data, you are at the end',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).disabledColor,
            ),
          ),
          isLastPage: isLastPage,
          child: list!.isNotEmpty
          ? Column(
            children: list!
              .map((e) => ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.apple_rounded),
                ),
                  title: Text(e),
                  trailing: const Icon(Icons.arrow_forward_rounded),
                ),
              )
              .toList(),
            )
          : 
          const Center(
            child: Text('empty'),
          ),
        )
      : 
      const Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}