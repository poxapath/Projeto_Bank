class Contato {
  final int? id;
  final String nome;
  final int numeroConta;

  Contato(this.nome, this.numeroConta, {this.id});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'numeroConta': numeroConta};
  }

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(map['nome'], map['numeroConta'], id: map['id']);
  }

  @override
  String toString() {
    return "Contato{id: $id, nome: $nome, numeroConta: $numeroConta}";
  }
}
