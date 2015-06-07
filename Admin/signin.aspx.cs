// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using AspDotNetStorefrontCore;

public partial class signin : System.Web.UI.Page
{
	private String LastSecurityCode = String.Empty;
	private Boolean DisablePasswordAutocomplete
	{
		get { return AppLogic.AppConfigBool("DisablePasswordAutocomplete"); }
	}


	protected void Page_Load(object sender, EventArgs e)
	{


		Response.CacheControl = "private";
		Response.Expires = 0;
		Response.AddHeader("pragma", "no-cache");

		if(AppLogic.IsAdminSite && AppLogic.OnLiveServer() && AppLogic.UseSSL() && !CommonLogic.IsSecureConnection())
		{
			if(AppLogic.RedirectLiveToWWW())
			{
				HttpContext.Current.Response.Redirect("https://www." + AppLogic.LiveServer() + CommonLogic.ServerVariables("PATH_INFO") + "?" + CommonLogic.ServerVariables("QUERY_STRING"));
			}
			else
			{
				HttpContext.Current.Response.Redirect("https://" + AppLogic.LiveServer() + CommonLogic.ServerVariables("PATH_INFO") + "?" + CommonLogic.ServerVariables("QUERY_STRING"));
			}
		}

		if(DisablePasswordAutocomplete)
		{
			AppLogic.DisableAutocomplete(txtPassword);
			AppLogic.DisableAutocomplete(txtOldPwd);
			AppLogic.DisableAutocomplete(txtNewPwd);
			AppLogic.DisableAutocomplete(txtConfirmPwd);
		}

		if(!IsPostBack)
		{

			loadHolders();
			if(AppLogic.AppConfigBool("SecurityCodeRequiredOnAdminLogin"))
			{
				Session["SecurityCode"] = CommonLogic.GenerateRandomCode(6);
			}

		}

		txtEMail.Focus();
		if(AppLogic.AppConfigBool("SecurityCodeRequiredOnAdminLogin"))
		{
			RowSecurityImage.Visible = true;
			SecurityImage.Visible = true;
			RowSecurityCode.Visible = true;
			SecurityCode.Visible = true;
			SecurityCodeLabel.Visible = true;
			SecurityCodeLabel.Text = AppLogic.GetString("signin.aspx.21", 1, Localization.GetDefaultLocale());
			SecurityImage.ImageUrl = "../Captcha.ashx?id=1";
		}
		else
		{
			RowSecurityImage.Visible = false;
			SecurityImage.Visible = false;
			RowSecurityCode.Visible = false;
			SecurityCode.Visible = false;
			SecurityCodeLabel.Visible = false;
			SecurityImage.ImageUrl = string.Empty;
		}

	}

	protected void loadHolders()
	{
		ltStoreName.Text = AppLogic.AppConfig("StoreName");
	}

