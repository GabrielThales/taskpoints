import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_points/widgets/tarefa_card.dart';

import '../service/tarefa_provider.dart';

class PerfilView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final tarefaProvider = context.watch<TarefaProvider>();
    var pontos = tarefaProvider.totalDePontos();
    var user = FirebaseAuth.instance;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text( user != null ? user.currentUser!.email.toString() : "Usuário não logado",
            style: const TextStyle(
              fontSize: 24,
            ),
            ),
            Text('Pontos: ${pontos.toString()}',
            style: const TextStyle(
              fontSize: 24,
            ),),
          ],
        ),
      ),
    );

  }

}