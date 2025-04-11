# 🔁 Scripts de Automação Firebird (.bat)

Este repositório contém scripts para automação de backups e restaurações de bancos de dados Firebird, utilizando arquivos `.bat`.

---

## ✅ Requisitos

- Firebird 3.0 ou superior instalado
- `gbak.exe` acessível (via path completo)
- Permissões de leitura/escrita nos diretórios de origem e destino
- Compartilhamento de rede habilitado (para restauração remota)
- Conta com privilégios administrativos para executar as tarefas agendadas

---

## 🧰 Scripts disponíveis

### 🔒 Backup
> `scripts/backup/backup_database.bat`

- Realiza backup com banco em uso (`-g`)
- Gera `.fbk` com timestamp
- Apaga backups com mais de 7 dias
- Salva logs da execução

### ♻️ Restore automático do último backup
> `scripts/restore/restore_last_backup.bat`

- Copia o `.fbk` mais recente de uma pasta compartilhada
- Restaura localmente para `BANCOFDB.FDB`
- Apaga ou substitui base anterior

---

## ⏰ Agendamento da tarefa no Windows

Para rodar o script automaticamente:

1. Abrir o **Agendador de Tarefas (taskschd.msc)**
2. Criar uma **tarefa básica**
3. Escolher o disparo (ex: toda sexta às 18h)
4. Ação: iniciar um programa
    - Programa: `cmd.exe`
    - Argumentos: `/c "C:\caminho\do\script.bat"`
5. Marcar "Executar com privilégios elevados"
6. Testar manualmente

---

## 📁 Estrutura de arquivos recomendada


/scripts
  ├── backup/backup_database.bat
  ├── restore/restore_last_backup.bat
  └── utils/exemplo_agendamento.md

## 🛡️ Observações
Nunca restaure uma base em uso

Evite copiar .FDB diretamente com o sistema rodando

Prefira sempre restaurar .FBK de backup