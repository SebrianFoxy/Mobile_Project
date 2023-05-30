import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './navigation.dart';



class CentreHelp extends StatefulWidget {
  const CentreHelp({super.key});

  @override
  State<CentreHelp> createState() => _CentreHelpState();
}

class _CentreHelpState extends State<CentreHelp> {
  final String phoneNumber = '+79787955673';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30), 
          ),
        ),
        title: Text(
          'Центр помощи',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontFamily: 'Nexa',
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 2,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 90),
            Text('Почта тех-поддержки: yunass2@gmail.com',
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontFamily: 'Nexa',),),
            Text('Телефон обратной связи: +79787955673',
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontFamily: 'Nexa',),),
              SizedBox(height: 90),
            ElevatedButton(
              onPressed: () {
                launch('tel:$phoneNumber');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(200, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            child: Text('Обратная связь',style: TextStyle(fontSize: 18)),
            ),
          ]
          
        ),
      ),
      bottomNavigationBar: navigation(),
    );
  }
}