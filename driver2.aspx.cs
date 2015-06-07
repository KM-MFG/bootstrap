// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefront
{

	// this provides a topic page that is NOT rendered inside the skin. The topic page itself should also contain the full <html>, not just the body.
	[PageType("topic")]
	public partial class driver2 : System.Web.UI.Page
	{
		Customer ThisCustomer;
		Topic m_T;

		protected void Page_Load(object sender, EventArgs e)
		{
			// set the Customer context, and set the SkinBase context, so meta tags will be set if they are not blank in the Topic results
			ThisCustomer = ((AspDotNetStorefrontPrincipal)Context.User).ThisCustomer;

			String PN = CommonLogic.QueryStringCanBeDangerousContent("TopicName");
			if(PN.Length == 0)
			{
				PN = CommonLogic.QueryStringCanBeDangerousContent("Topic");
			}

			AppLogic.CheckForScriptTag(PN);

			m_T = new Topic(PN, ThisCustomer.LocaleSetting, ThisCustomer.SkinID, null, AppLogic.StoreID());

			TopicContents.Text += m_T.ContentsRAW;

			if(CommonLogic.FormCanBeDangerousContent("Password").Length != 0)
			{
				ThisCustomer.ThisCustomerSession["Topic" + PN] = Security.MungeString(CommonLogic.FormCanBeDangerousContent("Password"));
			}
		}
	}
}
