import './components/transacao_user.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(DespesasPessoaisApp());
}

class DespesasPessoaisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyhomePage()
    );
  }
}

class MyhomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas Pessoais'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: null)
          ],
        ),
        body: Column(          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(              
              child: Card(
                color: Colors.blue,
                child: Text('Grafico'),
                elevation: 5,
              ),
            ),
            TransacaoUser(),
          ],
        )
    );
  }
}