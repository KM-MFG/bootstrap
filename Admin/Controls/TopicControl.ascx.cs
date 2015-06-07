// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Data;
using System.Text;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefront
{

    public partial class TopicControl : System.Web.UI.UserControl
    {
        private String m_TopicName = String.Empty;
        private int m_TopicID = 0;
        private String m_RuntimeParams = String.Empty;
        private Topic m_T = null;

        // these are set to false, to make "most" page control invocations shorter to create (as "most" instances don't care about these!)
        private bool m_EnforcePassword = false;
        private bool m_EnforceDisclaimer = false;
        private bool m_AllowSEPropogation = false;

        private int m_SkinID = 1;
        private String m_LocaleSetting = String.Empty;

        private SkinBase m_SkinBase = null; // if not null, this control will set the page metatags to the results from the Topic, IF those Topic results are not "empty strings"

        protected void Page_Load(object sender, EventArgs e)
        {
            m_SkinBase = (SkinBase)this.Page;
            try
            {
                if (m_SkinBase != null)
                {
                    if (TopicID != 0)
                    {
                        m_T = new Topic(TopicID, m_SkinBase.ThisCustomer.LocaleSetting, m_SkinBase.ThisCustomer.SkinID, m_SkinBase.GetParser);
                    }
                    else
                    {
                        m_T = new Topic(TopicName, m_SkinBase.ThisCustomer.LocaleSetting, m_SkinBase.ThisCustomer.SkinID, m_SkinBase.GetParser);
                    }
                    m_SkinID = m_SkinBase.ThisCustomer.SkinID;
                    m_LocaleSetting = m_SkinBase.ThisCustomer.LocaleSetting;
                }
                else
                {
                    m_LocaleSetting = Localization.GetDefaultLocale();
                    if (TopicID != 0)
                    {
                        m_T = new Topic(TopicID, m_LocaleSetting, m_SkinID, null);
                    }
                    else
                    {
                        m_T = new Topic(TopicName, m_LocaleSetting, m_SkinID, null);
                    }
                }
                StringBuilder tmpS = new StringBuilder(4096);

                String xpdd = m_SkinBase.ThisCustomer.ThisCustomerSession["Topic" + XmlCommon.GetLocaleEntry(m_T.TopicName, m_SkinBase.ThisCustomer.LocaleSetting, true)];
                if (xpdd.Length != 0)
                {
                    // don't let decrypt failure crash, just set xpdd to string.empty so it fails.
                    try
                    {
                        xpdd = Security.UnmungeString(xpdd);
                    }
                    catch
                    {
                        xpdd = String.Empty; // some kind of decrypt failure, deny access, not sure what else to do here.
                    }
                }
                if (EnforcePassword && m_T.Password.Length != 0 && xpdd != m_T.Password)
                {
                    String Url = String.Empty;
                    if (CommonLogic.GetThisPageName(false).Equals("driver.aspx", StringComparison.InvariantCultureIgnoreCase))
                    {
                        Url = SE.MakeDriverLink(XmlCommon.GetLocaleEntry(m_T.TopicName, m_SkinBase.ThisCustomer.LocaleSetting, true));
                    }
                    else
                    {
                        Url = SE.MakeDriver2Link(XmlCommon.GetLocaleEntry(m_T.TopicName, m_SkinBase.ThisCustomer.LocaleSetting, true));
                    }
                    tmpS.Append("<form method=\"POST\" action=\"" + Url + "\">\n");
                    tmpS.Append("<p><b>");
                    tmpS.Append(AppLogic.GetString("driver.aspx.1", m_SkinID, m_LocaleSetting));
                    tmpS.Append("</b></p>\n");
                    tmpS.Append("<p>");
                    tmpS.Append(AppLogic.GetString("driver.aspx.2", m_SkinID, m_LocaleSetting));
                    tmpS.Append(" <input type=\"text\" name=\"Password\" size=\"20\" maxlength=\"100\"><input type=\"submit\" value=\"");
                    tmpS.Append(AppLogic.GetString("driver.aspx.5", m_SkinID, m_LocaleSetting));
                    tmpS.Append("\" name=\"B1\"></p>\n");
                    tmpS.Append("</form>\n");
                    m_SkinBase.ThisCustomer.RequireCustomerRecord();
                }
                else
                {
                    if (EnforceDisclaimer && m_T.RequiresDisclaimer && CommonLogic.CookieCanBeDangerousContent("SiteDisclaimerAccepted", true).Length == 0)
                    {
                        String ThisPageURL = CommonLogic.GetThisPageName(true) + "?" + CommonLogic.ServerVariables("QUERY_STRING");
                        Response.Redirect("disclaimer.aspx?returnURL=" + HttpContext.Current.Server.UrlEncode(ThisPageURL));
                    }

                    tmpS.Append("<!-- READ FROM ");
                    tmpS.Append(CommonLogic.IIF(m_T.FromDB, "DB", "FILE"));
                    tmpS.Append(" -->");
                    tmpS.Append(m_T.Contents);
                    tmpS.Append("<!-- END OF ");
                    tmpS.Append(CommonLogic.IIF(m_T.FromDB, "DB", "FILE"));
                    tmpS.Append(" -->");
                }
                Contents.Text = tmpS.ToString();
            }
            catch (Exception ex)
            {
                Contents.Text = CommonLogic.GetExceptionDetail(ex, "<br/>");
            }
            if (m_SkinBase != null && m_AllowSEPropogation && m_T != null)
            {
                if (m_T.SectionTitle.Length != 0)
                {
                    m_SkinBase.SectionTitle = m_T.SectionTitle;
                }
                if (m_T.SETitle.Length != 0)
                {
                    m_SkinBase.SETitle = m_T.SETitle;
                }
                if (m_T.SEKeywords.Length != 0)
                {
                    m_SkinBase.SEKeywords = m_T.SEKeywords;
                }
                if (m_T.SEDescription.Length != 0)
                {
                    m_SkinBase.SEDescription = m_T.SEDescription;
                }
            }
        }

        public String TopicName
        {
            get
            {
                return m_TopicName;
            }
            set
            {
                m_TopicName = value;
            }
        }

        public int TopicID
        {
            get
            {
                return m_TopicID;
            }
            set
            {
                m_TopicID = value;
            }
        }

        public String RuntimeParams
        {
            get
            {
                return m_RuntimeParams;
            }
            set
            {
                m_RuntimeParams = value;
            }
        }

        public String SectionTitle
        {
            get
            {
                return m_T.SectionTitle;
            }
        }

        public String Password
        {
            get
            {
                return m_T.Password;
            }
        }

        public bool RequiresDisclaimer
        {
            get
            {
                return m_T.RequiresDisclaimer;
            }
        }

        public String SETitle
        {
            get
            {
                return m_T.SETitle;
            }
        }

        public String SEKeywords
        {
            get
            {
                return m_T.SEKeywords;
            }
        }

        public String SEDescription
        {
            get
            {
                return m_T.SEDescription;
            }
        }

        public bool EnforcePassword
        {
            get
            {
                return m_EnforcePassword;
            }
            set
            {
                m_EnforcePassword = value;
            }
        }

        public bool EnforceDisclaimer
        {
            get
            {
                return m_EnforceDisclaimer;
            }
            set
            {
                m_EnforceDisclaimer = value;
            }
        }

        public bool AllowSEPropogation
        {
            get
            {
                return m_AllowSEPropogation;
            }
            set
            {
                m_AllowSEPropogation = value;
            }
        }


    }

}
