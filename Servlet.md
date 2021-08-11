# Java Servlet

Servlet é uma especificação java, ou seja, possui um xml.

Tomcat (servidorzão)

Servlet (servidorzinho)

## Criação do Ambiente

Requisitos: Eclipse JEE, Apache Tomcat 9, criar o servidor tomcat apache 9 no eclipse.

Atenção: Não excluir o "Servers" nem fechar o projeto.

Apache Tomcat será nosso servidor web conectando através do protocolo HTTP, que mais pra frente retorna nosso HTML da página web.

Tomcat recebe a chamada do navegador e da uma resposta, podendo ser status 404 (erro), status 200 (sucesso), etc...

## Apache HTTP ou Apache Tomcat?

A Apache Foundation, responsável pelo Apache Tomcat também possui o Apache HTTP, mas afinal, qual a diferença entre os dois?

O Tomcat é puramente Java, já o Apache HTTP é escrito em C.

Por padrão o Apache HTTP é um servidor estático, já o Tomcat é dinâmico, usando Java e JSP.

## Iniciando nosso projeto Java para integrar ao Servlet

Criar o projeto no eclipse com a opção "New Dynamic Web Project".

Nome do projeto deve ser em camelCase.

Manter as configurações padrões na criação do projeto.

Flagar a opção "Generate web.xml deployment descriptor". Sem gerar o web.xml também funcionará, porém iremos fazer algumas configurações diferentes e por isso será necessário.

Adicionar o projeto criado no tomcat e iniciar novamente o servidor.

Para o tomcat, não precisamos declarar a pasta /WebContent/arquivo.html pois quando utilizamos na url o **nomeDoProjeto/arquivo.html** ele já esta acessando a raiz da pasta **WebContent**.

Quando rodamos nosso servidor tomcat, estamos criando uma máquina virtual Java (JRE).

Usamos o navegador para utilizar o protocolo HTTP e enviar requisições, obtendo respostas que por exemplo pode ser nosso **arquivo.html**.

Acessando: [http://localhost:8080](http://localhost:8080) (Tomcat) e depois disso precisamos adicionar o diretório do nosso projeto e também o nosso arquivo html.

Servlet é um objeto especial que fica dentro do nosso projeto.

Métodos HTTP sempre funcionam com requisição e resposta.

Existem anotações para o compilador e também para a máquina virtual.

Usamos a anotação **@WebServlet** com o paramêtro **urlPatterns = "/oi"** para definir nosso endpoint da servlet.

Utilizamos a classe PrintWriter para podemos "escrever" em nosso navegador usando a respose.

Usando os dois conceitos destacados acima, teremos o resultado de acessar **/gerenciador/oi** e iremos visualizar a mensagem "Oi Mundo!" que foi escrita no nosso método **service** na classe **OiMundoServlet**.

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled.png)

Para passarmos parametros para uma servlet, utilizamos na url da seguinte forma: **/gerenciador/novaEmpresa?nome=Alura&cnpj=123**

No lado da servlet para utilizarmos esse parâmetro que foi passado, devemos utilizar um método que está dentro da nossa request, ou seja, quando fizemos nossa requisição, passamos o parâmetro nome, então podemos resgatar ele com o método **request.getParameter("nome");**.

Atenção, o método **getParameter** sempre retorna uma **String!**

Nem sempre a melhor forma é enviar o parâmetro via URL, exemplo dados que são muito grandes, enviar dados sensiveis...

Para utilizarmos nosso endpoint **novaEmpresa** de forma mais factível, podemos criar mais um arquivo html porém dessa vez com um formulário para inserirmos o nome da empresa:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%201.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%201.png)

Quando demos submit, irá redirecionar para a URL inserida na tag **action** e irá enviar via parâmetro o nome que usamos: 

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%202.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%202.png)

Definimos o method **post** no formulário, para termos uma requisição que grava o nome da empresa que iremos cadastrar, ao invés de **get**, utilizado para buscar algo.

Utilizando o método **post** nosso parâmetro passado, na requisição ele ficará no campo **formData** e não mais na URL.

Caso não definirmos o método no formulário, ele define **GET** como padrão.

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%203.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%203.png)

Atualmente, temos nosso método **service** em nossa servlet, porém podemos renomear ele para **doPost** ou **doGet**, com isso, podemos restringir o tipo de método permitido. Se alterarmos para **doPost** e tentar realizar uma requisição **get** como anteriormente, utilizando **/gerenciador/novaEmpresa?nome=Alura** iremos receber um status **405** **- Method Not Allowed.**

