// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Xml;
using AspDotNetStorefrontCommon;
using AspDotNetStorefrontCore;
using AspDotNetStorefrontExcelWrapper;

namespace AspDotNetStorefrontAdmin
{

	public partial class importstringresourcefile2 : AdminPageBase
	{
		#region Private Variables

		private const int NAME_COLUMN = 1;
		private const int VALUE_COLUMN = 2;
		private String ShowLocaleSetting;
		private String SpreadsheetName;
		private List<String> ExcelFiles = new List<String>();
		private bool isMasterStringResource = CommonLogic.QueryStringBool("master");
		private bool isMultiStore = Store.IsMultiStore;

		#endregion


		#region Methods

		protected void Page_Load(object sender, EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");
			Server.ScriptTimeout = 1000000;

			ShowLocaleSetting = Localization.CheckLocaleSettingForProperCase(CommonLogic.QueryStringCanBeDangerousContent("ShowLocaleSetting"));

			// this should tell that the excel file to be loaded
			// is a master string resource for the locale i.e. strings.fr-FR.xls
			if (isMasterStringResource)
			{
				bool exists = StringResourceManager.CheckStringResourceExcelFileExists(ShowLocaleSetting);
				if (!exists)
				{
					resetError(AppLogic.GetString("admin.StringResources.NoFileFound", SkinID, ShowLocaleSetting), true);
					return;
				}
				else
				{
					ExcelFiles = StringResourceManager.GetStringResourceFilesForLocale(ShowLocaleSetting);
				}
			}
			else
			{
				SpreadsheetName = CommonLogic.QueryStringCanBeDangerousContent("SpreadsheetName");
				ExcelFiles.Add(CommonLogic.SafeMapPath("~/images" + "/" + SpreadsheetName + ".xls"));
			}

			if (!IsPostBack)
			{
				CancelLink.NavigateUrl = String.Format("{0}?filterlocale={1}", AppLogic.AdminLinkUrl("stringresources.aspx"), ShowLocaleSetting);
				if (isMasterStringResource)
				{
					btnProcessFile.Text = AppLogic.GetString("admin.importstringresourcefile2.BeginReload", SkinID, LocaleSetting);
					ltProcessing.Text = String.Format(AppLogic.GetString("admin.importstringresourcefile2.ReloadLocale", SkinID, LocaleSetting), ShowLocaleSetting);
				}
				else
				{
					btnProcessFile.Text = AppLogic.GetString("admin.importstringresourcefile2.BeginImport", SkinID, LocaleSetting);
					ltProcessing.Text = String.Format(AppLogic.GetString("admin.importstringresourcefile2.ProcessingFile", SkinID, LocaleSetting), ExcelFiles[0]);
				}
				loadData();
			}
		}

		protected void loadData()
		{
			StringBuilder tmpS = new StringBuilder(4096);
			tmpS.Append("<table class=\"table table-fixed\">");
			tmpS.Append("<tr>\n");
			tmpS.Append("<th width=\"5%\">" + AppLogic.GetString("admin.importstringresourcefile2.Row", SkinID, LocaleSetting) + "</th>\n");
			tmpS.Append("<th width=\"10%\">" + AppLogic.GetString("admin.importstringresourcefile2.Status", SkinID, LocaleSetting) + "</th>\n");
			tmpS.Append("<th width=\"20%\">" + AppLogic.GetString("admin.common.Name", SkinID, LocaleSetting) + "</th>\n");
			tmpS.Append("<th width=\"5%\">" + AppLogic.GetString("admin.common.Locale", SkinID, LocaleSetting) + "</th>\n");
			tmpS.Append("<th>" + AppLogic.GetString("admin.importstringresourcefile2.StringValue", SkinID, LocaleSetting) + "</th>\n");
			if (isMultiStore)
			{
				tmpS.Append("<th width=\"5%\">" + AppLogic.GetString("admin.importstringresourcefile2.StoreID", SkinID, LocaleSetting) + "</th>\n");
			}
			tmpS.Append("</tr>\n");

			String NameField = String.Empty;
			String ValueField = String.Empty;
			String StoreIDField = String.Empty;
			ExcelToXml exf = new ExcelToXml(ExcelFiles.ToArray());

			XmlDocument xmlDoc = new XmlDocument();
			try
			{
				xmlDoc = exf.LoadSheet("Sheet1", "C", 5000, "A");
			}
			catch (Exception e)
			{
				resetError(e.Message, true);
				ActionsPanel.Visible = false;
				return;
			}
			foreach (XmlNode row in xmlDoc.SelectNodes("/excel/sheet/row"))
			{
				NameField = exf.GetCell(row, "A");
				ValueField = exf.GetCell(row, "B");
				StoreIDField = exf.GetCell(row, "C");

				int storeid;
				if (!int.TryParse(StoreIDField, out storeid))
					storeid = AppLogic.StoreID();

				string status = ProcessLine(NameField, ShowLocaleSetting, ValueField, true, storeid);
				string statusHTML = status;
				var statusClass = status.StartsWith(AppLogic.ro_OK) ? "success" : String.Empty;

				tmpS.AppendFormat("<tr class=\"{0}\">\n", statusClass);
				tmpS.Append("<td>" + XmlCommon.XmlAttributeUSInt(row, "id").ToString() + "</td>\n");

				
				tmpS.Append("<td>" + (statusHTML.Length == 0 ? "&nbsp;" : statusHTML) + "</td>\n");

				tmpS.Append("<td>" + (NameField.Length == 0 ? "&nbsp;" : NameField) + "</td>\n");
				tmpS.Append("<td>" + (ShowLocaleSetting.Length == 0 ? "&nbsp;" : ShowLocaleSetting) + "</td>\n");
				tmpS.Append("<td>" + (ValueField.Length == 0 ? "&nbsp;" : ValueField) + "</td>\n");
				if (isMultiStore)
				{
					tmpS.Append("<td>" + storeid + "</td>\n");
				}
				tmpS.Append("</tr>\n");

			}

			tmpS.Append("</table>\n");
			tmpS.Append("<a href=\"" + AppLogic.AdminLinkUrl("stringresources.aspx") + "?filterlocale=" + ShowLocaleSetting + "\">" + AppLogic.GetString("admin.importstringresourcefile2.Back", SkinID, LocaleSetting) + "</a>");

			ltData.Text = tmpS.ToString();
		}

