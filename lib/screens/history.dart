import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key, required this.title});
  final String title;
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<String> temp = ['F', 'F', 'T', 'T', 'F', 'F', 'F', 'T', 'T', 'F', 'F', 'F', 'T', 'T', 'F',];

  // void sortList(){
  //   temp.sort();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: temp.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            tileColor: (temp[index] == 'F') ? Colors.red : Colors.green,
            leading: Text(index.toString()),
            title: Text(temp[index]),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
