class Tarefa
{
  String nome;
  String data;
  bool concluida;

  Tarefa(String nome) {
    this.concluida = false;
    this.nome = nome;
    DateTime now = DateTime.now();
    this.data = now.day.toString()+ "/" + now.month.toString() + " - " + now.hour.toString() + ":" + now.minute.toString();
  }
}