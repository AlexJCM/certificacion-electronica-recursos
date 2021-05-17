<%@page language="java"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>404 Not found</title>
	<style>
		#notfound {
	  position: relative;
	  height: 100vh;
	  background-color: #fafbfd;
	}

	#notfound .notfound {
	  position: absolute;
	  left: 50%;
	  top: 50%;
	  -webkit-transform: translate(-50%, -50%);
		  -ms-transform: translate(-50%, -50%);
		      transform: translate(-50%, -50%);
	}

	.notfound {
	  max-width: 520px;
	  width: 100%;
	  text-align: center;
	}


	.notfound h1 {
	  font-size: 86px;
	  text-transform: uppercase;
	  font-weight: 700;
	  margin-top: 0;
	  margin-bottom: 8px;
	  color: #151515;
	}

	.notfound h2 {
	  font-size: 26px;
	  margin: 0;
	  font-weight: 700;
	  color: #151515;
	}

	.notfound a {
	  font-size: 14px;
	  text-decoration: none;
	  background: #022f5a;
	  display: inline-block;
	  padding: 15px 30px;
	  border-radius: 5px;
	  color: #fff;
	  font-weight: 700;
	  margin-top: 20px;
	}
	</style>
</head>
<body>
					
	</div>	
		<div id="notfound">
		<div class="notfound">	
			<h1>oops!</h1>
			<h2>Error 404 : Página no encontrada</h2>
			<p id="message">
				<a href="http://190.96.96.153:5000/bonita/apps/userApp/task-list">Ir a la Página principal</a>
			</p>
		</div>
	</div>
	
</body>
</html>
