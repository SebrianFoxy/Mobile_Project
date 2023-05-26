import 'package:cognitivyskills/ui/profilemenu.dart';
import 'package:flutter/material.dart';


class navigation extends StatefulWidget {
  const navigation({super.key});

  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        decoration: BoxDecoration(
        color: Color.fromARGB(255, 104, 238, 207),
      ),
      child: Container(
        height: 56.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                try{
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => profilemenu()),
                    (route) => false,
                  );
                }catch(e){
                  print(e);
                }
              },
              icon: Icon(Icons.account_box, color: Colors.deepOrange),
            ),
            IconButton(
              onPressed: () {},
              icon:
                  Icon(Icons.gamepad, color: Colors.deepOrange),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.stacked_bar_chart, color: Colors.deepOrange),
            ),
          ],
        ),
      ),
    )
    );
  }
}