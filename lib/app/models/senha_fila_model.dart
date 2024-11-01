class SenhaFilaModel {
  num? id;
  String? prefixo;
  num? senha;
  num? idFila;
  String? nome;
  String? dataCriacao;

  SenhaFilaModel(
    this.id,
    this.prefixo,
    this.senha,
    this.idFila,
    this.nome,
    this.dataCriacao,
  );

  SenhaFilaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prefixo = json['prefix'];
    senha = json['password'];
    idFila = json['idQueue'];
    nome = json['name'];
    dataCriacao = json['creationDate'];
  }
}
