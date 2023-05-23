import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './startHome.dart';
import 'package:cognitivyskills/ui/profilemenu.dart';


class checkauth extends StatefulWidget {
  const checkauth({super.key});

  @override
  State<checkauth> createState() => _checkauthState();
}

class _checkauthState extends State<checkauth> {
  @override
  bool isLoggedIn = false;
  void initState() {
    final User? user = Supabase.instance.client.auth.currentUser;
    if (user.isUndefined) {
      setState(() {
        isLoggedIn = false;
      });
    } else {
      setState(() {
        isLoggedIn = true;
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? new profilemenu() : new startHome();
  }
}
