using System;
using System.Linq;
using api.Controllers;
using Xunit;

namespace api.UnitTest
{
    public class RangeTests
    {
        [Fact]
        public void Test1()
        {
            var range = new Range {Count = 3};

            var generated = range.Of(() => "");

            Assert.Equal(3, generated.Count());
        }


        [Fact]
        public void SortShouldOrderResults()
        {
            var range = new Range {Count = 3, Sort = true};
            var values = new[] {"a","c","b"};
            var counter = 0;
            var generated = range.Of(() => values[counter++]);

            Assert.Equal(new [] {"a","b","c"}, generated.ToArray());
        }
    }
}
