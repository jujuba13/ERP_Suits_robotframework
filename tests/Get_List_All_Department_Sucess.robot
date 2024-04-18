*** Settings ***
#Resource       ../resources/Logar_ADMIN.resource
Resource        ../resources/List_All_Department_Sucess.resource

*** Variables ***
${TOKEN}

*** Test Cases ***
 
Cenario com Post: Liatr todos os Departmento
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
    Listar todos os departamentos
    #Verificar se todos os departamentos foram listados com sucesso
 

   

