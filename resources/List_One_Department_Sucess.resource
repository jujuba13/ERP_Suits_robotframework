*** Settings ***
Documentation   Objetivo realizar testes de API
Library        RequestsLibrary
Library        String
Library        Collections


*** Variables ***
${API_URL}          https://suits.qacoders-academy.com.br
${ADMIN_EMAIL}      sysadmin@qacoders.com
${ADMIN_PASSWORD}   1234@Test


*** Keywords ***
Criar Sessão
    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json   #Authorization=${TOKEN}
     
    Create Session    alias=SuitsERP    url=${API_URL}    headers=${headers}      

Logar ADMIN
    ${body}=    Create Dictionary    mail=${ADMIN_EMAIL}    password=${ADMIN_PASSWORD}
    Log    ${body}
    Criar Sessão
    ${resposta}=    POST On Session    alias=SuitsERP    url=/api/login/    json=${body}
    Log    ${resposta.json()}
    Set Test Variable  ${TOKEN}     ${resposta.json()['token']} 
    Set Test Variable    ${RESPOSTA}           ${resposta.json()}
    Log    ${TOKEN}


Verificar a validação e a gravação do token
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${resposta}=    GET On Session    alias=SuitsERP    url=/api/validateToken    headers=${headers}
    Log    Resposta da solicitação: ${resposta.content}
    Log    Token: ${TOKEN}


Cadastro de usuário
    ${palavra_randomica}=    Generate Random String    length=50    chars=LETTERS
    ${palavra_randomica_email}=    Generate Random String    length=10    chars=\[LETTERS]\[NUMBERS]
    ${palavra_randomica_cpf}=     Generate Random String    length=11   chars=[NUMBERS]
    ${palavra_randomica}=    Convert To Lower Case    ${palavra_randomica}
    ${palavra_randomica_email}=    Convert To Lower Case    ${palavra_randomica_email}

    Set Test Variable    ${FULLNAME}    ${palavra_randomica}
    Log    ${FULLNAME}
    Set Test Variable    ${EMAIL}    ${palavra_randomica_email}@gmail.com
    Log    ${EMAIL}
    Set Test Variable    ${CPF}    ${palavra_randomica_cpf}
    Log    ${CPF}

    ${body}=    Create Dictionary
    ...    fullName=Juliana França
    ...    mail=${EMAIL}
    ...    password=1234@Teste
    ...    accessProfile=ADMIN
    ...    cpf=${CPF}
    ...    confirmPassword=1234@Teste   # Corrigido para ser igual à senha

    Log    ${body}

    # Enviar solicitação POST para cadastrar usuário
    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json   Authorization=${TOKEN}
    
    ${resposta}=    Post On Session    alias=SuitsERP    url=/api/user/    json=${body}    expected_status=201  headers=${headers}
    Log    ${resposta.json()}
    ${resposta.json()}=    Evaluate    json.loads($resposta.content)    json    
    Log    ${resposta.json()}  
       
   Set Test Variable      ${ID_USER}      ${resposta.json()["user"]["_id"]}
    Log    ${ID_USER}    
    Set Test Variable    ${RESPOSTA}      ${resposta.json()}   
    
Verificar se o usuário foi cadastrado com sucesso
    Log     ${RESPOSTA}
   Dictionary Should Contain Item     ${RESPOSTA}      msg     Olá Juliana França, cadastro realizado com sucesso.  
   Dictionary Should Contain Key     ${RESPOSTA}       user     _id
  

Logar Usuário

   ${body}  Create Dictionary   mail=julianafr@gmail.com  password=1234@Test
    Log     ${body}
    
    Criar sessão
    

    ${resposta}=    POST On Session    alias=SuitsERP    url=/api/login   json=${body}  
    Log    ${resposta.status_code}
    Log    ${resposta.content}
     ${resposta.json()}=    Evaluate    json.loads($resposta.content)    json 
    Log    ${resposta.json()}
    Should Be Equal As Strings    ${resposta.status_code}    200  
    Set Test Variable  ${TOKEN_USER}     ${resposta.json()['token']} 
    Set Test Variable    ${RESPOSTA}           ${resposta.json()} 
     Log    ${TOKEN_USER} 


Criar Diretoria
   
     [Documentation]    Cria uma diretoria com um nome aleatório
    ${board_name}=    Generate Random String    length=10    chars=ABCDEFGHIJKLMNOPQRSTUVWXYZ    # Gera um nome de diretoria aleatório com 10 caracteres
    Log    Nome da diretoria: ${board_name}
 
  ${body}  Create Dictionary   boardName=${board_name}     
    Log     ${body}

    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json   Authorization=${TOKEN}

  ${resposta}=    POST On Session    alias=SuitsERP    url=/api/board/    json=${body}    headers=${headers}    expected_status=201
    Log    ${resposta.json()}
    ${resposta.json()}=    Evaluate    json.loads($resposta.content)    json
    Log    ${resposta.json()}
    Set Test Variable    ${ID_DIRETORIA}    ${resposta.json()["newBoard"]["_id"]}
    Log    ${ID_DIRETORIA}
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

