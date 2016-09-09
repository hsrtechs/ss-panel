{include file='admin/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Add Node
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div id="msg-success" class="alert alert-success alert-dismissable" style="display: none;">
                    <button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-info"></i> Success!</h4>

                    <p id="msg-success-p"></p>
                </div>
                <div id="msg-error" class="alert alert-warning alert-dismissable" style="display: none;">
                    <button type="button" class="close" id="error-close" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-warning"></i> Error Occurred!</h4>

                    <p id="msg-error-p"></p>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-body">
                        <div class="form-horizontal">
                            <div class="row">
                                <fieldset class="col-sm-6">
                                    <legend>Connection Info</legend>
                                    <div class="form-group">
                                        <label for="title" class="col-sm-3 control-label">Node Name</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="name" value="">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="server" class="col-sm-3 control-label">Node Address</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="server" value="">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="method" class="col-sm-3 control-label">Encryption Method</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="method" value="">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="rate" class="col-sm-3 control-label">Traffic Calculation Rate</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="rate" value="1">
                                        </div>

                                    </div>

                                    <div class="form-group">
                                        <label for="method" class="col-sm-3 control-label">Custom Encryption Method</label>

                                        <div class="col-sm-9">
                                            <select class="form-control" id="custom_method">
                                                <option value="0" selected="selected">
                                                    Not Supported
                                                </option>
                                                <option value="1">
                                                    Supported
                                                </option>
                                            </select>

                                            <p class="help-block">
                                                <a href="https://github.com/orvice/ss-panel/wiki/v3-custom-method">How to use custom encryption method?</a>|
                                                <a href="https://github.com/orvice/ss-panel/wiki/v3-traffic-rate">How to set traffic calculation rate?</a>
                                            </p>
                                        </div>
                                    </div>

                                </fieldset>
                                <fieldset class="col-sm-6">
                                    <legend>Connection Info</legend>
                                    <div class="form-group">
                                        <label for="type" class="col-sm-3 control-label">Display or not?</label>

                                        <div class="col-sm-9">
                                            <select class="form-control" id="type">
                                                <option value="1" selected="selected">Display</option>
                                                <option value="0">Hidden</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="status" class="col-sm-3 control-label">Node Status</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="status" value="">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="sort" class="col-sm-3 control-label">Set Order</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="sort" type="number" value="">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="info" class="col-sm-3 control-label">Node Description</label>

                                        <div class="col-sm-9">
                                            <textarea class="form-control" id="info" rows="3"></textarea>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <button type="submit" id="submit" name="action" value="add" class="btn btn-primary">Add</button>
                    </div>
                </div>
                <!-- /.box -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.row -->
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
    $(document).ready(function () {
        function submit() {
            $.ajax({
                type: "POST",
                url: "/admin/node",
                dataType: "json",
                data: {
                    name: $("#name").val(),
                    server: $("#server").val(),
                    method: $("#method").val(),
                    custom_method: $("#custom_method").val(),
                    rate: $("#rate").val(),
                    info: $("#info").val(),
                    type: $("#type").val(),
                    status: $("#status").val(),
                    sort: $("#sort").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide(100);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/admin/node'", 2000);
                    } else {
                        $("#msg-error").hide(10);
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
                login();
            }
        });
        $("#submit").click(function () {
            submit();
        });
        $("#ok-close").click(function () {
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function () {
            $("#msg-error").hide(100);
        });
    })
</script>


{include file='admin/footer.tpl'}
