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
using System.Linq;
using System.Web;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
    /// <summary>
    /// Base class for all admin site pages
    /// </summary>
    public class AdminGridOrder
    {
        #region Private Variables
        public int OrderNumber { get; private set; }
        public int StoreId { get; private set; }
        public string Email { get; private set; }
        public string EmailLink { get; private set; }
        public string Phone { get; private set; }
        public string Items { get; private set; }
		public string TransactionState { get; private set; }
        public decimal OrderTotal { get; private set; }
        public bool Printed { get; private set; }
        public DateTime OrderDate { get; private set; }
		public DateTime ShippedOn { get; private set; }
        #endregion

        #region Constructors

        /// <summary>
        /// Default constructor
        /// </summary>
        public AdminGridOrder()
        { }

        public AdminGridOrder(int OrderId)
        {
            Load(OrderId, Localization.GetDefaultLocale());
        }

        public AdminGridOrder(int OrderId, string LocaleSetting)
        {
            Load(OrderId, LocaleSetting);
        }

        #endregion

        #region Methods
        public void Load(int OrderId, string LocaleSetting)
        {
            List<SqlParameter> sqlParams = new List<SqlParameter> { new SqlParameter("@OrderNumber", OrderId) };

            using (SqlConnection dbconn = DB.dbConn())
            {
                dbconn.Open();
				using(IDataReader dr = DB.GetRS("SELECT OrderDate, Email, ShippingPhone, ShippedOn, TransactionState, OrderTotal, StoreID, IsPrinted FROM Orders WHERE OrderNumber = @OrderNumber", sqlParams.ToArray(), dbconn))
                {
                    if (dr.Read())
                    {
                        this.OrderNumber = OrderId;

                        //Values from DB
                        Email = DB.RSField(dr, "Email");
                        Phone = DB.RSField(dr, "ShippingPhone");
						TransactionState = DB.RSField(dr, "TransactionState");
                        OrderTotal = DB.RSFieldDecimal(dr, "OrderTotal");
                        Printed = DB.RSFieldBool(dr, "IsPrinted");
                        OrderDate = DB.RSFieldDateTime(dr, "OrderDate");
						ShippedOn = DB.RSFieldDateTime(dr, "ShippedOn");
                        StoreId = DB.RSFieldInt(dr, "StoreID");

                        //Items
                        Order boughtOrder = new Order(OrderId, LocaleSetting);
						int count = 0;
                        foreach (CartItem item in boughtOrder.CartItems)
                        {
							if(count < 2)
							{
								Items += String.Format("<div class=\"order-item\" >{0}</div>", AppLogic.MakeProperObjectName(item.ProductName, item.VariantName, LocaleSetting));
								count++;
							}
							else
							{
								Items += String.Format("<div class=\"order-item\" ><a href=\"order.aspx?ordernumber={0}\">{1}</a></div>", OrderId, AppLogic.GetString("admin.orderdetails.More", LocaleSetting));
								return;
							}
                            
                        }

                        //Calculated values
                        EmailLink = string.Format("mailto:{0}?subject=RE: {1} order #{2}", Email, Store.GetStoreName(StoreId), OrderId.ToString());
                    }
                }
            }
        }

        #endregion
    }
}
