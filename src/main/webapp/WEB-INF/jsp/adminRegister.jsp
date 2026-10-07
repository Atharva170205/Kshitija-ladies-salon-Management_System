<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .login-card {
            width: 100%;
            max-width: 380px;
            border: none;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
        }
        .login-card .card-body {
            padding: 2.5rem 2rem;
        }
        .login-title {
            font-weight: 700;
            color: #4a2f7d;
            margin-bottom: 1.5rem;
        }
        .btn-login {
            background: #764ba2;
            border: none;
            font-weight: 600;
        }
        .btn-login:hover {
            background: #5e3a84;
        }
        .form-label {
            font-weight: 500;
            color: #444;
        }
    </style>
</head>
<body>

    <div class="card login-card">
        <div class="card-body">

            <h2 class="text-center login-title">Register</h2>

            <!-- Success message (e.g. after logout) -->
            <c:if test="${not empty successMsg}">
                <div class="alert alert-success py-2">${successMsg}</div>
            </c:if>

            <!-- Error message (e.g. wrong credentials) -->
            <c:if test="${not empty errMsg}">
                <div class="alert alert-danger py-2">${errMsg}</div>
            </c:if>

            <form action="doRegister" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter name" required />
                </div>
                
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter username" required />
                </div>

                <div class="mb-4">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required />
                </div>

                <button type="submit" class="btn btn-login w-100 text-white">Register</button>

            </form>

        </div>
    </div>

</body>
</html>