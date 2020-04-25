import 'package:flutter/material.dart';

class TransacaoForm extends StatefulWidget {

  final void Function(String, double) onSubmit;
  
  TransacaoForm(this.onSubmit);

  @override
  _TransacaoFormState createState() => _TransacaoFormState();
}

class _TransacaoFormState extends State<TransacaoForm> {
  final tituloController = TextEditingController();

  final valorController = TextEditingController();

  _submitForm(){    
    final titulo = tituloController.text;
    final valor = double.tryParse(valorController.text) ?? 0.0;

    if(titulo.isEmpty || valor <=0){
      return;
    }

    widget.onSubmit(titulo,valor); 
       
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
          child: Column(children: <Widget>[
            TextField(
              controller: tituloController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              controller: valorController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
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
                  onPressed: _submitForm, 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}