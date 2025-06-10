// var ambiente_processo = 'producao';
var ambiente_processo = 'desenvolvimento';

var caminho_env = ambiente_processo === 'producao' ? '.env' : '.env.dev';
// Acima, temos o uso do operador ternário para definir o caminho do arquivo .env
// A sintaxe do operador ternário é: condição ? valor_se_verdadeiro : valor_se_falso

require("dotenv").config({ path: caminho_env });

var express = require("express");
var cors = require("cors");
var path = require("path");

//multer é responsavél por salvar as imagens
var multer = require("multer");
var upload = multer()

var PORTA_APP = process.env.APP_PORT;
var HOST_APP = process.env.APP_HOST;

var app = express();

var indexRouter = require("./src/routes/index");
var usuarioRouter = require("./src/routes/usuarios");
var dashRouter = require('./src/routes/dashboard');
var uploadUser = require('./src/middleware/uploadImage');
var corredoresRouter = require("./src/routes/corredores");
var mapaRouter = require("./src/routes/mapa");
var supermercadoRouter = require("./src/routes/supermercado");
// var kpiRouter = require("./src/routes/kpi");
// var BobIaRouter = require("./src/routes/BobIa");
// var SuporteRouter = require('./src/routes/Suporte');


var medidasRouter = require("./src/routes/medidas");


app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

app.use(cors());

app.use("/", indexRouter);
app.use("/usuarios", usuarioRouter);
app.use("/corredores", corredoresRouter);
app.use("/dashboard", dashRouter);
app.use("/mapa", mapaRouter);
app.use("/supermercado", supermercadoRouter);
// app.use("/kpi", kpiRouter);
// app.use("/BobIa", BobIaRouter);
// app.use('/suporte', SuporteRouter);

app.use("/medidas", medidasRouter);


app.post('/profile', uploadUser.single('imagem'), async (req, res ) => {

    if(req.file){
        console.log(req.file)
        return res.json({
            erro: false,
            mensagem: "Upload realizado com sucesso!",
            nomeArquivo: req.file.filename
        })
    }
    return res.json({
        erro: false,
        mensagem: "Upload realizado com sucesso!, formato de imagem incorreto"
    });
})

// Teste de requisição
// app.post('/profile-image', async (req, res ) => {
//     return res.json({
//         erro: false,
//         mensagem: "Upload realizado com sucesso"
//     })
// })

app.listen(PORTA_APP, function () {
    console.log(`
    ##   ##  ######   #####             ####       ##     ######     ##              ##  ##    ####    ######  
    ##   ##  ##       ##  ##            ## ##     ####      ##      ####             ##  ##     ##         ##  
    ##   ##  ##       ##  ##            ##  ##   ##  ##     ##     ##  ##            ##  ##     ##        ##   
    ## # ##  ####     #####    ######   ##  ##   ######     ##     ######   ######   ##  ##     ##       ##    
    #######  ##       ##  ##            ##  ##   ##  ##     ##     ##  ##            ##  ##     ##      ##     
    ### ###  ##       ##  ##            ## ##    ##  ##     ##     ##  ##             ####      ##     ##      
    ##   ##  ######   #####             ####     ##  ##     ##     ##  ##              ##      ####    ######  
    \n\n\n                                                                                                 
    Servidor do seu site já está rodando! Acesse o caminho a seguir para visualizar .: http://${HOST_APP}:${PORTA_APP} :. \n\n
    Você está rodando sua aplicação em ambiente de .:${process.env.AMBIENTE_PROCESSO}:. \n\n
    \tSe .:desenvolvimento:. você está se conectando ao banco local. \n
    \tSe .:producao:. você está se conectando ao banco remoto. \n\n
    \t\tPara alterar o ambiente, comente ou descomente as linhas 1 ou 2 no arquivo 'app.js'\n\n`);
});
