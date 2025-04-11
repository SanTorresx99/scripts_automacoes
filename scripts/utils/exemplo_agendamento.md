# ⏰ Exemplo de Agendamento de Tarefa no Windows

Este guia mostra como agendar a execução automática de um script `.bat` no Windows usando o **Agendador de Tarefas (Task Scheduler)**.

---

## ✅ Exemplo de uso: Backup ou Restauração Firebird

### 🛠️ Etapas:

1. **Abrir o Agendador de Tarefas**
   - Pressione `Win + R`
   - Digite: `taskschd.msc` e pressione `Enter`

2. **Criar uma nova tarefa básica**
   - Clique em “Criar Tarefa Básica”
   - Dê um nome como `Backup Firebird` ou `Restore Firebird`

3. **Definir o gatilho (Trigger)**
   - Exemplo: Toda sexta-feira às 18:00
   - Frequência: `Semanal`

4. **Definir a ação (Action)**
   - Ação: `Iniciar um programa`
   - Programa/script:
     ```
     cmd.exe
     ```
   - Adicionar argumentos:
     ```
     /c "C:\Caminho\do\script.bat"
     ```

5. **Permissões**
   - Marque: “Executar com privilégios mais altos”
   - Marque: “Executar mesmo que o usuário não esteja logado”

6. **Finalizar e testar**
   - Clique com o botão direito na tarefa criada → **Executar**
   - Verifique se o script rodou corretamente

---

## ✅ Dica de Teste

Para testar imediatamente, você pode alterar o horário para daqui 2 minutos e observar a execução no Agendador.

---

## 🔐 Observações

- Sempre use caminhos **completos e sem aspas externas** no campo “Programa/script”
- Prefira rodar o `.bat` via `cmd.exe /c` para garantir que o terminal feche corretamente
- Certifique-se que o `.bat` está em um local **acessível com permissões de leitura e execução**

---

## Exemplo real:

- Programa/script:
cmd.exe

- Argumentos:
/c "C:\scripts\restore\restore_last_backup.bat"
