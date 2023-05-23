import 'package:cognitivyskills/ui/profilemenu.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/auth.dart';

class authorization extends StatefulWidget {
  const authorization({super.key});

  @override
  State<authorization> createState() => _authorizationState();
}

class _authorizationState extends State<authorization> {
  @override

  TextEditingController valuecontroll = TextEditingController();
  TextEditingController passwordcontroll = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: Text('Авторизация',
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
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, left: 5),
              child: Form(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: valuecontroll,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.people),
                    hintText: "Введите почту",
                    hintStyle: TextStyle(fontFamily: 'Nexa'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 5),
              child: Form(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordcontroll,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.lock),
                    hintText: "Введите пароль",
                    hintStyle: TextStyle(fontFamily: 'Nexa'),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: () async{
              if (valuecontroll.text.isNotEmpty && passwordcontroll.text.isNotEmpty){
                final responseEmail = await Supabase.instance.client
                        .from('Users')
                        .select('Email')
                        .eq('Email', valuecontroll.text) as List<dynamic>;
                    if (responseEmail.isNotEmpty) {
                      print('ResponseEmail is not empty');
                      final responseEmail1 =
                          responseEmail[0]['Email'] as String;
                      final password2 = await Supabase.instance.client
                          .from('Users')
                          .select('Password')
                          .eq('Email', valuecontroll.text) as List<dynamic>;
                      final _password2 = password2[0]['Password'] as String;
                      print(responseEmail1);
                      if (responseEmail1 == valuecontroll.text &&
                        _password2 == passwordcontroll.text) {
                        final auth = await signInWithEmailAndPassword(responseEmail1, _password2);
                        if (auth != null) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => profilemenu()),
                            (route) => false,
                          );
                          //final token = await authenticateWithJWT(auth);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Авторизация прошла успешно')),
                          );
                        } else {
                          // Handle authentication error
                          print('Authentication failed');
                        }
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Логин или пароль неверны')),
                        );
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Логин или пароль неверны')),
                        );
                      }
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Введите все данные')),
                    );
                }
            }, 
            child: Text('Авторизоваться')
            ),
          ],
        )
      )
    );
  }
}