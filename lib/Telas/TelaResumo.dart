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
  List<BarChartGroupData> barGroupsCarboProtGord = [];
  List<BarChartGroupData> barGroupsCalorias = [];

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
          //Gordura * 9
          //Proteina * 4
          //Carboidratos * 4
          double calorias = 0.0;

          listaRefeicoes.where((element) => element.nome == nome).toList().forEach((e) {
            c += double.tryParse(e.carbo) ?? 0;
            p += double.tryParse(e.proteina) ?? 0;
            g += double.tryParse(e.gordura) ?? 0;
            calorias += c * 4 + p * 4 + g * 9;
          });
          print(nome);
          print(c);
          print(p);
          print(g);
          print(calorias);
          barGroupsCarboProtGord.add(
            generateGroupDataCarboProtGord(
              nomes.indexOf(nome),
              c,
              p,
              g
            ),
          );
          barGroupsCalorias.add(
            generateGroupDataCalorias(
                nomes.indexOf(nome),
                calorias
            ),
          );
        });

        setState(() {
          listaRefeicoes = listaRefeicoes;
          barGroupsCarboProtGord=barGroupsCarboProtGord;
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

  BarChartGroupData generateGroupDataCarboProtGord(
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

  BarChartGroupData generateGroupDataCalorias(
      int x,
      double calorias,
      ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: calorias,
          color: pilateColor,
          width: 5,
        ),
      ],
    );
  }

  Widget bottomTitlesCarboProtGord(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    text = listaRefeicoes.map((e) => e.nome).toSet().toList()[value.toInt()] ?? 'Holder';
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitlesCalorias(double value, TitleMeta meta) {
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
      padding: const EdgeInsets.only(bottom: 0, top: 0, left: 15, right: 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Carbo/Prot/Gord das Refeicoes',
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
                      getTitlesWidget: bottomTitlesCarboProtGord,
                      reservedSize: 20,
                    ),
                  ),
                ),
                barTouchData: BarTouchData(enabled: true),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: true),
                barGroups: barGroupsCarboProtGord,
              ),
            ),
          ),
          Divider(),

          const Text(
            'Calorias das Refeicoes',
            style: TextStyle(
              color: AppColors.contentColorBlue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          LegendsListWidget(
            legends: [
              Legend('Calorias', pilateColor),
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
                      getTitlesWidget: bottomTitlesCalorias,
                      reservedSize: 20,
                    ),
                  ),
                ),
                barTouchData: BarTouchData(enabled: true),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: true),
                barGroups: barGroupsCalorias,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
