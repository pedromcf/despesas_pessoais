import '../models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransacaoList extends StatelessWidget {

  final List<Transacao> transacoes;
  final void Function(String) onRemove;

  TransacaoList(this.transacoes, this.onRemove);
  
  @override
  Widget build(BuildContext context) {
    return transacoes.isEmpty 
          ? LayoutBuilder(builder: (ctx, constraints){
            return Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Nenhuma Transação adicionada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset('assets/images/waiting.png',
                    fit: BoxFit.cover, 
                  ),
                ),
                        
              ],
            );
          })
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
                  trailing: MediaQuery.of(context).size.width > 400 ?
                    FlatButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text('Excluir'),
                      textColor: Theme.of(context).errorColor,
                      onPressed: () => onRemove(tr.id),
                    )
                  : IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => onRemove(tr.id),
                  ),
                ),
              );
            },
        );
  }
}