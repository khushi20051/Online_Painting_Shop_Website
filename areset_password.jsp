<%@page import="com.dao.ArtistDAO"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
<%@include file="component/css.jsp"%>
<style type="text/css">
.paint-card {
	box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.3);
}

.clink {
	text-decoration: none;
}
</style>
</head>
<body>
	<%@include file="component/navbar.jsp"%>

	<div class="container p-5">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<div class="card paint-card">
					<div class="card-body">
						<p class="fs-4 text-center">Artist Reset Password</p>
						<c:if test="${not empty errorMsg}">
							<p class="fs-4 text-center text-danger">${errorMsg}</p>
							<c:remove var="errorMsg" scope="session" />
						</c:if>
						<c:if test="${not empty succMsg}">
							<p class=" fs-4 text-center text-success">${succMsg}</p>
							<c:remove var="succMsg" scope="session" />

							<%
							response.setHeader("Refresh", "3;url=aforgot_password.jsp");
							%>.
							
						</c:if>

						<%
						String em = request.getParameter("em");
						%>

						<form action="areset_password.jsp" method="post">
							<input type="hidden" value="<%=em%>" name="email">

							<div class="mb-3">
								<label class="form-label">New password</label> <input required
									name="pass" type="text" class="form-control">
							</div>
							<div class="mb-3">
								<label class="form-label">Confirm password</label> <input
									required name="cpassword" type="password" class="form-control">
							</div>

							<button type="submit" class="btn bg-custom text-white col-md-12">Change
								Password</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
	String pass = request.getParameter("pass");
	String email = request.getParameter("email");

	if (pass != null && email != null) {
		ArtistDAO dao = new ArtistDAO(DBConnect.getConnection());
		if (dao.resetPasssword(pass, email)) {
			session.setAttribute("succMsg", "Password Change Successfully");
			response.sendRedirect("areset_password.jsp");
		} else {
			session.setAttribute("errorMsg", "Something wrong on server");
			response.sendRedirect("aforgot_password.jsp");
		}
	}
	%>
</body>
</html>