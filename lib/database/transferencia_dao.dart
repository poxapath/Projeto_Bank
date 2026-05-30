import '../models/transferencia.dart';
import 'database_helper.dart';

class TransferenciaDao {
  // Salva uma transferência no banco
  static Future<int> inserir(Transferencia transferencia) async {
    final db = await DatabaseHelper.getDatabase();
    return await db.insert('transferencias', transferencia.toMap());
  }

  // Busca todas as transferências salvas
  static Future<List<Transferencia>> listar() async {
    final db = await DatabaseHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('transferencias');
    return maps.map((map) => Transferencia.fromMap(map)).toList();
  }
}