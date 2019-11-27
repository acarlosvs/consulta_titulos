class Titulo {
  String sequencial;
  String numeroTitulo;
  String valorDevedor;
  String status;
  String observacao;

  Titulo({this.sequencial, this.numeroTitulo, this.valorDevedor, this.status, this.observacao});

  Titulo.fromJson(Map<String, dynamic> json) {
	  sequencial = json['fn06_SEQU'];
	  numeroTitulo = json['fn06_NUME_TITULO'];
    valorDevedor = json['fn06_VALOR_DEVEDOR'];
    status = json['fn06_STATUS'];
    observacao = json['fn06_OBSE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
      data['fn06_SEQU'] = this.sequencial;
      data['fn06_NUME_TITULO'] = this.numeroTitulo;
      data['fn06_VALOR_DEVEDOR'] = this.valorDevedor;
      data['fn06_STATUS'] = this.status;
      data['fn06_OBSE'] = this.observacao;
    
    return data;
  }
}
