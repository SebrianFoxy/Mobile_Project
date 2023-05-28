import 'dart:async';
import 'package:cognitivyskills/Levels/AllForLevels/data.dart';
import 'package:cognitivyskills/Levels/Level3.dart';
import 'package:cognitivyskills/text/text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import '../Levels/AllForLevels/menulevel.dart';

int level = 8;

class SecondLevel extends StatefulWidget {
  final int size;

  const SecondLevel({Key? key, this.size = 8}) : super(key: key);
  @override
  _SecondLevelState createState() => _SecondLevelState();
}

class _SecondLevelState extends State<SecondLevel> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<String> data = [];
  int previousIndex = -1;
  bool flip = false;

  int time = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }
    startTimer();
    data.shuffle();
  }
  
  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        menulevel(context);
        return false;
      },
      child:Scaffold(
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
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "$time",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Theme(
                  data: ThemeData.dark(),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) => FlipCard(
                        key: cardStateKeys[index],
                        onFlip: () {
                          if (!flip) {
                            flip = true;
                            previousIndex = index;
                          } else {
                            flip = false;
                            if (previousIndex != index) {
                              if (data[previousIndex] != data[index]) {
                                cardStateKeys[previousIndex]
                                    .currentState!
                                    .toggleCard();
                                previousIndex = index;
                              } else {
                                cardFlips[previousIndex] = false;
                                cardFlips[index] = false;
                                print(cardFlips);

                                if (cardFlips.every((t) => t == false)) {
                                  print("Won");
                                  showResult();
                                }
                              }
                            }
                          }
                        },
                        direction: FlipDirection.HORIZONTAL,
                        flipOnTouch: cardFlips[index],
                        front: Container(
                          margin: EdgeInsets.all(4.0),
                          color: Colors.deepOrange.withOpacity(0.3),
                        ),
                        back: Container(
                          margin: EdgeInsets.all(4.0),
                          color: Colors.deepOrange,
                          child: Center(
                            child: Text(
                              "${data[index]}",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                      ),
                      itemCount: data.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(grac),
        content: Text(
          completelevel,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ThirdLevel(Level.Medium)    
                ),
              );
            },
            child: Text(continuelevel),
          ),
        ],
      ),
    );
  }
}
