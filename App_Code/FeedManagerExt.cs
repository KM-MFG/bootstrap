using System;
using System.IO;
using System.Text;
using System.Threading;
using System.Web;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;
using AspDotNetStorefrontCore;
using log4net;

namespace Moco.AspDNSF.Extension
{
	public class FeedManagerExt
	{
		private static readonly ILog log = LogManager.GetLogger(typeof(FeedManagerExt));

		public static String ExecuteFeed(Feed f, Customer ThisCustomer)
		{
			return ExecuteFeed(f, ThisCustomer, String.Empty);
		}

		public static string ExecuteFeed(Feed f, Customer ThisCustomer, String RuntimeParams)
		{
			string folderpath = CommonLogic.IIF(AppLogic.IsAdminSite, CommonLogic.SafeMapPath("../images/"), CommonLogic.SafeMapPath("images/"));
			string retval = string.Empty;
			try
			{
				string filename = folderpath + f.XmlPackage + "_" + Guid.NewGuid().ToString() + ".txt";

				//BEGIN MoCo-MJM 2009/12/09
				//  Perform XSLT Feed using disk(FileStream) instead of MemoryStream
				string inputFileName = folderpath + f.XmlPackage + "_" + Guid.NewGuid().ToString() + ".xml";

				//Setup destination filestream
				using(FileStream outputFileStream = new FileStream(filename, FileMode.Create))
				{
					//Setup temporary XMLData filestream
					using(FileStream xmlInputFileStream = new FileStream(inputFileName, FileMode.Create))
					{
						String runTimeQuery = String.Empty;
						String runTimeParameters = String.Format("FileName={0}", f.DestinationFileName());
						FeedManagerExt.RunXmlPackageToDocument(f.XmlPackage, null, ThisCustomer, 1, runTimeQuery, runTimeParameters, false, false, xmlInputFileStream, outputFileStream);
						xmlInputFileStream.Close();
					}
					File.Delete(inputFileName);

					outputFileStream.Close();
				}

				//Read first 16bytes looking for "Exception="
				string feeddocument = String.Empty;
				using(FileStream fs = File.OpenRead(filename))
				{
					char[] buffer = new char[16];
					if(fs.CanRead)
					{
						StreamReader reader = new StreamReader(fs);
						reader.Read(buffer, 0, 16);
						feeddocument = new string(buffer);
					}
					fs.Close();
				}
				//                string feeddocument = AppLogic.RunXmlPackage(this.XmlPackage, null, ThisCustomer, 1, "", "", false, false);
				//                feeddocument = feeddocument.Replace("encoding=\"utf-16\"", "");
				//                using (StreamWriter sw = new StreamWriter(filename, false))
				//                {					
				//                    sw.Write(feeddocument);
				//                    sw.Close();
				//                }
				//END MoCo-MJM 2009/12/09
				bool feedDocumentContainsException = feeddocument.Contains("Exception=");

				if(f.CanAutoFTP && !feedDocumentContainsException)
				{
					bool usePassive = f.UsePassive;
					if(AppLogic.AppConfig("UsePassiveFtpConnection") == "true"
							&& AppLogic.AppConfig("UsePassiveFtpConnection") != null)
					{
						usePassive = true;
					}

					IFtpClient ftp = FtpManager.GetClient(f.FTPServer, f.FTPPort, f.FTPUsername, f.FTPPassword, usePassive, f.UseBinary, f.UseSFTP);

					retval = ftp.Upload(filename, f.DestinationFileName());

					if (retval.IndexOf("Successfully") < 0)
					{
						if (log.IsErrorEnabled)
						{
							log.ErrorFormat("Error Uploading feed [{0}]{1}{2}", f.Name, Environment.NewLine, retval);
						}
					}
					else
					{
						FileInfo fInfo = new FileInfo(filename);
						if (fInfo.Exists)
						{
							fInfo.Delete();
						}
					}
					
				}
				else
				{
					if(feedDocumentContainsException && log.IsErrorEnabled)
					{
						log.ErrorFormat("Feed [{0}] did not transform successfully", f.Name);
					}

					if(File.Exists(folderpath + f.DestinationFileName())) File.Delete(folderpath + f.DestinationFileName());
					FileInfo fInfo = new FileInfo(filename);
					fInfo.MoveTo(folderpath + f.DestinationFileName());
					retval = "The file " + f.DestinationFileName() + " has been created in the /images folder of your website";
				}
			}
			catch(Exception ex)
			{
				if(log.IsErrorEnabled)
				{
					log.Error("Error during ExecuteFeed", ex);
				}

				retval = ex.Message;
			}

			return retval;
		}

