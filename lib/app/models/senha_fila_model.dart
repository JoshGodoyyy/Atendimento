class SenhaFilaModel {
  num? id;
  num? senha;
  num? idFila;
  String? nome;
  String? dataCriacao;

  SenhaFilaModel(
    this.id,
    this.senha,
    this.idFila,
    this.nome,
    this.dataCriacao,
  );

  SenhaFilaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senha = json['password'];
    idFila = json['idQueue'];
    nome = json['name'];
    dataCriacao = json['creationDate'];
  }
}
