import 'package:flutter/material.dart';

Widget buildAlertIconWithText() {
  return Container(
    color: Colors.red, // Cor de fundo vermelho
    padding: const EdgeInsets.all(8), // Espaçamento interno do Container
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline, // Ícone de erro
          color: Colors.white, // Cor do ícone (branco)
          size: 24,
        ),
        SizedBox(width: 8),
        Text(
          'Sem conexão', // Texto personalizado
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Cor de fundo do container
      width: double.infinity, // Ocupa a largura total da tela
      height: double.infinity, // Ocupa a altura total da tela
      alignment: Alignment.center, // Alinha o filho no centro
      child: const Text(
        'Olá, munddo!Olá, munddo!Olá, munddo!Olá, munddo!Olá, munddo!Olá, munddo!Olá, munddo!', // A frase a ser exibida
        style: TextStyle(
          color: Colors.white, // Cor do texto
          fontSize: 24, // Tamanho da fonte
        ),
      ),
    );
  }
}
