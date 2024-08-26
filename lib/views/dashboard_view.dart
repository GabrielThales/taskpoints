import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/tarefa_provider.dart';

class DashboardView extends StatefulWidget {
  @override
  State<DashboardView> createState() => _DashboardView();
}

class _DashboardView extends State<DashboardView> {


  @override
  Widget build(BuildContext context) {
    final tarefaProvider = context.watch<TarefaProvider>();

    var totalTarefasConcluidas = tarefaProvider.tarefasConcluidas();
    var pontuacao = tarefaProvider.totalDePontos();
    var tarefasPorPrioridade = tarefaProvider.tarefasPorPrioridade();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
                child: Card(
              color: Color.fromRGBO(135, 181, 78, 1),
              child: Column(
                children: [
                  Text(
                    'Tarefas Concluídas',
                    style: TextStyle(fontSize: 26),
                  ),
                  Text('Total ${totalTarefasConcluidas}'),
                ],
              ),
            )),
            SizedBox(
                child: Card(
                  color: Color.fromRGBO(135, 181, 78, 1),
                  child: Column(
                    children: [
                      Text(
                        'Pontos',
                        style: TextStyle(fontSize: 26),
                      ),
                      Text('Total ${pontuacao}'),
                    ],
                  ),
                )),
            SizedBox(
                child: Card(
                  color: Color.fromRGBO(135, 181, 78, 1),
                  child: Column(
                    children: [
                      Text(
                        'Tarefas por prioridade',
                        style: TextStyle(fontSize: 26),
                      ),
                      Text('Normal ${tarefasPorPrioridade["Normal"]}'),
                      Text('Importante ${tarefasPorPrioridade["Importante"]}'),
                      Text('Muito Importante ${tarefasPorPrioridade["Muito Importante"]}')
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
