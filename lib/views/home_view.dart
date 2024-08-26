import 'package:flutter/material.dart';
import 'package:task_points/views/perfil_view.dart';
import 'package:task_points/views/lista_tarefas_view.dart';

import '../routes/routes.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  int _currentIndex = 0;
  List<Widget> body= [
    ListaTarefasView(),
    const Icon(Icons.dashboard),
    PerfilView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Point',
        ),
        leading: IconButton(onPressed: () {
          Navigator.pushNamed(context, Routes.FORM_TAREFA_VIEW);
          //tarefaProvider.addTarefa(Tarefa(4,'Estudar Autenticação', '20/05/2024', 'Infnet', "teste da descrição do item", TarefasStatus.EM_ANDAMENTO));
        }, icon: Icon(Icons.add, semanticLabel: 'Adicionar nova tarefa',),),

      ),
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.house),
              label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil'
          )
        ],
      ),
    );
  }
}
