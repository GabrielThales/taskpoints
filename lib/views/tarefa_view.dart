import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/tarefa.dart';
import '../routes/routes.dart';
import '../service/tarefa_provider.dart';
import '../tarefa_status.dart';

class TarefaView extends StatefulWidget {
  TarefaView({super.key});

  @override
  State<TarefaView> createState() => _TarefaView();
}

class _TarefaView extends State<TarefaView> {
  @override
  Widget build(BuildContext context) {
    final tarefaProvider = context.watch<TarefaProvider>();
    final Tarefa tarefa = ModalRoute.of(context)!.settings.arguments as Tarefa;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  tarefa.nome,
                  style: TextStyle(fontSize: 32, overflow: TextOverflow.clip),
                ),
                Text(
                      "Prioridade: ${tarefa.prioridade.toString()}",
                  style: TextStyle(fontSize: 28, overflow: TextOverflow.clip),
                ),
                Text(
                  tarefa.dataInicio,
                  style: TextStyle(fontSize: 24, overflow: TextOverflow.clip),
                ),
                Text(
                  tarefa.status,
                  style: TextStyle(fontSize: 22, overflow: TextOverflow.clip),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: IconButton(
          onPressed: () {
            setState(() {
              tarefa.status = TarefasStatus.CONCLUIDO;
              tarefaProvider.concluirTarefa(tarefa);
              Navigator.pop(context);
            });
          },
          icon: Icon(Icons.task_alt),
        ),
          label: 'Concluir'
        ),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.FORM_TAREFA_VIEW, arguments: tarefa);
                },
                icon: Icon(Icons.edit)),
            label: 'Editar'),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  tarefaProvider.removerTarefa(tarefa);
                  final snackBar = SnackBar(
                    content: Text('Item Excluído, deseja restaurar ?'),
                    action: SnackBarAction(
                        label: 'Restaurar',
                        onPressed: () =>
                            {tarefaProvider.restaurarUltimaTarefa()}),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete_forever)),
            label: 'Deletar')
      ]),
    );
  }
}
