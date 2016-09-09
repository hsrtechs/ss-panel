{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Invite
            <small>Invite</small>
        </h1>
    </section>

    <!-- Main content --><!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-sm-12">
                <div id="msg-error" class="alert alert-warning alert-dismissable" style="display:none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-warning"></i> Error Occurred!</h4>

                    <p id="msg-error-p"></p>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- left column -->
            <div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-rocket"></i>

                        <h3 class="box-title">Invite</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <p>You can generate <code>{$user->invite_num}</code> invitation codes at this moment. </p>
                        {if $user->invite_num }
                            <button id="invite" class="btn btn-sm btn-info">Generate the invitation code for me</button>
                        {/if}
                    </div>
                    <!-- /.box -->
                    <div class="box-header">
                        <h3 class="box-title">My Invitation Code</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>###</th>
                                <th>Invitation Code(Right click to copy)</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach $codes as $code}
                                <tr>
                                    <td><b>{$code->id}</b></td>
                                    <td><a href="/auth/register?code={$code->code}" target="_blank">{$code->code}</a>
                                    </td>
                                    <td>Available</td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="callout callout-warning">
                    <h4>Notice!</h4>

                    <p>Please only share the code to people you know and have demand for that code.</p>

                    <p>We track the invitation, if the people you invited abuse, you might be punished as well.</p>
                </div>

                <div class="callout callout-info">
                    <h4>Note:</h4>

                    <p>Users can only generate invitation code 48 hours after register.</p>

                    <p>Invitation code cannot be purchased, so you should cherish.</p>

                    <p>The public page will release invitation code every now and then, you can keep an eye on it to get new invitation code.</p>
                </div>
            </div>
            <!-- /.col (right) -->
        </div>
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
    $(document).ready(function () {
        $("#invite").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/invite",
                dataType: "json",
                success: function (data) {
                    window.location.reload();
                },
                error: function (jqXHR) {
                    alert("There was an error: " + jqXHR.status);
                }
            })
        })
    })
</script>

{include file='user/footer.tpl'}
