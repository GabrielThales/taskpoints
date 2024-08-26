import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/tarefa.dart';
import '../service/tarefa_provider.dart';
import '../tarefa_status.dart';

List<String> listaPrioridades = ['Normal', 'Importante', 'Muito Importante'];

class FormTarefaView extends StatefulWidget {
  @override
  State<FormTarefaView> createState() => _FormTarefaView();

/*@override
  Widget build(BuildContext context) {
    final tarefaProvider = context.watch<TarefaProvider>();

    final tarefa = ModalRoute
        .of(context)!
        .settings
        .arguments as Tarefa?;

    if (tarefa != null) {
      _controllerNome.text = tarefa.nome;
      _controllerLocal.text = tarefa.local;
      _controllerDescricao.text = tarefa.descricao;
    }

    Tarefa novaTarefa;
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Tarefa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controllerNome,
            ),
            TextField(
              controller: _controllerLocal,
            ),
            TextField(
              controller: _controllerDescricao,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Data da Tarefa',
                  filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.primaries.first)
                  )
              ),
              readOnly: true,
              controller: _controllerData,
              onTap: () {
                _selecionarData(context);
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (tarefa == null) {
                    novaTarefa = Tarefa(
                        Random().nextInt(10000),
                        _controllerNome.text,
                        "data",
                        _controllerLocal.text,
                        _controllerDescricao.text,
                        TarefasStatus.EM_ANDAMENTO);
                    tarefaProvider.addTarefa(novaTarefa);
                    Navigator.pop(context);
                  } else {
                    tarefa.nome = _controllerNome.text;
                    tarefa.local = _controllerLocal.text;
                    tarefa.descricao = _controllerDescricao.text;
                    tarefaProvider.editarTarefa(tarefa);
                    Navigator.pop(context);
                  }
                },
                child: Text("Adicionar tarefa"))
            //CalendarDatePicker(initialDate: DateTime.now(), firstDate: firstDate, lastDate: lastDate, onDateChanged: onDateChanged)
          ],
        ),
      ),
    );
  }*/
}

class _FormTarefaView extends State<FormTarefaView> {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();
  final TextEditingController _controllerPrioridade = TextEditingController();
  final TextEditingController _controllerData = TextEditingController();
  String prioridadeTarefa = listaPrioridades.first;


  @override
  Widget build(BuildContext context) {
    final tarefaProvider = context.watch<TarefaProvider>();
    late int dropdownIndex = 0;

    final tarefa = ModalRoute
        .of(context)!
        .settings
        .arguments as Tarefa?;


    if (tarefa != null) {
      _controllerNome.text = tarefa.nome;
      //prioridadeTarefa = tarefa.prioridade;
      //_controllerDescricao.text = tarefa.descricao;
    }

    Tarefa novaTarefa;
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Tarefa'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: _controllerNome,
              decoration: InputDecoration(
                labelText: 'Nome da Tarefa',
              ),
            ),
            Text('Prioridade da tarefa'),
            DropdownButton<String>(
              items: listaPrioridades.map<DropdownMenuItem<String>>((
                  String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: prioridadeTarefa, onChanged: (String? value) {
                setState(() {
                  prioridadeTarefa = value.toString();
                });
            },),
            Container(
              child: TextField(
                decoration: const InputDecoration(
                    labelText: 'Data da Tarefa',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide())),
                readOnly: true,
                controller: _controllerData,
                onTap: () {
                  _selecionarData(context);
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (tarefa == null && validarCampos(context)) {
                    novaTarefa = Tarefa(
                        Random().nextInt(10000).toString(),
                        _controllerNome.text,
                        _controllerData.text,
                        _controllerPrioridade.text,
                        prioridadeTarefa,
                        TarefasStatus.EM_ANDAMENTO,
                        10
                    );
                    tarefaProvider.addTarefa(novaTarefa);
                    Navigator.pop(context);
                  } else {
                    tarefa?.nome = _controllerNome.text;
                    tarefa?.prioridade = prioridadeTarefa;
                    tarefa?.dataTermino = _controllerData.text;
                    //tarefaProvider.editarTarefa(tarefa!);
                    Navigator.pop(context);
                  }
                },
                child: Text("Adicionar tarefa"))
            //CalendarDatePicker(initialDate: DateTime.now(), firstDate: firstDate, lastDate: lastDate, onDateChanged: onDateChanged)
          ],
        ),
      ),
    );
  }

  Future<void> _selecionarData(BuildContext context) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_picked != null) {
      setState(() {
        _controllerData.text = _picked.toString().split(" ")[0];
      });
    }

    TimeOfDay? _timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: TimeOfDay
                .now()
                .hour, minute: TimeOfDay
            .now()
            .minute));

    if (_timePicked != null) {
      setState(() {
        _controllerData.text += " ${_timePicked.hour}:${_timePicked.minute}";
      });
    }
  }

  bool validarCampos(BuildContext context) {
    if (_controllerNome.text.isEmpty || _controllerData.text.isEmpty) {
      final snackBar = SnackBar(
        content: Text('faltam informações'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    } else {
      return true;
    }
  }
}
