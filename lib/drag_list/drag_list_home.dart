import 'dart:math';
import 'package:flutter/material.dart';

class DragListHome extends StatefulWidget {

  @override
  _DragListHomeState createState() => _DragListHomeState();
}

class _DragListHomeState extends State<DragListHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可以拖动的列表'),
      ),
      body: MyWidgets(),
    );
  }
}

// ReorderableListView
class MyWidgets extends StatefulWidget {
  @override
  _MyWidgetsState createState() => _MyWidgetsState();
}

class _MyWidgetsState extends State<MyWidgets> {
  List<Map<String, Color>> _listData = [
    {'one': getRandomColor()},
    {'two': getRandomColor()},
    {'three': getRandomColor()},
    {'four': getRandomColor()},
    {'five': getRandomColor()},
    {'six': getRandomColor()},
    {'seven': getRandomColor()},
    {'eight': getRandomColor()},
    {'nine': getRandomColor()},
    {'ten': getRandomColor()},
  ];
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      header: Container(),
      children: getWidgets(),
      onReorder: (int oldIndex, int newIndex) {
        print('old:$oldIndex  -- new: $newIndex');
        var sourceObj = _listData[oldIndex];
        _listData.removeAt(oldIndex);
        _listData.insert(newIndex - (oldIndex < newIndex ? 1 : 0), sourceObj);
        setState(() {});
      },
    );
  }

  List<Widget> getWidgets() {
    List<Widget> widgets = [];
    _listData.forEach((d) {
      print('${d.values.first}--${d.keys.first}');
      Widget view = Container(
        key: ValueKey(d),
        margin: EdgeInsets.all(10),
        color: d.values.first,
        child: ListTile(
          title: Text('这是--${d.keys.first}',
              style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
      );
      widgets.add(view);
    });
    return widgets;
  }
}

getRandomColor() {
  return Color.fromARGB(
    255,
    Random.secure().nextInt(255),
    Random.secure().nextInt(255),
    Random.secure().nextInt(255),
  );
}
