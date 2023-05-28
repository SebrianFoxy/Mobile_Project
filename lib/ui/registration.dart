import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/auth.dart';
import './checkauth.dart';
import 'package:cognitivyskills/ui/profilemenu.dart';


class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  @override
  
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();

  String _password1 = "";
  String _password2 = "";
  String _name = "";
  String _email = "";

  bool _isButtonEnabled = false;

  void _validateInputs() {
    if (_formKey1.currentState!.validate() &&
        _formKey2.currentState!.validate() &&
        _formKey3.currentState!.validate() &&
        _formKey4.currentState!.validate()) {
      setState(() {
        _isButtonEnabled = true;
      });
    } else {
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80, // Установите желаемую высоту AppBar
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30), // Установите радиус закругления здесь
          ),
        ),
        title: Text(
          'Регистрация',
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
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, left: 5,right: 15),
              child: Form(
                key: _formKey1,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.people),
                    hintText: "Имя пользователя",
                    hintStyle: TextStyle(fontFamily: 'Nexa'),
                  ),
                  validator: (value) {
                    if (value!.length >= 20 && value.isNotEmpty) {
                      return "Имя пользователя должен содержать не более 20 символов";
                    }
                    else if(!RegExp(r'^[a-zA-Z0-9_]{4,20}$').hasMatch(value)){
                      return 'Присутствуют недопустимые символы';
                    }
                    else if (value.length < 4 || value.isEmpty) {
                      return "Имя пользователя должен содержать не менее 4 символов";
                    }

                    else{
                      _name = value;
                    }
                    return null;
                  },
                  onChanged: (value){
                    _validateInputs();
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 5,right: 15),
              child: Form(
                key: _formKey2,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.email),
                    hintText: "Почта",
                    hintStyle: TextStyle(fontFamily: 'Nexa'),
                  ),
                  validator: (value) {
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value!) && value.isNotEmpty) {
                      return 'Неверный формат почты';
                    }
                    else if (value.isEmpty){
                      return 'Введите вашу почту';
                    }
                    else {
                      _email = value;
                    }
                    return null;
                  },
                  onChanged: (value){
                    _validateInputs();
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 5,right: 15),
              child: Form(
                key:_formKey3,
                child: TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.lock),
                    hintText: "Пароль",
                    hintStyle: TextStyle(fontFamily: 'Nexa'),
                  ),
                  validator: (value) {
                    if (value!.length < 6 && value.isNotEmpty){
                      return "Пароль должен состоять не менее чем из 6 символов";
                    }
                    else if (value.isEmpty){
                      return "Введите пароль";
                    }
                    else {
                      _password1 = value;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _validateInputs();
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 5,right: 15),
              child: Form(
                key: _formKey4,
                child: TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.lock),
                    hintText: "Повторный пароль",
                    hintStyle: TextStyle(fontFamily: 'Nexa'),
                  ),
                  validator: (value) {
                    if (_password1 != value! && value.isNotEmpty){
                      return "Пароли не совпадают";
                    }
                    else if (value.isEmpty){
                      return 'Введите пароль еще раз';
                    }
                    else{
                      _password2 = value;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _validateInputs();
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isButtonEnabled ? () async {
                setState(() {
                  _isButtonEnabled = false;
                });
                try{
                  final takeName = (await Supabase.instance.client.from('Users').select('UserName').eq('UserName', _name.toLowerCase()));
                  final takeEmail = (await Supabase.instance.client.from('Users').select('Email').eq('Email', _email.toLowerCase()));
                  if (takeName.isNotEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Такое имя пользователя уже существует')),
                    );
                  }
                  else if (takeEmail.isNotEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Такая почта уже существует')),
                    );
                    print(_email);
                    print(takeEmail);
                    print(_name);
                    print(takeName);
                  }
                  else{
                    final auth = await signUpWithEmailAndPassword(_email.toLowerCase(), _password1);
                    if (auth != null) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                        builder: (context) => checkauth()),
                        (route) => false,
                      );
                      await Supabase.instance.client.from('Users').insert({'UserName': _name.toLowerCase(), 'Email': _email.toLowerCase(), 'Password': _password1}).then((response) => print('yes'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Регистрация прошла успешно')),
                        );
                      } else {
                        print('Authentication failed');
                        print(_email);
                        print(takeEmail);
                        print(_name);
                        print(takeName);
                      }
                  }
                  setState(() {
                    _isButtonEnabled = true;
                  });
                }catch(error){
                  print(error);
                }
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 110, 204, 152),
                minimumSize: Size(200, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}
