using NUnit.Framework;
using Xunit;

namespace TestProj
{
    class Program
    {
        static void Main(string[] args)
        {
        }
    }

    [TestFixture]
    public class NunitTests
    {
        [Test]
        public void OneEqualsOne()
        {
            NUnit.Framework.Assert.AreEqual(1, 1);
        }
    }

    public class XUnitTests
    {
        [Fact]
        public void OneEqualsOne()
        {
            Xunit.Assert.Equal(1, 1);
        }
    }
}
