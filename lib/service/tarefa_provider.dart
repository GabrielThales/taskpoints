import 'dart:math';

import 'package:flutter/material.dart';
import '../domain/tarefa.dart';

class TarefaProvider extends ChangeNotifier {

  List<Tarefa>? listaDeTarefas = [
    Tarefa("Id", "Estudar Flutter", "18/10/2024", null, "Importante", "Em Andamento", 20 ),
    Tarefa("Id", "Estudar Dart", "18/10/2024", null, "Normal", "Em Andamento", 10 ),
    Tarefa("Id", "Estudar Ux", "18/10/2024", null, "Normal", "Em Andamento", 10 ),
  ];

  Tarefa? ultimaTarefaExcluida;

  List<Tarefa> listarTarefas(){
    notifyListeners();
      return listaDeTarefas!;
  }

  void addTarefa(Tarefa tarefa){
    listaDeTarefas?.add(tarefa);
    notifyListeners();
  }

  void removerTarefa(Tarefa tarefa){
    ultimaTarefaExcluida = tarefa;
    listaDeTarefas?.remove(tarefa);
    notifyListeners();
  }

  void restaurarUltimaTarefa(){
    if(ultimaTarefaExcluida != null){
      listaDeTarefas?.add(ultimaTarefaExcluida!);
      notifyListeners();
    }
  }

  /*void editarTarefa(Tarefa tarefaAtualizada){
    listaDeTarefas?.forEach((element) {
      if(element.id == tarefaAtualizada.id){
        element.nome = tarefaAtualizada.nome;
        element.dateTime = tarefaAtualizada.dateTime;
        element.local = tarefaAtualizada.local;
        element.descricao = tarefaAtualizada.descricao;
        element.status = tarefaAtualizada.status;
      }
    });
    notifyListeners();
  }*/

}