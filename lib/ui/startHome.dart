import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './registration.dart';
import './authorization.dart';
import 'package:cognitivyskills/ui/profilemenu.dart';


class startHome extends StatefulWidget {
  const startHome({Key? key}) : super(key: key);

  @override
  _StartHomeState createState() => _StartHomeState();
}

class _StartHomeState extends State<startHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 224, 224),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Войдите в аккаунт',
              style: TextStyle(
                color: Color.fromARGB(255, 49, 47, 47),
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontFamily: 'Nexa',
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 51, 224, 129),
                minimumSize: Size(300, 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
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
              child: const Text('Зарегистрироваться',
                  style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 51, 224, 129),
                minimumSize: Size(300, 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
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
              child: const Text('Авторизоваться',
                  style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
