<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url value="/novaEmpresa" var="linkServletNovaEmpresa" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Formulário Nova Empresa</title>
</head>
<body>
	<form action="${linkServletNovaEmpresa}" method="post">
	
		Nome: <input type="text" name="nome"/>
		Data de Abertura: <input type="text" name="data"/>
		<input type="submit"/>
		
	</form>
</body>
</html>


