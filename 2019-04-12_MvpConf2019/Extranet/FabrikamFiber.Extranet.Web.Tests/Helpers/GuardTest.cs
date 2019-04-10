namespace FabrikamFiber.Extranet.Web.Tests.Helpers
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using NUnit.Framework;
    using FabrikamFiber.Extranet.Web.Helpers;
    using Xunit;

    [TestFixture]
    public class GuardTest
    {
        [Xunit.Fact]
        public void ItShouldThrowExceptionIfArgumentIsNull()
        {
            try
            {
                Web.Helpers.Guard.ThrowIfNull(null, "value");
            }
            catch (ArgumentNullException)
            { }
        }

        [Test]
        public void ItShouldNotThrowExceptionIfArgumentIsNotNull()
        {
            Web.Helpers.Guard.ThrowIfNull("this is not null", "value");
        }

        [Test]
        [ExpectedException(typeof(ArgumentNullException))]
        public void ItShouldThrowExceptionIfArgumentIsNullOrEmpty()
        {
            Web.Helpers.Guard.ThrowIfNullOrEmpty(string.Empty, "value");
        }

        [Test]
        public void ItShouldNotThrowExceptionIfArgumentIsNotNullOrEmpty()
        {
            Web.Helpers.Guard.ThrowIfNullOrEmpty("not null or empty", "value");
        }

        [Test]
        [ExpectedException(typeof(ArgumentOutOfRangeException))]
        public void ItShouldThrowExceptionIfArgumentIsNotInRange()
        {
            Web.Helpers.Guard.ThrowIfNotInRange(1, 2, 3, "value");
        }

        [Test]
        public void ItShouldNotThrowExceptionIfArgumentIsNotLesserThanTheMin()
        {
            Web.Helpers.Guard.ThrowIfNotInRange(2, 1, 3, "value");
        }
    }
}
