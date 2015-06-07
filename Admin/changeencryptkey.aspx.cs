// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
	public partial class changeencryptkey : AdminPageBase
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Server.ScriptTimeout = 5000000;
			SectionTitle = AppLogic.GetString("admin.title.changeencryptkey", SkinID, LocaleSetting);

			if(!ThisCustomer.IsAdminSuperUser)
			{
				ctlAlertMessage.PushAlertMessage(AppLogic.GetString("admin.common.Notification.UnAuthorized", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}

			if(!IsPostBack)
			{
				bool StoringCCInDB = AppLogic.StoreCCInDB();
				bool HaveRecurringThatNeedCC = AppLogic.ThereAreRecurringOrdersThatNeedCCStorage();
				bool ValidTrustLevel = (AppLogic.TrustLevel == AspNetHostingPermissionLevel.Unrestricted || AppLogic.TrustLevel == AspNetHostingPermissionLevel.High);
				StoringCC.Text = CommonLogic.IIF(StoringCCInDB, AppLogic.GetString("admin.common.Yes", SkinID, LocaleSetting), AppLogic.GetString("admin.common.No", SkinID, LocaleSetting));
				RecurringProducts.Text = CommonLogic.IIF(HaveRecurringThatNeedCC, AppLogic.GetString("admin.common.Yes", SkinID, LocaleSetting), AppLogic.GetString("admin.common.No", SkinID, LocaleSetting));
				rblChangeMachineKey.SelectedValue = "false";
				rblChangeEncryptKey.SelectedValue = "false";

				pnlUpdateEncryptKey.Visible = false;

				if((!StoringCCInDB && !HaveRecurringThatNeedCC) || !ValidTrustLevel)
				{
					DoItPanel.Visible = false;
				}
			}
		}

		protected void btnUpdateEncryptKey_Click(object sender, EventArgs e)
		{
			bool changeEncryptKeySelected = rblChangeEncryptKey.SelectedValue.Equals("true", StringComparison.InvariantCultureIgnoreCase);
			bool changeMachineKeySelected = rblChangeMachineKey.SelectedValue.Equals("true", StringComparison.InvariantCultureIgnoreCase);
			bool encryptKeyAutoGenerate = rblEncryptKeyGenType.SelectedValue.Equals("auto", StringComparison.InvariantCultureIgnoreCase);
			bool machineKeyAutoGenerate = rblMachineKeyGenType.SelectedValue.Equals("auto", StringComparison.InvariantCultureIgnoreCase);

			if(changeEncryptKeySelected && !encryptKeyAutoGenerate && (NewEncryptKey.Text.Trim().Length < 8 || NewEncryptKey.Text.Trim().Length > 50))
			{
				ctlAlertMessage.PushAlertMessage(AppLogic.GetString("admin.changeencryptkey.AtLeast", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				return;
			}

			if(changeMachineKeySelected)
			{
				if(!machineKeyAutoGenerate && (txtValidationKey.Text.Trim().Length < 32 || txtValidationKey.Text.Trim().Length > 64))
				{
					ctlAlertMessage.PushAlertMessage(AppLogic.GetString("admin.changeencryptkey.ValidationKeyAtLeast", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
					return;
				}
				else if(!machineKeyAutoGenerate && txtDecryptKey.Text.Trim().Length != 24)
				{
					ctlAlertMessage.PushAlertMessage(AppLogic.GetString("admin.changeencryptkey.DecryptKeyAtLeast", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
					return;
				}
			}

			try
			{
				WebConfigManager webMgr = new WebConfigManager();

				if(changeEncryptKeySelected)
				{
					webMgr.SetEncryptKey = true;
					webMgr.EncryptKeyGenMethod = (WebConfigManager.KeyGenerationMethod)Enum.Parse(typeof(WebConfigManager.KeyGenerationMethod),
						rblEncryptKeyGenType.SelectedValue, true);

					if(webMgr.EncryptKeyGenMethod == WebConfigManager.KeyGenerationMethod.Manual)
					{
						webMgr.EncryptKey = NewEncryptKey.Text;
					}
				}

				if(changeMachineKeySelected)
				{
					webMgr.SetMachineKey = true;
					webMgr.ValidationKeyGenMethod = (WebConfigManager.KeyGenerationMethod)Enum.Parse(typeof(WebConfigManager.KeyGenerationMethod),
						rblMachineKeyGenType.SelectedValue, true);

					webMgr.DecryptKeyGenMethod = webMgr.ValidationKeyGenMethod;

					if(webMgr.ValidationKeyGenMethod == WebConfigManager.KeyGenerationMethod.Manual)
					{
						webMgr.ValidationKey = txtValidationKey.Text;
						webMgr.DecryptKey = txtDecryptKey.Text;
					}
				}

				List<Exception> commitExceptions = webMgr.Commit();

				if(commitExceptions.Count > 0)
				{
					StringBuilder sb = new StringBuilder();
					sb.Append("Your web.config could not be saved for the following reasons:<br/>");
					foreach(Exception ex in commitExceptions)
						sb.Append(ex.Message + "<br />");

					ctlAlertMessage.PushAlertMessage(sb.ToString(), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				}
				else
					ctlAlertMessage.PushAlertMessage(AppLogic.GetString("admin.changeencryptkey.Done", ThisCustomer.LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
			}
			catch(Exception ex)
			{
				ctlAlertMessage.PushAlertMessage(CommonLogic.GetExceptionDetail(ex, "<br/>"), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}
		}

		/// <summary>
		/// Event Handler for OnSelectedIndexChanged event for RadioButtonList rblMachineKeyGenType
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void rblMachineKeyGenType_OnSelectedIndexChanged(object sender, EventArgs e)
		{
			pnlMachineKey.Visible = (!rblMachineKeyGenType.SelectedValue.Equals("auto", StringComparison.InvariantCultureIgnoreCase));
		}


		/// <summary>
		/// Event Handler for OnSelectedIndexChanged event for RadioButtonList rblEncryptKeyGenType
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void rblEncryptKeyGenType_OnSelectedIndexChanged(object sender, EventArgs e)
		{
			pnlEncryptKey.Visible = (!rblEncryptKeyGenType.SelectedValue.Equals("auto", StringComparison.InvariantCultureIgnoreCase));
		}

		/// <summary>
		/// Event Handler for OnSelectedIndexChanged event for RadioButtonList rblChangeEncryptKey
		/// Determines if any of the ChangeEncryptKey Options are shown
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void rblChangeEncryptKey_OnSelectedIndexChanged(object sender, EventArgs e)
		{
			bool enabled = rblChangeEncryptKey.SelectedValue.Equals("true", StringComparison.InvariantCultureIgnoreCase);

			pnlChangeEncryptKeyMaster.Visible = enabled;
			rblEncryptKeyGenType.SelectedValue = "auto";
			pnlUpdateEncryptKey.Visible = (enabled || rblChangeMachineKey.SelectedValue.Equals("true", StringComparison.InvariantCultureIgnoreCase));
		}

		/// <summary>
		/// Event Handler for OnSelectedIndexChanged event for RadioButtonList rblChangeMachineKey
		/// Determines if any of the Change/Set machine key options are displayed
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void rblChangeMachineKey_OnSelectedIndexChanged(object sender, EventArgs e)
		{
			bool enabled = rblChangeMachineKey.SelectedValue.Equals("true", StringComparison.InvariantCultureIgnoreCase);

			pnlChangeSetMachineKey.Visible = enabled;
			rblMachineKeyGenType.SelectedValue = "auto";
			pnlUpdateEncryptKey.Visible = (enabled || rblChangeEncryptKey.SelectedValue.Equals("true", StringComparison.InvariantCultureIgnoreCase));
		}
	}
}
