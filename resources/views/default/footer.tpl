<footer class="page-footer orange">
	<div class="container">
		<div class="row">
			<div class="col l6 s12">
				<h5 class="white-text">About</h5>
				<p class="grey-text text-lighten-4">We provide accounts for scientific browsering.</p>


			</div>
			<div class="col l3 s12">
				<h5 class="white-text">Customers</h5>
				<ul>
				{if $user->isLogin}
					<li><a class="white-text" href="/user">Portal</a></li>
					<li><a class="white-text" href="/user/logout">Log Out</a></li>
				{else}
					<li><a class="white-text" href="/auth/login">Log In</a></li>
					<li><a class="white-text" href="/auth/register">Sign Up</a></li>
				{/if}
				</ul>
			</div>
			<div class="col l3 s12">
				<h5 class="white-text">Pages</h5>
				<ul>
					<li><a class="white-text" href="/code">Invitation Code</a></li>
					<li><a class="white-text" href="/tos">ToS</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="footer-copyright">
		<div class="container">
			&copy; {$config["appName"]}  Powered by <a class="orange-text text-lighten-3" href="https://github.com/orvice/ss-panel">ss-panel</a> {$config["version"]}
		 Theme by <a class="orange-text text-lighten-3" href="http://materializecss.com">Materialize</a>
		</div>
		<div style="display:none;">
			{$analyticsCode}
		</div>
	</div>
</footer>


<!--  Scripts-->
<script src="/assets/public/js/jquery.min.js"></script>
<script src="/assets/materialize/js/materialize.min.js"></script>
<script src="/assets/materialize/js/init.js"></script>

</body>
</html>
