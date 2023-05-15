import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
                    hintText: "Введите имя пользователя или почту",
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
                final responseName = await Supabase.instance.client
                        .from('Users')
                        .select('UserName')
                        .eq('UserName', valuecontroll.text) as List<dynamic>;
                    if (responseName.isNotEmpty) {
                      print('ResponseName NotEmpty');
                      final responseName1 =
                          responseName[0]['UserName'] as String;
                      final password1 = await Supabase.instance.client
                          .from('Users')
                          .select('Password')
                          .eq('UserName', valuecontroll.text) as List<dynamic>;
                      final _password1 = password1[0]['Password'] as String;
                      if (responseName1 == valuecontroll.text &&
                          _password1 == passwordcontroll.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Авторизация прошла успешно')),
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Логин или пароль неверны')),
                        );
                      }
                    } else if (responseName.isEmpty) {
                      print('ResponseName empty');
                      final responseEmail = await Supabase.instance.client
                          .from('Users')
                          .select('Email')
                          .eq('Email', valuecontroll.text) as List<dynamic>;
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Авторизация прошла успешно')),
                        );
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