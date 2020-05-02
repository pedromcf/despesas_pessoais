
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'models/transacao.dart';

import 'components/transacao_form.dart';
import 'components/transacao_list.dart';
import 'components/transacao_grafico.dart';


void main() {
  runApp(DespesasPessoaisApp());
}

class DespesasPessoaisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],          
      supportedLocales: [const Locale('pt', 'BR')],
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
          ),
          button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ), 
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
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

  final List<Transacao> _transacoes = [];

  List<Transacao> get _transacoesRecentes {
    return _transacoes.where((tr){
      return tr.data.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
        )
      );
    }).toList();
  }
  
  _abrirTransacaoFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) {
        return TransacaoForm(_addTransacao);
      }
    );
  }

  _addTransacao(String titulo, double valor, DateTime data) {
    final novaTransacao = Transacao(
      id: Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      data: data,
    );

    setState(() {
      _transacoes.add(novaTransacao);
    });

    Navigator.of(context).pop();
  }

  _deleteTransacao(String id){
    setState((){
      _transacoes.removeWhere((tr) => tr.id == id);
    });
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
        body: Column(          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: TransacaoGrafico(_transacoesRecentes)
            ),
            Expanded(   
              flex: 5,           
              child: SingleChildScrollView(
                child: TransacaoList(_transacoes, _deleteTransacao),
              )
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _abrirTransacaoFormModal(context),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: Container(
            height: 50,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        
    );
  }
}