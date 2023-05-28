import 'package:cognitivyskills/ui/profilemenu.dart';
import 'package:cognitivyskills/ui/listgame.dart';
import 'package:flutter/material.dart';


class navigation extends StatefulWidget {
  const navigation({super.key});

  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
        child: BottomAppBar(
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      try {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => ListGame()),
                          (route) => false,
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Icon(Icons.gamepad, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.stacked_bar_chart, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      try {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => profilemenu()),
                          (route) => false,
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Icon(Icons.account_box, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}