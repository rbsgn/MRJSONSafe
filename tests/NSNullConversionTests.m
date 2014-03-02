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


@interface NSNullConversionTests : XCTestCase

@end


@implementation NSNullConversionTests

- (void)test_WhenConvertedToStringNumberDictionaryOrArray_ThenReturnsNil
{
    XCTAssertNil([[NSNull null] mr_toString], @"NSNull -> NSString should return nil");
    XCTAssertNil([[NSNull null] mr_toNumber], @"NSNull -> NSNumber should return nil");
    XCTAssertNil([[NSNull null] mr_toDictionary], @"NSNull -> NSDictionary should return nil");
    XCTAssertNil([[NSNull null] mr_toArray], @"NSNull -> NSArray should return nil");
    XCTAssertNil([[NSNull null] mr_toArrayOf:[NSString class]], @"NSNull -> NSArray of instances of a given class should return nil");
}

@end
