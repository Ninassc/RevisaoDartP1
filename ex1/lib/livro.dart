abstract class ItemColecao {
  int id;
  String titulo;
  String _autor = "";

  void setAutor(String autor) {
    if (!(autor.isEmpty && autor.length < 3)) {
      _autor = autor;
    } else {
      throw Exception("Autor Inválido");
    }
  }

  String get pegarAutor => _autor;

  ItemColecao(this.id, this.titulo);

   Map<String, dynamic> toJson();
}

class Livro extends ItemColecao{
  int paginas;

  Livro(this.paginas, super.id, super.titulo, String autor){
    _autor = autor;
  }

  @override
  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "titulo" : titulo,
      "autor" : _autor,
      "paginas" : paginas
    };
  }
}
