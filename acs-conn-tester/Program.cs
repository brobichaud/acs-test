using System;
using System.Threading;

namespace ConnectivityTester
{
	class Program
	{
		static void Main(string[] args)
		{
			var time = DateTime.UtcNow;

			Console.WriteLine($"ACS Connectivity Tester started @ {time}");
			Console.WriteLine("Press Ctrl-C to exit");

			var tester = new Tester();
			tester.Start();

			var token = new CancellationTokenSource();
			Console.CancelKeyPress += (s, e) =>
			{
				e.Cancel = true;
				token.Cancel();
			};

			while (!token.IsCancellationRequested)
			{
				Thread.Sleep(100);
			}

			tester.Stop();
		}
	}
}
