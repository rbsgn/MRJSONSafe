// The MIT License (MIT)
//
// Copyright (c) 2012-2014 Michael Efimov, Roman Busyghin
// Copyright (c) 2012-2014 Yandex LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


@interface NSNumberConversionTests : XCTestCase

@end


@implementation NSNumberConversionTests

- (void)setUp
{
    [super setUp];
}

- (void)test_WhenConvertedToString_ThenReturnsStringRepresentation
{
    XCTAssertEqualObjects([@1 mr_toString], @"1", @"NSNumber [int] -> NSString failed");
    XCTAssertEqualObjects([@1.5 mr_toString], @"1.5", @"NSNumber [double] -> NSString failed");
}

- (void)test_WhenConvertedToNumber_ThenReturnsSameNumber
{
    XCTAssertEqualObjects([@1 mr_toNumber], @1, @"NSNumber -> NSNumber failed");
}

- (void)test_WhenConvertedToDictionary_ThenReturnsNil
{
    XCTAssertNil([@1 mr_toDictionary], @"NSNumber -> NSDictionary should fail");
}


- (void)test_WhenConvertedToArray_ThenReturnsArrayWithThatNumber
{
    XCTAssertEqualObjects([@1 mr_toArray], @[ @1 ], @"NSNumber -> NSArray failed");
}

- (void)test_WhenConvertedToArrayOfNumber_ThenReturnsArrayWithThatNumber
{
    XCTAssertEqualObjects([@1 mr_toArrayOf:[NSNumber class]], @[ @1 ], @"NSNumber -> NSArray of NSNumber failed");
}

- (void)test_WhenConvertedToArrayOfStrings_ThenReturnsArrayWithStringRepresentationOfThatNumber
{
    XCTAssertEqualObjects([@1 mr_toArrayOf:[NSString class]], @[ @"1" ], @"NSNumber -> NSArray of NSString failed");
}

@end
