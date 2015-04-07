// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{

    public partial class stringresourcepage : AdminPageBase
    {
		protected override void OnInit(EventArgs e)
		{
			FilteredListing.SqlQuery = "select {0} * from StringResource with (NOLOCK) where {1}";
			base.OnInit(e);
		}

        protected void Page_Load(object sender, EventArgs e)
        {            
            Response.CacheControl = "private";
            Response.Expires = 0;
            Response.AddHeader("pragma", "no-cache");

			if (!IsPostBack)
			{
				loadLocales();
			}

			string menulocale = string.Empty;

			if(pnlLocale.Visible == false || ddLocales.SelectedValue == "Reset")
			{
				//We're on the default locale, don't allow some stuff
				menulocale = Localization.GetDefaultLocale();

				btnClearLocale.Visible = false;
				btnShowMissing.Visible = false;
			}
			else
			{
				menulocale = ddLocales.SelectedValue;

				btnClearLocale.Visible = true;
				btnShowMissing.Visible = true;
			}

			btnLoadExcelServer.Attributes.Add("onclick", "return confirm('Are you sure you want to reload all prompts for the " + menulocale + " locale from the /StringResources/strings." + menulocale + ".xls file?')");
			btnClearLocale.Attributes.Add("onclick", "return confirm('Are you sure you want to delete all prompts in the " + menulocale + " locale from the database?')");
			btnUploadExcel.Attributes.Add("onclick", "return confirm('Are you sure you want to upload and load an excel file with all prompts for the " + menulocale + " locale?')");
        }

        private void loadLocales()
		{
			ddLocales.Items.Clear();

			List<KeyValuePair<string, string>> localeArray = new List<KeyValuePair<string, string>>();

            try
            {
				int localeCount = DB.GetSqlN("select count(Name) as N from LocaleSetting with (NOLOCK)");

				if(localeCount > 1)
				{
					pnlLocale.Visible = true;
					ddLocales.Items.Add(new ListItem("ALL LOCALES", "Reset"));
				}

				using(SqlConnection conn = new SqlConnection(DB.GetDBConn()))
				{
					conn.Open();
					using(IDataReader rs = DB.GetRS("select Name from LocaleSetting  with (NOLOCK)  order by DisplayOrder,Description", conn))
					{
						while(rs.Read())
						{
							string localeName = DB.RSField(rs, "Name");
							ListItem myNode = new ListItem();
							myNode.Value = localeName;
							ddLocales.Items.Add(myNode);

							localeArray.Add(new KeyValuePair<string, string>(localeName, localeName));
						}
					}
				}
            }
            catch (Exception ex)
            {
				AlertMessage.PushAlertMessage(ex.ToString(), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
            }
        }

		protected void gMain_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			if(e.CommandName == "DeleteItem")
			{
				DeleteString(Localization.ParseNativeInt(e.CommandArgument.ToString()));
				AlertMessage.PushAlertMessage("Item Deleted", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
				FilteredListing.Rebind();
			}
		}

		protected void DeleteString(int stringId)
		{
			DB.ExecuteSQL("delete from StringResource where StringResourceID=" + stringId.ToString());
		}

        protected void btnLoadExcelServer_Click(object sender, EventArgs e)
        {
			string selectedLocale = ddLocales.SelectedValue;

			if (string.IsNullOrEmpty(selectedLocale) || selectedLocale == "Reset")
				selectedLocale = Localization.GetDefaultLocale();

			bool stringResourceFileExists = StringResourceManager.CheckStringResourceExcelFileExists(selectedLocale);
			if(stringResourceFileExists)
			{
				Response.Redirect(string.Format(AppLogic.AdminLinkUrl("importstringresourcefile1.aspx") + "?showlocalesetting={0}&master=true", selectedLocale));
			}
			else
			{
				AlertMessage.PushAlertMessage(String.Format("Prompts File for {0} not found!!!", selectedLocale), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}
        }

        protected void btnClearLocale_Click(object sender, EventArgs e)
		{
			DB.ExecuteSQL("delete from StringResource where LocaleSetting=" + DB.SQuote(ddLocales.SelectedValue));

			AlertMessage.PushAlertMessage("Locale Cleared.", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
			btnClearLocale.Visible = false;
			btnShowMissing.Visible = false;
        }

        protected void btnUploadExcel_Click(object sender, EventArgs e)
        {
			Response.Redirect(AppLogic.AdminLinkUrl("importstringresourcefile1.aspx") + "?showlocalesetting=" + ddLocales.SelectedValue);
        }

        protected void btnShowMissing_Click(object sender, EventArgs e)
        {
			Response.Redirect(AppLogic.AdminLinkUrl("stringresourcerpt.aspx") +"?reporttype=missing&ShowLocaleSetting=" + ddLocales.SelectedValue);
        }
    }
}
