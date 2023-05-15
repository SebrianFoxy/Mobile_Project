import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: Text('Регистрация аккаунта', style: TextStyle(
          fontSize:24,
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
                key: _formKey1,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.people),
                    hintText: "Введите имя пользователя",
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
              padding: EdgeInsets.only(top:15, left: 5),
              child: Form(
                key: _formKey2,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.email),
                    hintText: "Введите почту",
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
              padding: EdgeInsets.only(top:15, left: 5),
              child: Form(
                key:_formKey3,
                child: TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.lock),
                    hintText: "Введите пароль",
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
              padding: EdgeInsets.only(top: 15, left: 5),
              child: Form(
                key: _formKey4,
                child: TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.lock),
                    hintText: "Введите пароль",
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
            ElevatedButton(
              onPressed: _isButtonEnabled ? () async {
                try{
                  final responseName = await Supabase.instance.client.from('Users').select('UserName').eq('UserName', _name);
                  final responseEmail = await Supabase.instance.client.from('Users').select('Email').eq('Email', _email);
                  if (responseName.isNotEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Такое имя пользователя уже существует')),
                    );
                  }
                  else if (responseEmail.isNotEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Такая почта уже существует')),
                    );
                  }
                  else{
                    await Supabase.instance.client.from('Users').insert({'UserName': _name, 'Email': _email, 'Password': _password1}).then((response) => print('yes'));
                    print(responseName);
                  }
                }catch(error){
                  print(error);
                }
              } : null,
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}
