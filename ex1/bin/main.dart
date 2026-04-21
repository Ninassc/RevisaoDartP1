import 'dart:convert';
import 'dart:io';

import 'package:main/livro.dart';

void salvarDados(List<ItemColecao> dadosLivros) {
  final arquivo = File(
    r"/home/nina/Desktop/Link to Programacao/Projetos Dart/revisaoprova/ex1/biblioteca.json",
  );

  List<Map<String, dynamic>> dadosSalvos = dadosLivros
      .map((dados) => dados.toJson())
      .toList();

  arquivo.writeAsStringSync(jsonEncode(dadosSalvos));
}

void main(List<String> arguments) {
  List<ItemColecao> dadosLivros = [];

  final arquivo = File(
    r"/home/nina/Desktop/Link to Programacao/Projetos Dart/revisaoprova/ex1/biblioteca.json",
  );

  if (arquivo.existsSync()) {
    try {
      List<dynamic> dados = jsonDecode(arquivo.readAsStringSync());

      for (var dado in dados) {
        int id = dado["id"];
        String titulo = dado["titulo"];
        String autor = dado["autor"];
        int paginas = dado["paginas"];

        Livro livro = Livro(paginas, id, titulo, autor);
        dadosLivros.add(livro);

        // for (var dado in dadosLivros) {
        //   print(dado.titulo);
        // }
      }
    } catch (err) {
      print(err);
    }
  }

  while (true) {
    stdout.write("1 para CADASTRAR\n2 para PESQUISAR\n0 para SAIR\n--> : ");
    int opcao = int.parse(stdin.readLineSync()!);

    switch (opcao) {
      case 0:
        return;

      case 1:
        int id = dadosLivros.length + 1;

        stdout.write("Título: ");
        String titulo = stdin.readLineSync()!;

        stdout.write("Autor: ");
        String autor = stdin.readLineSync()!;

        stdout.write("Páginas: ");
        int paginas = int.parse(stdin.readLineSync()!);

        if (paginas > 500) {
          print("Este é um livro denso!");
        }

        Livro livro = Livro(paginas, id, titulo, autor);
        dadosLivros.add(livro);

        // for (var dado in dadosLivros) {
        //   print(dado.titulo);
        // }

        salvarDados(dadosLivros);

        break;

      case 2:
        stdout.write("Autor: ");
        String autor = stdin.readLineSync()!;

        for (var dado in dadosLivros) {
          if (dado.pegarAutor == autor) {
            print(dado.titulo);
          }
        }

        break;
    }
  }
}
