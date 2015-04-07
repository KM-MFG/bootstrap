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
using System.Data.SqlClient;
using System.Data;

namespace AspDotNetStorefrontCore
{
    public class Country
    {
        private int m_id;
        private string m_name;

        public int ID
        {
            get { return m_id; }
            set { m_id = value; }
        }

        public string Name
        {
            get { return m_name; }
            set { m_name = value; }
        }

        public static List<Country> GetAll()
        {
            List<Country> listCountry = new List<Country>();

            using (SqlConnection conn = DB.dbConn())
            {
                try
                {
                    conn.Open();
                    using (IDataReader rs = DB.GetRS(String.Format("SELECT CountryID,Name FROM Country WHERE Published={0} ORDER BY DisplayOrder, Name", 1),conn))
                    {
                        while (rs.Read())
                        {
                            listCountry.Add(new Country { ID = DB.RSFieldInt(rs, "CountryID"), Name = DB.RSField(rs, "Name") });
                        }
                    }
                }
                finally
                {
                    conn.Close();
                    conn.Dispose();
                }
            }

            return listCountry;
        }

    }

	public class State
	{
		public string Abbreviation
		{ get { return _Abbreviation; } }

		public string Name
		{ get { return _Name; } }

		readonly string _Abbreviation;
		readonly string _Name;

		public State(string name, string abbreviation)
		{
			_Name = name;
			_Abbreviation = abbreviation;
		}

		public static IEnumerable<State> GetAllStateForCountry(int CountryID, String LocaleSetting)
		{
			var sql = "select Abbreviation, Name from State where Published = 1 and CountryID = @countryId order by displayOrder, Name";

			using(var connection = new SqlConnection(DB.GetDBConn()))
			using(var command = new SqlCommand(sql, connection))
			{
				command.Parameters.Add(new SqlParameter("countryId", (object)CountryID));
				connection.Open();

				using(var reader = command.ExecuteReader())
				{
					if(!reader.Read())
					{
						yield return new State(
							name: AppLogic.GetString("state.countrywithoutstates", LocaleSetting),
							abbreviation: "--");
						yield break;
					}

					do
					{
						yield return new State(
							name: DB.RSField(reader, "Name"),
							abbreviation: DB.RSField(reader, "Abbreviation"));
					} while(reader.Read());
				}
			}
		}
	}
}
