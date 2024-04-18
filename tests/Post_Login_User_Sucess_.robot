*** Settings ***
#Resource       ../resources/Logar_ADMIN.resource
Resource       ../resources/Login__User_Sucess.resource

*** Variables ***
${TOKEN}

*** Test Cases ***
 
Cenario com Post: Logar usuário
   Criar sessão
   Logar ADMIN
   Cadastro de usuário
   Verificar se o usuário foi cadastrado com sucesso 
   Logar Usuário



