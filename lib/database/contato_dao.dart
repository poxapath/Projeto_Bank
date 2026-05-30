import '../models/contato.dart';
import 'database_helper.dart';

class ContatoDao {
  static Future<int> inserir(Contato contato) async {
    final db = await DatabaseHelper.getDatabase();
    return await db.insert('contatos', contato.toMap());
  }

  static Future<List<Contato>> listar() async {
    final db = await DatabaseHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('contatos');
    return maps.map((map) => Contato.fromMap(map)).toList();
  }
}
