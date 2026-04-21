abstract class Pet {
  int id = 0;
  String nome = "";
  double _peso = 0.0;

  Pet(this.id, this.nome);

  void setPeso(double peso) {
    if (peso > 0) {
      _peso = peso;
    } else {
      throw Exception("Peso deve ser maior que 0");
    }
  }

  double get pegarPeso => _peso;

  void engordar(double ganho) {
    _peso += ganho;
  }

  Map<String, dynamic> toJson();
}

class Cachorro extends Pet {
  String raca = "";

  Cachorro(this.raca, super.id, super.nome);

  @override
  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "nome" : nome,
      "peso" : pegarPeso,
      "raca" : raca
    };
  }
}
