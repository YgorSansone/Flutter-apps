class Tarefa
{
  String nome;
  DateTime data;
  bool concluida;

  Tarefa(String nome) {
    this.concluida = false;
    this.nome = nome;
    this.data = DateTime.now();
  }
}