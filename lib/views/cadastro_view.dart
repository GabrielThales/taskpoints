import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/auth_provider.dart';

class CadastroView extends StatelessWidget {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    AuthProviderFB authProvider = context.watch<AuthProviderFB>();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Tela de Cadastro'),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              controller: _loginController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Senha',
              ),
              controller: _senhaController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            ElevatedButton(onPressed: () {
              //TODO: Implementar Cadastro
                var snackBar = SnackBar(content: Text('Dados insuficientes'));
                  if(_loginController.text.isNotEmpty && _senhaController.text.
                  isNotEmpty) {
                authProvider.signUp(_loginController.text, _senhaController.text)
                    .then((bool) => bool == true ? Navigator.pop(context) : ScaffoldMessenger.of(context).showSnackBar(snackBar));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

    }, child: Text('Confirmar cadastro')),
            ElevatedButton(onPressed: () => {
              Navigator.pop(context)
            }, child: Text('Retornar para Login'))
          ],
        ),
      )
    );
  }

}