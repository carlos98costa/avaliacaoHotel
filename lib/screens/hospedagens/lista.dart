import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/hospedagem.dart';
import 'formulario.dart';

class ListaHospedagens extends StatefulWidget {
  const ListaHospedagens({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListaHospedagensState();
  }
}

class ListaHospedagensState extends State<ListaHospedagens> {
  static const _tituloAppBar = 'Hospedagens';

  final List<Hospedagem> _hospedagens = [
    Hospedagem(350.00, 101),
    Hospedagem(520.90, 204),
  ];

  Future<void> _atualiza(Hospedagem? hospedagemRecebida) async {
    if (hospedagemRecebida == null) return;

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    setState(() {
      _hospedagens.add(hospedagemRecebida);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_tituloAppBar)),
      body: ListView.builder(
        itemCount: _hospedagens.length,
        itemBuilder: (context, indice) {
          final hospedagem = _hospedagens[indice];
          return ItemHospedagem(hospedagem);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push<Hospedagem>(
            context,
            MaterialPageRoute(
              builder: (context) => const FormularioHospedagem(),
            ),
          ).then((hospedagemRecebida) => _atualiza(hospedagemRecebida));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ItemHospedagem extends StatelessWidget {
  final Hospedagem _hospedagem;

  const ItemHospedagem(this._hospedagem, {super.key});

  @override
  Widget build(BuildContext context) {
    final NumberFormat formato = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );
    return Card(
      child: ListTile(
        leading: const Icon(Icons.hotel),
        title: Text(formato.format(_hospedagem.valor)),
        subtitle: Text('Quarto nº ${_hospedagem.numeroQuarto}'),
      ),
    );
  }
}
