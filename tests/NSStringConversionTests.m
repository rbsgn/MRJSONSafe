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


@interface NSStringConversionTests : XCTestCase

@end


@implementation NSStringConversionTests

- (void)test_WhenConvertedToNSString_ThenReturnsSameNSString
{
    XCTAssertEqualObjects([@"foo" mr_toString], @"foo", @"NSString -> NSString should return same object");
}

- (void)test_WhenConvertedToNSNumber_ThenReturnsNumberRepresentation
{
    XCTAssertEqualObjects([@"1" mr_toNumber], @1, @"NSString [integer] -> NSNumber failed");
    XCTAssertEqualObjects([@"1.5" mr_toNumber], @1.5, @"NSString [double] -> NSNumber failed");
    XCTAssertNil([@"foo" mr_toNumber], @"NSString [nan] -> NSNumber should return nil");
}

- (void)test_WhenConvertedToNSDictionary_ThenReturnsNil
{
    XCTAssertNil([@"foo" mr_toDictionary], @"NSString -> NSDictionary should fail");
}

- (void)test_WhenConvertedToNSArray_ThenReturnsArrayWithThatString
{
    XCTAssertEqualObjects([@"foo" mr_toArray], @[ @"foo" ], @"NSString -> NSArray failed");
}

- (void)test_WhenConvertedToArrayOfStrings_ThenReturnsArrayWithThatString
{
    XCTAssertEqualObjects([@"foo" mr_toArrayOf:[NSString class]], @[ @"foo" ], @"NSString -> Array of NSString failed");
}

- (void)test_WhenConvertedToArrayOfNumbers_ThenReturnsArrayWithNumberRepresentationOfThatString
{
    XCTAssertEqualObjects([@"1.5" mr_toArrayOf:[NSNumber class]], @[ @1.5 ], @"NSString -> Array of NSNumber failed");
}
@end
