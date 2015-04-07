// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;
using AspDotNetStorefrontControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
	public partial class Customers : AdminPageBase
	{
		public const string DeleteCustomerCommand = "customer:delete";
		public const string UndeleteCustomerCommand = "customer:undelete";

		protected void DispatchGridCommand(object sender, GridViewCommandEventArgs e)
		{
			if(e.CommandName == DeleteCustomerCommand)
				DeleteCustomerCommandHandler(sender, e, deleted: true, successStringResource: "admin.common.HasBeenDeleted");
			else if(e.CommandName == UndeleteCustomerCommand)
				DeleteCustomerCommandHandler(sender, e, deleted: false, successStringResource: "admin.common.HasBeenRestored");
		}

		void DeleteCustomerCommandHandler(object sender, CommandEventArgs e, bool deleted, string successStringResource)
		{
			int customerId;

			if(!Int32.TryParse((string)e.CommandArgument, out customerId))
				return;

			if(SetDeletedFlag(customerId, deleted))
			{
				AlertMessageDisplay.PushAlertMessage(
					BuildAlertMessage(customerId, successStringResource),
					AlertMessage.AlertType.Success);

				FilteredListing.Rebind();
			}
		}

		string BuildAlertMessage(int customerId, string stringResourceName)
		{
			var locale = AppLogic.GetCurrentCustomer().LocaleSetting;
			return String.Format(
				"{0} {1} {2}",
				AppLogic.GetString("admin.common.Customer", locale),
				customerId,
				AppLogic.GetString(stringResourceName, locale));
		}

		#region Customer Data Access Methods

		bool SetDeletedFlag(int customerId, bool deleted)
		{
			try
			{
				DB.ExecuteSQL(
					"update dbo.Customer set Deleted = @deleted where CustomerID = @customerId",
					new[]
					{
						new SqlParameter("deleted", deleted),
						new SqlParameter("customerId", customerId),
					});

				return true;
			}
			catch(Exception ex)
			{
				SysLog.LogException(ex, MessageTypeEnum.DatabaseException, MessageSeverityEnum.Error);
				return false;
			}
		}
		#endregion

	}
}
