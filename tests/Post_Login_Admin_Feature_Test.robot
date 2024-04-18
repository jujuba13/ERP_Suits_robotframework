*** Settings ***
Resource       ../resources/Logar_ADMIN.resource


*** Variables ***

*** Test Cases ***
 
Cenario com Post: Logar ADMIN
  Criar sessão
  Logar ADMIN
  Verificar a validação e a gravação do token



