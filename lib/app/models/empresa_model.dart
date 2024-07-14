class EmpresaModel {
  String? logo;
  String? endereco;

  EmpresaModel(
    this.logo,
    this.endereco,
  );

  EmpresaModel.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    endereco = json['address'];
  }
}
