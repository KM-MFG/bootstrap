// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;

namespace AspDotNetStorefrontControls
{
	public partial class ManualSearch : System.Web.UI.UserControl
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		/// <summary>
        /// Handles search functionality within the admin page header
        /// </summary>
        protected void search_OnClick(object sender, EventArgs e)
        {
			string searchTerm = txtManualSearch.Text.Trim();

			if(searchTerm.Length > 0)
				Page.ClientScript.RegisterStartupScript(GetType(),
					"openwindow",
					String.Format("<script type=text/javascript> window.open('http://help.aspdotnetstorefront.com/manual/95/default.aspx?pageid=_search_&searchtext={0}'); </script>", searchTerm));
			else
				Page.ClientScript.RegisterStartupScript(GetType(),
					"openwindow",
					"<script type=text/javascript> window.open('http://help.aspdotnetstorefront.com/manual/95/default.aspx?pageid=welcome'); </script>");

			txtManualSearch.Text = string.Empty;
        }
	}
}
