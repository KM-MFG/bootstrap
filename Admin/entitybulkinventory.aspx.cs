// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using AspDotNetStorefrontCore;
using System;
using System.Data;
using System.Globalization;
using System.Text;

namespace AspDotNetStorefrontAdmin
{
	/// <summary>
	/// Summary description for bulkeditinventory.
	/// </summary>
	public partial class entityBulkInventory : AdminPageBase
	{
		int EntityID;
		String EntityName;
		EntitySpecs m_EntitySpecs;
		EntityHelper Helper;
		new int SkinID = 1;
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
				MainBody.Visible = false;
				return;
			}

			LoadBody();
		}

		protected void LoadBody()
		{
			StringBuilder tmpS = new StringBuilder(4096);

			Int32 mappingCount = DB.GetSqlN("select count(*) as N from Product" + this.m_EntitySpecs.m_EntityName + " where " + m_EntitySpecs.m_EntityName + "Id = " + this.EntityID.ToString());

			ProductCollection products = new ProductCollection(EntityName, EntityID);
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
				tmpS.Append("<td><b>ProductID</b></td>\n");
				tmpS.Append("<td><b>VariantID</b></td>\n");
				tmpS.Append("<td><b>Product Name</b></td>\n");
				tmpS.Append("<td><b>Variant Name</b></td>\n");
				tmpS.Append("<td><b>Inventory</b></td>\n");
				tmpS.Append("</tr>\n");

				int rowcount = dsProducts.Tables[0].Rows.Count;

				for (int i = 0; i < rowcount; i++)
				{
					DataRow row = dsProducts.Tables[0].Rows[i];

					int ThisProductID = DB.RowFieldInt(row, "ProductID");
					int ThisVariantID = DB.RowFieldInt(row, "VariantID");

					if (i % 2 == 0)
					{
						tmpS.Append("<tr>\n");
					}
					else
					{
						tmpS.Append("<tr>\n");
					}
					tmpS.Append("<td>");
					tmpS.Append(ThisProductID.ToString());
					tmpS.Append("</td>");
					tmpS.Append("<td>");
					tmpS.Append(ThisVariantID.ToString());
					tmpS.Append("</td>");
					tmpS.Append("<td>");
					bool showlinks = false;
					if (showlinks)
						tmpS.Append("<a target=\"entityBody\" href=\"" + AppLogic.AdminLinkUrl("product.aspx") + "?productid=" + ThisProductID.ToString() + "&entityname=" + EntityName + "&entityid=" + EntityID.ToString() + "\">");
					tmpS.Append(DB.RowFieldByLocale(row, "Name", cust.LocaleSetting));
					if (showlinks)
						tmpS.Append("</a>");
					tmpS.Append("</td>\n");
					tmpS.Append("<td>");
					if (showlinks)
						tmpS.Append("<a target=\"entityBody\" href=\"" + AppLogic.AdminLinkUrl("variant.aspx") + "?productid=" + ThisProductID.ToString() + "&variantid=" + ThisVariantID.ToString() + "&entityname=" + EntityName + "&entityid=" + EntityID.ToString() + "\">");
					tmpS.Append(DB.RowFieldByLocale(row, "VariantName", cust.LocaleSetting));
					if (showlinks)
						tmpS.Append("</a>");
					tmpS.Append("</td>\n");
					tmpS.Append("<td>");
					String s = AppLogic.GetInventoryTable(ThisProductID, ThisVariantID, true, SkinID, false, true);
					tmpS.Append(s);
					tmpS.Append("</td>\n");
					tmpS.Append("</tr>\n");

				}
				tmpS.Append("</table>\n");

			}
			else
			{
				MainBody.Visible = false;
				AlertMessageDisplay.PushAlertMessage(AppLogic.GetString("admin.common.NoProductsFound", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}
			dsProducts.Dispose();
			products.Dispose();

			ltBody.Text = tmpS.ToString();
		}

		protected void BtnInventoryUpdate_click(object sender, EventArgs e)
		{
			for (int i = 0; i <= Request.Form.Count - 1; i++)
			{
				String FieldName = Request.Form.Keys[i];
				if (FieldName.IndexOf("|") != -1 && ((FieldName.StartsWith("simple", StringComparison.InvariantCultureIgnoreCase) || FieldName.StartsWith("sizecolor", StringComparison.InvariantCultureIgnoreCase))))
				{
					String KeyVal = CommonLogic.FormCanBeDangerousContent(FieldName);
					// this field should be processed
					String[] FieldNameSplit = FieldName.Split('|');
					String InventoryType = FieldNameSplit[0].ToLower(CultureInfo.InvariantCulture);
					int TheProductID = Localization.ParseUSInt(FieldNameSplit[1]);
					int TheVariantID = Localization.ParseUSInt(FieldNameSplit[2]);
					String Size = FieldNameSplit[3];
					String Color = FieldNameSplit[4];
					int inputVal = CommonLogic.FormUSInt(FieldName);
					if (InventoryType == "simple")
					{
						DB.ExecuteSQL("update ProductVariant set Inventory=" + inputVal.ToString() + " where VariantID=" + TheVariantID.ToString());
					}
					else
					{
						String sql = "select count(*) as N from Inventory  with (NOLOCK)  where VariantID=" + TheVariantID.ToString() + " and lower([size])=" + DB.SQuote(AppLogic.CleanSizeColorOption(Size).ToLowerInvariant()) + " and lower(color)=" + DB.SQuote(AppLogic.CleanSizeColorOption(Color).ToLowerInvariant());
						if (DB.GetSqlN(sql) == 0)
						{
							sql = "insert into Inventory(InventoryGUID,VariantID,[Size],Color,Quan) values(" + DB.SQuote(DB.GetNewGUID()) + "," + TheVariantID.ToString() + "," + DB.SQuote(AppLogic.CleanSizeColorOption(Size)) + "," + DB.SQuote(AppLogic.CleanSizeColorOption(Color)) + "," + inputVal.ToString() + ")";
							DB.ExecuteSQL(sql);
						}
						else
						{
							sql = "update Inventory set Quan=" + inputVal.ToString() + " where VariantID=" + TheVariantID.ToString() + " and lower([size])=" + DB.SQuote(AppLogic.CleanSizeColorOption(Size).ToLowerInvariant()) + " and lower(color)=" + DB.SQuote(AppLogic.CleanSizeColorOption(Color).ToLowerInvariant());
							DB.ExecuteSQL(sql);
						}
					}
				}
			}
			DB.ExecuteSQL("Update Inventory set Quan=0 where Quan<0"); // safety check
			DB.ExecuteSQL("Update ProductVariant set Inventory=0 where Inventory<0"); // safety check

			AlertMessageDisplay.PushAlertMessage("Inventory was updated", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);

			LoadBody();
		}
	}
}