	protected void btnSubmit_Click(object sender, EventArgs e)
	{
		int SkinID = 1;
		String EMailField = CommonLogic.FormCanBeDangerousContent("txtEMail").ToLowerInvariant().Trim();
		String PasswordField = CommonLogic.FormCanBeDangerousContent("txtPassword").Trim();

		bool LoginOK = false;

		if(AppLogic.AppConfigBool("SecurityCodeRequiredOnAdminLogin"))
		{
			if(Session["SecurityCode"] != null)
			{
				String sCode = Session["SecurityCode"].ToString();
				String fCode = SecurityCode.Text;
				Boolean codeMatch = false;

				if(AppLogic.AppConfigBool("Captcha.CaseSensitive"))
				{
					if(fCode.Equals(sCode))
						codeMatch = true;
				}
				else
				{
					if(fCode.Equals(sCode, StringComparison.InvariantCultureIgnoreCase))
						codeMatch = true;
				}

				if(!codeMatch)
				{
					loginError.Visible = true;
					ltError.Text = "Invalid Security Code|" + sCode + "|" + fCode + "|";
					SecurityCode.Text = String.Empty;
					SecurityImage.ImageUrl = "../Captcha.ashx?id=1";
					return;
				}
			}
			else
			{
				loginError.Visible = true;
				ltError.Text = "Invalid Security Code|" + "" + "|" + SecurityCode.Text + "|";
				SecurityCode.Text = String.Empty;
				SecurityImage.ImageUrl = "../Captcha.ashx?id=1";
				return;
			}
		}

		Customer c = new Customer(null, EMailField, true, false, true);

		if(c.IsRegistered && (c.IsAdminUser || c.IsAdminSuperUser))
		{
			LoginOK = c.CheckLogin(PasswordField);
			if(LoginOK)
			{
				if(c.LockedUntil > DateTime.Now)
				{
					loginError.Visible = true;
					ltError.Text = AppLogic.GetString("lat_signin_process.aspx.3", SkinID, c.LocaleSetting);
					return;
				}
				else if(!c.Active)
				{
					loginError.Visible = true;
					ltError.Text = AppLogic.GetString("lat_signin_process.aspx.2", SkinID, c.LocaleSetting);
					return;
				}
				else if(c.PwdChanged.AddDays(AppLogic.AppConfigUSDouble("AdminPwdChangeDays")) < DateTime.Now || c.PwdChangeRequired)
				{
					lblPwdChgErrMsg.Text = AppLogic.GetString("lat_signin_process.aspx.4", SkinID, c.LocaleSetting);
					pnlPwdChgErrMsg.Visible = true;
					pnlChangePwd.Visible = true;
					pnlSignIn.Visible = false;
					txtEmailNewPwd.Text = c.EMail;
					txtOldPwd.Focus();
					return;
				}
			}
			else
			{
				Session["SecurityCode"] = CommonLogic.GenerateRandomCode(6);
				if(AppLogic.AppConfigBool("SecurityCodeRequiredOnAdminLogin"))
				{
					SecurityCode.Text = "";
					Session["SecurityCode"] = CommonLogic.GenerateRandomCode(6);
				}
				Security.LogEvent("Admin Site Login Failed", "Attempted login failed for email address " + EMailField, 0, 0, 0);
				loginError.Visible = true;
				ltError.Text = AppLogic.GetString("lat_signin_process.aspx.1", c.SkinID, Localization.GetDefaultLocale());
				object lockuntil = null;
				int badlogin = 1;
				if((c.BadLoginCount + 1) >= AppLogic.AppConfigNativeInt("MaxBadLogins"))
				{
					lockuntil = DateTime.Now.AddMinutes(AppLogic.AppConfigUSInt("BadLoginLockTimeOut"));
					badlogin = -1;
					ltError.Text = AppLogic.GetString("lat_signin_process.aspx.3", SkinID, Localization.GetDefaultLocale());
				}
				c.UpdateCustomer(
					/*CustomerLevelID*/ null,
					/*EMail*/ null,
					/*SaltedAndHashedPassword*/ null,
					/*SaltKey*/ null,
					/*DateOfBirth*/ null,
					/*Gender*/ null,
					/*FirstName*/ null,
					/*LastName*/ null,
					/*Notes*/ null,
					/*SkinID*/ null,
					/*Phone*/ null,
					/*AffiliateID*/ null,
					/*Referrer*/ null,
					/*CouponCode*/ null,
					/*OkToEmail*/ null,
					/*IsAdmin*/ null,
					/*BillingEqualsShipping*/ null,
					/*LastIPAddress*/ null,
					/*OrderNotes*/ null,
					/*RTShipRequest*/ null,
					/*RTShipResponse*/ null,
					/*OrderOptions*/ null,
					/*LocaleSetting*/ null,
					/*MicroPayBalance*/ null,
					/*RecurringShippingMethodID*/ null,
					/*RecurringShippingMethod*/ null,
					/*BillingAddressID*/ null,
					/*ShippingAddressID*/ null,
					/*CODCompanyCheckAllowed*/ null,
					/*CODNet30Allowed*/ null,
					/*ExtensionData*/ null,
					/*FinalizationData*/ null,
					/*Deleted*/ null,
					/*Over13Checked*/ null,
					/*CurrencySetting*/ null,
					/*VATSetting*/ null,
					/*VATRegistrationID*/ null,
					/*StoreCCInDB*/ null,
					/*IsRegistered*/ null,
					/*LockedUntil*/ lockuntil,
					/*AdminCanViewCC*/ null,
					/*BadLogin*/ badlogin,
					/*Active*/ null,
					/*PwdChangeRequired*/ null,
					/*RegisterDate*/ null,
					/*StoreId*/null
					);
				return;
			}

		}
		else
		{
			if(c.IsAdminUser)
			{
				Security.LogEvent("Invalid Admin Site Login", "An invalid login name was used: " + EMailField, 0, 0, 0);
			}
			loginError.Visible = true;
			ltError.Text = AppLogic.GetString("lat_signin_process.aspx.1", c.SkinID, Localization.GetDefaultLocale());
			Session["SecurityCode"] = CommonLogic.GenerateRandomCode(6);
			SecurityCode.Text = "";
			return;
		}



		// we've got a good login:
		object lockeduntil = DateTime.Now.AddMinutes(-1);
		c.UpdateCustomer(
			/*CustomerLevelID*/ null,
			/*EMail*/ null,
			/*SaltedAndHashedPassword*/ null,
			/*SaltKey*/ null,
			/*DateOfBirth*/ null,
			/*Gender*/ null,
			/*FirstName*/ null,
			/*LastName*/ null,
			/*Notes*/ null,
			/*SkinID*/ null,
			/*Phone*/ null,
			/*AffiliateID*/ null,
			/*Referrer*/ null,
			/*CouponCode*/ null,
			/*OkToEmail*/ null,
			/*IsAdmin*/ null,
			/*BillingEqualsShipping*/ null,
			/*LastIPAddress*/ null,
			/*OrderNotes*/ null,
			/*RTShipRequest*/ null,
			/*RTShipResponse*/ null,
			/*OrderOptions*/ null,
			/*LocaleSetting*/ null,
			/*MicroPayBalance*/ null,
			/*RecurringShippingMethodID*/ null,
			/*RecurringShippingMethod*/ null,
			/*BillingAddressID*/ null,
			/*ShippingAddressID*/ null,
			/*CODCompanyCheckAllowed*/ null,
			/*CODNet30Allowed*/ null,
			/*ExtensionData*/ null,
			/*FinalizationData*/ null,
			/*Deleted*/ null,
			/*Over13Checked*/ null,
			/*CurrencySetting*/ null,
			/*VATSetting*/ null,
			/*VATRegistrationID*/ null,
			/*StoreCCInDB*/ null,
			/*IsRegistered*/ null,
			/*LockedUntil*/ lockeduntil,
			/*AdminCanViewCC*/ null,
			/*BadLogin*/ -1,
			/*Active*/ null,
			/*PwdChangeRequired*/ 0,
			/*RegisterDate*/ null,
			/*StoreId*/null
			);

		//clear impersonation
		c.ThisCustomerSession.ClearVal("IGD");
		c.ThisCustomerSession.ClearVal("IGD_EDITINGORDER");

		string LocaleSetting = c.LocaleSetting;
		if(LocaleSetting.Length == 0)
		{
			LocaleSetting = Localization.GetDefaultLocale();
		}
		LocaleSetting = Localization.CheckLocaleSettingForProperCase(LocaleSetting);
		String CustomerGUID = c.CustomerGUID.Replace("{", "").Replace("}", "");
		Security.LogEvent("Admin Site Login", "", c.CustomerID, c.CustomerID, c.ThisCustomerSession.SessionID);
		FormsAuthentication.SetAuthCookie(CustomerGUID, false);
		Response.Write("<script type=\"text/javascript\">top.location='" + AppLogic.AdminLinkUrl("default.aspx") + "'</script>;");
	}

