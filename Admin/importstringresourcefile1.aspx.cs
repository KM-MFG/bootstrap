// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using AspDotNetStorefrontCore;
using AspDotNetStorefrontControls;

namespace AspDotNetStorefrontAdmin
{
    public partial class importstringresourcefile1 : AdminPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.CacheControl = "private";
            Response.Expires = 0;
            Response.AddHeader("pragma", "no-cache");
            Server.ScriptTimeout = 1000000;

            bool isMasterReload = CommonLogic.QueryStringBool("master");
            pnlReload.Visible = isMasterReload;
            pnlUpload.Visible = !isMasterReload;

            if (!IsPostBack)
            {
                litSelectFileInstructions.Text = String.Format(AppLogic.GetStringForDefaultLocale("admin.stringresources.SelectFile"), CommonLogic.QueryStringCanBeDangerousContent("ShowLocaleSetting"));
                if(isMasterReload )
                {
                    litStage.Text = string.Format(AppLogic.GetStringForDefaultLocale("admin.stringresources.ReloadMaster"), CommonLogic.QueryStringCanBeDangerousContent("ShowLocaleSetting"));
                }
                else
                {
                    litStage.Text = string.Format(AppLogic.GetStringForDefaultLocale("admin.stringresources.ImportFile1"), CommonLogic.QueryStringCanBeDangerousContent("ShowLocaleSetting"));
                }

				lnkBack1.NavigateUrl = AppLogic.AdminLinkUrl("stringresources.aspx") + "?filterlocale=" + Localization.CheckLocaleSettingForProperCase(CommonLogic.QueryStringCanBeDangerousContent("ShowLocaleSetting"));
				lnkBack2.NavigateUrl = AppLogic.AdminLinkUrl("stringresources.aspx") + "?filterlocale=" + Localization.CheckLocaleSettingForProperCase(CommonLogic.QueryStringCanBeDangerousContent("ShowLocaleSetting"));
            }
            Page.Form.DefaultButton = btnSubmit.UniqueID;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            String ShowLocaleSetting = Localization.CheckLocaleSettingForProperCase(CommonLogic.QueryStringCanBeDangerousContent("ShowLocaleSetting"));
            String SpreadsheetName = "Strings_" + Localization.ToThreadCultureShortDateString(System.DateTime.Now).Replace(" ", "").Replace("/", "").Replace(":", "").Replace(".", "");
            bool DataUpdated = false;
            
            ImportOption option = ImportOption.Default;
            if (chkLeaveModified.Checked)
            {
                option = option | ImportOption.LeaveModified;
            }
            if (chkReplaceExisting.Checked)
            {
                option = option | ImportOption.OverWrite;
            }

            // handle file upload:
            try
            {
                String TargetFile = CommonLogic.SafeMapPath("../images" + "/" + SpreadsheetName + ".xls");
                fuMain.SaveAs(TargetFile);
                DataUpdated = true;
            }
            catch (Exception ex)
            {
                ctlAlertMessage.PushAlertMessage(String.Format("admin.importstringresourcefile1.UploadError".StringResource(), ex.ToString()), AlertMessage.AlertType.Error);
            }

            if (DataUpdated)
            {
                ctlAlertMessage.PushAlertMessage("<a href=\"" + AppLogic.AdminLinkUrl("importstringresourcefile2.aspx") + "?spreadsheetname=" + SpreadsheetName + "&showlocalesetting=" + ShowLocaleSetting + "&option=" + ((int)option).ToString() + "\">" + AppLogic.GetString("admin.importstringresourcefile1.UploadSuccessful", SkinID, LocaleSetting) + "</a>\n", AlertMessage.AlertType.Success);
            }
        }

        protected void btnReload_Click(object sender, EventArgs e)
        {
            String ShowLocaleSetting = Localization.CheckLocaleSettingForProperCase(CommonLogic.QueryStringCanBeDangerousContent("ShowLocaleSetting"));
            ImportOption option = ImportOption.Default;
            if (chkReloadLeaveModified.Checked)
            {
                option = option | ImportOption.LeaveModified;
            }
            if (chkReloadReplaceExisting.Checked)
            {
                option = option | ImportOption.OverWrite;
            }

            Response.Redirect(AppLogic.AdminLinkUrl("importstringresourcefile2.aspx")+ "?master=true&showlocalesetting=" + ShowLocaleSetting + "&option=" + ((int)option).ToString());            
        }
    }
}
