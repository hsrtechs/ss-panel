{include file='auth/header.tpl'}
<body class="register-page">
<div class="register-box">
    <div class="register-logo">
        <a href="../"><b>{$config['appName']}</b></a>
    </div>

    <div class="register-box-body">
        <p class="login-box-msg">Sign Up</p>

        <div class="form-group has-feedback">
            <input type="text" id="name" class="form-control" placeholder="Name"/>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>

        <div class="form-group has-feedback">
            <input type="text" id="email" class="form-control" placeholder="Email"/>
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>

        {if $requireEmailVerification}
            <div class="form-group">
                <div class="input-group">
                    <input type="text" id="verifycode" class="form-control" placeholder="Email Verification Code"/>
                <span class="input-group-btn">
                    <button type="button" id="sendcode" class="btn btn-default btn-flat">Send Verification Code</button>
                </span>
                </div>
            </div>
        {/if}

        <div class="form-group has-feedback">
            <input type="password" id="passwd" class="form-control" placeholder="Password"/>
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>

        <div class="form-group has-feedback">
            <input type="password" id="repasswd" class="form-control" placeholder="Repeat Password"/>
            <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
        </div>

        <div class="form-group has-feedback">
            <input type="text" id="code" value="{$code}" class="form-control" placeholder="Invitation Code"/>
            <span class="glyphicon glyphicon-send form-control-feedback"></span>
        </div>

        <div class="form-group has-feedback">
            <p>By signing up at us you are agreeing to our <a href="/tos">Terms of Services</a></p>
        </div>

        <div class="form-group has-feedback">
            <button type="submit" id="reg" class="btn btn-primary btn-block btn-flat">Agree with ToS and complete sign up</button>
        </div>

        <div id="msg-success" class="alert alert-info alert-dismissable" style="display: none;">
            <button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button>
            <h4><i class="icon fa fa-info"></i> Success!</h4>
            <p id="msg-success-p"></p>
        </div>

        <div id="msg-error" class="alert alert-warning alert-dismissable" style="display: none;">
            <button type="button" class="close" id="error-close" aria-hidden="true">&times;</button>
            <h4><i class="icon fa fa-warning"></i> Error Occurred!</h4>
            <p id="msg-error-p"></p>
        </div>

        <a href="/auth/login" class="text-center">Already have an account? Log in</a>
    </div><!-- /.form-box -->
</div><!-- /.register-box -->

<!-- jQuery 2.1.3 -->
<script src="/assets/public/js/jquery.min.js"></script>
<!-- Bootstrap 3.3.2 JS -->
<script src="/assets/public/js/bootstrap.min.js" type="text/javascript"></script>
<!-- iCheck -->
<script src="/assets/public/js/icheck.min.js" type="text/javascript"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
        // $("#msg-error").hide(100);
        // $("#msg-success").hide(100);

    });
</script>
<script>
    $(document).ready(function () {
        function register() {
            $.ajax({
                type: "POST",
                url: "/auth/register",
                dataType: "json",
                data: {
                    email: $("#email").val(),
                    name: $("#name").val(),
                    passwd: $("#passwd").val(),
                    repasswd: $("#repasswd").val(),
                    code: $("#code").val(),
                    verifycode: $("#verifycode").val(),
                    agree: $("#agree").val()
                },
                success: function (data) {
                    if (data.ret == 1) {
                        $("#msg-error").hide(10);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/auth/login'", 2000);
                    } else {
                        $("#msg-success").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("There was an error: " + jqXHR.status);
                }
            });
        }

        $("html").keydown(function (event) {
            if (event.keyCode == 13) {
                register();
            }
        });
        $("#reg").click(function () {
            register();
        });
        $("#sendcode").on("click", function () {
            var count = sessionStorage.getItem('email-code-count') || 0;
            var email = $("#email").val();
            var timer, countdown = 60, $btn = $(this);
            if (count > 3 || timer) return false;

            if (!email) {
                $("#msg-error").hide(10);
                $("#msg-error").show(100);
                $("#msg-error-p").html("Please input email first!");
                return $("#email").focus();
            }

            $.ajax({
                type: "POST",
                url: "/auth/sendcode",
                dataType: "json",
                data: {
                    email: email
                },
                success: function (data) {
                    if (data.ret == 1) {
                        $("#msg-error").hide(10);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        timer = setInterval(function () {
                            --countdown;
                            if (countdown) {
                                $btn.text('Resend (' + countdown + 's)');
                            } else {
                                clearTimer();
                            }
                        }, 1000);
                    } else {
                        $("#msg-success").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                        clearTimer();
                    }
                },
                error: function (jqXHR) {
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("There was an error: " + jqXHR.status);
                    clearTimer();
                }
            });
            $btn.addClass("disabled").prop("disabled", true).text('Sending...');
            $("#verifycode").select();
            function clearTimer() {
                $btn.text('Resend').removeClass("disabled").prop("disabled", false);
                clearInterval(timer);
                timer = null;
            }
        });
        $("#ok-close").click(function () {
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function () {
            $("#msg-error").hide(100);
        });
    })
</script>
<div style="display:none;">
    {$analyticsCode}
</div>
</body>
</html>
