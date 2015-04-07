// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using AspDotNetStorefrontCore;
using AspDotNetStorefrontCore.ShippingCalculation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace AspDotNetStorefrontAdmin
{
	public partial class ShippingPage : AdminPageBase
	{
		public int SelectedStoreId;
		public int SelectedShippingCalculationId;
		protected bool FilterShipping = AppLogic.GlobalConfigBool("AllowShippingFiltering");

		protected void Page_Load(object sender, EventArgs e)
		{
			var queryStringStoreId = Request.QueryStringNativeInt("StoreId");
			SelectedStoreId = queryStringStoreId > 0 ? queryStringStoreId : Store.GetDefaultStore().StoreID;

			if (!IsPostBack)
			{
				if (FilterShipping)
					BindStores();

				BindShippingCalculations(SelectedStoreId);
			}
		}

		void BindShippingCalculations(int StoreId)
		{
			string query = string.Empty;
			query = "select sc.* from ShippingCalculation sc with (NOLOCK) order by shippingcalculationid";

			SelectedShippingCalculationId = EnsureStoreShippingCalculation(SelectedStoreId);

			using (SqlConnection connection = new SqlConnection(DB.GetDBConn()))
			{
				connection.Open();
				using (IDataReader rs = DB.GetRS(query, connection))
				{
					var currentShippingCalculationId = (int)Shipping.GetActiveShippingCalculationID(StoreId);
					while (rs.Read())
					{
						var shippingCalculationId = rs.FieldInt("ShippingCalculationID");
						var isSelected = currentShippingCalculationId == shippingCalculationId;

						if (isSelected)
							SelectedShippingCalculationId = DB.RSFieldInt(rs, "ShippingCalculationID");

						switch (shippingCalculationId)
						{
							case (int)Shipping.ShippingCalculationEnum.CalculateShippingByWeight:
								CalculateShippingByWeightName.Text = DB.RSFieldByLocale(rs, "Name", LocaleSetting);
								break;
							case (int)Shipping.ShippingCalculationEnum.CalculateShippingByTotal:
								CalculateShippingByTotalName.Text = DB.RSFieldByLocale(rs, "Name", LocaleSetting);
								break;
							case (int)Shipping.ShippingCalculationEnum.UseFixedPrice:
								UseFixedPriceName.Text = DB.RSFieldByLocale(rs, "Name", LocaleSetting);
								break;
							case (int)Shipping.ShippingCalculationEnum.AllOrdersHaveFreeShipping:
								AllOrdersHaveFreeShippingName.Text = DB.RSFieldByLocale(rs, "Name", LocaleSetting);
								break;
							case (int)Shipping.ShippingCalculationEnum.UseFixedPercentageOfTotal:
								UseFixedPercentageOfTotalName.Text = DB.RSFieldByLocale(rs, "Name", LocaleSetting);
								break;
							case (int)Shipping.ShippingCalculationEnum.UseIndividualItemShippingCosts:
								UseIndividualItemShippingCostsName.Text = DB.RSFieldByLocale(rs, "Name", LocaleSetting);
								break;
							case (int)Shipping.ShippingCalculationEnum.UseRealTimeRates:
								UseRealTimeRatesName.Text = DB.RSFieldByLocale(rs, "Name", LocaleSetting);
								break;
							case (int)Shipping.ShippingCalculationEnum.CalculateShippingByWeightAndZone:
								CalculateShippingByWeightAndZoneName.Text = DB.RSFieldByLocale(rs, "Name", LocaleSetting);
								break;
							case (int)Shipping.ShippingCalculationEnum.CalculateShippingByTotalAndZone:
								CalculateShippingByTotalAndZoneName.Text = DB.RSFieldByLocale(rs, "Name", LocaleSetting);
								break;
							case (int)Shipping.ShippingCalculationEnum.CalculateShippingByTotalByPercent:
								CalculateShippingByTotalByPercentName.Text = DB.RSFieldByLocale(rs, "Name", LocaleSetting);
								break;
						}


					}
				}
			}
			Page.DataBind();
		}

		void BindStores()
		{
			List<Store> storeList = Store.GetStoreList();
			StoreSelector.DataSource = storeList;
			StoreSelector.DataTextField = "Name";
			StoreSelector.DataValueField = "StoreID";
			StoreSelector.DataBind();

			StoreSelector.SelectedValue = SelectedStoreId.ToString();
		}

		protected void StoreSelector_SelectedIndexChanged(object sender, EventArgs e)
		{
			var selectedStoreId = 1;
			if (!int.TryParse(StoreSelector.SelectedValue, out selectedStoreId))
				return;
			Response.Redirect(String.Format("shipping.aspx?StoreId={0}", selectedStoreId));
		}

		/// <summary>
		/// Ensures that current storeid has a corresponding calculation id on the ShippingCalculationStore table
		/// </summary>
		/// <returns></returns>
		private int EnsureStoreShippingCalculation(int storeId)
		{
			int calcId;

			// first check if we have an entry in the mapping table for this store calculation
			if (!StoreHasShippingCalculationMap(storeId))
			{
				calcId = AppLogic.AppConfigUSInt("DefaultShippingCalculationID");
				string insertDefaultSql = string.Format("INSERT INTO ShippingCalculationStore(StoreId, ShippingCalculationId) Values({0}, {1})", storeId, calcId);

				DB.ExecuteSQL(insertDefaultSql);
			}

			string query = string.Format("SELECT ShippingCalculationId AS N FROM ShippingCalculationStore WHERE StoreID = {0}", storeId);
			calcId = DB.GetSqlN(query);

			return calcId;
		}
		
		/// <summary>
		/// Determines if the storeid has a calculation configured
		/// </summary>
		/// <param name="storeId"></param>
		/// <returns></returns>
		private bool StoreHasShippingCalculationMap(int storeId)
		{
			string query = string.Format("SELECT COUNT(*) AS N FROM ShippingCalculationStore WHERE StoreID = {0}", storeId);
			return DB.GetSqlN(query) > 0;
		}

		private void UpdateStoreCalculation(int shippingCalculationId, int storeId)
		{
			DB.ExecuteSQL("Update ShippingCalculation set Selected=0");
			string updateStoreCalculation = string.Format("Update ShippingCalculationStore set ShippingCalculationID={0} where StoreId={1}", shippingCalculationId, storeId);
			DB.ExecuteSQL(updateStoreCalculation);
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			var newSelectedShippingCalculationId = int.Parse(hdnSelectedShippingCalculationId.Value);
			EnsureStoreShippingCalculation(SelectedStoreId);
			UpdateStoreCalculation(newSelectedShippingCalculationId, SelectedStoreId);
			BindShippingCalculations(SelectedStoreId);

			AlertMessage.PushAlertMessage("Shipping calculation method updated.", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
			Response.Redirect(AppLogic.AdminLinkUrl("shipping.aspx"), true);
		}
	}

}