		protected void resetError(string error, bool isError)
		{
			string str = "<font class=\"info-just-color\">" + AppLogic.GetString("admin.common.Notice", SkinID, LocaleSetting) + "</font>&nbsp;&nbsp;&nbsp;";
			if (isError)
				str = "<font class=\"text-danger\">" + AppLogic.GetString("admin.common.Error", SkinID, LocaleSetting) + "</font>&nbsp;&nbsp;&nbsp;";

			if (error.Length > 0)
				str += error + "";
			else
				str = "";

			ltError.Text = str;
		}

		private String ProcessLine(String Name, String LocaleSetting, String ConfigValue, bool preview, int storeid)
		{
			String result = AppLogic.ro_OK;
			if (Name.Length != 0)
			{
				try
				{
					ImportOption option = (ImportOption)CommonLogic.QueryStringUSInt("option");
					bool existing = false;
					bool modified = false;
					string resourceId = string.Empty;

					using (SqlConnection dbconn = DB.dbConn())
					{
						dbconn.Open();
						using (IDataReader reader = DB.GetRS(string.Format("SELECT Name, Modified, StringResourceGuid FROM StringResource WHERE Name = {0} AND LocaleSetting = {1} and StoreId = {2}", DB.SQuote(Name), DB.SQuote(LocaleSetting), storeid), dbconn))
						{
							existing = reader.Read();
							if (existing)
							{
								modified = (DB.RSFieldTinyInt(reader, "Modified") > 0);
								resourceId = DB.RSFieldGUID(reader, "StringResourceGuid");
							}
						}
					}

					if (existing)
					{
						if (modified && ((option & ImportOption.LeaveModified) == ImportOption.LeaveModified))
						{
							// do nothing

							result = AppLogic.GetString("admin.importstringresourcefile2.NotImported", SkinID, LocaleSetting);
						}
						else if ((option & ImportOption.OverWrite) == ImportOption.OverWrite)
						{
							if (!preview)
							{
								DB.ExecuteSQL(string.Format("DELETE StringResource WHERE StringResourceGuid = {0}", DB.SQuote(resourceId)));
								InsertStringResource(Name, LocaleSetting, ConfigValue, storeid);
							}

							result = AppLogic.ro_OK; // +"- Overwritten";
						}
						else
						{
							result = AppLogic.GetString("admin.importstringresourcefile2.NotImportedDuplicate", SkinID, LocaleSetting);
						}
					}
					else
					{
						if (!preview)
						{
							InsertStringResource(Name, LocaleSetting, ConfigValue, storeid);
						}
						result = AppLogic.ro_OK; // +"- Added";
					}
				}
				catch (Exception ex)
				{
					result = CommonLogic.GetExceptionDetail(ex, "<br/>");
				}
			}

			return result;
		}

