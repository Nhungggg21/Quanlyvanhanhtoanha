<?php
include 'database/DBController.php';

if (isset($_POST['submit'])) {
    $name = mysqli_real_escape_string($conn, $_POST['name']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, md5($_POST['password']));
    $confirm_password = mysqli_real_escape_string($conn, md5($_POST['confirm_password']));

    // Kiểm tra email đã tồn tại chưa
    $select_user = mysqli_query($conn, "SELECT * FROM `users` WHERE email = '$email'") or die('Query failed');

    if (mysqli_num_rows($select_user) > 0) {
        $message[] = 'Email đã tồn tại!';
    } else {
        if ($password != $confirm_password) {
            $message[] = 'Mật khẩu không khớp!';
        } else {
            // Thêm tài khoản vào bảng `users`
            mysqli_query($conn, "INSERT INTO `users` (username, email, password) VALUES('$name', '$email', '$password')") or die('Query failed');
            $message[] = 'Đăng ký thành công!';
            header('location:login.php');
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng ký - Sân Bóng</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }

        .container {
            margin: auto;
            display: flex;
            justify-content: center;
        }

        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 0;
            background: url('./assets/bg-login.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .register-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            width: 450px;
            backdrop-filter: blur(10px);
        }

        .form-control {
            margin-bottom: 0px !important;
        }

        .register-header {
            background: #28a745;
            color: white;
            padding: 20px;
            border-radius: 15px 15px 0 0;
            text-align: center;
        }

        .register-header h4 {
            margin: 0;
            font-size: 24px;
            font-weight: 600;
        }

        .register-body {
            padding: 30px;
        }

        .form-control {
            border-radius: 25px;
            padding: 12px 20px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
            border-color: #28a745;
        }

        .btn-register {
            background: #28a745;
            border: none;
            border-radius: 25px;
            padding: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
        }

        .btn-register:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

        .login-link a {
            color: #28a745;
            font-weight: 600;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .alert {
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .input-group-text {
            border-radius: 25px 0 0 25px;
            width: 45px;
            justify-content: center;
        }

        .input-group .form-control {
            border-radius: 0 25px 25px 0;
            margin-bottom: 0;
        }

        .input-group {
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <div class="register-container">
        <div class="container">
            <?php
            if (isset($message)) {
                foreach ($message as $msg) {
                    echo '<div class="alert alert-warning alert-dismissible fade show" role="alert">
                            <span>' . $msg . '</span>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                          </div>';
                }
            }
            ?>
            
            <div class="register-card">
                <div class="register-header">
                    <h4><i class="fas fa-user-plus me-2"></i>Đăng Ký Tài Khoản</h4>
                </div>
                <div class="register-body">
                    <form action="" method="post">
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0">
                                <i class="fas fa-user text-muted"></i>
                            </span>
                            <input type="text" name="username" class="form-control border-start-0" 
                                   placeholder="Tên người dùng" required>
                        </div>

                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0">
                                <i class="fas fa-envelope text-muted"></i>
                            </span>
                            <input type="email" name="email" class="form-control border-start-0" 
                                   placeholder="Email" required>
                        </div>

                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0">
                                <i class="fas fa-phone text-muted"></i>
                            </span>
                            <input type="text" name="phone" class="form-control border-start-0" 
                                   placeholder="Số điện thoại" required>
                        </div>

                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0">
                                <i class="fas fa-lock text-muted"></i>
                            </span>
                            <input type="password" name="password" class="form-control border-start-0" 
                                   placeholder="Mật khẩu" required>
                        </div>

                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0">
                                <i class="fas fa-lock text-muted"></i>
                            </span>
                            <input type="password" name="cpassword" class="form-control border-start-0" 
                                   placeholder="Xác nhận mật khẩu" required>
                        </div>

                        <button type="submit" name="submit" class="btn btn-register btn-success w-100">
                            Đăng Ký
                        </button>
                    </form>
                    <div class="login-link">
                        <p class="mb-0">Đã có tài khoản? 
                            <a href="login.php">Đăng nhập ngay</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<body class="background">
    <?php
    //nhúng vào các trang bán hàng
    if (isset($message)) { // hiển thị thông báo sau khi thao tác với biến message được gán giá trị
        foreach ($message as $msg) {
            echo '
                            <div class=" alert alert-info alert-dismissible fade show" role="alert">
                                <span style="font-size: 16px;">' . $msg . '</span>
                                <i style="font-size: 20px; cursor: pointer" class="fas fa-times" onclick="this.parentElement.remove();"></i>
                            </div>';
        }
    }
    ?>
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow" style="width: 400px; border-radius: 15px;">
            <div class="card-header text-center bg-primary text-white" style="border-radius: 15px 15px 0 0;">
                <h4>Đăng ký</h4>
            </div>
            <div class="card-body">
                <!-- Hiển thị thông báo -->
                <?php
                if (isset($message)) {
                    foreach ($message as $msg) {
                        echo '
                        <div class="alert alert-info alert-dismissible fade show" role="alert">
                            <span>' . $msg . '</span>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>';
                    }
                }
                ?>

                <!-- Form đăng ký -->
                <form action="" method="post">
                    <div class="mb-3">
                        <label for="name" class="form-label">Họ tên</label>
                        <input type="text" id="name" name="name" class="form-control" placeholder="Nhập họ tên" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">E-mail</label>
                        <input type="email" id="email" name="email" class="form-control" placeholder="Nhập email" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                    </div>
                    <div class="mb-3">
                        <label for="confirm_password" class="form-label">Nhập lại mật khẩu</label>
                        <input type="password" id="confirm_password" name="confirm_password" class="form-control" placeholder="Nhập lại mật khẩu" required>
                    </div>
                    <button type="submit" name="submit" class="btn btn-primary w-100">Đăng ký ngay</button>
                </form>
                <p class="text-center mt-3">
                    Bạn đã có tài khoản?
                    <a href="login.php" class="text-primary text-decoration-none">Đăng nhập</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>