import 'dart:math';
import 'package:flutter/material.dart';

import '../models/transacao.dart';
import 'transacao_form.dart';
import 'transacao_list.dart';

class TransacaoUser extends StatefulWidget {
  @override
  _TransacaoUserState createState() => _TransacaoUserState();
}

class _TransacaoUserState extends State<TransacaoUser> {
  final _transacoes = [
    Transacao(
      id: 't1',
      titulo: 'Novo tênis de corrida',
      valor: 310.76,
      data: DateTime.now(),
    ),
    Transacao(
      id: 't2',
      titulo: 'Conta de Luz',
      valor: 211.30,
      data: DateTime.now(),
    ),
  ];

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransacaoList(_transacoes),
        TransacaoForm(_addTransacao),
      ],
    );
  }
}