	protected void btnRequestNewPassword_Click(object sender, EventArgs e)
	{
		string FromEMail = AppLogic.AppConfig("MailMe_FromAddress");
		string EMail = CommonLogic.IIF(CommonLogic.FormCanBeDangerousContent("txtEMailRemind").Length > 0, CommonLogic.FormCanBeDangerousContent("txtEMailRemind"), CommonLogic.FormCanBeDangerousContent("txtEMail"));
		loginError.Visible = true;
		ltError.Text = "Email: " + EMail;

		Customer c = new Customer(null, EMail, false, false, true);

		if(!c.IsRegistered)
		{
			ltError.Text = AppLogic.GetString("signin.aspx.admin.1", c.SkinID, c.LocaleSetting);
		}
		else if(AppLogic.MailServer().Length == 0 || AppLogic.MailServer() == AppLogic.ro_TBD)
		{
			ltError.Text = AppLogic.GetString("signin.aspx.admin.2", c.SkinID, c.LocaleSetting);
		}
		else
		{
			Password p = new Password();
			bool SendWasOk = false;
			try
			{
				String PackageName = AppLogic.AppConfig("XmlPackage.LostPassword");
				XmlPackage2 pkg = new XmlPackage2(PackageName, c, c.SkinID, String.Empty, "newpwd=" + p.ClearPassword.Replace("&", "*") + "&thiscustomerid=" + c.CustomerID.ToString());
				String MsgBody = pkg.TransformString();
				AppLogic.SendMail(AppLogic.AppConfig("StoreName") + " " + AppLogic.GetString("lostpassword.aspx.6", c.SkinID, c.LocaleSetting), MsgBody, true, FromEMail, FromEMail, EMail, EMail, "", AppLogic.MailServer());
				SendWasOk = true;
				object lockeduntil = DateTime.Now.AddMinutes(-1);

				c.UpdateCustomer(
					/*CustomerLevelID*/ null,
					/*EMail*/ null,
					/*SaltedAndHashedPassword*/ p.SaltedPassword,
					/*SaltKey*/ p.Salt,
					/*DateOfBirth*/ null,
					/*Gender*/ null,
					/*FirstName*/ null,
					/*LastName*/ null,
					/*Notes*/ null,
					/*SkinID*/ null,
					/*Phone*/ null,
					/*AffiliateID*/ null,
					/*Referrer*/ null,
					/*CouponCode*/ null,
					/*OkToEmail*/ null,
					/*IsAdmin*/ null,
					/*BillingEqualsShipping*/ null,
					/*LastIPAddress*/ null,
					/*OrderNotes*/ null,
					/*RTShipRequest*/ null,
					/*RTShipResponse*/ null,
					/*OrderOptions*/ null,
					/*LocaleSetting*/ null,
					/*MicroPayBalance*/ null,
					/*RecurringShippingMethodID*/ null,
					/*RecurringShippingMethod*/ null,
					/*BillingAddressID*/ null,
					/*ShippingAddressID*/ null,
					/*CODCompanyCheckAllowed*/ null,
					/*CODNet30Allowed*/ null,
					/*ExtensionData*/ null,
					/*FinalizationData*/ null,
					/*Deleted*/ null,
					/*Over13Checked*/ null,
					/*CurrencySetting*/ null,
					/*VATSetting*/ null,
					/*VATRegistrationID*/ null,
					/*StoreCCInDB*/ null,
					/*IsRegistered*/ null,
					/*LockedUntil*/ lockeduntil,
					/*AdminCanViewCC*/ null,
					/*BadLogin*/ -1,
					/*Active*/ null,
					/*PwdChangeRequired*/ 1,
					/*RegisterDate*/ null,
					/*StoreId*/null
					);
			}
			catch { }
			if(!SendWasOk)
			{
				ltError.Text = AppLogic.GetString("lostpassword.aspx.3", c.SkinID, c.LocaleSetting);
			}
			else
			{
				ltError.Text = AppLogic.GetString("lostpassword.aspx.2", c.SkinID, c.LocaleSetting);
			}
		}

	}

