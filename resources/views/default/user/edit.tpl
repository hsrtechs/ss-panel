{include file='user/main.tpl'}

<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Modify Profile
            <small>Profile Edit</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div id="msg-error" class="alert alert-warning alert-dismissable" style="display:none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-warning"></i> There's an error!</h4>

                    <p id="msg-error-p"></p>
                </div>
                <div id="ss-msg-success" class="alert alert-success alert-dismissable" style="display:none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-info"></i> Update successfully!</h4>

                    <p id="ss-msg-success-p"></p>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- left column -->
            <div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-key"></i>

                        <h3 class="box-title">Change Login Password</h3>
                    </div>
                    <!-- /.box-header --><!-- form start -->

                    <div class="box-body">
                        <div class="form-horizontal">

                            <div id="msg-success" class="alert alert-info alert-dismissable" style="display:none">
                                <button type="button" class="close" data-dismiss="alert"
                                        aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-info"></i> Ok!</h4>

                                <p id="msg-success-p"></p>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">Current Password</label>

                                <div class="col-sm-9">
                                    <input type="password" class="form-control" placeholder="Current Password(Required)" id="oldpwd">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">New Password</label>

                                <div class="col-sm-9">
                                    <input type="password" class="form-control" placeholder="New Password" id="pwd">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">Repeat Password</label>

                                <div class="col-sm-9">
                                    <input type="password" placeholder="Repeat Password" class="form-control" id="repwd">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button type="submit" id="pwd-update" class="btn btn-primary">Submit</button>
                    </div>

                </div>
                <!-- /.box -->
            </div>

            <div class="col-md-6">

                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-link"></i>

                        <h3 class="box-title">Shadowsocks Info Modify</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Password For Connection</label>

                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <input type="text" id="sspwd" placeholder="Type new password for connection" class="form-control">
                                        <div class="input-group-btn">
                                            <button type="submit" id="ss-pwd-update" class="btn btn-primary">Submit</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">Encryption Method</label>

                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <input type="text" id="method" placeholder="Type new encryption method" class="form-control">
                                        <div class="input-group-btn">
                                            <button type="submit" id="method-update" class="btn btn-primary">Submit</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="box-footer"></div>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->

        </div>
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
    $("#msg-success").hide();
    $("#msg-error").hide();
    $("#ss-msg-success").hide();
</script>

<script>
    $(document).ready(function () {
        $("#pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "password",
                dataType: "json",
                data: {
                    oldpwd: $("#oldpwd").val(),
                    pwd: $("#pwd").val(),
                    repwd: $("#repwd").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide();
                        $("#msg-success").show();
                        $("#msg-success-p").html(data.msg);
                    } else {
                        $("#msg-error").show();
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("There was an error:" + jqXHR.status);
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#ss-pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "sspwd",
                dataType: "json",
                data: {
                    sspwd: $("#sspwd").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#ss-msg-success").show();
                        $("#ss-msg-success-p").html(data.msg);
                    } else {
                        $("#ss-msg-error").show();
                        $("#ss-msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("There was an error: " + jqXHR.status);
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#method-update").click(function () {
            $.ajax({
                type: "POST",
                url: "method",
                dataType: "json",
                data: {
                    method: $("#method").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#ss-msg-success").show();
                        $("#ss-msg-success-p").html(data.msg);
                    } else {
                        $("#ss-msg-error").show();
                        $("#ss-msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("There was an error: " + jqXHR.status);
                }
            })
        })
    })
</script>


{include file='user/footer.tpl'}
