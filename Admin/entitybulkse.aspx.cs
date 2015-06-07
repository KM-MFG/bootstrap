// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Data;
using System.Globalization;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
    /// <summary>
    /// Summary description for bulkeditsearch.
    /// </summary>
    public partial class entityBulkSE : AdminPageBase
    {
        int EntityID;
        String EntityName;
        EntitySpecs m_EntitySpecs;
        EntityHelper Helper;
        
        protected void Page_Load(object sender, System.EventArgs e)
        {
            Response.CacheControl = "private";
            Response.Expires = 0;
            Response.AddHeader("pragma", "no-cache");

            EntityID = CommonLogic.QueryStringUSInt("EntityID"); ;
            EntityName = CommonLogic.QueryStringCanBeDangerousContent("EntityName");
            m_EntitySpecs = EntityDefinitions.LookupSpecs(EntityName);
            Helper = new EntityHelper(m_EntitySpecs, 0);
      
            if (EntityID == 0 || EntityName.Length == 0)
            {
                Response.Redirect(AppLogic.AdminLinkUrl("default.aspx"));
            }

            if (CommonLogic.FormCanBeDangerousContent("IsSubmit").Equals("TRUE", StringComparison.InvariantCultureIgnoreCase))
            {
                for (int i = 0; i <= Request.Form.Count - 1; i++)
                {
                    String FieldName = Request.Form.Keys[i];
                    if (FieldName.StartsWith("setitle", StringComparison.InvariantCultureIgnoreCase))
                    {
                        String[] FieldNameSplit = FieldName.Split('_');
                        int TheProductID = Localization.ParseUSInt(FieldNameSplit[1]);
                        int TheVariantID = Localization.ParseUSInt(FieldNameSplit[2]);
                        string inputVal = AppLogic.FormLocaleXml("SETitle", CommonLogic.FormCanBeDangerousContent(FieldName), ThisCustomer.ThisCustomerSession.Session("entityUserLocale"), "Product", TheProductID);
                        if (inputVal.Length == 0)
                        {
                            DB.ExecuteSQL("update Product set SETitle=NULL where ProductID=" + TheProductID.ToString());
                        }
                        else
                        {
                            DB.ExecuteSQL("update Product set SETitle=" + DB.SQuote(inputVal) + " where ProductID=" + TheProductID.ToString());
                        }
                    }
                    if (FieldName.StartsWith("sekeywords", StringComparison.InvariantCultureIgnoreCase))
                    {
                        String[] FieldNameSplit = FieldName.Split('_');
                        int TheProductID = Localization.ParseUSInt(FieldNameSplit[1]);
                        int TheVariantID = Localization.ParseUSInt(FieldNameSplit[2]);
                        string inputVal = AppLogic.FormLocaleXml("SEKeywords", CommonLogic.FormCanBeDangerousContent(FieldName), ThisCustomer.ThisCustomerSession.Session("entityUserLocale"), "Product", TheProductID);
                        if (inputVal.Length == 0)
                        {
                            DB.ExecuteSQL("update Product set SEKeywords=NULL where ProductID=" + TheProductID.ToString());
                        }
                        else
                        {
                            DB.ExecuteSQL("update Product set SEKeywords=" + DB.SQuote(inputVal) + " where ProductID=" + TheProductID.ToString());
                        }
                    }
                    if (FieldName.StartsWith("sedescription", StringComparison.InvariantCultureIgnoreCase))
                    {
                        String[] FieldNameSplit = FieldName.Split('_');
                        int TheProductID = Localization.ParseUSInt(FieldNameSplit[1]);
                        int TheVariantID = Localization.ParseUSInt(FieldNameSplit[2]);
                        string inputVal = AppLogic.FormLocaleXml("SEDescription", CommonLogic.FormCanBeDangerousContent(FieldName), ThisCustomer.ThisCustomerSession.Session("entityUserLocale"), "Product", TheProductID);
                        if (inputVal.Length == 0)
                        {
                            DB.ExecuteSQL("update Product set SEDescription=NULL where ProductID=" + TheProductID.ToString());
                        }
                        else
                        {
                            DB.ExecuteSQL("update Product set SEDescription=" + DB.SQuote(inputVal) + " where ProductID=" + TheProductID.ToString());
                        }
                    }
                }
				AlertMessageDisplay.PushAlertMessage("The search engine fields have been saved.", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
            }

            LoadBody();
        }

        protected void LoadBody()
        {
			ltBody.Text = String.Empty;
			Int32 mappingCount = DB.GetSqlN("select count(*) as N from Product" + this.m_EntitySpecs.m_EntityName + " where " + m_EntitySpecs.m_EntityName + "Id = " + this.EntityID.ToString());

            ProductCollection products = new ProductCollection(m_EntitySpecs.m_EntityName, EntityID);
            products.PageSize = 0;
            products.PageNum = 1;
            products.PublishedOnly = false;
            products.ReturnAllVariants = false;

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
                ltBody.Text += ("<input type=\"hidden\" name=\"IsSubmit\" value=\"true\">\n");
                ltBody.Text += ("<table class=\"table\">\n");
                ltBody.Text += ("<tr>\n");
                ltBody.Text += ("<td>" + AppLogic.GetString("admin.common.ProductID", SkinID, LocaleSetting) + "</td>\n");
                ltBody.Text += ("<td>" + AppLogic.GetString("admin.common.VariantID", SkinID, LocaleSetting) + "</td>\n");
                ltBody.Text += ("<td>" + AppLogic.GetString("admin.common.ProductName", SkinID, LocaleSetting) + "</td>\n");
                ltBody.Text += ("<td>" + AppLogic.GetString("admin.common.VariantName", SkinID, LocaleSetting) + "</td>\n");
                ltBody.Text += ("<td>" + AppLogic.GetString("admin.common.ProductFields", SkinID, LocaleSetting) + "</td>\n");
               
                ltBody.Text += ("</tr>\n");
                int LastProductID = 0;



                int rowcount = dsProducts.Tables[0].Rows.Count;

                for (int i = 0; i < rowcount; i++)
                {
                    DataRow row = dsProducts.Tables[0].Rows[i];

                    int ThisProductID = DB.RowFieldInt(row, "ProductID");
                    int ThisVariantID = DB.RowFieldInt(row, "VariantID");

                    if (i % 2 == 0)
                    {
                        ltBody.Text += ("<tr>\n");
                    }
                    else
                    {
                        ltBody.Text += ("<tr>\n");
                    }
                    ltBody.Text += ("<td>");
                    ltBody.Text += (ThisProductID.ToString());
                    ltBody.Text += ("</td>");
                    ltBody.Text += ("<td>");
                    ltBody.Text += (ThisVariantID.ToString());
                    ltBody.Text += ("</td>");
                    ltBody.Text += ("<td>");
                    bool showlinks = false;
                    if (showlinks)
						ltBody.Text += ("<a href=\"" + AppLogic.AdminLinkUrl("product.aspx") + "?productid=" + ThisProductID.ToString() + "&entityname=" + EntityName + "&entityid=" + EntityID.ToString() + "\">");
                    ltBody.Text += (DB.RowFieldByLocale(row, "Name", LocaleSetting));
                    if (showlinks)
                        ltBody.Text += ("</a>");
                    ltBody.Text += ("</td>\n");
                    ltBody.Text += ("<td>");
                    if (showlinks)
                        ltBody.Text += ("<a href=\"" + AppLogic.AdminLinkUrl("variant.aspx") + "?productid=" + ThisProductID.ToString() + "&variantid=" + ThisVariantID.ToString() + "&entityname=" + EntityName + "&entityid=" + EntityID.ToString() + "\">");
                    ltBody.Text += (DB.RowFieldByLocale(row, "VariantName", LocaleSetting));
                    if (showlinks)
                        ltBody.Text += ("</a>");
                    ltBody.Text += ("</td>\n");
                    ltBody.Text += ("<td>");
                    ltBody.Text += ("<div>");
                    ltBody.Text += ("" + AppLogic.GetString("admin.topic.setitle", SkinID, LocaleSetting) + "<br/>");
                    ltBody.Text += ("<input maxLength=\"100\" name=\"SETitle_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "\" id=\"SETitle_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "\" value=\"" + XmlCommon.GetLocaleEntry(DB.RowField(row, "SETitle"), ThisCustomer.ThisCustomerSession.Session("entityUserLocale"), false) + "\" class=\"singleLongest\" /><br/>");
                    ltBody.Text += ("" + AppLogic.GetString("admin.topic.sekeywords", SkinID, LocaleSetting) + "<br/>");
                    ltBody.Text += ("<input maxLength=\"255\" name=\"SEKeywords_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "\" id=\"SEKeywords" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "\" value=\"" + XmlCommon.GetLocaleEntry(DB.RowField(row, "SEKeywords"), ThisCustomer.ThisCustomerSession.Session("entityUserLocale"), false) + "\" class=\"singleLongest\" /><br/>");
                    ltBody.Text += ("" + AppLogic.GetString("admin.topic.sedescription", SkinID, LocaleSetting) + "<br/>");
                    ltBody.Text += ("<input maxLength=\"255\" name=\"SEDescription_" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "\" id=\"SEDescription" + ThisProductID.ToString() + "_" + ThisVariantID.ToString() + "\" value=\"" + XmlCommon.GetLocaleEntry(DB.RowField(row, "SEDescription"), ThisCustomer.ThisCustomerSession.Session("entityUserLocale"), false) + "\" class=\"singleLongest\" /><br/>");
                                      
                    ltBody.Text += ("</div>");
                    ltBody.Text += ("</td>\n");
                    ltBody.Text += ("</tr>\n");
                    LastProductID = ThisProductID;

                }
                ltBody.Text += ("</table>\n");
               
            }
            else
            {
				AlertMessageDisplay.PushAlertMessage(AppLogic.GetString("admin.common.NoProductsFound", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				MainBody.Visible = false;
            }
            dsProducts.Dispose();
            products.Dispose();
        }
    }
}