## Definindo nosso modelo

Inicialmente criamos uma classe chamada **Empresa** que será nosso modelo e declaramos alguns atributos: **id** (para ser a primary key) e **nome**.

Em nossa servlet, devemos criar nosso objeto **Empresa** para podermos definir esse atributo nome com o nome que estamos passando em nossa requisição.

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%204.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%204.png)

Agora de alguma forma precisamos gravar isso em algum lugar, correto?

Então iremos simular um banco de dados e gravar esses dados de alguma forma, para isso iremos criar uma classe **Banco** e dentro dessa classe teremos o método **adiciona** que será o método para adicionar uma nova empresa.

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%205.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%205.png)

E nossa classe **Banco:**

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%206.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%206.png)

Iremos dentro da nossa classe Banco implementar o método adiciona e também criar o método **getEmpresas** que irá nos retornar uma lista de empresas que também criamos, ficará da seguinte forma:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%207.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%207.png)

Declaramos a **lista** como static por que ela será um atributo estático da classe e não própriamente do objeto.

***Nota**: Por ser apenas um mock de um "Banco" toda vez que reiniciamos nossa aplicação, perdemos o que está cadastrado, pois não estamos persistindo esses dados em um banco de dados realmente.

Agora precisamos listar as empresas que estamos cadastrando, para isso iremos criar uma servlet chamada **ListaEmpresasServlet** que será responsável por exibir as empresas e ela terá o método **doGet**.

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%208.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%208.png)

Agora que temos um meio de utilizar o método **GET** iremos configurar nosso método de forma que consuma nossa lista de empresas cadastradas e exiba em uma **unordered list** do html da seguinte maneira:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%209.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%209.png)

***Nota:** Utilizar HTML dentro das nossas classes Java não é boa prática.

Então quando acessarmos o nosso endpoint **(/gerenciador/listaEmpresas)** iremos obter uma **ul** com as empresas cadastradas:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2010.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2010.png)

Porém como dito anteriormente, toda vez que nosso tomcat é reiniciado, perdemos o que tinhamos cadastrado... Então para toda vez que nosso tomcat for reiniciado termos algum registro iremos criar um bloco estático na nossa classe **Banco** para que ao inicializar nossa servlet ele já crie duas empresas, da seguinte maneira:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2011.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2011.png)

Dessa forma, quando reiniciamos nosso tomcat e entrarmos na URL **/gerenciador/listaEmpresas** ao invés de termos uma página em branco, teremos os dois registros (Alura e Caelum).

## Páginas Dinâmicas com JSP

Inicialmente, iremos criar nossa página que será acessada na hora de um novo cadastro de empresa, iremos criar como **novaEmpresaCriada.jsp,** podemos notar que a extensão do arquivo é **JSP** ou seja, estamos utilizando o **java server pages** para que possamos utilizar scriptlets dentro desse arquivo juntamente com nossos elementos HTML.

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2012.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2012.png)

Apenas para visualização utilizamos o método de print para verificarmos que de fato está funcionando.

Agora para exibirmos o nome da empresa em nossa página HTML iremos usar novamente scritplets para exibirmos nossa váriavel, utilizando da seguinte forma:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2013.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2013.png)

Utilizamos o recurso **out.println(nomeEmpresa);** que temos por padrão dentro de nossos arquivos JSP.

Temos também uma forma de exibir essa variável de forma que não necessita utilizarmos o **out.println(nomeEmpresa);** que seria da seguinte maneira:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2014.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2014.png)

Agora que temos essa página JSP para exibir a empresa que estamos cadastrando ao invés de termos código HTML dentro da nossa servlet que não é o ideal, iremos precisar fazer com que noss servlet chame essa página JSP.

Para isso, iremos adicionar ao final do nosso método **doPost,** precisaremos adicionar um método que está dentro do nosso **request** que seria o **getRequestDispatcher** que recebe como parâmetro um path específico, ou seja, esse path irá nos levar até nosso arquivo JSP.

Tendo declarado o path que desejamos que a requisição seja despachada, iremos efetivar esse despacho utilizando o método **forward** que se encontra dentro da classe **RequestDispatcher**.

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2015.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2015.png)

Dessa forma, quando disparamos nosso botão de cadastro, seremos redirecionados para a página **novaEmpresaCriada.jsp** porém precisamos também passar da **servlet** para o **jsp** o valor que temos em nossa variável **nomeEmpresa.**

