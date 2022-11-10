import 'package:flutter/material.dart';
import 'package:muss/txt_db.dart';

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
      color: const Color.fromARGB(190, 81, 118, 147),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  value: _courseEditSelectedCourse,
                  alignment: AlignmentDirectional.centerEnd,
                  underline: const DropdownButtonHideUnderline(
                    child: SizedBox.shrink(),
                  ),
                  items: widget.tdb.coursesList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: const TextStyle(
                          letterSpacing: 3,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _courseEditSelectedCourse = val ?? "";
                    });
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$_minuteChange min",
                        style: const TextStyle(
                          letterSpacing: 3,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            padding: const EdgeInsets.fromLTRB(10, 8, 8, 0),
                            icon: const Icon(
                              Icons.arrow_upward_outlined,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  _minuteChange = _minuteChange + 10;
                                },
                              );
                            },
                          ),
                          IconButton(
                            padding: const EdgeInsets.fromLTRB(10, 0, 8, 8),
                            icon: const Icon(
                              Icons.arrow_downward_outlined,
                              size: 30,
                            ),
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
                    ],
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(150)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(150, 0, 49, 83)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)))),
                child: const Text('Update'),
                onPressed: () async {
                  Navigator.pop(context);
                  // if save button causing a lag, modify this method
                  await updateDB(_courseEditSelectedCourse, _minuteChange);
                },
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
    // only able to edit today's data: db[currentDay]
    String changeResult = "";
    int totalSelectCourseValue = 0;
    for (var day in db) {
      totalSelectCourseValue =
          totalSelectCourseValue + int.parse(day[courseIndex]);
    }
    // if time decrease amount larger than total course amount
    if (totalSelectCourseValue + minute < 0) {
      minute = -totalSelectCourseValue;
    }
    changeResult =
        (int.parse(db[db.length - 1][courseIndex]) + minute).toString();
    if (changeResult != "") {
      // total time should larger than zero (need alert dialog)
      db[db.length - 1][courseIndex] = changeResult;
      await widget.tdb.updateDB(db);
    }
  }
}
