// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Linq;
using System.Net.Http;
using AspDotNetStorefrontCore;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace AspDotNetStorefrontAdmin
{
	public partial class dotfeedadmincloudconnector : AdminPageBase
	{
		protected void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				var dotFeedBaseUri = AppLogic.AppConfig("DotFeed.Connect.ApiUri");
				if(string.IsNullOrEmpty(dotFeedBaseUri))
				{
					ShowDisconnectedState();
					return;
				}

				var client = new HttpClient();
				var response = client.GetAsync(new Uri(new Uri(dotFeedBaseUri), "1/component/cloudconnector")).Result;
				if(!response.IsSuccessStatusCode)
				{
					ShowDisconnectedState();
					return;
				}

				var storeUrl = string.Format("{0}://{1}",
					Request.Url.Scheme,
					AppLogic.GetAdminHTTPLocation(true)
						.Replace("http://", "")
						.Replace("https://", ""));

				DotFeedBaseUrl.Value = new Uri(new Uri(dotFeedBaseUri), "1/").ToString();
				AdnsfBaseUrl.Value = new Uri(new Uri(storeUrl), "api/1/").ToString();

				var content = response.Content.ReadAsStringAsync().Result;
				CloudConnectorContainer.Text = content;
				ShowConnectedState();
			}
			catch(Exception exception)
			{
				SysLog.LogException(exception, MessageTypeEnum.GeneralException, MessageSeverityEnum.Error);
				ShowDisconnectedState();
			}
		}

		void ShowConnectedState()
		{
			CloudConnectorContainer.Visible = true;
		}

		void ShowDisconnectedState()
		{
			Disconnected.Visible = true;
		}
	}
}