Verificar se a diretoria foi cadastrado com sucesso
    Log     ${RESPOSTA}
   Dictionary Should Contain Item     ${RESPOSTA}      msg     Cadastro realizado com sucesso! 
   Dictionary Should Contain Key     ${RESPOSTA}       newBoard     _id



Criar Centro de Custos
     
    ${palavra_randomica}    Generate Random String    length=10    chars=[LETTERS]
     ${palavra_randomica}=    Convert To Lower Case      ${palavra_randomica}

     Set Test Variable    ${COST_NAME}     ${palavra_randomica}
     Log    ${COST_NAME}
 
    ${body}=    Create Dictionary    costCenterName=${COST_NAME}  boardId=${ID_DIRETORIA} 
    Log    ${body}
    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json    Authorization=${TOKEN}

    ${resposta}=    POST On Session    alias=SuitsERP    url=/api/costCenter/    json=${body}    headers=${headers}    expected_status=201
    Log    ${resposta.json()}
    ${resposta.json()}=    Evaluate    json.loads($resposta.content)    json
    Log    ${resposta.json()}
    Set Test Variable    ${ID_COST_CENTER}    ${resposta.json()["newCostCenter"]["_id"]}
    Log    ${ID_COST_CENTER}   
     
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

Verificar se o centro de custo foi cadastrado com sucesso
    Log     ${RESPOSTA}
   Dictionary Should Contain Item     ${RESPOSTA}      msg     Cadastro realizado com sucesso.
   Dictionary Should Contain Key     ${RESPOSTA}       newCostCenter    _id

Criar Cadastro Department

 
    ${palavra_randomica}    Generate Random String    length=10    chars=[LETTERS]
     ${palavra_randomica}=    Convert To Lower Case      ${palavra_randomica}

     Set Test Variable    ${DEPARTMENT_NAME}     ${palavra_randomica}
     Log    ${DEPARTMENT_NAME}
 
    ${body}=    Create Dictionary    departmentName=${DEPARTMENT_NAME}   costCenterId=${ID_COST_CENTER} 
    Log    ${body}
    ${headers}=    Create Dictionary       Authorization=${TOKEN}

    ${resposta}=    POST On Session    alias=SuitsERP    url=/api/department/    json=${body}    headers=${headers}    expected_status=201
    Log    ${resposta.json()}
    ${resposta.json()}=    Evaluate    json.loads($resposta.content)    json
    Log    ${resposta.json()}
    Set Test Variable    ${ID_DEPARTMENT}    ${resposta.json()["newDepartment"]["_id"]}
    Log    ${ID_DEPARTMENT}   
     
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

Verificar se o departamento foi cadastrado com sucesso
    Log     ${RESPOSTA}
   Dictionary Should Contain Item     ${RESPOSTA}      msg     Cadastro realizado com sucesso.
   Dictionary Should Contain Key     ${RESPOSTA}       newDepartment    _id


Listar todos os departamentos

    ${headers}=    Create Dictionary    Accept=application/json    Authorization=${TOKEN}
    ${resposta}=    GET On Session    alias=SuitsERP    url=/api/department/    headers=${headers}    expected_status=200
    Log    ${resposta.json()}
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

Verificar se todos os departamentos foram listados com sucesso
    Log    ${RESPOSTA}
    Dictionary Should Contain Key    ${RESPOSTA}    departments     


Listar Somente um Departamento
    ${headers}=    Create Dictionary         Authorization=${TOKEN}
    ${resposta_consulta}=    GET On Session    alias=SuitsERP    url=/api/department/${ID_DEPARTMENT}    headers=${headers}    expected_status=200
    Log    ${resposta_consulta.json()}
    Set Test Variable    ${RESPOSTA_CONSULTA}    ${resposta_consulta.json()}
     

Verificar Somente um Departamento foi Listado com Sucesso
    Log   ${RESPOSTA} 
    Should Be Equal As Strings    ${RESPOSTA["department"]["departmentName"]}    OPERAÇÕES K&
    Should Be Equal As Strings    ${RESPOSTA["department"]["costCenter"]["_id"]}    ${ID_DEPARTMENT} 
    Should Be Equal As Strings    ${RESPOSTA["department"]["costCenter"]["costCenterName"]}    Infraestrutura E&
    Should Be Equal As Strings    ${resposta.status_code}    200