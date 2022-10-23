import 'package:flutter/material.dart';
import 'package:muss/txtDB.dart';

class UpdateDatabaseWidget extends StatefulWidget {
  final TxtDB tdb;

  const UpdateDatabaseWidget({Key? key, required this.tdb}) : super(key: key);

  @override
  State<UpdateDatabaseWidget> createState() => _UpdateDatabaseWidgetState();
}

class _UpdateDatabaseWidgetState extends State<UpdateDatabaseWidget> {
  String _courseEditSelectedCourse = "";
  int _minuteChange = 0;

  @override
  void initState() {
    _courseEditSelectedCourse = widget.tdb.coursesList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.amber,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  value: _courseEditSelectedCourse,
                  items: widget.tdb.coursesList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _courseEditSelectedCourse = val ?? "";
                    });
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("$_minuteChange min"),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(
                            () {
                              _minuteChange = _minuteChange + 10;
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(
                            () {
                              _minuteChange = _minuteChange - 10;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            )),
            Container(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () async {
                      Navigator.pop(context);
                      // if save button causing a lag, modify this method
                      await updateDB(_courseEditSelectedCourse, _minuteChange);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  updateDB(String course, int minute) async {
    List<List<String>> db = [];
    await widget.tdb.getDBInfo().then((value) => db = value);
    int courseIndex = 0;
    for (int i = 0; i < widget.tdb.coursesList.length; i++) {
      if (widget.tdb.coursesList[i] == course) {
        courseIndex = i;
        break;
      }
    }
    // print("minute is $minute");
    // print("int parse is ${int.parse(db[db.length - 1][courseIndex])}");
    // only able to edit today's data: db[currentDay]
    String changeResult =
        (int.parse(db[db.length - 1][courseIndex]) + minute).toString();
    // print("change result is $changeResult");
    if (changeResult != "" || changeResult != "0") {
      db[db.length - 1][courseIndex] = changeResult;
      await widget.tdb.updateDB(db);
    }
  }
}
