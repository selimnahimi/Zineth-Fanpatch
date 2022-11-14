using System.Net;
using System.IO;

namespace NETModule
{
    public class HTTPSModule
    {
        public static string SendRequest(string url, string method, string headers=null)
        {
            System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;

            var webRequest = (HttpWebRequest)WebRequest.Create(url);
            webRequest.Method = method;
            if (headers != null)
            {
                webRequest.Headers["Authorization"] = headers;
            }
            var webResponse = (HttpWebResponse)webRequest.GetResponse();
            var webResponseStr = new StreamReader(webResponse.GetResponseStream()).ReadToEnd();

            return webResponseStr;
        }
    }
}
