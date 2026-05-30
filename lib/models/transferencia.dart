class Transferencia {
  final int? id;
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta, {this.id});

  // Converte Transferencia → Map (para salvar no banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valor': valor,
      'numeroConta': numeroConta,
    };
  }

  // Converte Map → Transferencia (para ler do banco)
  factory Transferencia.fromMap(Map<String, dynamic> map) {
    return Transferencia(
      map['valor'],
      map['numeroConta'],
      id: map['id'],
    );
  }

  @override
  String toString() {
    return "Transferencia{id: $id, valor: $valor, numeroConta: $numeroConta}";
  }
}