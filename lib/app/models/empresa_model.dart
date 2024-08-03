class EmpresaModel {
  String? nome;
  String? logo;
  String? endereco;

  EmpresaModel(
    this.nome,
    this.logo,
    this.endereco,
  );

  EmpresaModel.fromJson(Map<String, dynamic> json) {
    nome = json['name'];
    logo = json['logo'];
    endereco = json['address'];
  }
}
