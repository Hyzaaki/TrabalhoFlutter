class Refeicao {
  String? id;
  String idUsuario;
  String nome;
  String alimento;
  String carbo;
  String proteina;
  String gordura;

  // Add any additional properties you need

  Refeicao({
    this.id,
    required this.idUsuario,
    required this.nome,
    required this.alimento,
    required this.carbo,
    required this.proteina,
    required this.gordura,
    // Initialize additional properties here
  });

  factory Refeicao.fromJson(Map<String, dynamic> json) {
    return Refeicao(
      id: json['id'],
      idUsuario: json['idUsuario'],
      nome: json['nome'],
      alimento: json['alimento'],
      carbo: json['carbo'],
      proteina: json['proteina'],
      gordura: json['gordura'],
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
      // Add additional properties to JSON here
    };
  }
}
