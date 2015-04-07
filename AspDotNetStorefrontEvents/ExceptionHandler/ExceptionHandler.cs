// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using AspDotNetStorefrontCore;
using AspDotNetStorefrontEventHandlers.ExceptionHandlers.Formatters;
using AspDotNetStorefrontEventHandlers.ExceptionHandlers.Publishers;
using System;
using System.Collections.Generic;
using System.Web;

namespace AspDotNetStorefrontEventHandlers.ExceptionHandlers
{

	public static class ExceptionHandler
	{

		public static void Handle(Exception ex)
		{
			// make sure this is a server error before proceeding
			if (ex is HttpException)
				if (((HttpException)ex).GetHttpCode() != 500)
					return;

			// Make sure the exception is not being thrown on InvalidRequest.aspx to prevent loops
			try
			{
				if (CommonLogic.GetThisPageName(false).IndexOf("invalidrequest.aspx", StringComparison.InvariantCultureIgnoreCase) != -1)
					return;
			}
			catch
			{
				return;
			}

			string errorCode = Guid.NewGuid().ToString("N").Substring(0, 7).ToUpper();

			if (AppLogic.AppConfigBool("System.LoggingEnabled"))
			{
				string configuredPublishers = AppLogic.AppConfig("System.LoggingLocation");

				if (CommonLogic.IsStringNullOrEmpty(configuredPublishers)) return;

				bool publishInFile = CommonLogic.StringInCommaDelimitedStringList("file", configuredPublishers);
				bool publishInEmail = CommonLogic.StringInCommaDelimitedStringList("email", configuredPublishers);
				bool publishInEventLog = CommonLogic.StringInCommaDelimitedStringList("eventLog", configuredPublishers);
				bool publishInDatabase = CommonLogic.StringInCommaDelimitedStringList("database", configuredPublishers);

				if ((publishInFile || publishInEmail || publishInEventLog || publishInDatabase) == false) return;

				// generate a new error code for reference

				IErrorFormatter formatter = new TextErrorFormatter();
				formatter.Prepare(errorCode, ex);

				List<IExceptionPublisher> publishers = new List<IExceptionPublisher>();

				if (publishInFile)
				{
					publishers.Add(new FileBasedExceptionPublisher());
				}
				if (publishInEmail)
				{
					publishers.Add(new EmailExceptionPublisher());
				}
				if (publishInEventLog)
				{
					publishers.Add(new EventLogExceptionPublisher());
				}

				// if an error occurs be silent about it
				// since these are the ones supposed to send the notification!
				foreach (IExceptionPublisher publisher in publishers)
				{
					try
					{
						publisher.Publish(errorCode, formatter.Error);
					}
					catch { }
				}

				if (publishInDatabase)
				{
					SysLog.LogException(ex, MessageTypeEnum.GeneralException, MessageSeverityEnum.Error);
				}
			}

		}
	}
}