Para realizar essa tarefa, antes de efetuar o despache iremos setar um atributo pra enviar junto, iremos fazer isso da seguinte forma: 

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2016.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2016.png)

Dessa forma iremos criar um atributo dentro da nossa **request** com o nome **empresa** e em nossa **jsp** conseguiremos utilizar esse valor que estamos passando, no caso o nome da empresa.

No lado da **jsp** iremos resgatar esse valor da seguinte maneira:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2017.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2017.png)

Iremos manter algumas coisas que já tinhamos, porém o que mudamos é que nossa variável **nomeEmpresa** irá agora ser definida com o valor que passamos anteriormente com nosso **dispatcher.** Como estamos recebendo um objeto, precisaremos fazer um cast para o formato que precisamos para utilizar, ou seja, precisamos tranformar em uma string. Depois de realizar o cast, e utilizar o método **getAttribute**, quando formos utilizar nossa página **/gerenciador/formNovaEmpresa.html,** quando disparamos a criação de uma nova empresa, seremos redirecionados para nossa página **JSP** e dessa vez teremos o nome exato que cadastramos.

Agora iremos fazer o mesmo procedimento porém para nossa página que lista as empresas cadastradas **(/listaEmpresas)**. Da mesma forma que fizemos na criação de uma empresa, teremos de criar um **ResponseDispatcher** na nossa servlet e com ela enviar também um atributo que irá conter nossa lista de empresas, após feito isso, precisaremos criar uma página **JSP** para onde seremos redirecionados e que consumirá o atributo enviado no **Dispatcher**.

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2018.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2018.png)

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2019.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2019.png)

Com isso feito, quando acessamos a página **/listaEmpresas,** iremos visualizar da mesma forma, porém dessa vez estamos em uma página feita com **JSP** e não mais visualizando um HTML dentro da nossa servlet.

## JSTL e Expression Language

Nesse capítulo iremos aprender sobre a **expression language** que nos ajuda a diminuir a diminuir o uso de scriptlets, nos possibilitanto códigos **jsp** mais limpos e manuteníveis.

### Antes

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2020.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2020.png)

### Depois

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2021.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2021.png)

Podemos ver que conseguimos diminuir bastante o esforço para recuperar o atributo **empresa** que nosso servlet está passando para nossa página **JSP**.

Agora para conseguirmos simplificar mais alguns recursos, precisaremos utilizar a lib **JSTL** que seria um acrônimo para **Java Standard Taglib**.

Somente com as expressions laguage não conseguimos por exemplo simplificar nosso **for** que ainda está sendo usado com **scriptlets** e com a lib **JSTL** iremos efetuar essa mudança e deixar o código mais simples.

E com isso conseguimos simplificar bastante nossa **JSP**, vamos verificar o antes e depois:

### Antes

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2022.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2022.png)

### Depois

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2023.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2023.png)

Nós importamos a lib **JSTL** e a utilizamos para criar um **for** de maneira mais simplificada, utilizamos esse recurso juntamente com a **expression language** e dessa forma obtivemos um código muito mais simples e legível.

Então no momento teríamos mais ou menos o seguinte fluxo:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2024.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2024.png)

Ainda falando de **JSTL** temos também algumas outras opções de uso, até aqui nós utilizamos apenas o módulo **core**, porém também temos o módulo **fmt** que carrega funções relacionadas a formatação e internacionalização, **sql** que executa sql e **xml** que gera xml.

Utilizando mais um recurso do **JSTL** **core** podemos definir o action do nosso form de uma maneira diferente, mais dinâmica:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2025.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2025.png)

Dessa forma utilizamos o **JSTL** juntamente com a **Expression Language** para definir de forma dinâmica nosso endpoint levando em conta o nosso contexto, que pode variar.

Também iremos utilizar o **JSTL** em conjunto com o **Expression Language** na nossa página novaEmpresaCriada.jsp para verificar se foi passado alguma empresa ou não:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2026.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2026.png)

Dessa forma utilizamos uma estrutura de controle que se encontra dentro do **JSTL core**.

Agora para visualizarmos também o que podemos fazer com a função **fmt** do **JSTL** iremos fazer uma pequena alteração, iremos juntamente da empresa cadastrada informar também uma data de criação. Para fazer isso, iremos primeiramente criar um atributo **dataAbertura** em nossa classe **Empresa** e nesse caso, para testes iremos utilizar a data atual para demonstrarmos:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2027.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2027.png)

