import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../text/text.dart';


class mySettings extends StatefulWidget {
  const mySettings({super.key});

  @override
  State<mySettings> createState() => _mySettingsState();
}

class _mySettingsState extends State<mySettings> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(error1),
            );
          }else{
            return Scaffold(
              backgroundColor: Colors.pink[100],
              appBar: AppBar(
                title: Text('Настройки'),
              ),
            );
          }
          
    },);
  }
}