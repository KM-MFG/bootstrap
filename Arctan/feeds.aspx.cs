// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.IO;
using System.Net;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using AspDotNetStorefrontAdmin;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
	public partial class Feeds : AdminPageBase
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");

			if(IsPostBack)
				return;

			InitializePageData();
		}

		protected void rptrFeeds_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
		{
			if(e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
				return;
			
			Button btnDelete = (Button)e.Item.FindControl("btnDeleteFeed");
			btnDelete.Attributes.Add("onClick", "javascript: return confirm('" + AppLogic.GetString("admin.feeds.msgconfirmdeletion", SkinID, LocaleSetting) + "')");
		}
		
		protected void rptrFeeds_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			switch(e.CommandName)
			{
				case "execute":
					String[] splitArgs = e.CommandArgument.ToString().Split(':');
					if(splitArgs.Length != 2)
						return;

					ExecuteFeed(Convert.ToInt32(splitArgs[0]), Convert.ToInt32(splitArgs[1]));
					break;

				case "delete":
					int FeedID = Convert.ToInt32(e.CommandArgument);
					DeleteFeed(FeedID);
					break;
			}
		}

		private void InitializePageData()
		{
			using(SqlConnection dbconn = new SqlConnection(DB.GetDBConn()))
			{
				dbconn.Open();
				using(IDataReader dr = DB.GetRS("aspdnsf_GetFeed", dbconn))
				{
					rptrFeeds.DataSource = dr;
					rptrFeeds.DataBind();

				}
			}
		}

		private void ExecuteFeed(int FeedID, int StoreID)
		{
			Customer ThisCustomer = ((AspDotNetStorefrontPrincipal)Context.User).ThisCustomer;
			Feed f = new Feed(FeedID);
			String RuntimeParams = String.Empty;
			RuntimeParams += String.Format("SID={0}&", StoreID);
			string result = f.ExecuteFeed(ThisCustomer, RuntimeParams);
			if(!string.IsNullOrWhiteSpace(result))
				AlertMessage.PushAlertMessage(result, AspDotNetStorefrontControls.AlertMessage.AlertType.Error);

			InitializePageData();
		}

		private void DeleteFeed(int FeedID)
		{
			var result = Feed.DeleteFeed(FeedID);
			if(!string.IsNullOrWhiteSpace(result))
				AlertMessage.PushAlertMessage(result, AspDotNetStorefrontControls.AlertMessage.AlertType.Error);

			InitializePageData();
		}

		protected void SmartSearch_RebuildIndex_Click(object sender, EventArgs e)
		{
			// Create the web request
			String action = "GenerateIndex";
			String data = "true";
			String url = String.Format("{0}{1}={2}", ConfigurationManager.AppSettings["SmartSearchURL"], action, data);

			HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
			request.Timeout = 3600000;
			string r = null;
			// Get response
			using(HttpWebResponse response = request.GetResponse() as HttpWebResponse)
			{
				// Get the response stream
				StreamReader reader = new StreamReader(response.GetResponseStream());
				r = reader.ReadToEnd();
			}
			
			resetError(r, false);
		}
		
		protected void resetError(string error, bool isError)
        {
            if (error.Length > 0)
            {
                if (isError)
                {
                    string errorMessage = String.Format("<font class=\"noticeMsg\">{0}</font>", "Error Occurred While Rebuilding Smart Search Index!");
					AlertMessage.PushAlertMessage(errorMessage, AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				}
                else
                {
                    string successMessage = String.Format("<font class=\"noticeMsg\">{0}</font>", "Success! Smart Search Index Has Been Rebuilt");
					AlertMessage.PushAlertMessage(successMessage, AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
				}
            }
        }
	}
}
