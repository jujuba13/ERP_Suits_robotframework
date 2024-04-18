*** Settings ***
#Resource       ../resources/Logar_ADMIN.resource
Resource        ../resources/Create_Register_Department_Sucess.resource

*** Variables ***
${TOKEN}

*** Test Cases ***
 
Cenario com Post: Criar Cadastro Departamento
   Criar sessão
   Logar ADMIN
   Cadastro de usuário
   Verificar se o usuário foi cadastrado com sucesso 
   Logar Usuário
   Criar Diretoria
   Criar centro de custos
   Verificar se o centro de custo foi cadastrado com sucesso
   Criar Cadastro Department
   Verificar se o departamento foi cadastrado com sucesso

   

