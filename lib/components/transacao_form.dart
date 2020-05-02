import 'package:despesas_pessoais/components/adaptative_date_picker.dart';
import 'package:flutter/material.dart';


import 'adaptative_button.dart';
import 'adaptative_textfield.dart';

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

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top:10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextfield(
                label: 'Titulo',
                valorController: _tituloController,
                onSubmitted: (_) => _submitForm(),                
              ),
              AdaptativeTextfield(
                label: 'Valor',
                valorController: _valorController,
                onSubmitted: (_) => _submitForm(), 
                keyboardType: TextInputType.numberWithOptions(decimal: true),               
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate){
                  setState((){
                    _selectedDate = newDate;
                  });
                },

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(label:'Nova Transação',onPressed: _submitForm),                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}