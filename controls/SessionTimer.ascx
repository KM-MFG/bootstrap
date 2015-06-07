<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SessionTimer.ascx.cs" Inherits="AspDotNetStorefront.controls_SessionTimer" %>
<asp:Panel runat="server" ID="pnlSessionWarning">
	<script src="jscripts/boxit.js" type="text/javascript"></script>

	<div class="session-expiring-wrap boxit" id="sessionWarningDialog" style="display: none;">
		<div class="boxit-content session-modal">
			<asp:Literal ID="litSessionExpiring" runat="server" Text="<%$ Tokens:Topic, SessionExpiring %>" />
			<asp:HyperLink runat="server" ClientIDMode="Static" ID="hlResetSessionTimer" data-role="button" CssClass="button call-to-action session-button" Text="<%$ Tokens:StringResource, sessiontimer.expiringbuttontext %>" />
		</div>
	</div>

	<div class="session-expired-wrap boxit" id="sessionExpiredDialog" style="display: none;">
		<div class="boxit-content session-modal">
			<asp:Literal ID="litSessionExpired" runat="server" Text="<%$ Tokens:Topic, SessionExpired %>" />
			<asp:HyperLink runat="server" ClientIDMode="Static" ID="hlSessionExpired" data-role="button" CssClass="button call-to-action session-button" Text="<%$ Tokens:StringResource, sessiontimer.expiredbuttontext %>" />
		</div>
	</div>

	<script type="text/javascript">
		adnsf$(document).ready(function () {
			adnsf$("#hlResetSessionTimer").click(function (event) {
				sessionTimer.refresh(true);
			});

			adnsf$("#hlSessionExpired").click(function (event) {
				location.reload();
			});

			sessionTimer.start();
		});
	</script>

	<script type="text/javascript">
		var sessionTimer = (function () {
			var warningTimer;
			var expiredTimer;

			function startSessionTimer() {

				//Protect against broken JS
				if(!sessionTimeoutInMilliSeconds || sessionTimeoutInMilliSeconds < 60000)
					return;

				//One minute warning
				warningTimer = setTimeout(function () {
					adnsf$(".session-expiring-wrap").boxit().open();
				}, sessionTimeoutInMilliSeconds - 60000);

				//Session ended
				expiredTimer = setTimeout(function () {
					adnsf$(".session-expiring-wrap").boxit().close();
					adnsf$(".session-expired-wrap").boxit().open();
				}, sessionTimeoutInMilliSeconds);
			}

			function refreshSession(closeDialog) {
				//Stop the timers
				clearTimeout(expiredTimer);
				clearTimeout(warningTimer);

				//Close the warning dialog if it was open - this may have been called by SOPC before that happens
				if(closeDialog) {
					closeWarningDialog();
				}

				//AJAX call to refresh the session
				adnsf$.ajax({ type: "POST", url: "refreshsession.aspx", dataType: "text" });

				//Start the timers again
				startSessionTimer();
			}

			function closeWarningDialog() {
				adnsf$(".session-expiring-wrap").boxit().close();
			}

			return {
				start: startSessionTimer,
				refresh: refreshSession
			};

		})();		
	</script>
</asp:Panel>
