import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';


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
  bool _showChart = false;

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

  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS ?
      GestureDetector(onTap: fn, child: Icon(icon))
      :
      IconButton(icon: Icon(icon), onPressed: fn);
            
          
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh: Icons.list;
    final chartList = Platform.isIOS ? CupertinoIcons.refresh: Icons.show_chart;

    final actions = <Widget>[
        if(isLandScape)
          _getIconButton(
            _showChart? iconList : chartList,             
            () {
              setState((){
                _showChart = !_showChart;
              });
            }
          ),          
        _getIconButton(
          Platform.isIOS ? CupertinoIcons.add : Icons.add, 
          () => _abrirTransacaoFormModal(context),
        ),        
      ];

    final  PreferredSizeWidget appBar = Platform.isIOS
    ? CupertinoNavigationBar(
      middle: Text('Despesas Pessoais'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      ),
    )
    : AppBar(          
      title: Text(
        'Despesas Pessoais',
      ),
      actions: actions,
    );
    final availabelHeight = mediaQuery.size.height
      -appBar.preferredSize.height - mediaQuery.padding.top;

    final bodypage = SafeArea(
      child: SingleChildScrollView(
        child: Column(           
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if(isLandScape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text('Exibir Gráfico'),
            //       Switch.adaptive(
            //         activeColor: Theme.of(context).accentColor,
            //         value: _showChart,
            //         onChanged: (value){
            //         setState(() {
            //           _showChart = value;
            //         });
            //       },)
            //     ],
            //   ),              
            if(_showChart || !isLandScape)
              Container(
                height: availabelHeight * (isLandScape? 0.7 : 0.3),
                child: TransacaoGrafico(_transacoesRecentes)
              ),                                
            if(!_showChart || !isLandScape)
              Container(
                height: availabelHeight * (isLandScape? 1 : 0.7),
                child: TransacaoList(_transacoes, _deleteTransacao),
              ),                                          
          ],
        ),
      ),
    ); 

    return Platform.isIOS 
      ? CupertinoPageScaffold(
        navigationBar: appBar,
        child: bodypage,) 
    
      : Scaffold(
        appBar: appBar,
        body: bodypage,
        floatingActionButton: Platform.isIOS ? 
          Container() 
          : FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _abrirTransacaoFormModal(context),
        ),        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        
    );
  }
}