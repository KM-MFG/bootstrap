// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.IO;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using AspDotNetStorefrontAdmin;
using AspDotNetStorefrontCore;

using EXT = Moco.AspDNSF.Extension;

namespace AspDotNetStorefrontAdmin
{
	public partial class editfeed : AdminPageBase
	{
		int FeedID;
		EXT.Feed m_Feed;
		EXT.FeedManager m_FeedMgr = new EXT.FeedManager(DB.GetDBConn());
		private List<Store> m_stores;
		public List<Store> Stores
		{
			get { return m_stores; }
			set { m_stores = value; }
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");

			if(ViewState["feedid"] != null)
				FeedID = Convert.ToInt32(ViewState["feedid"]);
			else
				FeedID = CommonLogic.QueryStringUSInt("feedid");

			if(FeedID != 0)
				m_Feed = m_FeedMgr.LoadFeed(FeedID);

			if(!IsPostBack)
				InitializePageData();

			Page.Form.DefaultButton = btnSubmit_Top.UniqueID;
		}

		private void InitializePageData()
		{
			string path = Server.MapPath("") + @"\XmlPackages";
			string searchpattern = "feed*";
			string[] feeds = Directory.GetFiles(path, searchpattern);

			// clear any existing items from the XMLPackage list
			XmlPackage.Items.Clear();

			foreach(string s in feeds)
			{
				XmlPackage.Items.Add(new ListItem(s.Substring(s.LastIndexOf(@"\") + 1).ToLowerInvariant(), s.Substring(s.LastIndexOf(@"\") + 1).ToLowerInvariant()));
			}
			XmlPackage.Items.Insert(0, new ListItem("Select a Package", ""));
			XmlPackage.SelectedIndex = 0;

			Stores = Store.GetStoreList();
			cboStore.Items.Clear();
			cboStore.Items.Add(new ListItem("Select a store", "0"));
			foreach(var store in Stores)
			{
				string storeName = CommonLogic.IIF(store.IsDefault, store.Name + "(Default)", store.Name);
				cboStore.Items.Add(new ListItem(storeName, store.StoreID.ToString()));
			}

			if(m_Feed != null)
			{
				txtFeedName.Text = m_Feed.Name;
				if(XmlPackage.Items.FindByText(m_Feed.XmlPackage.ToLowerInvariant()) != null)
				{
					XmlPackage.SelectedValue = m_Feed.XmlPackage.ToLowerInvariant();
				}
				txtFtpUserName.Text = m_Feed.FTPUsername;
				txtFtpPwd.Text = m_Feed.FTPPassword;
				txtFtpServer.Text = m_Feed.FTPServer;
				txtFtpPort.Text = m_Feed.FTPPort.ToString();
				txtFtpFileName.Text = m_Feed.FTPFilename;
				CanAutoFtp.Items[0].Selected = m_Feed.CanAutoFTP;
				CanAutoFtp.Items[1].Selected = !m_Feed.CanAutoFTP;
				btnSubmit_Top.Text =
					btnSubmit_Bottom.Text = "Update Feed";
				ViewState["feedid"] = FeedID.ToString();
				foreach(ListItem li in cboStore.Items)
					if(li.Value.EqualsIgnoreCase(m_Feed.StoreID.ToString()))
						li.Selected = true;

				btnExecFeed_Top.Visible =
					btnExecFeed_Bottom.Visible = true;
					
				RequiresClassification.Items[0].Selected = m_Feed.RequiresClassification;
				RequiresClassification.Items[1].Selected = !m_Feed.RequiresClassification;
				UseFtpFileNameDateStamp.Items[0].Selected = m_Feed.UseFTPFilenameDateStamp;
				UseFtpFileNameDateStamp.Items[1].Selected = !m_Feed.UseFTPFilenameDateStamp;
				FTPFilenameDateStampFormat.Text = m_Feed.FTPFilenameDateStampFormat.Trim();
				UsePassive.Items[0].Selected = m_Feed.UsePassive;
				UsePassive.Items[1].Selected = !m_Feed.UsePassive;
				UseBinary.Items[0].Selected = m_Feed.UseBinary;
				UseBinary.Items[1].Selected = !m_Feed.UseBinary;
				UseSFTP.Items[0].Selected = m_Feed.UseSFTP;
				UseSFTP.Items[1].Selected = !m_Feed.UseSFTP;
				FTPFilenameDateStampFormatPreview.Text = (m_Feed.UseFTPFilenameDateStamp && !String.IsNullOrEmpty(m_Feed.FTPFilename)) ? "&nbsp;"+m_Feed.DestinationFileName() : String.Empty;
			}
			else
			{
				btnExecFeed_Top.Visible =
					btnExecFeed_Bottom.Visible = false;
			}
		}

		protected void btnCancel_OnClick(object sender, EventArgs e)
		{
			Response.Redirect("Feeds.aspx");
		}

		protected void btnSubmit_OnClick(object sender, EventArgs e)
		{
			Page.Validate();
			if(Page.IsValid)
			{
				if(m_Feed != null)
				{
					string result = UpdateFeed();
					if(!String.IsNullOrWhiteSpace(result))
						AlertMessage.PushAlertMessage(result, AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
					else
						AlertMessage.PushAlertMessage("Feed has been updated.", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
				}
				else
				{
					String FTPPort = txtFtpPort.Text.Trim();
					if(FTPPort.Length == 0)
					{
						FTPPort = "21";
					}

					m_Feed = m_FeedMgr.CreateFeed(txtFeedName.Text,
						1,
						XmlPackage.SelectedValue,
						(CanAutoFtp.SelectedValue == "1"),
						(RequiresClassification.SelectedValue == "1"),
						txtFtpUserName.Text,
						txtFtpPwd.Text,
						txtFtpServer.Text,
						Convert.ToInt32(FTPPort),
						txtFtpFileName.Text,
						(UseFtpFileNameDateStamp.SelectedValue == "1"),
						FTPFilenameDateStampFormat.Text.Trim(),
						(UsePassive.SelectedValue == "1"),
						(UseBinary.SelectedValue == "1"),
						(UseSFTP.SelectedValue == "1"),
						"");

					FeedID = m_Feed.FeedID;
				}
			}
			else
			{
				resetError("Errors occured " + CommonLogic.IIF(m_Feed == null, "creating", "updating") + " the feed", true);
			}

			InitializePageData();
		}

		protected void btnExecFeed_OnClick(object sender, EventArgs e)
		{
			ExecuteFeed();
		}

		private void ExecuteFeed()
		{
			Server.ScriptTimeout = 120;
			if(txtFtpServer.Text.Trim().Length == 0 && m_Feed.CanAutoFTP)
			{
				AlertMessage.PushAlertMessage("No ftp server specified", AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}
			else if(txtFtpFileName.Text.Trim().Length == 0 && m_Feed.CanAutoFTP)
			{
				AlertMessage.PushAlertMessage("No remote filename specified", AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}
			else
			{
				Customer ThisCustomer = ((AspDotNetStorefrontPrincipal)Context.User).ThisCustomer;
				String RuntimeParams = String.Empty;
				RuntimeParams += String.Format("SID={0}&", cboStore.SelectedValue);
				UpdateFeed();
				resetError(EXT.FeedManagerExt.ExecuteFeed(m_Feed, ThisCustomer, RuntimeParams), false);
			}

			InitializePageData();
		}
		
		private string UpdateFeed()
		{
			String FTPPort = txtFtpPort.Text.Trim();
			String errorResponse = String.Empty;
			if(FTPPort.Length == 0)
			{
				FTPPort = "21";
			}

			//TODO - Add support for StoreID: Convert.ToInt32(cboStore.SelectedValue),
			errorResponse = m_FeedMgr.UpdateFeed(txtFeedName.Text,
                                   -1,
                                   XmlPackage.SelectedValue,
                                   Convert.ToSByte(CanAutoFtp.SelectedValue),
								   Convert.ToSByte(RequiresClassification.SelectedValue),
                                   txtFtpUserName.Text,
                                   txtFtpPwd.Text,
                                   txtFtpServer.Text,
                                   Convert.ToInt32(FTPPort),
                                   txtFtpFileName.Text.Trim(),
								   Convert.ToSByte(UseFtpFileNameDateStamp.SelectedValue),
								   FTPFilenameDateStampFormat.Text.Trim(),
								   Convert.ToSByte(UsePassive.SelectedValue),
								   Convert.ToSByte(UseBinary.SelectedValue),
								   Convert.ToSByte(UseSFTP.SelectedValue),
								   "", 
								   m_Feed);
			m_Feed = m_FeedMgr.LoadFeed(m_Feed.FeedID);
			return errorResponse;
		}

		protected void ValidateXmlPackage(object source, ServerValidateEventArgs args)
		{
			args.IsValid = (XmlPackage.SelectedIndex > 0);
		}

		protected void ValidateStoreID(object source, ServerValidateEventArgs args)
		{
			args.IsValid = (cboStore.SelectedIndex > 0);
		}

		protected void ValidatePort(object source, ServerValidateEventArgs args)
		{
			string port = txtFtpPort.Text.Trim();
			if(port.Length > 0)
			{
				args.IsValid = (CommonLogic.IsInteger(port));
			}
			else
			{
				args.IsValid = true;
			}
		}

		protected void ValidateServer(object source, ServerValidateEventArgs args)
		{
			if(CanAutoFtp.Items[0].Selected && txtFtpServer.Text.Trim() == "")
			{
				args.IsValid = false;
			}
			else
			{
				args.IsValid = true;
			}
		}
		
		protected void resetError(string message, bool isError)
        {
            if (message.Length > 0)
            {
                if (isError)
                {
                    string errorMessage = String.Format("<font class=\"noticeMsg\">{0}</font>", message);
					AlertMessage.PushAlertMessage(errorMessage, AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				}
                else
                {
                    string successMessage = String.Format("<font class=\"noticeMsg\">{0}</font>", message);
					AlertMessage.PushAlertMessage(successMessage, AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
				}
            }
        }
	}
}
