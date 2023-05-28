import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Levels/AllForLevels/data.dart';
import 'dart:async';
import '../../text/text.dart';
import './Level2.dart';
import '../../ui/listgame.dart';
import '../Levels/AllForLevels/menulevel.dart';

class FirstLevel extends StatefulWidget {
  final Level _level;
  FirstLevel(this._level);
  @override
  _FirstLevelState createState() => _FirstLevelState(_level);
}

class _FirstLevelState extends State<FirstLevel> {
  _FirstLevelState(this._level);

  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;
  bool _isDisposed = false;

  bool _wait = false;
  late Level _level;
  Timer? _timer;
  int _time = 2;
  late int _left;
  late bool _isFinished;
  late List<String> _data;

  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 0.8,
              offset: Offset(2.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(4.0),
      child: Image.asset(_data[index]),
    );
  }

  startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        _time = _time - 1;
      });
    });
  }

  void restart() {
    startTimer();
    _data = getSourceArray(
      _level,
    ) as List<String>;
    _cardFlips = getInitialItemState(_level);
    _cardStateKeys = getCardStateKeys(_level) as List<GlobalKey<FlipCardState>>;
    _time = 2;
    _left = (_data.length ~/ 2);

    _isFinished = false;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _start = true;
        _timer?.cancel();
      });
    });
  }

void showResultDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(grac),
        content: Text(completelevel),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  buttonTheme: ButtonThemeData(
                    minWidth: 10, 
                    height: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0), 
                    ),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 110, 204, 152),
                  ),
                  child: Text(continuelevel),
                  onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => SecondLevel()),
                      );
                    },
                ),
              ),
              SizedBox(width: 16),
              Theme(
                data: Theme.of(context).copyWith(
                  buttonTheme: ButtonThemeData(
                    minWidth: 10,
                    height: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 110, 204, 152),
                  ),
                  child: Text(restartlevel),
                  onPressed: () {
                    setState(() {
                      restart();
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(width: 16),
              Theme(
                data: Theme.of(context).copyWith(
                  buttonTheme: ButtonThemeData(
                    minWidth: 10,
                    height: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 110, 204, 152),
                  ),
                  onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => ListGame()),
                      );
                    },
                  child: Text(exitlevel),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}



  @override
  void initState() {
    super.initState();
    restart();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        menulevel(context);
        return false;
      },
      child: _isFinished
        ? Scaffold(
            body: Center(
              child: GestureDetector(
                onTap: () {
                  showResultDialog();
                },
                child: Container(
                  height: 50,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(child: SizedBox()),
                        IconButton(
                          onPressed: () {
                            menulevel(context);
                          },
                          icon: Icon(Icons.menu),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _time > 0
                          ? Text(
                              '$_time',
                              style: Theme.of(context).textTheme.headline3,
                            )
                          : Text(
                              'Left:$_left',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) => _start
                            ? FlipCard(
                                key: _cardStateKeys[index],
                                onFlip: () {
                                  if (!_flip) {
                                    _flip = true;
                                    _previousIndex = index;
                                  } else {
                                    _flip = false;
                                    if (_previousIndex != index) {
                                      if (_data[_previousIndex] !=
                                          _data[index]) {
                                        _wait = true;

                                        Future.delayed(
                                            const Duration(milliseconds: 1500),
                                            () {
                                          _cardStateKeys[_previousIndex]
                                              .currentState!
                                              .toggleCard();
                                          _previousIndex = index;
                                          _cardStateKeys[_previousIndex]
                                              .currentState!
                                              .toggleCard();

                                          Future.delayed(
                                              const Duration(milliseconds: 160),
                                              () {
                                            setState(() {
                                              _wait = false;
                                            });
                                          });
                                        });
                                      } else {
                                        _cardFlips[_previousIndex] = false;
                                        _cardFlips[index] = false;
                                        print(_cardFlips);

                                        setState(() {
                                          _left -= 1;
                                        });
                                        if (_cardFlips
                                            .every((t) => t == false)) {
                                          print("Won");
                                          Future.delayed(
                                              const Duration(milliseconds: 160),
                                              () {
                                            setState(() {
                                              _isFinished = true;
                                              _start = false;
                                            });
                                            showResultDialog();
                                          });
                                        }
                                      }
                                    }
                                  }
                                  setState(() {});
                                },
                                flipOnTouch: _wait ? false : _cardFlips[index],
                                direction: FlipDirection.HORIZONTAL,
                                front: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 3,
                                          spreadRadius: 0.8,
                                          offset: Offset(2.0, 1),
                                        )
                                      ]),
                                  margin: EdgeInsets.all(4.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/animalspics/quest.png",
                                    ),
                                  ),
                                ),
                                back: getItem(index))
                            : getItem(index),
                        itemCount: _data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
  }
}

