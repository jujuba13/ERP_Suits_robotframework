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
    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json
    Create Session    alias=SuitsERP    url=${API_URL}    headers=${headers}

Logar ADMIN
    ${body}=    Create Dictionary    mail=${ADMIN_EMAIL}    password=${ADMIN_PASSWORD}
    Log    ${body}
    Criar Sessão
    ${resposta}=    POST On Session    alias=SuitsERP    url=/api/login/    json=${body}
    Log    ${resposta.json()}
    Set Test Variable  ${TOKEN}     ${resposta.json()['token']} 


Verificar a validação e a gravação do token
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${resposta}=    GET On Session    alias=SuitsERP    url=/api/validateToken    headers=${headers}
    Log    Resposta da solicitação: ${resposta.content}
    Log    Token: ${TOKEN}


