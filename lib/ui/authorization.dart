import 'package:cognitivyskills/ui/listgame.dart';
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

  TextEditingController valueCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool isLoading = false;
  bool _obscureText = true;
    void _togglevisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
          'Авторизация',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, left: 5, right: 15),
              child: Form(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: valueCtrl,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    icon: Icon(Icons.people),
                    hintText: "Введите почту",
                    hintStyle: TextStyle(fontFamily: 'Nexa'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 5, right: 15),
              child: Form(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordCtrl,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    icon: Icon(Icons.lock),
                    hintText: "Введите пароль",
                    hintStyle: TextStyle(fontFamily: 'Nexa'),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _togglevisibility();
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: isLoading ? null : () async{
              if (valueCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty){
                setState(() {
                  isLoading = true;
                });
                final Email = await Supabase.instance.client
                        .from('Users')
                        .select('Email')
                        .eq('Email', valueCtrl.text.toLowerCase());
                    if (Email.isNotEmpty) {
                      print('ResponseEmail is not empty');
                      final newEmail = (Email[0]['Email']).toLowerCase();
                      final pass = await Supabase.instance.client
                          .from('Users')
                          .select('Password')
                          .eq('Email', valueCtrl.text.toLowerCase());
                      final newPass = pass[0]['Password'];
                      if (newEmail == valueCtrl.text.toLowerCase() &&
                        newPass == passwordCtrl.text) {
                        final auth = await signInWithEmailAndPassword(newEmail, newPass);
                        if (auth != null) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListGame()),
                            (route) => false,
                          );
                          //final token = await authenticateWithJWT(auth);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Авторизация прошла успешно')),
                          );
                          isLoading = false;
                        } else {
                          // Handle authentication error
                          isLoading = false;
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
                      setState(() {
                        isLoading = false;
                      });
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Введите все данные')),
                    );
                }
            }, 
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 110, 204, 152),
                minimumSize: Size(200, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            child: Text('Авторизоваться',style: TextStyle(fontSize: 18)),
            ),
          ],
        )
      )
    );
  }
}