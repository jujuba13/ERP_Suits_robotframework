*** Settings ***
#Resource       ../resources/Logar_ADMIN.resource
Resource        ../resources/Update_Department_Sucess.resource

*** Variables ***
${TOKEN}

*** Test Cases ***
 
Cenario com Put: Atualizar o Cadastro do departamento
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
   Listar somente um departamento 
   #Verificar somente um departamentos foram listados com sucesso
   Atualizar o cadastro do departamento 
   verificar se foi atualizado com sucesso 
 

   

