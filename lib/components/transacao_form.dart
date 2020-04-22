import 'package:flutter/material.dart';
import 'transacao_user.dart';

class TransacaoForm extends StatelessWidget {

  final tituloController = TextEditingController();
  final valorController = TextEditingController();

  final void Function(String, double) onSubmit;
  
  TransacaoForm(this.onSubmit);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
          child: Column(children: <Widget>[
            TextField(
              controller: tituloController,
              decoration: InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              controller: valorController,
              decoration: InputDecoration(
                labelText: 'Valor',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(                          
                  child: Text('Nova Transação'),
                  textColor: Colors.purple,
                  onPressed: () {                    
                    final titulo = tituloController.text;
                    final valor = double.tryParse(valorController.text) ?? 0.0;
                    onSubmit(titulo,valor);
                  }, 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}