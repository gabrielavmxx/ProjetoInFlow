function login(){
    var emailCadastrado = "julia@tech.com";
    var senhaCadastrada = "Julia123@"
    var emailCadastrado2 = "brandao@tech.com";
    var senhaCadastrada2 = "Brandao123@"
    var email=ipt_email.value;
    var senha=ipt_senha.value;
    if(email == emailCadastrado && senha == senhaCadastrada){
        alert("Login realizado com sucesso")
        window.location.href = "dashboard.html";
} 
    else if(email == emailCadastrado2 && senha == senhaCadastrada2){
        alert("Login realizado com sucesso")
        window.location.href = "dashboard.html";
}
else{
    alert("Email ou senha incorretos")
}
}