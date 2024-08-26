import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:trivia/services/firestore_provider.dart';

class AuthProviderFB extends ChangeNotifier{
  String? message;
  String? token;

  final firebaseAuth = FirebaseAuth.instance;
//  final firestore = FirestoreProviderTrivia();

  final _url = 'https://identitytoolkit.googleapis.com/v1/';
  final _resource = 'accounts:'; // signUp // signInWithPassword
  final _apiKey = '?key=AIzaSyA-ctlNMU3HhL806fPdnblb4JvzOEox5VM';


  Future<bool> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      token = userCredential.credential?.token.toString();
      message = "Usuário cadastrado com sucesso!";
      return true;
    } on FirebaseAuthException catch (e) {
      message = "Erro ao cadastrar Usuário!";
      print(e.code);
      print(e.message);
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      token = userCredential.credential?.token.toString();
      //firestore.insert(firebaseAuth.currentUser!.uid, email.split("@")[0], 0, 0, 0);
      return true;
    } on FirebaseAuthException catch (e) {
      message = "Erro ao autenticar o Usuário!";
      print(e.code);
      print(e.message);
      return false;
    }
  }

}