import 'package:flutter/material.dart';
import 'package:task_points/widgets/tarefa_card.dart';

class PerfilView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Nome do usuário',
            style: TextStyle(
              fontSize: 32,
            ),),
          ],
        ),
      ),
    );

  }

}