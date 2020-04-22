import '../models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransacaoList extends StatelessWidget {

  final List<Transacao> transacoes;

  TransacaoList(this.transacoes);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: 
        transacoes.map((tr) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10
                  ),
                  decoration: BoxDecoration(
                    border:Border.all(
                      color: Colors.purple,
                      width: 2,
                    )
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'R\$ ${tr.valor.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple,
                    )
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,                          
                  children: <Widget>[
                    Text(
                      tr.titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      DateFormat('d MMM y').format(tr.data).toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:16,
                        color: Colors.grey
                      )
                    ),
                ],
                )
              ],
            ),
          );
        }).toList(),      
    );
  }
}