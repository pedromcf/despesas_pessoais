import '../models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransacaoList extends StatelessWidget {

  final List<Transacao> transacoes;

  TransacaoList(this.transacoes);
  
  @override
  Widget build(BuildContext context) {
    return Container(
			height: MediaQuery.of(context).size.height * 0.39,      
      	child: transacoes.isEmpty 
          ? Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Nenhuma Transação adicionada!',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.20, 
                child: Image.asset('assets/images/waiting.png',
                  fit: BoxFit.cover, 
                ),
              ),
                       
            ],
          )
          : ListView.builder(
              itemCount: transacoes.length,
              itemBuilder: (ctx, index) {
              final tr = transacoes[index];
              
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
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'R\$ ${tr.valor.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        )
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,                          
                      children: <Widget>[
                        Text(
                          tr.titulo,
                          style: Theme.of(context).textTheme.headline6,                          
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
            },
        ),
    );
  }
}