Agora nosso modelo possui o atributo **dataAbertura** que esta sendo setado quando criamos ele. Sendo assim quando tivermos algum objeto dessa classe criado, podemos recuperar agora além do nome a data. Utilizando **Expression Language** e o módulo **fmt** iremos recuperar essa data criada e também formatá-la da forma que desejamos:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2028.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2028.png)

Podemos ver que importamos o **core** e também o **fmt,** em nosso laço **for** podemos ver que estamos utilizando a **Expression Language** para recuperar o atributo **dataAbertura** do objeto **empresa** e utilizando a tag **<fmt:formatDate/>** para formatar a data com o padrão desejado.

O resultado será o seguinte:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2029.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2029.png)

Então podemos criar um campo no formulário de cadastro de empresas para que preenchamos o nome da empresa e também a sua data de criação, dessa forma iremos popular esses dois dados e já formatar a data com o **fmt.**

### Redirecionando o Fluxo

Nesse momento iremos ver que podemos também mudar um pouco o fluxo do nosso programa e que podemos disparar um **dispatcher** para outra servlet também, nesse caso, quando criamos uma nova empresa agora iremos disparar o **dispatcher** para a servlet **/listaEmpresas:**

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2030.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2030.png)

E tendo uma visão da nossa aplicação nesse momento ela estaria dessa forma:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2031.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2031.png)

Porém temos um problema, quando o usuário preencher e submeter o formulário na página **formNovaEmpresa.jsp** ele será redirecionado para a servlet **/listaEmpresas** e se nessa página após ser redirecionado, apertar **F5,** irá repetir o **post** que acabou de ser feito e irá inserir o mesmo registros novamente e novamente... Então precisamos resolver essa questão.

Para resolver o problema, ao invés de realizar um redirecionamento server-side, teremos de utilizar um redirecionamento client-side para que não tenhamos esse problema da requisição ao atualizar a página.

Para realizar isso, iremos comentar a parte do nosso código que contém o dispatcher e utilizar o método **sendRedirect** que está dentro da classe da nossa response da nossa servlet:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2032.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2032.png)

Assim teremos um redirecionamento client-side.

### Completando o CRUD

Agora iremos completar as funcionalidades básicas do nosso projeto, geralmente chamamos essas operações de **CRUD**. Que seria **Create, Read, Update e Delete.**

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2033.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2033.png)

Iremos inicialmente desenvolver a parte do **Delete,** para isso vamos primeiramente criar um link ao lado das nossas empresas listadas com o nome de **Remove:**

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2034.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2034.png)

Após isso criaremos uma nova servlet **RemoveEmpresaServlet** que contém o método **doGet**. Sempre que precisarmos deletar algum registro, devemos realizar essa operação nos baseando no **id** do registro e não em seu nome, por isso nesse caso para nosso propósito, iremos definir manualmente um id para nossos registros:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2035.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2035.png)

Após feito isso, iremos pegar nossa servlet **RemoveEmpresaServlet** e complementar ela de forma a pegar o parâmetro da requisição que será o id a ser deletado, transformar de **String para Integer** e poder utilizar em nosso método **deleta**.

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2036.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2036.png)

Agora podemos implementar o método **deleta** em nossa classe **Banco** para efetuarmos a remoção do registro desejado:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2037.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2037.png)

Porém desta forma nós nos deparamos com um problema, não podemos iterar dentro de uma lista com um **for** e realizar alterações, quando vamos deletar um registro recebemos a seguinte tela:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2038.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2038.png)

Devemos utilizar outra forma de iterar em nossa lista, utilizando um **iterator,** método comum em todo tipo de coleção Java (map, list, etc...). Dessa forma nosso método ficará da seguinte forma:

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2039.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2039.png)

E para finalizar, vamos adicionar em nossa servlet um **sendRedirect** para após realizar uma exclusão, sermos enviados novamente para a **listaEmpresas**.

![Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2040.png](Java%20Servlet%209c609acd414849ee94f177d38d996c06/Untitled%2040.png)

Agora partiremos para a criação da operação de **update** das empresas, para isso teremos de criar duas servlets **MostraEmpresaServlet e** **AlteraEmpresaServlet** onde uma irá mostrar os dados da empresa, puxando o que está cadastrado e podendo alterar para realizar a alteração e a outra irá de fato lidar com a alteração.

## Servlet é singleton!!!