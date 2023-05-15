import 'package:flutter/material.dart';
import './registration.dart';
import './authorization.dart';

class startHome extends StatefulWidget {
  const startHome({super.key});

  @override
  State<startHome> createState() => _startHome();
}

class _startHome extends State<startHome> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: Text('Главная страница',
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
            )),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 80),),
                Text('Войдите в аккаунт', style: TextStyle(
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
            )),
            Padding(padding: EdgeInsets.only(top: 40),),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              minimumSize: Size(300, 100),
            ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        registration(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const Text('Зарегистрироваться',style: TextStyle(
                  fontSize: 18)),
            ),
            Padding(padding: EdgeInsets.only(top: 10),),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              minimumSize: Size(300, 100),
            ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        authorization(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const Text('Авторизироваться',style: TextStyle(
                  fontSize: 18)),
            ),
                ],
              )
          ]
          )   
      ),
    );

  }
}