		private void InsertStringResource(string name, string locale, string configValue, int storeId)
		{
			String NewGUID = DB.GetNewGUID();
			StringBuilder sql = new StringBuilder(1000);
			sql.Append("insert into StringResource(StringResourceGUID,Name,LocaleSetting,ConfigValue,StoreID) values(");
			sql.Append(DB.SQuote(NewGUID) + ",");
			sql.Append(DB.SQuote(name) + ",");
			sql.Append(DB.SQuote(locale) + ",");
			sql.Append(DB.SQuote(configValue) + ",");
			sql.Append(storeId);
			sql.Append(")");
			DB.ExecuteSQL(sql.ToString());
		}

		protected void btnProcessFile_Click(object sender, EventArgs e)
		{
			resetError("", false);
			ActionsPanel.Visible = false;
			StringBuilder tmpS = new StringBuilder(4096);
			try
			{
				tmpS.Append("<p>" + AppLogic.GetString("admin.importstringresourcefile2.ImportNewStrings", SkinID, LocaleSetting) + "</p>");
				tmpS.Append("<table class=\"table table-fixed\">\n");
				tmpS.Append("<tr>\n");
				tmpS.Append("<th width=\"5%\">" + AppLogic.GetString("admin.importstringresourcefile2.Row", SkinID, LocaleSetting) + "</th>\n");
				tmpS.Append("<th width=\"10%\">" + AppLogic.GetString("admin.importstringresourcefile2.Status", SkinID, LocaleSetting) + "</th>\n");
				tmpS.Append("<th width=\"20%\">" + AppLogic.GetString("admin.common.Name", SkinID, LocaleSetting) + "</th>\n");
				tmpS.Append("<th width=\"5%\">" + AppLogic.GetString("admin.common.LocaleSetting", SkinID, LocaleSetting) + "</th>\n");
				tmpS.Append("<th>" + AppLogic.GetString("admin.importstringresourcefile2.StringValue", SkinID, LocaleSetting) + "</th>\n");
				if (isMultiStore)
				{
					tmpS.Append("<th width=\"5%\">" + AppLogic.GetString("admin.importstringresourcefile2.StoreID", SkinID, LocaleSetting) + "</th>\n");
				}
				tmpS.Append("</tr>\n");

				String NameField = String.Empty;
				String ValueField = String.Empty;
				String StoreIDField = String.Empty;

				ExcelToXml exf = new ExcelToXml(ExcelFiles.ToArray());
				XmlDocument xmlDoc = exf.LoadSheet("Sheet1", "C", 5000, "A");

				foreach (XmlNode row in xmlDoc.SelectNodes("/excel/sheet/row"))
				{
					NameField = exf.GetCell(row, "A");
					ValueField = exf.GetCell(row, "B");
					StoreIDField = exf.GetCell(row, "C");

					int storeid;
					if (!int.TryParse(StoreIDField, out storeid))
						storeid = AppLogic.StoreID();


					String processIt = ProcessLine(NameField, ShowLocaleSetting, ValueField, false, storeid);
					var statusClass = processIt.StartsWith(AppLogic.ro_OK) ? "success" : String.Empty;

					tmpS.AppendFormat("<tr class=\"{0}\">\n", statusClass);
					tmpS.Append("<td>" + XmlCommon.XmlAttributeUSInt(row, "id").ToString() + "</td>\n");
					tmpS.Append("<td>" + processIt + "</td>\n");
					tmpS.Append("<td>" + (NameField.Length == 0 ? "&nbsp;" : NameField) + "</td>\n");
					tmpS.Append("<td>" + (ShowLocaleSetting.Length == 0 ? "&nbsp;" : ShowLocaleSetting) + "</td>\n");
					tmpS.Append("<td>" + (ValueField.Length == 0 ? "&nbsp;" : ValueField) + "</td>\n");
					if (isMultiStore)
					{
						tmpS.Append("<td>" + storeid + "</td>\n");
					}
					tmpS.Append("</tr>\n");
				}

				tmpS.Append("</table>\n");
				tmpS.Append("<b>" + AppLogic.GetString("admin.importstringresourcefile2.Done", SkinID, LocaleSetting) + "</b><br/><br/>");
				tmpS.Append("<a href=\"" + AppLogic.AdminLinkUrl("stringresources.aspx") + "?filterlocale=" + ShowLocaleSetting + "\">" + AppLogic.GetString("admin.importstringresourcefile2.Back", SkinID, LocaleSetting) + "</a>");

				StringResourceManager.LoadAllStrings(false);
			}
			catch (Exception ex)
			{
				resetError(String.Format(AppLogic.GetString("admin.importstringresourcefile2.ErrorProcessingStrings", SkinID, LocaleSetting), ex.ToString()), true);
			}
			ltData.Text = tmpS.ToString();
		}

		#endregion
	}
}
