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
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
    /// <summary>
    /// Summary description for bulkeditshippingcosts.
    /// </summary>
    public partial class entityBulkShipping : AdminPageBase
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

            EntityID = CommonLogic.QueryStringUSInt("EntityID");
            EntityName = CommonLogic.QueryStringCanBeDangerousContent("EntityName");
            m_EntitySpecs = EntityDefinitions.LookupSpecs(EntityName);
            Helper = new EntityHelper(m_EntitySpecs, 0);
           
            if (EntityID == 0 || EntityName.Length == 0)
            {
                ltBody.Text = AppLogic.GetString("admin.common.InvalidParameters", SkinID, LocaleSetting);
                return;
            }
            if (CommonLogic.FormCanBeDangerousContent("IsSubmit").Equals("TRUE", StringComparison.InvariantCultureIgnoreCase))
            {
                for (int i = 0; i <= Request.Form.Count - 1; i++)
                {
                    String FieldName = Request.Form.Keys[i];
                    if (FieldName.StartsWith("shippingcost", StringComparison.InvariantCultureIgnoreCase) && !FieldName.EndsWith("_vldt", StringComparison.InvariantCultureIgnoreCase))
                    {
                        String[] FieldNameSplit = FieldName.Split('_');
                        int ThisVariantID = Localization.ParseUSInt(FieldNameSplit[1]);
                        int ThisShippingMethodID = Localization.ParseUSInt(FieldNameSplit[2]);
                        decimal ShippingCost = CommonLogic.FormUSDecimal(FieldName);
                        DB.ExecuteSQL("delete from ShippingByProduct where VariantID=" + ThisVariantID.ToString() + " and ShippingMethodID=" + ThisShippingMethodID.ToString());
                        DB.ExecuteSQL("insert ShippingByProduct(VariantID,ShippingMethodID,ShippingCost) values(" + ThisVariantID.ToString() + "," + ThisShippingMethodID.ToString() + "," + Localization.CurrencyStringForDBWithoutExchangeRate(ShippingCost) + ")");
                    }
                }
				AlertMessageDisplay.PushAlertMessage("The shipping costs have been saved.", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);

            }

            LoadBody();
        }

		protected void LoadBody()
		{
			StringBuilder tmpS = new StringBuilder(4096);

			using (ProductCollection products = new ProductCollection(m_EntitySpecs.m_EntityName, EntityID))
			{
				Int32 mappingCount = DB.GetSqlN("select count(*) as N from Product" + this.m_EntitySpecs.m_EntityName + " where " + m_EntitySpecs.m_EntityName + "Id = " + this.EntityID.ToString());

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
					using (DataTable dtShippingMethods = new DataTable())
					{
						using (SqlConnection con = new SqlConnection(DB.GetDBConn()))
						{
							con.Open();
							using (IDataReader rs = DB.GetRS("select * from ShippingMethod  with (NOLOCK)  where IsRTShipping=0 order by DisplayOrder", con))
							{
								dtShippingMethods.Load(rs);
							}
						}


						tmpS.Append("<input type=\"hidden\" name=\"IsSubmit\" value=\"true\">\n");

						tmpS.Append("<table class=\"table\">\n");
						tmpS.Append("<tr class=\"table-header\">\n");
						tmpS.Append("<td><b>" + AppLogic.GetString("admin.common.ProductID", SkinID, LocaleSetting) + "</b></td>\n");
						tmpS.Append("<td><b>" + AppLogic.GetString("admin.common.VariantID", SkinID, LocaleSetting) + "</b></td>\n");
						tmpS.Append("<td><b>" + AppLogic.GetString("admin.common.ProductName", SkinID, LocaleSetting) + "</b></td>\n");
						tmpS.Append("<td><b>" + AppLogic.GetString("admin.common.VariantName", SkinID, LocaleSetting) + "</b></td>\n");
						foreach (DataRow row in dtShippingMethods.Rows)
						{
							tmpS.Append("<td><b>" + DB.RowFieldByLocale(row, "Name", cust.LocaleSetting) + " Cost</b><br/>" + AppLogic.GetString("admin.entityBulkPrices.Format", SkinID, LocaleSetting) + "</td>\n");
						}
						tmpS.Append("</tr>\n");

						for (int i = 0; i < dsProducts.Tables[0].Rows.Count; i++)
						{
							DataRow row = dsProducts.Tables[0].Rows[i];

							int ThisProductID = DB.RowFieldInt(row, "ProductID");
							int ThisVariantID = DB.RowFieldInt(row, "VariantID");

							tmpS.Append("<tr>\n");

							tmpS.Append("<td>");
							tmpS.Append(ThisProductID.ToString());
							tmpS.Append("</td>");
							tmpS.Append("<td>");
							tmpS.Append(ThisVariantID.ToString());
							tmpS.Append("</td>");
							tmpS.Append("<td>");
							tmpS.Append("<a target=\"entityBody\" href=\"" + AppLogic.AdminLinkUrl("product.aspx") + "?productid=" + ThisProductID.ToString() + "&entityname=" + EntityName + "&entityid=" + EntityID.ToString() + "\">");
							tmpS.Append(DB.RowFieldByLocale(row, "Name", cust.LocaleSetting));
							tmpS.Append("</a>");
							tmpS.Append("</td>\n");
							tmpS.Append("<td>");
							tmpS.Append("<a target=\"entityBody\" href=\"" + AppLogic.AdminLinkUrl("variant.aspx") + "?productid=" + ThisProductID.ToString() + "&variantid=" + ThisVariantID.ToString() + "\">");
							tmpS.Append(DB.RowFieldByLocale(row, "VariantName", cust.LocaleSetting));
							tmpS.Append("</a>");
							tmpS.Append("</td>\n");
							foreach (DataRow row2 in dtShippingMethods.Rows)
							{
								tmpS.Append("<td>");
								tmpS.Append("<input class=\"default\" maxLength=\"10\" size=\"10\" name=\"ShippingCost_" + ThisVariantID.ToString() + "_" + DB.RowFieldInt(row2, "ShippingMethodID") + "\" value=\"" + Localization.CurrencyStringForDBWithoutExchangeRate(Shipping.GetVariantShippingCost(ThisVariantID, DB.RowFieldInt(row2, "ShippingMethodID"))) + "\">\n");
								tmpS.Append("<input type=\"hidden\" name=\"ShippingCost_" + ThisVariantID.ToString() + "_" + DB.RowFieldInt(row2, "ShippingMethodID") + "_vldt\" value=\"[number][invalidalert=" + AppLogic.GetString("admin.common.ValidDollarAmountPrompt", SkinID, LocaleSetting) + "]\">\n");
								tmpS.Append("</td>\n");
							}
							tmpS.Append("</tr>\n");
						}
						tmpS.Append("</table>\n");

					}
				}
				else
				{
					AlertMessageDisplay.PushAlertMessage(AppLogic.GetString("admin.common.NoProductsFound", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
					MainBody.Visible = false;
				}

				ltBody.Text = tmpS.ToString();
			}
		}
    }
}
