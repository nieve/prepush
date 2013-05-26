using Machine.Specifications;
using NUnit.Framework;
using Xunit;
using Assert = Xunit.Assert;

namespace TestProj
{
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
        public It should_equal_one = () => 1.ShouldEqual(1);
    }
}
