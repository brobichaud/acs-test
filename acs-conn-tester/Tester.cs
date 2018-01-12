using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Azure.Documents.Client;
using Newtonsoft.Json;

namespace ConnectivityTester
{
	public class Tester
	{
		// these are free throwaway accounts, replace with your own as needed
		string logglyEndpoint = "http://logs-01.loggly.com/inputs/d5bdf925-a0ac-4508-a5e3-2a9f0c8f691a/tag/http/";
		string cosmosEndpoint = "https://a8c3b57a-0ee0-4-231-b9ee.documents.azure.com:443/";
		string cosmosKey = "0kRT3Mw4rJtoPPRLF3g3U1rUfb5Ia3cZPreqU6uy4zW6I6gxFXNou00xDRSTL51nUjNupFP81mPMhoRlr7vnjw==";
		
		private Timer _timer;
		private int _intervalMs = 10 * 1000;
		private static readonly ManualResetEvent _timerIdle = new ManualResetEvent(true);

		public Tester()
		{
		}

		public void Start()
		{
			_timer = new Timer(PerformCheck, null, 5000, _intervalMs);
		}

		public void Stop()
		{
			_timer.Change(Timeout.Infinite, Timeout.Infinite);
			_timer.Dispose();
			_timer = null;
		}

		void PerformCheck(object sender)
		{
			if (!_timerIdle.WaitOne(0))
				return;

			try
			{
				_timerIdle.Reset();

				CheckLoggly().Wait();
				CheckGoogle().Wait();
				CheckCosmos().Wait();
			}
			finally
			{
				_timerIdle.Set();
			}
		}

		async Task CheckLoggly()
		{
			Console.Write($"{DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")} Checking loggly...");

			var items = new Dictionary<string, string>
				{
					{"timestamp", DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffffffZ")},
					{"source", "acs-conn-test"},
					{"deployment", "dev-fossil"},
					{"level", "INFO"},
					{"thread", Thread.CurrentThread.ManagedThreadId.ToString()},
					{"hostname", Environment.GetEnvironmentVariable("COMPUTERNAME")},
					{"environment", "dev"},
					{"event", "Testing connectivity"},
				};

			try
			{
				var json = JsonConvert.SerializeObject(items, Formatting.None);
				var content = new StringContent(json, Encoding.UTF8, "text/plain");

				using (var client = new HttpClient())
				{
					var httpResponseMessage = await client.PostAsync(logglyEndpoint, content);
				}

				Console.WriteLine("Success!");
			}
			catch (Exception e)
			{
				var error = $"{DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")} Error checking loggly:\n{e.Message}\n{e.InnerException?.Message}\n";
				Console.WriteLine(error);
				LogFile(error);
			}
		}

		async Task CheckCosmos()
		{
			Console.Write($"{DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")} Checking cosmos...");
			DocumentClient client;

			try
			{
				using (client = new DocumentClient(new Uri(cosmosEndpoint), cosmosKey))
				{
					var databases = await client.ReadDatabaseFeedAsync();
					//foreach (var db in databases)
					//	Console.WriteLine(db);
				}

				Console.WriteLine("Success!");
			}
			catch (Exception e)
			{
				var error = $"{DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")} Error checking cosmos:\n{e.Message}\n{e.InnerException?.Message}\n";
				Console.WriteLine(error);
				LogFile(error);
			}
		}

		async Task CheckGoogle()
		{
			Console.Write($"{DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")} Checking google...");

			try
			{
				using (HttpClient client = new HttpClient())
				{
					var response = await client.GetAsync("https://www.google.com");
					if (response.IsSuccessStatusCode)
						Console.WriteLine("Success!");
					else
						Console.WriteLine("Unknown result!");
				}
			}
			catch (Exception e)
			{
				var error = $"{DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")} Error checking google:\n{e.Message}\n{e.InnerException?.Message}\n";
				Console.WriteLine(error);
				LogFile(error);
			}
		}

		void LogFile(string message)
		{
			File.AppendAllText("error.log", message);
		}
	}
}
