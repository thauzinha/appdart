import 'package:app_lista_tarefas/modelo/objeto_data_hora.dart';
import 'package:flutter/material.dart';
import '/widgets/itens_lista.dart';

class Pagina_lista extends StatefulWidget {
  @override
  State<Pagina_lista> createState() => _Pagina_listaState();
}

class _Pagina_listaState extends State<Pagina_lista> {
  final TextEditingController mensagensControlador = TextEditingController();

  List<Data_Hora> Mensagens = [];
  Data_Hora? deletar_itens;
  int? posicao_atual_deletar;

  void adicionarMensagem() {
    String qualquercoisa = mensagensControlador.text;
    mensagensControlador.clear();
    setState((){
      Data_Hora item_Data_Hora = Data_Hora(
          titulo: qualquercoisa, DataHora: DateTime.now());
       Mensagens.add(item_Data_Hora);
    });
  }
  void deletar_tarefas(Data_Hora item_data_hora) {
      deletar_itens = item_data_hora;
      posicao_atual_deletar = Mensagens.indexOf(item_data_hora);
    setState(() {
      Mensagens.remove(item_data_hora);
       });
       ScaffoldMessenger.of(context).showSnackBar( 
    SnackBar(
       content: 
       Text(
        "tarefa ${item_data_hora.titulo} foi removida com sucesso",
        style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label:"Desfazer",
              onPressed: () {
                setState(() {
                  Mensagens.insert(posicao_atual_deletar!, deletar_itens!);
                });
                
              },
              ),
            ),
          ); 
        }

void limparMensagens(){
  setState(() {
    mensagem_confirmacao();
  });
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: mensagensControlador,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Adicione uma tarefa",
                          hintText: "Digite aqui",
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: adicionarMensagem,
                    style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(240, 200, 4, 4),
                    padding: EdgeInsets.all(20)
                    ),
                    child: Icon(
                    Icons.add,
                    size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Flexible(child: ListView(
                shrinkWrap: true,
                children: [
                  for (Data_Hora mensagemcontrole in Mensagens)
                  tudoItemLista(
                    mensagem_data_hora: mensagemcontrole,
                    item_deletar_tarefas: deletar_tarefas,
                    ),
                  ],
                ),
               ),
              
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text("Você possui ${Mensagens.length} tarefas pendentes"),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: limparMensagens,
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(231, 210, 5, 5),
                        padding: EdgeInsets.all(20)
                        ),
                    child: Text("Limpar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void mensagem_confirmacao () {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text("limpar tudo?"),
          content: 
          Text("voce tem certeza que deseja apagar todas as tarefa?"),
          actions: [
            TextButton(
              onPressed: () {},  
              child: Text("cancelar"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    Mensagens.clear();
                  });
                }, 
                child: Text("Limpar tudo"),
            ),
          ],
        );
      },
    );
  }
}