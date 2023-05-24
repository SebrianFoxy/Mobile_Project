import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Future <String?> signUpWithEmailAndPassword(String email, String password) async {
  try{
    final response = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );
    final Session? session = response.session;
    final User? user = response.user;
    String jwtToken = response.session!.accessToken;
    return jwtToken;
  }catch(e){
    print(e);
  }
}

Future<String?> signInWithEmailAndPassword(String email, String password) async {
  try {
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final Session? session = response.session!;
    final User? user = response.session!.user;
    String jwtToken = response.session!.accessToken;
    return jwtToken;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<String?> signOutWithEmailAndPassword() async {
  try {
    final response = await Supabase.instance.client.auth.signOut();
  } catch (e) {
    print(e);
  }
}

/*Future<String?> authenticateWithJWT(String token) async {
  try {
    Map<String, dynamic> payload = JwtDecoder.decode(token);

    // Extract data from the token
    String username = payload['UserName'];
    String userId = payload['id'];
    String email = payload['Email'];

    // Authenticate with JWT
    final response = await Supabase.instance.client.auth.recoverSession(token);
    Session? session = response.session;
    User? user = response.user;

    return session?.accessToken;
  } catch (error) {
    // Handle authentication error
    print('Authentication error: $error');
    return null;
  }
}
*/

