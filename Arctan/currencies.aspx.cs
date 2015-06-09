// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI.WebControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
	public partial class currencies : AdminPageBase
	{
		#region Handlers
		protected void Page_Load(object sender, System.EventArgs e)
		{
			SectionTitle = AppLogic.GetString("admin.sectiontitle.currencies", SkinID, LocaleSetting);

			if (!Page.IsPostBack)
			{
				SetupLiveRatesDisplay();
				BindGrid();
				ToggleMultiCurrencyDisplay();
			}
		}

		protected void gMain_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			if(e.CommandName == "DeleteItem")
			{
				try
				{
					DeleteCurrency(Localization.ParseNativeInt(e.CommandArgument.ToString()));
					ctlAlertMessage.PushAlertMessage("Currency Deleted", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
					BindGrid();
				}
				catch(Exception ex)
				{
					ctlAlertMessage.PushAlertMessage(ex.Message, AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				}
			}
			BindGrid();
			ToggleMultiCurrencyDisplay();	//The last row may have been deleted, in which case we need to show the header again
		}

		protected void btnConversionTest_Click(Object sender, EventArgs e)
		{
			decimal testAmount;
			if (Decimal.TryParse(txtTestAmount.Text.Trim(), out testAmount))
			{
				var result = Currency.Convert(testAmount, ddlSource.SelectedValue, ddlTarget.SelectedValue);
				txtTestResult.Text = result.ToString();
				txtTestResult.Visible = true;
			}
		}

		protected void btnGetLiveRates_Click(Object sender, EventArgs e)
		{
			AppLogic.SetAppConfig("Localization.CurrencyFeedUrl", txtLiveURL.Text.Trim());
			AppLogic.SetAppConfig("Localization.CurrencyFeedBaseRateCurrencyCode", txtBaseCurrencyCode.Text.Trim());
			AppLogic.SetAppConfig("Localization.CurrencyFeedXmlPackage", txtXmlPackage.Text.Trim());

			Currency.GetLiveRates();

			txtXmlDoc.Text = XmlCommon.PrettyPrintXml(Currency.m_LastRatesResponseXml);
			txtXmlTransform.Text = XmlCommon.PrettyPrintXml(Currency.m_LastRatesTransformedXml);
			pnlLiveRatesDebug.Visible = true;

			BindGrid();
		}

		protected void btnSaveCurrencies_Click(Object sender, EventArgs e)
		{
			var currencyId = String.Empty;
			var name = String.Empty;
			var code = String.Empty;
			var displayLocale = String.Empty;
			var displaySpec = String.Empty;
			var displayOrder = "1";
			var published = true;
			decimal exchangeRate = 1;
			var currencyUpdated = true;
			var currencyAdded = false;

			try
			{
				foreach(GridViewRow row in grdCurrencies.Rows)
				{
					if(row.RowType == DataControlRowType.DataRow)
					{
						Literal litCurrencyID = row.FindControl("litCurrencyID") as Literal;
						TextBox txtName = row.FindControl("txtName") as TextBox;
						TextBox txtCode = row.FindControl("txtCode") as TextBox;
						TextBox txtRate = row.FindControl("txtRate") as TextBox;
						TextBox txtDisplayFormat = row.FindControl("txtDisplayFormat") as TextBox;
						TextBox txtDisplaySpec = row.FindControl("txtDisplaySpec") as TextBox;
						TextBox txtDisplayOrder = row.FindControl("txtDisplayOrder") as TextBox;
						CheckBox cbxPublished = row.FindControl("cbxPublished") as CheckBox;

						if(litCurrencyID != null)
							currencyId = litCurrencyID.Text;

						if(txtName != null)
							name = txtName.Text.Trim();

						if(txtCode != null)
							code = txtCode.Text.Trim();

						if(txtRate != null)
							exchangeRate = Decimal.Parse(txtRate.Text.Trim());

						if(txtDisplayFormat != null)
							displayLocale = txtDisplayFormat.Text.Trim();

						if(txtDisplaySpec != null)
							displaySpec = txtDisplaySpec.Text.Trim();

						if(txtDisplayOrder != null)
							displayOrder = txtDisplayOrder.Text.Trim();

						if(cbxPublished != null)
							published = cbxPublished.Checked;

						//Locale reality check
						if(!ValidateDisplayLocale(displayLocale))
							return;

						if(currencyId.Length != 0)
						{
							DB.ExecuteSQL(String.Format("UPDATE Currency SET Name={0}, WasLiveRate=0, CurrencyCode={1}, ExchangeRate={2}, DisplayLocaleFormat={3}, DisplaySpec={4}, Published={5}, DisplayOrder={6}, LastUpdated=getdate() where CurrencyID={7}",
										DB.SQuote(name),
										DB.SQuote(code),
										Localization.DecimalStringForDB(exchangeRate),
										DB.SQuote(displayLocale),
										DB.SQuote(displaySpec),
										published ? "1" : "0",
										displayOrder,
										currencyId));
						}
					}
				}

				currencyAdded = AddCurrency();

				BindGrid();
				ToggleMultiCurrencyDisplay();	//May have added the first row, in which case hide the new table header
			}
			catch (Exception ex)
			{
				currencyUpdated = false;
				ctlAlertMessage.PushAlertMessage(ex.Message, AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}

			if(currencyUpdated || currencyAdded)
			{
				Currency.FlushCache();
				ctlAlertMessage.PushAlertMessage("Currencies Updated", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
			}
		}
		#endregion

		#region Display methods
		void ToggleMultiCurrencyDisplay()
		{
			int numCurrencies = DB.GetSqlN("SELECT COUNT(*) N FROM Currency");

			tblNewRowHeader.Visible = numCurrencies == 0;
			pnlMultipleCurrencies.Visible = numCurrencies > 1;

			if(numCurrencies > 0)
				PopulateTestDropdowns();
		}

		void ClearNewFields()
		{
			txtNewName.Text = txtNewCode.Text = txtNewExchangeRate.Text = txtNewDisplayLocale.Text = txtNewDisplaySpec.Text = txtNewDisplayOrder.Text = String.Empty;
			cbxNewPublished.Checked = true;
		}

		void BindGrid()
		{
			using(SqlConnection dbconn = new SqlConnection(DB.GetDBConn()))
			{
				dbconn.Open();
				using(IDataReader rs = DB.GetRS("SELECT CurrencyID, Name, CurrencyCode, ExchangeRate, DisplayLocaleFormat, Published, DisplayOrder, DisplaySpec, LastUpdated FROM Currency with (NOLOCK)", dbconn))
				{
					using(DataTable dt = new DataTable())
					{
						dt.Load(rs);
						grdCurrencies.DataSource = dt;
						grdCurrencies.DataBind();
					}
				}
			}
		}

		void SetupLiveRatesDisplay()
		{
			var feedURL = AppLogic.AppConfig("Localization.CurrencyFeedUrl");

			txtLiveURL.Text = feedURL;
			litLiveURL.Text = String.Format(AppLogic.GetString("admin.currencies.CurrencyFeedUrl", ThisCustomer.LocaleSetting),
				(feedURL.Length != 0)
					? " (<a href=\"" + AppLogic.AppConfig("Localization.CurrencyFeedUrl") + "\" target=\"_blank\">test</a>)"
					: String.Empty);

			txtBaseCurrencyCode.Text = AppLogic.AppConfig("Localization.CurrencyFeedBaseRateCurrencyCode");
			txtXmlPackage.Text = AppLogic.AppConfig("Localization.CurrencyFeedXmlPackage");
		}

		void PopulateTestDropdowns()
		{
			ddlSource.Items.Clear();
			ddlTarget.Items.Clear();

			using(SqlConnection dbconn = new SqlConnection(DB.GetDBConn()))
			{
				dbconn.Open();
				using(IDataReader rs = DB.GetRS("SELECT Name, CurrencyCode FROM Currency with (NOLOCK) WHERE Published = 1 ORDER BY DisplayOrder", dbconn))
				{
					while(rs.Read())
					{
						ListItem currencyItem = new ListItem()
						{
							Text = DB.RSField(rs, "Name"),
							Value = DB.RSField(rs, "CurrencyCode")
						};

						ddlSource.Items.Add(currencyItem);
						ddlTarget.Items.Add(currencyItem);
					}
				}
			}
		}
		#endregion

		#region Helper methods
		bool ValidateDisplayLocale(string displayLocale)
		{
			try
			{
				CultureInfo validCulture = new CultureInfo(displayLocale);
				return true;
			}
			catch
			{
				ctlAlertMessage.PushAlertMessage(String.Format("Invalid Display Locale: {0}", displayLocale), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				return false;
			}
		}

		void DeleteCurrency(int currencyId)
		{
			DB.ExecuteSQL("DELETE FROM Currency WHERE CurrencyID=" + currencyId.ToString());
		}

		bool AddCurrency()
		{
			var name = txtNewName.Text.Trim();
			var code = txtNewCode.Text.Trim();
			var displayLocale = txtNewDisplayLocale.Text.Trim();
			var displaySpec = txtNewDisplaySpec.Text.Trim();
			var displayOrder = txtNewDisplayOrder.Text.Trim();
			var published = cbxNewPublished.Checked;
			decimal parsedRate;
			decimal exchangeRate = 0;

			if(Decimal.TryParse(txtNewExchangeRate.Text.Trim(), out parsedRate))
				exchangeRate = parsedRate;

			//Locale reality check
			if(!String.IsNullOrEmpty(displayLocale) && !ValidateDisplayLocale(displayLocale))
				return false;

			//If all required required fields were filled in, try to add
			if(!String.IsNullOrEmpty(name)
				&& !String.IsNullOrEmpty(code)
				&& !String.IsNullOrEmpty(displayOrder)
				&& exchangeRate > 0)
			{
				try
				{
					DB.ExecuteSQL(String.Format("INSERT INTO Currency(Name,WasLiveRate,CurrencyCode,ExchangeRate,DisplayLocaleFormat,DisplaySpec,Published,DisplayOrder,LastUpdated) VALUES({0}, 0, {1}, {2}, {3}, {4}, {5}, {6}, getdate())",
										DB.SQuote(name),
										DB.SQuote(code),
										Localization.DecimalStringForDB(exchangeRate),
										DB.SQuote(displayLocale),
										DB.SQuote(displaySpec),
										published ? "1" : "0",
										displayOrder));

					BindGrid();
					ClearNewFields();
					return true;
				}
				catch(Exception ex)
				{
					ctlAlertMessage.PushAlertMessage(ex.Message, AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				}
			}

			return false;
		}
		#endregion
	}
}
