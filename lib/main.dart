import 'package:cognitivyskills/Levels/Level2.dart';
import 'package:cognitivyskills/ui/navigation.dart';
import 'package:cognitivyskills/ui/startHome.dart';
import 'package:flutter/material.dart';
import 'ui/registration.dart';
import 'ui/authorization.dart';
import 'ui/startHome.dart';
import 'ui/profilemenu.dart';
import 'ui/checkauth.dart';
import 'ui/settingsmenu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Levels/Level1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://liaqzljdfubvopdiwwtz.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxpYXF6bGpkZnVidm9wZGl3d3R6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODM3MTQyMjMsImV4cCI6MTk5OTI5MDIyM30.9-yI167Iq4e8PmTTJem90470OvWfdOOH0vpO0b6TTlw',
  );
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.deepOrange,
    ),
    home: checkauth(),
  ));
}
