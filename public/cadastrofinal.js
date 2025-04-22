function cadastro() {
    var email = (ipt_email.value).toLowerCase();
    var senha = ipt_senha.value;
    var nome_empresa= ipt_nomeEmpresa.value
    var nome_usuario= ipt_nomeUsuario.value
    var confirmacao_email=ipt_emailConfirmar.value
    output_email.innerHTML = "";
    output_senha.innerHTML = "";
    //CONDICOES REGEX
    const regex_numero = /\d/;
    const regex_letra_maiuscula = /[A-Z]/;
    const regex_caractere_especial = /[!@#%&*().;,/]/;

    // Verifica se os campos estão preenchidos
    if (email == "" || senha == ""|| nome_empresa=="" || nome_usuario=="" || confirmacao_email=="") {
        alert("Preencha todos os campos!");
        return;
    }
    // Loop para percorrer as verificacoes do email
    for (i = 1; i < 4; i++) {
        //Condicao 1
        if (i == 1) {
            if (!email.endsWith(".com")) {
                output_email.innerHTML += `O email deve terminar em .com<br>`
                output_email.style.color = 'red';
            }

        }
        //Condicao 2
        else if (i == 2) {
            if (!email.includes("@")) {
                output_email.innerHTML += `O email deve conter @<br>`
                output_email.style.color = 'red';
            }

        }
        else if(i==3){
            if(email!=confirmacao_email){
                output_confirmacao.innerHTML += `Os emails devem ser iguais>`
                output_email.style.color = 'red';
            }
        }
    }
    //loop para percorrer as verificacoes da senha
    for (j = 1; j < 6; j++) {
        if (j == 1) {
            if (!regex_caractere_especial.test(senha)) {
                output_senha.innerHTML += `A senha deve conter no mínimo 1 caracter epecial<br>`
                output_senha.style.color = `red`
            }

        }
    
    else if (j == 2) {
        if (senha.length < 8) {
            output_senha.innerHTML += `A senha deve conter no mínimo 8 caracteres<br>`
            output_senha.style.color = `red`
        }

    }
    else if (j == 3) {
        if (!regex_numero.test(senha)) {
            output_senha.innerHTML += `A senha deve conter no mínimo 1 caracter numérico<br>`
            output_senha.style.color = `red`
        }

    }
    else if (j == 4) {
        if (!regex_letra_maiuscula.test(senha)) {
            output_senha.innerHTML += `A senha deve conter no mínimo 1 letra maiúscula<br>`
            output_senha.style.color = `red`
        }

    }



}
}