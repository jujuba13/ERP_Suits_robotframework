*** Settings ***
#Resource       ../resources/Logar_ADMIN.resource
Resource       ../resources/Register_Sucess_User.resource

*** Variables ***
${TOKEN}

*** Test Cases ***
 
Cenario com Post: Cadastrar usuário
   Logar ADMIN
   Criar sessão
   Cadastro de usuário
   Verificar se o usuário foi cadastrado com sucesso 



