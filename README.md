# API para consulta de exame médico

API em Ruby para listagem de exames médicos desenvolvida para o [Desafio Rebase 2022](https://git.campuscode.com.br/core-team/rebase-challenge-2022)

## Tech Stack

* Docker
* Ruby

## Observações

Verifique sempre através do comando `docker ps` se todos os containers estejam rodando. São eles:

- rebase_challenge_test_1
- rebase_challenge_postgres_1
- rebase_challenge_myredis_1
- rebase_challenge_sidekiq_1
- rebase_challenge_app_1

Caso alguma porventura não esteja lista, volte a rodá-la manualmente com `docker start [nome_do_container]`, e siga com o fluxo das instruções abaixo.

## Running

Baixe a aplicação, abra o terminal e digite:

```bash
$ docker-compose up 
```
Em seguida, abra no terminal de sua preferência o endereço: `http://localhost:3000/tests` e visualize o resultado.

## Testing

Para rodar os testes, abra o terminal e digite:

```bash
$ docker-compose up -d
```

Espere os containers rodarem, e em seguida digite:

```bash
$ docker exec rebase_challenge_app_1 rspec
```

E veja o resultado dos testes.

## POST /import

Para enviar novos dados para o banco de dados, crie um arquivo `.csv` na raiz do projeto com os dados desejados, e em seguida, com a aplicação rodando, faça uma requisição http do tipo `POST` para `http://localhost:300/import`, com o seguinte parâmetro:

`params = { path: '/app/nome_do_arquivo.csv' }`

A aplicação atualizará o banco de dados, como pode-se verificar em seguida acessando `http://localhost:3000/tests`

## GET /tests/:token

É possível acessar todos os testes de um paciente específico através de um token. De posse deste token, basta acessar (ou fazer uma requisição do tipo `get`) `http://localhost:3000/tests/:token`, substituindo token pelo código correspondente (exemplo: "IQCZ17"). A página exibirá todos os exames e demais dados do paciente e do médico.
