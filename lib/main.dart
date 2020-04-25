import 'package:flutter/material.dart';
import 'dart:math';

import 'models/transacao.dart';

import 'components/transacao_form.dart';
import 'components/transacao_list.dart';


void main() {
  runApp(DespesasPessoaisApp());
}

class DespesasPessoaisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyhomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16,
            fontWeight: FontWeight.bold
          )
        ), 
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          ),
        )        
      )
    );
  }
}

class MyhomePage extends StatefulWidget {

  @override
  _MyhomePageState createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {

  final List<Transacao> _transacoes = [
    // Transacao(
    //   id: 't1',
    //   titulo: 'Novo tênis de corrida',
    //   valor: 310.76,
    //   data: DateTime.now(),
    // ),
    // Transacao(
    //   id: 't2',
    //   titulo: 'Conta de Luz',
    //   valor: 211.30,
    //   data: DateTime.now(),
    // ),
    
  ];
  
  _abrirTransacaoFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) {
        return TransacaoForm(_addTransacao);
      }
    );
  }

  _addTransacao(String titulo, double valor) {
    final novaTransacao = Transacao(
      id: Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      data: DateTime.now(),
    );

    setState(() {
      _transacoes.add(novaTransacao);
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(          
          title: Text('Despesas Pessoais'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add
              ), 
              onPressed: () => _abrirTransacaoFormModal(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(          
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(              
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Text('Grafico'),
                  elevation: 5,
                ),
              ),
              TransacaoList(_transacoes),                
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _abrirTransacaoFormModal(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}