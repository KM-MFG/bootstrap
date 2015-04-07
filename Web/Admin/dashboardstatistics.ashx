<%@ WebHandler Language="C#" Class="DashboardStatistics" %>

using System;
using System.Web;
using System.Text;
using AspDotNetStorefrontCore;
using System.Data.SqlClient;
using System.Data;

public class DashboardStatistics : IHttpHandler {

	public bool IsReusable
	{ get { return false; } }

	public void ProcessRequest(HttpContext context)
	{
		context.Response.ContentType = "application/json";

		var length = CommonLogic.QueryStringCanBeDangerousContent("length");
		if (length == String.Empty)
			length = "month";
		
		var statisticType = CommonLogic.QueryStringCanBeDangerousContent("type");
		if (statisticType == "orders")
		{
			WriteOrderData(context.Response, length);
		}
		else if (statisticType == "products")
		{
			WriteProductData(context.Response, length);
		}
		
		context.Response.End();
	}

	void WriteOrderData(HttpResponse response, String length)
	{
		response.Write(@"{ ""data"": [");

		var endDate = System.DateTime.Now;
		System.DateTime startDate;
		var interval = 12;
		var dateFormat = "MMM d";
		switch (length)
		{
			case "day":
				startDate = endDate.AddDays(-1);
				interval = 24;
				dateFormat = "h tt";
				break;
			case "year":
				startDate = endDate.AddYears(-1);
				interval = 12;
				dateFormat = "MMM y";
				break;
			default:
				startDate = endDate.AddMonths(-1);
				interval = 30;
				break;
		}

        using (var connection = new SqlConnection(DB.GetDBConn()))
		{
            var command = new SqlCommand("aspdnsf_SalesForChart", connection);
			command.CommandType = CommandType.StoredProcedure;
			command.Parameters.Add(new SqlParameter("@StartDate", SqlDbType.DateTime) { Value = startDate });
			command.Parameters.Add(new SqlParameter("@EndDate", SqlDbType.DateTime) { Value = endDate });
			command.Parameters.Add(new SqlParameter("@NumIntervals", SqlDbType.Int) { Value = interval });
			
			connection.Open();
			using (var reader = command.ExecuteReader())
			{
                var isFirst = true;

				while (reader.Read())
				{
					if (!isFirst)
						response.Write(",");
					else
						isFirst = false;

					var date = DB.RSFieldDateTime(reader, "EndDate");
					var sales = DB.RSFieldDecimal(reader, "Sales");
					response.Write(String.Format(@"[ ""{0}"" , {1}]", date.ToString(dateFormat), sales));
				}
			}
		}
		
		response.Write("]}");
		
	}

	void WriteProductData(HttpResponse response, String length)
	{
		response.Write(@"{ ""data"": [");

		var endDate = System.DateTime.Now;
		System.DateTime startDate;
		switch (length)
		{
			case "day":
				startDate = endDate.AddDays(-1);
				break;
			case "year":
				startDate = endDate.AddYears(-1);
				break;
			default:
				startDate = endDate.AddMonths(-1);
				break;
		}

        using (var connection = new SqlConnection(DB.GetDBConn()))
		{
            var command = new SqlCommand("aspdnsf_TopProducts", connection);
			command.CommandType = CommandType.StoredProcedure;
			command.Parameters.Add(new SqlParameter("@StartDate", SqlDbType.DateTime) { Value = startDate });
			command.Parameters.Add(new SqlParameter("@EndDate", SqlDbType.DateTime) { Value = endDate });
			command.Parameters.Add(new SqlParameter("@CountOfProducts", SqlDbType.Int) { Value = 10 });
			
			connection.Open();
			using (var reader = command.ExecuteReader())
			{
				bool isFirst = true;

				while (reader.Read())
				{
					if (!isFirst)
						response.Write(",");
					else
						isFirst = false;

					var productName = DB.RSFieldByLocale(reader, "ProductName", Localization.GetDefaultLocale());
					var sales = DB.RSFieldDecimal(reader, "Sales");
					var productId = DB.RSFieldInt(reader, "ProductID");
					response.Write(String.Format(@"[ ""{0}"" , {1} , {2}]", productName, sales, productId));
				}
			}
		}

		response.Write("]}");
	}	
}