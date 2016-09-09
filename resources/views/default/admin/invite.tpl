{include file='admin/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Invite
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div id="msg-success" class="alert alert-info alert-dismissable" style="display: none;">
                    <button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-info"></i> Success!</h4>

                    <p id="msg-success-p"></p>
                </div>

            </div>
        </div>
        <div class="row">
            <!-- left column -->
            <div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title">Add Invitation</h3>
                    </div>
                    <!-- /.box-header -->

                    <div class="box-body">

                        <div class="form-horizontal">

                            <div class="form-group">
                                <label for="cate_title" class="col-sm-3 control-label">Prefix of Invitation</label>

                                <div class="col-sm-9">
                                    <input class="form-control" id="prefix" placeholder="Less than 8 characters">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="cate_title" class="col-sm-3 control-label">Invitation Type</label>

                                <div class="col-sm-9">
                                    <input class="form-control" id="uid" type="number" placeholder="0 to make site public, the other numbers associate with user UID.">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="cate_title" class="col-sm-3 control-label">Invitation Numbers</label>

                                <div class="col-sm-9">
                                    <input class="form-control" id="num" type="number" placeholder="The number of Invitation to generate">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button id="invite" type="submit" name="action" value="add" class="btn btn-primary">Generate</button>
                    </div>

                </div>
            </div>
            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title">Notice</h3>
                    </div>
                    <div class="box-footer">
                        <p>Public Invitation（type 0）can be <a href="/code">reviewed here</a>.</p>
                    </div>
                </div>
            </div>
            <!-- /.box -->
        </div>
        <!-- /.row -->
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
    $(document).ready(function () {
        $("#invite").click(function () {
            $.ajax({
                type: "POST",
                url: "/admin/invite",
                dataType: "json",
                data: {
                    prefix: $("#prefix").val(),
                    uid: $("#uid").val(),
                    num: $("#num").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        //window.setTimeout("location.href='/admin/invite'", 2000);
                    }
                    // window.location.reload();
                },
                error: function (jqXHR) {
                    alert("There was an error: " + jqXHR.status);
                }
            })
        })
    })
</script>

{include file='admin/footer.tpl'}
