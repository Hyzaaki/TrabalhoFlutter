import 'package:cloud_firestore/cloud_firestore.dart';

class Refeicao {
  String? id;
  String idUsuario;
  String nome;
  String alimento;
  String carbo;
  String proteina;
  String gordura;
  DateTime data;

  // Add any additional properties you need

  Refeicao({
    this.id,
    required this.idUsuario,
    required this.nome,
    required this.alimento,
    required this.carbo,
    required this.proteina,
    required this.gordura,
    required this.data
    // Initialize additional properties here
  });

  factory Refeicao.fromJson(Map<String, dynamic> json) {
    print(json);
    print(json['data']);
    return Refeicao(
      id: json['id'],
      idUsuario: json['idUsuario'],
      nome: json['nome'],
      alimento: json['alimento'],
      carbo: json['carbo'],
      proteina: json['proteina'],
      gordura: json['gordura'],
      data: (json['data'] as  Timestamp).toDate(),
      // Assign additional properties from JSON here
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUsuario': idUsuario,
      'nome': nome,
      'alimento': alimento,
      'carbo': carbo,
      'proteina': proteina,
      'gordura': gordura,
      'data': data,
      // Add additional properties to JSON here
    };
  }
}
