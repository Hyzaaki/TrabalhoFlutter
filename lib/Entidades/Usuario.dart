import 'package:meta/meta.dart';

class Usuario {
  String? id;
  String nome;
  String email;
  String altura;
  String peso;
  String senha;

  // Add any additional properties you need

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.altura,
    required this.peso,
    required this.senha,
    // Initialize additional properties here
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        id: json['id'],
        nome: json['nome'],
        email: json['email'],
        altura: json['altura'],
        peso: json['peso'],
        senha: json['senha']
        // Assign additional properties from JSON here
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'altura': altura,
      'peso': peso,
      'senha': senha,
      // Add additional properties to JSON here
    };
  }
}
