import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/Entidades/Usuario.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../Entidades/Refeicao.dart';
import '../Resources/AppColors.dart';
import '../Widgets/LegendWidget.dart';

class TelaResumo extends StatefulWidget {

  @override
  _TelaResumoState createState() => _TelaResumoState();
}

class _TelaResumoState extends State<TelaResumo> {
  List<Refeicao> listaRefeicoes = [];
  List<BarChartGroupData> barGroups = [];

  Future listarRefeicoesUsuario() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUsuario = prefs.getString('currentUser');
    if (idUsuario != null) {
      var refeicoesSnapshot = await FirebaseFirestore.instance
          .collection('refeicoes')
          .where('idUsuario', isEqualTo: idUsuario)
          .get();
      refeicoesSnapshot.docs.forEach((refeicaoItem) {
        var r = Refeicao.fromJson(refeicaoItem.data());
        r.id = refeicaoItem.id;
        listaRefeicoes.add(r);
      });
      if (listaRefeicoes.isNotEmpty) {
        listaRefeicoes.sort((a, b) => a.data.compareTo(b.data));
        var nomes = listaRefeicoes.map((e) => e.nome).toSet().toList();
        nomes.forEach((nome) {
          double c = 0.0;
          double p = 0.0;
          double g = 0.0;
          listaRefeicoes.where((element) => element.nome == nome).toList().forEach((e) {
            c += double.tryParse(e.carbo) ?? 0;
            p += double.tryParse(e.proteina) ?? 0;
            g += double.tryParse(e.gordura) ?? 0;
          });
          print(nome);
          print(c);
          print(p);
          print(g);
          barGroups.add(
            generateGroupData(
              nomes.indexOf(nome),
              c,
              p,
              g
            ),
          );
        });

        setState(() {
          listaRefeicoes = listaRefeicoes;
          barGroups=barGroups;
        });
      }
    }
  }

  @override
  void initState(){
    listarRefeicoesUsuario();
    super.initState();
  }

  final pilateColor = AppColors.contentColorPurple;
  final cyclingColor = AppColors.contentColorCyan;
  final quickWorkoutColor = AppColors.contentColorBlue;
  final betweenSpace = 0.2;

  BarChartGroupData generateGroupData(
      int x,
      double carboidratos,
      double proteinas,
      double gorduras,
      ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: carboidratos,
          color: pilateColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: carboidratos + betweenSpace,
          toY: carboidratos + betweenSpace + proteinas,
          color: quickWorkoutColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: carboidratos + betweenSpace + proteinas + betweenSpace,
          toY: carboidratos + betweenSpace + proteinas + betweenSpace + gorduras,
          color: cyclingColor,
          width: 5,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    text = listaRefeicoes.map((e) => e.nome).toSet().toList()[value.toInt()] ?? 'Holder';
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Refeicoes',
            style: TextStyle(
              color: AppColors.contentColorBlue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          LegendsListWidget(
            legends: [
              Legend('Carboidrato', pilateColor),
              Legend('Proteinas', quickWorkoutColor),
              Legend('Gorduras', cyclingColor),
            ],
          ),
          const SizedBox(height: 14),
          AspectRatio(
            aspectRatio: 2,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 20,
                    ),
                  ),
                ),
                barTouchData: BarTouchData(enabled: true),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: true),
                barGroups: barGroups,
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: 3.3,
                      color: pilateColor,
                      strokeWidth: 1,
                      dashArray: [20, 4],
                    ),
                    HorizontalLine(
                      y: 8,
                      color: quickWorkoutColor,
                      strokeWidth: 1,
                      dashArray: [20, 4],
                    ),
                    HorizontalLine(
                      y: 11,
                      color: cyclingColor,
                      strokeWidth: 1,
                      dashArray: [20, 4],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
