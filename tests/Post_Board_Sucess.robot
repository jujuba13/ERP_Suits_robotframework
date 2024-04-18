*** Settings ***
#Resource       ../resources/Logar_ADMIN.resource
Resource        ../resources/Create_Board_Sucess.resource

*** Variables ***
${TOKEN}

*** Test Cases ***
 
Cenario com Post: Criar Diretoria
   Criar sessão
   Logar ADMIN
   Cadastro de usuário
   Verificar se o usuário foi cadastrado com sucesso 
   Logar Usuário
   Criar Diretoria


