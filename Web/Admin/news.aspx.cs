// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using AspDotNetStorefrontControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{

	public partial class News : AdminPageBase
	{
		public const string PublishNewsCommand = "news:publish";
		public const string UnpublishNewsCommand = "news:unpublish";
		readonly Dictionary<string, CommandEventHandler> CommandHandlerMappings;

		protected void Page_Load(object sender, EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");
		}

		public News()
		{
			// Use a dictionary to map the string command names to handler methods
			CommandHandlerMappings = new Dictionary<string, CommandEventHandler>
			{
				{ PublishNewsCommand, (o, e) => PublishNewsCommandHandler(o, e, true) },
				{ UnpublishNewsCommand, (o, e) => PublishNewsCommandHandler(o, e, false) }
			};
		}

		protected void DispatchCommand(object sender, CommandEventArgs e)
		{
			// Dispatch known command names out of the dictionary
			if(CommandHandlerMappings.ContainsKey(e.CommandName))
				CommandHandlerMappings[e.CommandName].Invoke(sender, e);
		}

		void PublishNewsCommandHandler(object sender, CommandEventArgs e, bool published)
		{
			int newsId;
			if(!Int32.TryParse((string)e.CommandArgument, out newsId))
				return;

			if(SetPublishedFlag(newsId, published))
			{
				ctrlAlertMessage.PushAlertMessage("News Article Updated", AlertMessage.AlertType.Success);

				FilteredListing.Rebind();
			}
		}

		bool SetPublishedFlag(int newsId, bool published)
		{
			try
			{
				DB.ExecuteSQL(
					"update dbo.News set Published = @Published where NewsId = @NewsId",
					new[]
					{
						new SqlParameter("Published", published),
						new SqlParameter("NewsId", newsId),
					});

				return true;
			}
			catch(Exception ex)
			{
				SysLog.LogException(ex, MessageTypeEnum.DatabaseException, MessageSeverityEnum.Error);
				return false;
			}
		}

		protected void gMain_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			if(e.Row.RowType == DataControlRowType.DataRow)
			{
				LinkButton lnkDelete = (LinkButton)e.Row.FindControl("lnkDelete");
				lnkDelete.Attributes.Add("onClick", "javascript: return confirm('Are you sure you want to delete this news article?')");
			}
		}

		protected void gMain_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			if(e.CommandName == "DeleteItem")
			{
				gMain.EditIndex = -1;
				int iden = Localization.ParseNativeInt(e.CommandArgument.ToString());

				try
				{
					DB.ExecuteSQL(String.Format("UPDATE News SET Deleted = 1 WHERE NewsID = {0}", iden));
					ctrlAlertMessage.PushAlertMessage("Deleted", AlertMessage.AlertType.Success);

					FilteredListing.Rebind();
				}
				catch(Exception ex)
				{
					ctrlAlertMessage.PushAlertMessage(ex.Message, AlertMessage.AlertType.Error);
				}
			}
		}
	}
}
