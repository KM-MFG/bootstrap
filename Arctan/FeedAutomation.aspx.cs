using System;
using System.Text;
using AspDotNetStorefrontCore;
using log4net;
using Moco.AspDNSF.Extension;

public partial class FeedAutomation : System.Web.UI.Page
{
	private static readonly ILog log = LogManager.GetLogger(typeof(FeedAutomation));

    protected void Page_Load(object sender, EventArgs e)
    {
		// It was suggested we implement try/catch IIS custom errors
		int FeedID=0;
		int.TryParse(Request.QueryString["FeedID"],out FeedID);
		if (FeedID > 0)
		{
			try
			{
				Customer customer = new Customer(true);
				customer.FirstName = "AutomatedFeeds";
				FeedManager feedMgr = new FeedManager(DB.GetDBConn());

				Moco.AspDNSF.Extension.Feed feed = feedMgr.LoadFeed(FeedID);
				FeedManagerExt.ExecuteFeed(feed, customer);
			}
			catch (Exception ex)
			{
				if (log.IsErrorEnabled)
				{
					log.Error("Date: " + DateTime.Now, ex);
				}
				
				StringBuilder msg = new StringBuilder("Date: " + DateTime.Now + " ERROR: ");
				do
				{
					msg.AppendLine(ex.Message);
				}
				while (null != (ex = ex.InnerException));
				Console.WriteLine(msg.ToString());

				Response.Write(msg.ToString());

			}
		}
    }
}