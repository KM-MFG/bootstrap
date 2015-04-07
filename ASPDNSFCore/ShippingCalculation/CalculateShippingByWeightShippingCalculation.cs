// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System.Data;
using System.Data.SqlClient;


namespace AspDotNetStorefrontCore.ShippingCalculation
{
    /// <summary>
    /// Summary for ShippingByWeight
    /// </summary>
    public class CalculateShippingByWeightShippingCalculation : ShippingCalculation
    {
        /// <summary>
        /// Represent calculation for ShippingByWeight
        /// </summary>
        /// <returns>return collection of shipping method based on the computation of ShippingByWeight</returns>
        public override ShippingMethodCollection GetShippingMethods(int storeId)
        {           
            decimal extraFee = AppLogic.AppConfigUSDecimal("ShippingHandlingExtraFee");

            ShippingMethodCollection availableShippingMethods = new ShippingMethodCollection();

            string shipsql = GenerateShippingMethodsQuery(storeId, false);

            using (SqlConnection dbconn = new SqlConnection(DB.GetDBConn()))
            {
                dbconn.Open();
                using (IDataReader reader = DB.GetRS(shipsql.ToString(),dbconn))
                {
                    while (reader.Read())
                    {
                        ShippingMethod thisMethod = new ShippingMethod();
                        thisMethod.Id = DB.RSFieldInt(reader, "ShippingMethodID");
                        thisMethod.Name = DB.RSFieldByLocale(reader, "Name", ThisCustomer.LocaleSetting);
                        thisMethod.IsFree = this.ShippingIsFreeIfIncludedInFreeList && Shipping.ShippingMethodIsInFreeList(thisMethod.Id);

                        if (thisMethod.IsFree)
                        {
                            thisMethod.ShippingIsFree = true;
                            thisMethod.Freight = decimal.Zero;
                        }
                        else
                        {
                            decimal freight = Shipping.GetShipByWeightCharge(thisMethod.Id, this.Cart.WeightTotal()); // exclude download items!

                            if (freight > System.Decimal.Zero && extraFee > System.Decimal.Zero)
                            {
                                freight += extraFee;
                            }

                            if (freight < 0)
                            {
                                freight = 0;
                            }
                            thisMethod.Freight = freight;

                        }

                        bool include = !(this.ExcludeZeroFreightCosts == true && (thisMethod.Freight == decimal.Zero && !thisMethod.IsFree));

                        if (include)
                        {
                            availableShippingMethods.Add(thisMethod);
                        }
                    }
                }
            
            }

            return availableShippingMethods;
        }
    }
}
