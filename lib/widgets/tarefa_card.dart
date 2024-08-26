import 'package:flutter/material.dart';

import '../domain/tarefa.dart';
import '../routes/routes.dart';
import '../tarefa_status.dart';

class TarefaCard extends StatefulWidget {
  final Tarefa tarefa;
  const TarefaCard(this.tarefa, {super.key}) : super();

  @override
  State<TarefaCard> createState() => _TarefaCard();
}

class _TarefaCard extends State<TarefaCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (widget.tarefa.status == TarefasStatus.EM_ANDAMENTO) ? const Icon(Icons.task) : const Icon(Icons.task_alt),
      title: Text(
        widget.tarefa.nome,
        style: TextStyle(fontSize: 22, overflow: TextOverflow.clip),
      ),
      subtitle: Text("Prioridade: ${widget.tarefa.prioridade}",
        style: TextStyle(fontSize: 16, overflow: TextOverflow.clip),
      ),
      trailing: Text(
        widget.tarefa.dataInicio,
        style: TextStyle(fontSize: 14, overflow: TextOverflow.clip),
      ),
      onTap: () {
        Navigator.pushNamed(context, Routes.TAREFA_VIEW, arguments: widget.tarefa);
      },
    );
  }
}
