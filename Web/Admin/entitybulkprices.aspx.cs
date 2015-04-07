// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using AspDotNetStorefrontCore;
using System;
using System.Data;
using System.Text;

namespace AspDotNetStorefrontAdmin
{
	/// <summary>
	/// Summary description for bulkeditprices.
	/// </summary>
	public partial class entityBulkPrices : AdminPageBase
	{
		int EntityID;
		String EntityName;
		EntitySpecs m_EntitySpecs;
		EntityHelper Helper;
		private Customer cust;

		protected void Page_Load(object sender, System.EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");

			cust = ((AspDotNetStorefrontPrincipal)Context.User).ThisCustomer;

			EntityID = CommonLogic.QueryStringUSInt("EntityID"); ;
			EntityName = CommonLogic.QueryStringCanBeDangerousContent("EntityName");
			m_EntitySpecs = EntityDefinitions.LookupSpecs(EntityName);
			Helper = new EntityHelper(m_EntitySpecs, 0);

			if (EntityID == 0 || EntityName.Length == 0)
			{
				AlertMessageDisplay.PushAlertMessage(AppLogic.GetString("admin.common.InvalidParameters", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				return;
			}

			if (CommonLogic.FormCanBeDangerousContent("IsSubmit").Equals("TRUE", StringComparison.InvariantCultureIgnoreCase))
			{
				ProductCollection products = new ProductCollection(m_EntitySpecs.m_EntityName, EntityID);
				products.PageSize = 0;
				products.PageNum = 1;
				products.PublishedOnly = false;
				products.ReturnAllVariants = true;
				DataSet dsProducts = products.LoadFromDB();
				int NumProducts = products.NumProducts;
				foreach (DataRow row in dsProducts.Tables[0].Rows)
				{
					int ThisProductID = DB.RowFieldInt(row, "ProductID");
					int ThisVariantID = DB.RowFieldInt(row, "VariantID");
					decimal Price = System.Decimal.Zero;
					decimal SalePrice = System.Decimal.Zero;
					decimal MSRP = System.Decimal.Zero;
					decimal Cost = System.Decimal.Zero;
					if (CommonLogic.FormCanBeDangerousContent("Price_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString()).Length != 0)
					{
						Price = CommonLogic.FormUSDecimal("Price_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString());
					}
					if (CommonLogic.FormCanBeDangerousContent("SalePrice_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString()).Length != 0)
					{
						SalePrice = CommonLogic.FormUSDecimal("SalePrice_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString());
					}
					if (CommonLogic.FormCanBeDangerousContent("MSRP_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString()).Length != 0)
					{
						MSRP = CommonLogic.FormUSDecimal("MSRP_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString());
					}
					if (CommonLogic.FormCanBeDangerousContent("Cost_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString()).Length != 0)
					{
						Cost = CommonLogic.FormUSDecimal("Cost_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString());
					}
					StringBuilder sql = new StringBuilder(1024);
					sql.Append("update productvariant set ");
					sql.Append("Price=" + Localization.DecimalStringForDB(Price) + ",");
					sql.Append("SalePrice=" + CommonLogic.IIF(SalePrice != System.Decimal.Zero, Localization.DecimalStringForDB(SalePrice), "NULL") + ",");
					sql.Append("MSRP=" + CommonLogic.IIF(MSRP != System.Decimal.Zero, Localization.DecimalStringForDB(MSRP), "NULL") + ",");
					sql.Append("Cost=" + CommonLogic.IIF(Cost != System.Decimal.Zero, Localization.DecimalStringForDB(Cost), "NULL"));
					sql.Append(" where VariantID=" + ThisVariantID.ToString());
					DB.ExecuteSQL(sql.ToString());
				}
				dsProducts.Dispose();

				AlertMessageDisplay.PushAlertMessage("The prices have been updated.", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);

			}

			LoadBody();
		}

		protected void LoadBody()
		{
			StringBuilder tmpS = new StringBuilder(4096);

			Int32 mappingCount = DB.GetSqlN("select count(*) as N from Product" + this.m_EntitySpecs.m_EntityName + " where " + m_EntitySpecs.m_EntityName + "Id = " + this.EntityID.ToString());

			ProductCollection products = new ProductCollection(m_EntitySpecs.m_EntityName, EntityID);
			products.PageSize = 0;
			products.PageNum = 1;
			products.PublishedOnly = false;
			products.ReturnAllVariants = true;

			DataSet dsProducts = new DataSet();
			if (mappingCount > 0)
				dsProducts = products.LoadFromDB();

			int NumProducts = products.NumProducts;
			if (NumProducts > 1000)
			{
				AlertMessageDisplay.PushAlertMessage(AppLogic.GetString("admin.common.ImportExcession", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				MainBody.Visible = false;
			}
			else if (NumProducts > 0)
			{

				tmpS.Append("<input type=\"hidden\" name=\"IsSubmit\" value=\"true\">\n");
				tmpS.Append("<table class=\"table\">\n");
				tmpS.Append("<tr class=\"table-header\">\n");
				tmpS.Append("<td><b>" + AppLogic.GetString("admin.common.ProductID", SkinID, LocaleSetting) + "</b></td>\n");
				tmpS.Append("<td><b>" + AppLogic.GetString("admin.common.VariantID", SkinID, LocaleSetting) + "</b></td>\n");
				tmpS.Append("<td><b>" + AppLogic.GetString("admin.common.ProductName", SkinID, LocaleSetting) + "</b></td>\n");
				tmpS.Append("<td><b>" + AppLogic.GetString("admin.common.VariantName", SkinID, LocaleSetting) + "</b></td>\n");
				tmpS.Append("<td align=\"center\"><b>" + AppLogic.GetString("admin.common.Price", SkinID, LocaleSetting) + "</b><br/><small>" + AppLogic.GetString("admin.entityBulkPrices.Format", SkinID, LocaleSetting) + "</small></td>\n");
				tmpS.Append("<td align=\"center\"><b>" + AppLogic.GetString("admin.common.SalePrice", SkinID, LocaleSetting) + "</b><br/><small>" + AppLogic.GetString("admin.entityBulkPrices.Format", SkinID, LocaleSetting) + "</small></td>\n");
				tmpS.Append("<td align=\"center\"><b>" + AppLogic.GetString("admin.common.MSRP", SkinID, LocaleSetting) + "</b><br/><small>" + AppLogic.GetString("admin.entityBulkPrices.Format", SkinID, LocaleSetting) + "</small></td>\n");
				tmpS.Append("<td align=\"center\"><b>" + AppLogic.GetString("admin.common.Cost", SkinID, LocaleSetting) + "</b><br/><small>" + AppLogic.GetString("admin.entityBulkPrices.Format", SkinID, LocaleSetting) + "</small></td>\n");
				tmpS.Append("</tr>\n");
				int LastProductID = 0;


				int rowcount = dsProducts.Tables[0].Rows.Count;

				for (int i = 0; i < rowcount; i++)
				{
					DataRow row = dsProducts.Tables[0].Rows[i];

					int ThisProductID = DB.RowFieldInt(row, "ProductID");
					int ThisVariantID = DB.RowFieldInt(row, "VariantID");

					if (i % 2 == 0)
					{
						tmpS.Append("<tr class=\"table-row2\">\n");
					}
					else
					{
						tmpS.Append("<tr class=\"table-alternatingrow2\">\n");
					}
					tmpS.Append("<td align=\"left\" valign=\"middle\">");
					tmpS.Append(ThisProductID.ToString());
					tmpS.Append("</td>");
					tmpS.Append("<td align=\"left\" valign=\"middle\">");
					tmpS.Append(ThisVariantID.ToString());
					tmpS.Append("</td>");
					tmpS.Append("<td align=\"left\" valign=\"middle\">");
					bool showlinks = false;
					if (showlinks)
						tmpS.Append("<a target=\"entityBody\" href=\"" + AppLogic.AdminLinkUrl("product.aspx") + "?productid=" + ThisProductID.ToString() + "&entityname=" + EntityName + "&entityid=" + EntityID.ToString() + "\">");
					tmpS.Append(DB.RowFieldByLocale(row, "Name", cust.LocaleSetting));
					if (showlinks)
						tmpS.Append("</a>");
					tmpS.Append("</td>\n");
					tmpS.Append("<td align=\"left\" valign=\"middle\">");
					if (showlinks)
						tmpS.Append("<a target=\"entityBody\" href=\"" + AppLogic.AdminLinkUrl("variant.aspx") + "?productid=" + ThisProductID.ToString() + "&variantid=" + ThisVariantID.ToString() + "&entityname=" + EntityName + "&entityid=" + EntityID.ToString() + "\">");
					tmpS.Append(DB.RowFieldByLocale(row, "VariantName", cust.LocaleSetting));
					if (showlinks)
						tmpS.Append("</a>");
					tmpS.Append("</td>\n");
					tmpS.Append("<td align=\"center\" valign=\"middle\">");
					tmpS.Append("<input maxLength=\"10\" size=\"10\" class=\"default\" name=\"Price_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "\" value=\"" + Localization.CurrencyStringForDBWithoutExchangeRate(DB.RowFieldDecimal(row, "Price")) + "\">");
					tmpS.Append("<input type=\"hidden\" name=\"Price_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "_vldt\" value=\"[req][number][blankalert=" + AppLogic.GetString("admin.common.VariantPricePrompt", SkinID, LocaleSetting) + "][invalidalert=" + AppLogic.GetString("admin.common.ValidDollarAmountPrompt", SkinID, LocaleSetting) + "]\">\n");
					tmpS.Append("</td>");
					tmpS.Append("<td align=\"center\" valign=\"middle\">");
					tmpS.Append("<input maxLength=\"10\" size=\"10\" class=\"default\" name=\"SalePrice_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "\" value=\"" + CommonLogic.IIF(DB.RowFieldDecimal(row, "SalePrice") != System.Decimal.Zero, Localization.CurrencyStringForDBWithoutExchangeRate(DB.RowFieldDecimal(row, "SalePrice")), "") + "\">\n");
					tmpS.Append("<input type=\"hidden\" name=\"SalePrice_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "_vldt\" value=\"[number][invalidalert=" + AppLogic.GetString("admin.common.ValidDollarAmountPrompt", SkinID, LocaleSetting) + "]\">\n");
					tmpS.Append("</td>");
					tmpS.Append("<td align=\"center\" valign=\"middle\">");
					tmpS.Append("<input maxLength=\"10\" size=\"10\" class=\"default\" name=\"MSRP_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "\" value=\"" + CommonLogic.IIF(DB.RowFieldDecimal(row, "MSRP") != System.Decimal.Zero, Localization.CurrencyStringForDBWithoutExchangeRate(DB.RowFieldDecimal(row, "MSRP")), "") + "\">\n");
					tmpS.Append("<input type=\"hidden\" name=\"MSRP_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "_vldt\" value=\"[number][invalidalert=" + AppLogic.GetString("admin.commmon.ValidDollarAmountPrompt", SkinID, LocaleSetting) + "]\">\n");
					tmpS.Append("</td>");
					tmpS.Append("<td align=\"center\" valign=\"middle\">");
					tmpS.Append("<input maxLength=\"10\" size=\"10\" class=\"default\" name=\"Cost_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "\" value=\"" + CommonLogic.IIF(DB.RowFieldDecimal(row, "Cost") != System.Decimal.Zero, Localization.CurrencyStringForDBWithoutExchangeRate(DB.RowFieldDecimal(row, "Cost")), "") + "\">\n");
					tmpS.Append("<input type=\"hidden\" name=\"Cost_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "_vldt\" value=\"[number][invalidalert=" + AppLogic.GetString("admin.common.ValidDollarAmountPrompt", SkinID, LocaleSetting) + "]\">\n");
					tmpS.Append("</td>\n");

					tmpS.Append("</tr>\n");
					LastProductID = ThisProductID;

				}
				tmpS.Append("</table>\n");
			}
			else
			{
				AlertMessageDisplay.PushAlertMessage(AppLogic.GetString("admin.common.NoProductsFound", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				MainBody.Visible = false;
			}
			dsProducts.Dispose();
			products.Dispose();

			ltBody.Text = tmpS.ToString();
		}
	}
}
