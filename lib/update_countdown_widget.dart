import 'package:flutter/material.dart';
import 'package:muss/txt_db.dart';

class UpdateCountdownWidget extends StatefulWidget {
  final TxtDB tdb;

  const UpdateCountdownWidget({Key? key, required this.tdb}) : super(key: key);

  @override
  State<UpdateCountdownWidget> createState() => _UpdateCountdownWidgetState();
}

class _UpdateCountdownWidgetState extends State<UpdateCountdownWidget> {
  late int _minuteChange;
  bool finishInit = false;
  String _courseEditSelectedCourse = "";

  @override
  void initState() {
    initInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return finishInit
        ? Container(
            height: 200,
            color: Color.fromARGB(190, 81, 118, 147),
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
                        onChanged: (val) async {
                          int index = 0;
                          for (var item in widget.tdb.coursesList) {
                            if (item == val) break;
                            index++;
                          }
                          List<int> countdowns =
                              await widget.tdb.getCountDowns();
                          setState(() {
                            _courseEditSelectedCourse = val ?? "";
                            _minuteChange = countdowns[index];
                          });
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "$_minuteChange 分钟后进行提醒",
                              style: const TextStyle(
                                letterSpacing: 3,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 8, 8, 0),
                                  icon: const Icon(
                                    Icons.arrow_upward_outlined,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        _minuteChange = _minuteChange + 5;
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 8, 8),
                                  icon: const Icon(
                                    Icons.arrow_downward_outlined,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        if (_minuteChange > 0) {
                                          _minuteChange = _minuteChange - 5;
                                        }
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
                  )),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(150)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(150, 0, 49, 83)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)))),
                      child: const Text('更新'),
                      onPressed: () async {
                        Navigator.pop(context);
                        // if save button causing a lag, modify this method
                        await updateCountdown(
                            _minuteChange, _courseEditSelectedCourse);
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  updateCountdown(int minute, String selectCourse) async {
    int index = 0;
    for (var item in widget.tdb.coursesList) {
      if (item == selectCourse) break;
      index++;
    }
    List<int> tmp = await widget.tdb.getCountDowns();
    tmp[index] = minute;
    await widget.tdb.updateCountDowns(tmp);
  }

  void initInfo() async {
    _courseEditSelectedCourse = widget.tdb.coursesList[0];
    var minutesChange = await widget.tdb.getCountDowns();
    _minuteChange = minutesChange[0];
    setState(() {
      finishInit = true;
    });
  }
}
