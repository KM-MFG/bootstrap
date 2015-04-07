// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace AspDotNetStorefrontCore
{
    public class CardTypeDataSource
    {
        public static List<string> GetAcceptedCreditCardTypes(Customer ThisCustomer)
        {
            List<string> CCTypes = new List<string>();

            CCTypes.Add(AppLogic.GetString("address.cs.32", ThisCustomer.SkinID, ThisCustomer.LocaleSetting));

            using (SqlConnection conn = DB.dbConn())
            {
                conn.Open();
                using (IDataReader rs = DB.GetRS("select * from creditcardtype  with (NOLOCK)  where Accepted=1 order by CardType", conn))
                {
                    while (rs.Read())
                    {
                        CCTypes.Add(DB.RSField(rs, "CardType"));
                    }
                }
            }
            return CCTypes;
        }
    }
}
