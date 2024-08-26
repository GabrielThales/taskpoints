import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_points/routes/routes.dart';

import '../service/auth_provider.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    AuthProviderFB authProvider = context.watch<AuthProviderFB>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Task points',
              style: TextStyle(
                fontSize: 42,
              ),
            ),
            const Text(
              'Uma ferramenta para melhor gerir o seu tempo e tarefas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.clip,
              ),
            ),
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(
                labelText: 'Login',
              ),
            ),
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: () {
                    //TODO: Implementar Login
                    if(_loginController.text.isEmpty || _senhaController.text.isEmpty){
                      var snackBar = SnackBar(
                      content: Text('Digite os dados de login'),);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      var snackBar = SnackBar(
                        content: Text('Dados Invalidos'),
                      );

                      var auth = authProvider
                          .signIn(_loginController.text,
                          _senhaController.text)
                          .then((auth) => auth == true
                          ? Navigator.pushNamed(
                          context, Routes.HOME_VIEW)
                          : ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar));

                    }

                    //Navigator.pushNamed(context, Routes.HOME_VIEW);
                  }, child: Text('Entrar')),
                  ElevatedButton(onPressed: () => {
                    Navigator.pushNamed(context, Routes.CADASTRO_VIEW)
                  }, child: Text('Cadastro'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
