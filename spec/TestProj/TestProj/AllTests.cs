using Machine.Specifications;
using NUnit.Framework;
using Xunit;
using Assert = Xunit.Assert;

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
            Assert.Equal(1,1);
        }
    }

    public class MspecTests
    {
        Machine.Specifications.It should_equal_one = () => 1.ShouldEqual(1);
    }
}
