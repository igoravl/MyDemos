using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.ApplicationInsights;
using Microsoft.ApplicationInsights.DataContracts;
using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.ApplicationInsights.Metrics;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            const string instrumentationKey = "** INSTRUMENTATION KEY HERE **";
            const string metricNamespace = "MyNamespace";
            const string metricName = "Delayed processes";
            const int iterations = 100;
            const int delay = 2000;

            const string dim1Name = "Customer";
            var dim1Values = new[] { "Cust_ACME", "Cust_XPTO" };

            const string dim2Name = "Delay";
            var dim2Values = new[] { "01 min", "03 min", "05 min", "> 05 min" };


            var configuration = TelemetryConfiguration.CreateDefault();
            configuration.InstrumentationKey = instrumentationKey;
            MetricIdentifier.DefaultMetricNamespace = metricNamespace;

            configuration.TelemetryChannel.DeveloperMode = true;

            var client = new TelemetryClient(configuration);

            for (var i = 0; i < iterations; i++)
            {
                for (var j = 0; j < dim1Values.Length; j++)
                {
                    for (var k = 0; k < dim2Values.Length; k++)
                    {
                        client.TrackMetric(new MetricTelemetry(metricName, (j + 1) * 10)
                        {
                            MetricNamespace = metricNamespace,
                            Properties = { { dim1Name, dim1Values[j] }, { dim2Name, dim2Values[k] } }
                        });
                    }
                }

                Task.Delay(delay).Wait();
                client.Flush();
            }
        }
    }
}
