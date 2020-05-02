import '../models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransacaoList extends StatelessWidget {

  final List<Transacao> transacoes;
  final void Function(String) onRemove;

  TransacaoList(this.transacoes, this.onRemove);
  
  @override
  Widget build(BuildContext context) {
    return Container(
			height: MediaQuery.of(context).size.height * 0.55,      
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
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('R\$${tr.valor}')
                      ),
                    ),
                  ),
                  title: Text(
                    tr.titulo,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.data),                  
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => onRemove(tr.id),
                  ),
                ),
              );
            },
        ),
    );
  }
}