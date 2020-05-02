import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransacaoForm extends StatefulWidget {

  final void Function(String, double, DateTime) onSubmit;
  
  TransacaoForm(this.onSubmit);

  @override
  _TransacaoFormState createState() => _TransacaoFormState();
}

class _TransacaoFormState extends State<TransacaoForm> {
  final _tituloController = TextEditingController();
  final _valorController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm(){    
    final titulo = _tituloController.text;
    final valor = double.tryParse(_valorController.text) ?? 0.0;
    final data = _selectedDate;

    if(titulo.isEmpty || valor <=0 || _selectedDate == null){
      return;
    }

    widget.onSubmit(titulo,valor,data); 
       
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),      
      lastDate: DateTime(DateTime.now().year + 10),

    ).then((pickedDate) {

      if (pickedDate == null) {
        return;        
      }

      setState((){
        _selectedDate = pickedDate;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
          child: Column(children: <Widget>[
            TextField(
              controller: _tituloController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              controller: _valorController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor',
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null ? 'Nenhuma data selecionada!'
                      : 'Data Selecionada ${DateFormat('dd/MM/y').format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _showDatePicker, 
                    child: Text('Selecionar Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ), 
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(                          
                  child: Text('Nova Transação'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
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