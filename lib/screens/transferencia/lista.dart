import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transferencia.dart';
import '../../database/transferencia_dao.dart';
import 'formulario.dart';
import '../contato/lista.dart';

class ListaTransferencias extends StatefulWidget {
  const ListaTransferencias({super.key});

  @override
  State<ListaTransferencias> createState() => _ListaTransferenciasState();
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transferência',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        actions: [
          IconButton(
            icon: const Icon(Icons.people, color: Colors.white),
            tooltip: 'Contatos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ListaContatos()),
              );
            },
          ),
        ],
      ),
      // FutureBuilder reconstrói a interface conforme o estado da operação
      body: FutureBuilder<List<Transferencia>>(
        future: TransferenciaDao.listar(), // busca no banco
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              // Enquanto carrega, exibe indicador de progresso
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                // Se houver erro, exibe mensagem
                return const Center(
                  child: Text('Erro ao carregar transferências.'),
                );
              }
              final transferencias = snapshot.data ?? [];
              if (transferencias.isEmpty) {
                return const Center(
                  child: Text('Nenhuma transferência encontrada.'),
                );
              }
              // Formatação monetária brasileira: 1234.5 → R$ 1.234,50
              final formatador = NumberFormat.simpleCurrency(locale: 'pt_BR');
              return ListView.builder(
                itemCount: transferencias.length,
                itemBuilder: (context, index) {
                  final transferencia = transferencias[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.monetization_on,
                        color: Colors.green,
                      ),
                      title: Text(formatador.format(transferencia.valor)),
                      subtitle: Text('Conta: ${transferencia.numeroConta}'),
                    ),
                  );
                },
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // async/await em vez de .then() — mais limpo e legível
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FormularioTransferencia()),
          );
          setState(() {}); // recarrega a lista ao voltar
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
