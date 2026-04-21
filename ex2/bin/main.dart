import 'dart:convert';
import 'dart:io';

import 'package:main/animal.dart';

void salvarArquivo(List<Cachorro> carregarDados) {
  final arquivo = File("./petshop.json");

  List<dynamic> dadosSalvos = carregarDados
      .map((dado) => dado.toJson())
      .toList();

  arquivo.writeAsStringSync(jsonEncode(dadosSalvos));
}

void mostrar(List<Cachorro> carregarDados) {
  for (var dado in carregarDados) {
    print("ID = ${dado.id}");
    print("Nome = ${dado.nome}");
    print("Peso = ${dado.pegarPeso}");
    print("Raça = ${dado.raca}");
  }
}

void main(List<String> arguments) {
  List<Cachorro> carregarDados = [];

  final arquivo = File("./petshop.json");

  if (arquivo.existsSync()) {
    List<dynamic> dados = jsonDecode(arquivo.readAsStringSync());

    for (var dado in dados) {
      int id = dado["id"];
      String nome = dado["nome"];
      double peso = dado["peso"];
      String raca = dado["raca"];

      Cachorro pet = Cachorro(raca, id, nome);
      pet.setPeso(peso);

      carregarDados.add(pet);
    }
  }

  while (true) {
    stdout.write(
      "Digite:\n[1] para ATUALIZAR PESO\n[2] para REMOVER PET\n[3] para EXIBIR MÉDIA DE PESOS\n[4] para MOSTRAR TUDO\n[5] para SAIR\n---> ",
    );

    int opcao = int.parse(stdin.readLineSync()!);

    switch (opcao) {
      case 1:
        stdout.write("ID de um pet: ");
        int idDigitado = int.parse(stdin.readLineSync()!);

        for (var dado in carregarDados) {
          if (dado.id == idDigitado) {
            stdout.write("Ganho de Peso: ");
            double pesoDigitado = double.parse(stdin.readLineSync()!);
            dado.engordar(pesoDigitado);
            salvarArquivo(carregarDados);
            break;
          }
        }
        break;

      case 2:
        stdout.write("ID de um pet: ");
        int idDigitado = int.parse(stdin.readLineSync()!);

        carregarDados.removeWhere((dado) => dado.id == idDigitado);
        salvarArquivo(carregarDados);
        break;

      case 3:
        double soma = 0;

        for (var dado in carregarDados) {
          soma += dado.pegarPeso;
        }

        double media = soma / carregarDados.length;

        print("Média de Pesos = {$media}kg");
        break;

      case 4:
        mostrar(carregarDados);
        break;

      case 5:
        return;
    }
  }
}
