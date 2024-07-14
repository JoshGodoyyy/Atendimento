class FilaAtendimentoModel {
  num? id;
  String? nome;
  num? prioridade;
  num? ultimaSenha;
  String? dataUltimaSenha;

  FilaAtendimentoModel({
    this.id,
    this.nome,
    this.prioridade,
    this.ultimaSenha,
    this.dataUltimaSenha,
  });

  FilaAtendimentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['name'];
    prioridade = json['priority'];
    ultimaSenha = json['lastPassword'];
    dataUltimaSenha = json['datePassword'];
  }
}