		#region
		static private void LogXMLPackageError(Exception ex, String XmlPackageName)
		{
			String body = String.Format("Error running package {0} \n caught the following exception \n {1} \n {2} \n {3}", XmlPackageName, ex.Message, ex.StackTrace, ex.InnerException);

			if(log.IsErrorEnabled)
			{
				log.Error(String.Format("Error running package {0}", XmlPackageName), ex);
			}
			
			SysLog.LogException(ex, MessageTypeEnum.XmlPackageException, MessageSeverityEnum.Error);

			AppLogic.SendMail("XMLPackage Error", body, true);
		}

		//BEGIN MoCo-MJM 2009/12/09
		//  Perform XSLT Feed using disk(FileStream) instead of MemoryStream
		static public String RunXmlPackageToDocument(String XmlPackageName, Parser UseParser, Customer ThisCustomer, int SkinID, String RunTimeQuery, String RunTimeParms, bool ReplaceTokens, bool WriteExceptionMessage, Stream xmlInputDataStream, Stream outputStream)
		{
			try
			{
				String pn = XmlPackageName.ToLowerInvariant();
				if(!pn.EndsWith(".xml.config", StringComparison.InvariantCultureIgnoreCase))
				{
					pn += ".xml.config";
				}

				int feedScriptTimeout = 0;
				feedScriptTimeout = AppLogic.AppConfigUSInt("Feed.ScriptTimeout");
				if(feedScriptTimeout > 0 && feedScriptTimeout > HttpContext.Current.Server.ScriptTimeout)
				{
					HttpContext.Current.Server.ScriptTimeout = feedScriptTimeout;
				}

				XmlPackage2 p = new XmlPackage2(XmlPackageName, ThisCustomer, SkinID, RunTimeQuery, RunTimeParms);
				return RunXmlPackageToDocument(p, UseParser, ThisCustomer, SkinID, ReplaceTokens, WriteExceptionMessage, xmlInputDataStream, outputStream);
			}
			catch(Exception ex)
			{
				LogXMLPackageError(ex, XmlPackageName);

				return CommonLogic.GetExceptionDetail(ex, "<br/>");
			}
		}

