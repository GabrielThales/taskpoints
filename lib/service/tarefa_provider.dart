import 'dart:math';

import 'package:flutter/material.dart';
import '../domain/tarefa.dart';

class TarefaProvider extends ChangeNotifier {

  List<Tarefa>? listaDeTarefas = [
    Tarefa("1313", "Estudar Flutter", "2024-08-29 16:20", null, "Importante", "Em Andamento", 20 ),
    Tarefa("3232", "Estudar Dart", "2024-08-29 16:20", null, "Normal", "Em Andamento", 10 ),
    Tarefa("1231", "Estudar Ux", "2024-08-29 16:20", null, "Normal", "Em Andamento", 10 ),
  ];

  List<Tarefa>? listaDeTarefasConcluidas = [];

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

  int totalDePontos (){
    var pontos = 0;
    if(listaDeTarefasConcluidas!.isNotEmpty){
      listaDeTarefasConcluidas?.forEach((element) { pontos += element.pontuacao;});
    }
    notifyListeners();
    return pontos;
  }

  int tarefasConcluidas(){
    var totalTarefasConcluidas = 0;
    if (listaDeTarefasConcluidas!.isNotEmpty){
      totalTarefasConcluidas = listaDeTarefasConcluidas!.length;
    }
    notifyListeners();
    return totalTarefasConcluidas;
  }

  Map<String, int> tarefasPorPrioridade() {
    Map<String, int> mapPrioridades = {};
    mapPrioridades['Normal'] = 0;
    mapPrioridades['Importante'] = 0;
    mapPrioridades['Muito Importante'] = 0;
    if(listaDeTarefasConcluidas!.isNotEmpty){
      listaDeTarefasConcluidas!.forEach((element) {
        switch(element.prioridade){
          case "Normal" : mapPrioridades['Normal'] = (mapPrioridades['Normal']! +1);
          case "Importante" : mapPrioridades['Importante'] = (mapPrioridades['Importante']! +1);
          case "Muito Importante" : mapPrioridades['Muito Importante'] = (mapPrioridades['Muito Importante']! +1);
        }
      });
    }
    return mapPrioridades;
  }

  void editarTarefa(Tarefa tarefaAtualizada){
    listaDeTarefas?.forEach((element) {
      if(element.id == tarefaAtualizada.id){
        element.nome = tarefaAtualizada.nome;
        element.dataTermino = tarefaAtualizada.dataTermino;
        element.status = tarefaAtualizada.status;
      }
    });
    notifyListeners();
  }
  
  void concluirTarefa(Tarefa tarefaConcluida){
    listaDeTarefas?.forEach((element) {
      if(element.id == tarefaConcluida.id){
        element.status = tarefaConcluida.status;
        listaDeTarefasConcluidas?.add(tarefaConcluida);
      }
    }
    );
    removerTarefa(tarefaConcluida);
    notifyListeners();
  }

}