	protected void btnChangePwd_OnClick(object sender, EventArgs e)
	{
		Customer ThisCustomer = new Customer(null, txtEmailNewPwd.Text, true, false, true);
		string newpwd = txtNewPwd.Text;
		string oldpwd = txtOldPwd.Text;
		string confirmpwd = txtConfirmPwd.Text;
		txtNewPwd.Text = "";
		txtOldPwd.Text = "";
		txtConfirmPwd.Text = "";
		if(ThisCustomer.IsRegistered)
		{
			Password pwdold = new Password(oldpwd, ThisCustomer.SaltKey);
			Password pwdnew = new Password(newpwd, ThisCustomer.SaltKey);
			if(ThisCustomer.Password != pwdold.SaltedPassword)
			{
				lblPwdChgErrMsg.Text = "Invalid old password.";
				return;
			}

			if(oldpwd == newpwd)
			{
				lblPwdChgErrMsg.Text = AppLogic.GetString("signin.aspx.30", ThisCustomer.SkinID, ThisCustomer.LocaleSetting);
				return;
			}

			if(newpwd != confirmpwd)
			{
				lblPwdChgErrMsg.Text = AppLogic.GetString("signin.aspx.32", ThisCustomer.SkinID, ThisCustomer.LocaleSetting);
				return;
			}

			if(!Regex.IsMatch(newpwd, AppLogic.AppConfig("CustomerPwdValidator"), RegexOptions.Compiled))
			{
				lblPwdChgErrMsg.Text = AppLogic.GetString("signin.aspx.26", ThisCustomer.SkinID, ThisCustomer.LocaleSetting);
				return;
			}

			if(ThisCustomer.PwdPreviouslyUsed(newpwd))
			{
				lblPwdChgErrMsg.Text = String.Format(AppLogic.GetString("signin.aspx.31", ThisCustomer.SkinID, ThisCustomer.LocaleSetting), AppLogic.AppConfig("NumPreviouslyUsedPwds"));
				return;
			}

			if(ThisCustomer.BadLoginCount >= AppLogic.AppConfigNativeInt("MaxBadLogins"))
			{
				lblPwdChgErrMsg.Text = "<br/><br/>" + AppLogic.GetString("lat_signin_process.aspx.3", ThisCustomer.SkinID, ThisCustomer.LocaleSetting);
				return;
			}

			newpwd = pwdnew.SaltedPassword;
			oldpwd = pwdold.SaltedPassword;


			ThisCustomer.UpdateCustomer(
				/*CustomerLevelID*/ null,
				/*EMail*/ null,
				/*SaltedAndHashedPassword*/ newpwd,
				/*SaltKey*/ pwdnew.Salt,
				/*DateOfBirth*/ null,
				/*Gender*/ null,
				/*FirstName*/ null,
				/*LastName*/ null,
				/*Notes*/ null,
				/*SkinID*/ null,
				/*Phone*/ null,
				/*AffiliateID*/ null,
				/*Referrer*/ null,
				/*CouponCode*/ null,
				/*OkToEmail*/ null,
				/*IsAdmin*/ null,
				/*BillingEqualsShipping*/ null,
				/*LastIPAddress*/ null,
				/*OrderNotes*/ null,
				/*RTShipRequest*/ null,
				/*RTShipResponse*/ null,
				/*OrderOptions*/ null,
				/*LocaleSetting*/ null,
				/*MicroPayBalance*/ null,
				/*RecurringShippingMethodID*/ null,
				/*RecurringShippingMethod*/ null,
				/*BillingAddressID*/ null,
				/*ShippingAddressID*/ null,
				/*CODCompanyCheckAllowed*/ null,
				/*CODNet30Allowed*/ null,
				/*ExtensionData*/ null,
				/*FinalizationData*/ null,
				/*Deleted*/ null,
				/*Over13Checked*/ null,
				/*CurrencySetting*/ null,
				/*VATSetting*/ null,
				/*VATRegistrationID*/ null,
				/*StoreCCInDB*/ null,
				/*IsRegistered*/ null,
				/*LockedUntil*/ null,
				/*AdminCanViewCC*/ null,
				/*BadLogin*/ null,
				/*Active*/ null,
				/*PwdChangeRequired*/ 0,
				/*RegisterDate*/ null,
				/*StoreId*/null
				   );

			Security.LogEvent("Admin Password Changed", "", ThisCustomer.CustomerID, ThisCustomer.CustomerID, 0);

			ThisCustomer.ThisCustomerSession.ClearVal("IGD");
			ThisCustomer.ThisCustomerSession.ClearVal("IGD_EDITINGORDER");

			string LocaleSetting = ThisCustomer.LocaleSetting;
			if(LocaleSetting.Length == 0)
			{
				LocaleSetting = Localization.GetDefaultLocale();
			}
			LocaleSetting = Localization.CheckLocaleSettingForProperCase(LocaleSetting);
			String CustomerGUID = ThisCustomer.CustomerGUID.Replace("{", "").Replace("}", "");
			Security.LogEvent("Admin Site Login", "", ThisCustomer.CustomerID, ThisCustomer.CustomerID, ThisCustomer.ThisCustomerSession.SessionID);
			FormsAuthentication.SetAuthCookie(CustomerGUID, false);

			Response.Write("<script type=\"text/javascript\">top.location='" + AppLogic.AdminLinkUrl("default.aspx") + "'</script>;");
		}
		else
		{
			lblPwdChgErrMsg.Text = "Please enter a valid administrator's email address.";
			return;
		}

	}
}