		static public String RunXmlPackageToDocument(XmlPackage2 p, Parser UseParser, Customer ThisCustomer, int SkinID, bool ReplaceTokens, bool WriteExceptionMessage, Stream xmlInputDataStream, Stream outputStream)
		{
			StringBuilder tmpS = new StringBuilder();
			try
			{
				if(p != null)
				{
					String XmlPackageName = p.Name;
					if(CommonLogic.ApplicationBool("DumpSQL"))
					{
						tmpS.Append("<p><b>XmlPackage: " + XmlPackageName + "</b></p>");
					}
					try
					{

						//Flush p.xmlDataDocument to file and free up memory

						/* May need to reenable for UTF8 BOM when UTF8 is specified
						XmlWriterSettings settings = new XmlWriterSettings();
						settings.CheckCharacters = false;
						settings.Encoding = new UTF8Encoding(false, false);
						settings.Indent = false;
						settings.NewLineHandling = NewLineHandling.None;
                        
						using (XmlWriter writer = XmlWriter.Create(xmlInputDataStream, settings))
						*/

						try
						{
							using(XmlWriter writer = XmlWriter.Create(xmlInputDataStream))
							{
								p.XmlDataDocument.WriteTo(writer);
								writer.Close();
							}

							p.XmlDataDocument.RemoveAll();
							xmlInputDataStream.Position = 0;

							System.Xml.XPath.XPathDocument DataDocument = new System.Xml.XPath.XPathDocument(xmlInputDataStream);
							System.Xml.XPath.XPathNavigator DataDocumentNavigator = DataDocument.CreateNavigator();
							//p.TransformToDocument(DataDocumentNavigator, outputStream);

							TransformToDocument(p.Transform, p.TransformArgumentList, true, DataDocumentNavigator, outputStream);
						}
						finally
						{

						}


						//TODO - add TokenReplace support
						String s = string.Empty;//p.TransformString();
						if(ReplaceTokens && (p.RequiresParser || p.Version < 2.1M))
						{
							if(UseParser == null)
							{
								UseParser = new Parser(SkinID, ThisCustomer);
							}

							tmpS.Append(UseParser.ReplaceTokens(s));
							throw new NotImplementedException("ReplaceTokens Not Implemented");
						}
						else
						{
							tmpS.Append(s);
						}

					}
					catch(ThreadAbortException taex)
					{
						LogXMLPackageError(taex, p.Name + HttpContext.Current.Server.ScriptTimeout.ToString());
						tmpS.Append("XmlPackage Exception: " + CommonLogic.GetExceptionDetail(taex, "<br/>") + taex.ToString() + "<br />");
					}
					catch(Exception ex)
					{
						LogXMLPackageError(ex, p.Name);
						tmpS.Append("XmlPackage Exception: " + CommonLogic.GetExceptionDetail(ex, "<br/>") + ex.ToString() + "<br />");
					}
					if(AppLogic.AppConfigBool("XmlPackage.DumpTransform") || p.IsDebug)
					{
						tmpS.Append("<div>");
						tmpS.Append("<br/><b>" + p.URL + "<br/>");
						tmpS.Append("<textarea READONLY cols=\"80\" rows=\"50\">" + XmlCommon.XmlEncode(XmlCommon.PrettyPrintXml(p.PackageDocument.InnerXml)) + "</textarea>");
						tmpS.Append("</div>");

						tmpS.Append("<div>");
						tmpS.Append("<br/><b>" + XmlPackageName + "_store.runtime.xml<br/>");
						tmpS.Append("<textarea READONLY cols=\"80\" rows=\"50\">" + XmlCommon.XmlEncode(CommonLogic.ReadFile(CommonLogic.IIF(AppLogic.IsAdminSite, "../", String.Empty) + "images/" + XmlPackageName + "_" + CommonLogic.IIF(AppLogic.IsAdminSite, "admin", "store") + ".runtime.xml", true)) + "</textarea>");
						tmpS.Append("</div>");

						tmpS.Append("<div>");
						tmpS.Append("<br/><b>" + XmlPackageName + "_store.runtime.sql<br/>");
						tmpS.Append("<textarea READONLY cols=\"80\" rows=\"50\">" + XmlCommon.XmlEncode(CommonLogic.ReadFile(CommonLogic.IIF(AppLogic.IsAdminSite, "../", String.Empty) + "images/" + XmlPackageName + "_" + CommonLogic.IIF(AppLogic.IsAdminSite, "admin", "store") + ".runtime.sql", true)) + "</textarea>");
						tmpS.Append("</div>");

						//tmpS.Append("<div>");
						//tmpS.Append("<br/><b>" + XmlPackageName + "_store.xml<br/>");
						//tmpS.Append("<textarea READONLY cols=\"80\" rows=\"50\">" + XmlCommon.XmlEncode(CommonLogic.ReadFile(CommonLogic.IIF(AppLogic.IsAdminSite,"../",String.Empty) + "images/" + XmlPackageName + "_" + CommonLogic.IIF(AppLogic.IsAdminSite,"admin","store") + ".xml",true)) + "</textarea>");
						//tmpS.Append("</div>");

						tmpS.Append("<div>");
						tmpS.Append("<br/><b>" + XmlPackageName + "_store.xfrm.xml<br/>");
						tmpS.Append("<textarea READONLY cols=\"80\" rows=\"50\">" + XmlCommon.XmlEncode(CommonLogic.ReadFile(CommonLogic.IIF(AppLogic.IsAdminSite, "../", String.Empty) + "images/" + XmlPackageName + "_" + CommonLogic.IIF(AppLogic.IsAdminSite, "admin", "store") + ".xfrm.xml", true)) + "</textarea>");
						tmpS.Append("</div>");
					}
				}
				else
				{
					tmpS.Append("XmlPackage2 parameter is null");
				}
			}
			catch(Exception ex)
			{
				LogXMLPackageError(ex, p.Name);
				tmpS.Append(CommonLogic.GetExceptionDetail(ex, "<br/> s"));
			}
			return tmpS.ToString();
		}
		//END MoCo-MJM 2009/12/09

		//BEGIN MoCo-MJM 2009/12/09
		//  Perform XSLT Feed using disk(FileStream) instead of MemoryStream
		static public void TransformToDocument(XslCompiledTransform m_Transform, XsltArgumentList m_TransformArgumentList, bool HasASPDNSFNameSpace, XPathNavigator DataDocumentNavigator, Stream outputStream)
		{
			Encoding e = m_Transform.OutputSettings.Encoding;
			if(e.Equals(new UTF8Encoding(true)))
				e = new UTF8Encoding(false);
			StreamWriter writer = new StreamWriter(outputStream, e);

			if(HasASPDNSFNameSpace)
				m_Transform.Transform(DataDocumentNavigator, m_TransformArgumentList, writer);
			else
				m_Transform.Transform(DataDocumentNavigator, null, writer);

		}
		//END MoCo-MJM 2009/12/09
		#endregion
	}
}
