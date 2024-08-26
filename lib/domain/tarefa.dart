class Tarefa {
  String id;
  String nome;
  String dataInicio;
  //String dataPlanejadaTermino;
  late String? dataTermino;
  String prioridade;
  String status;
  //bool recorrente;
  late int pontuacao;

  Tarefa(
      this.id,
      this.nome,
      this.dataInicio,
      //this.dataPlanejadaTermino,
      this.dataTermino,
      this.prioridade,
      this.status,
      this.pontuacao
      //this.recorrente
      ){}

}