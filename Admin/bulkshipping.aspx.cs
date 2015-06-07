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
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using AspDotNetStorefrontCore;
using System.Web.UI.WebControls;

namespace AspDotNetStorefrontAdmin
{
	public partial class BulkShipping : AdminPageBase
	{
		protected void Page_Load(object sender, System.EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");
		}

		protected void btnImport_Click(object sender, EventArgs e)
		{
			HttpPostedFile importFile = fuShippingImport.PostedFile;

			if (importFile == null || !importFile.FileName.EndsWith(".csv"))
			{
				AlertMessage.PushAlertMessage("Please select a CSV file for import.", AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				return;
			}

			//Save as a temp file
			string fullFilePath = CommonLogic.SafeMapPath("../images") + "\\ShippingExport_" + importFile.FileName.ToLowerInvariant().Substring(importFile.FileName.ToLowerInvariant().LastIndexOf('.'));

			importFile.SaveAs(fullFilePath);

			ProcessImport(fullFilePath);

			//Clean up the temp file
			File.Delete(fullFilePath);
		}

		protected void btnExport_Click(object sender, EventArgs e)
		{
			StringBuilder exportContents = new StringBuilder();

			exportContents.Append(MakeHeaderRow());

			//Can't use the grid as a datasource as it's paged, so query the DB with the same filters the grid is currently displaying
			using(SqlConnection conn = new SqlConnection(DB.GetDBConn()))
			{
				conn.Open();

				var whereClause = FilteredListing.GetFilterWhereClause();
				var sql = String.Format("SELECT OrderNumber, ShippedOn, ShippedVIA, ShippingTrackingNumber FROM Orders WHERE {0}", whereClause.Sql);

				SqlCommand command = new SqlCommand(sql, conn);
				command.Parameters.AddRange(whereClause.Parameters.ToArray());

				using(IDataReader rs = command.ExecuteReader())
				{
					while(rs.Read())
					{
						exportContents.Append(DB.RSFieldInt(rs, "OrderNumber").ToString());
						exportContents.Append(",");

						DateTime shippedOn = DB.RSFieldDateTime(rs, "ShippedOn");
						exportContents.Append(shippedOn == System.DateTime.MinValue ? String.Empty : shippedOn.ToString());
						exportContents.Append(",");

						exportContents.Append(DB.RSField(rs, "ShippedVIA"));
						exportContents.Append(",");

						exportContents.Append(DB.RSField(rs, "ShippingTrackingNumber"));
						exportContents.Append("\r\n");
					}
				}
			}

			//Save a copy in images
			string filepath = CommonLogic.SafeMapPath("../images") + "\\";
			string filename = "ShippingExport_" + Localization.ToNativeDateTimeString(System.DateTime.Now).Replace(" ", "_").Replace(",", "_").Replace("/", "_").Replace(":", "_").Replace(".", "_") + ".csv";
			string fullFilePath = filepath + filename;
			File.WriteAllText(fullFilePath, exportContents.ToString());

			// Send the CSV
			Response.Clear();
			Response.ClearHeaders();
			Response.ClearContent();
			Response.AddHeader("content-disposition", "attachment; filename=ShippingExport.csv");
			Response.BufferOutput = false;
			Response.ContentType = "text/csv";
			Response.TransmitFile(fullFilePath);
			Response.Flush();
			Response.End();
		}

		private String MakeHeaderRow()
		{
			StringBuilder headerRow = new StringBuilder();

			headerRow.Append("OrderNumber,");
			headerRow.Append("ShippedOn,");
			headerRow.Append("Carrier,");
			headerRow.Append("TrackingNumber\r\n");

			return headerRow.ToString();
		}

		private String UnQuoteValue(string quotedText)
		{
			return quotedText.TrimStart('\'').TrimEnd('\'');
		}

		private void ProcessImport(string fullFilePath)
		{
			using(TextReader tr = File.OpenText(fullFilePath))
			{
				DataTable importTable = CsvParser.Parse(tr, true);

				foreach(DataRow row in importTable.Rows)
				{
					try
					{
						int orderNumber = 0;
						int parsedOrderNumber;
						DateTime shippedOn = System.DateTime.Now;	//If no date is provided or we don't understand the format, use the import time
						DateTime parsedShippedOn;
						string carrier;
						string trackingNumber;
						bool sendEmail = AppLogic.AppConfigBool("BulkImportSendsShipmentNotifications");

						if(int.TryParse(UnQuoteValue(row["OrderNumber"].ToString()), out parsedOrderNumber))
						{
							orderNumber = parsedOrderNumber;

							if(DateTime.TryParse(UnQuoteValue(row["ShippedOn"].ToString()), out parsedShippedOn))
								shippedOn = parsedShippedOn;

							carrier = UnQuoteValue(row["Carrier"].ToString());
							trackingNumber = UnQuoteValue(row["TrackingNumber"].ToString());

							Order order = new Order(orderNumber);
							Customer orderCustomer = new Customer(order.CustomerID);
							Order.MarkOrderAsShipped(orderNumber, carrier, trackingNumber, shippedOn, false, null, new Parser(null, 1, orderCustomer), !sendEmail);
						}
					}
					catch (Exception ex)
					{
						AlertMessage.PushAlertMessage(ex.Message, AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
					}
				}
			}
			AlertMessage.PushAlertMessage("Import successful!", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
		}
	}
}
