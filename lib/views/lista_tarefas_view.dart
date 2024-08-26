import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_points/domain/tarefa.dart';
import 'package:task_points/widgets/tarefa_card.dart';

import '../service/tarefa_provider.dart';

class ListaTarefasView extends StatefulWidget {

  @override
  State<ListaTarefasView> createState() => _TarefasView();

}

class _TarefasView extends State<ListaTarefasView> {
  @override
  Widget build(BuildContext context) {
    final tarefaProvider = context.watch<TarefaProvider>();
    final List<Tarefa>? listaTarefas = tarefaProvider.listaDeTarefas;

    //var tarefa = Tarefa("Id", "Estudar Flutter", "18/10/2024", null, "Importante", "Em Andamento", 10 );

    return ListView.builder(
      itemCount: listaTarefas?.length,itemBuilder: (BuildContext context, int index) {
      Tarefa tarefa = listaTarefas![index];
      return TarefaCard(tarefa);
    },

    );

  }
}
