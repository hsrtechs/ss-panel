<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
    <title>{$config["appName"]}</title>
    <!-- CSS fonts.googleapis.com -->
    <link href="//fonts.lug.ustc.edu.cn/icon?family=Material+Icons" rel="stylesheet">
    <link href="/assets/materialize/css/materialize.min.css" type="text/css" rel="stylesheet" media="screen,projection"/>
    <link href="/assets/materialize/css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
</head>
<body>
<nav class="light-blue lighten-1" role="navigation">
    <div class="nav-wrapper container"><a id="logo-container" href="/" class="brand-logo">{$config["appName"]}</a>
        <ul class="right hide-on-med-and-down">
            <li><a href="/">Home</a></li>
            <li><a href="https://shadowsocks.org/en/download/clients.html">Client</a></li>
            <li><a href="/code">Invitation Code</a></li>
            {if $user->isLogin}
                <li><a href="/user">Portal</a></li>
                <li><a href="/user/logout">Log Out</a></li>
            {else}
                <li><a href="/auth/login">Log In</a></li>
                <li><a href="/auth/register">Sign Up</a></li>
            {/if}

        </ul>

        <ul id="nav-mobile" class="side-nav">
            <li><a href="/">Home</a></li>
            <li><a href="https://shadowsocks.org/en/download/clients.html">Client</a></li>
            <li><a href="/code">Invitation Code</a></li>
            {if $user->isLogin}
                <li><a href="/user">Portal</a></li>
                <li><a href="/user/logout">Log Out</a></li>
            {else}
                <li><a href="/auth/login">Log In</a></li>
                <li><a href="/auth/register">Sign Up</a></li>
            {/if}
        </ul>
        <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">menu</i></a>
    </div>
</nav>
