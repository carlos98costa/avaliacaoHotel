import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/hospedagem.dart';

class FormularioHospedagem extends StatefulWidget {
  const FormularioHospedagem({super.key});

  @override
  State<StatefulWidget> createState() {
    return FormularioHospedagemState();
  }
}

class FormularioHospedagemState extends State<FormularioHospedagem> {
  final TextEditingController _controladorCampoNumeroQuarto =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  static const _tituloAppBar = 'Nova hospedagem';
  static const _rotuloCampoValor = 'Valor da hospedagem';
  static const _dicaCampoValor = '0,00';

  static const _rotuloCampoNumeroQuarto = 'Nº do quarto';
  static const _dicaCampoNumeroQuarto = '101';
  static const _textoBotaoConfirmar = 'Confirmar hospedagem';
  static const _mensagemCamposInvalidos =
      'Informe um nº de quarto e um valor válidos.';

  @override
  void dispose() {
    _controladorCampoNumeroQuarto.dispose();
    _controladorCampoValor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_tituloAppBar)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroQuarto,
              rotulo: _rotuloCampoNumeroQuarto,
              dica: _dicaCampoNumeroQuarto,
              icone: Icons.meeting_room,
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.attach_money,
              tipoTeclado: const TextInputType.numberWithOptions(decimal: true),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => _criaHospedagem(context),
                child: const Text(_textoBotaoConfirmar),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _criaHospedagem(BuildContext context) {
    final int? numeroQuarto = int.tryParse(_controladorCampoNumeroQuarto.text);
    final double? valor = double.tryParse(
      _controladorCampoValor.text.replaceAll(',', '.'),
    );

    if (numeroQuarto != null && valor != null) {
      final hospedagemCriada = Hospedagem(valor, numeroQuarto);
      debugPrint('$hospedagemCriada');
      Navigator.pop(context, hospedagemCriada);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(_mensagemCamposInvalidos)),
      );
    }
  }
}
