import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transacao.dart';
import 'grafico_bar.dart';

class TransacaoGrafico extends StatelessWidget {

  final List<Transacao> transacoesRecentes;

  TransacaoGrafico(this.transacoesRecentes);

  List<Map<String, Object>> get groupTransacao {
    return List.generate(7, (index) {
      final diaSemana = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalGasto = 0.0;

      for(var i = 0; i < transacoesRecentes.length; i++){
        bool mesmoDia = transacoesRecentes[i].data.day == diaSemana.day;
        bool mesmoMes = transacoesRecentes[i].data.month == diaSemana.month;
        bool mesmoAno = transacoesRecentes[i].data.year == diaSemana.year;

        if (mesmoDia && mesmoMes && mesmoAno) {
          totalGasto += transacoesRecentes[i].valor;
          
        }
      } 

      return {
        'day': DateFormat.E().format(diaSemana)[0], 
        'valor': totalGasto,
      };
    }).reversed.toList();
  }

  double get _valorTotalSemana {
    return groupTransacao.fold(0.0, (soma, tr) {
      return soma + tr['valor'];
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(        
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransacao.map((tr) {
            return Flexible(
              fit: FlexFit.tight,            
              child: GraficoBar(
                label: tr['day'],
                valor: tr['valor'],
                percentual: _valorTotalSemana == 0 ? 0 :( tr['valor'] as double) / _valorTotalSemana,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}