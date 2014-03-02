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


@interface NSDictionaryConversionTests : XCTestCase

@property (nonatomic, copy) NSDictionary *dictionary;

@end


@implementation NSDictionaryConversionTests

- (void)setUp
{
    [super setUp];
    self.dictionary = @{ @"foo": @"bar" };
}

- (void)test_WhenConvertedToString_ThenReturnsNil
{
    XCTAssertNil([self.dictionary mr_toString], @"NSDictionary -> NSString should fail");
}

- (void)test_WhenConvertedToNumber_ThenReturnsNil
{
    XCTAssertNil([self.dictionary mr_toNumber], @"NSDictionary -> NSNumber should fail");
}

- (void)test_WhenConvertedToDictionary_ThenReturnsSameDictionary
{
    XCTAssertEqualObjects([self.dictionary mr_toDictionary], self.dictionary, @"NSDictionary -> NSDictionary failed");
}

- (void)test_WhenConvertedToArray_ThenReturnsArrayWithThatDictionary
{
    XCTAssertEqualObjects([self.dictionary mr_toArray], @[ self.dictionary ], @"NSDictionary -> NSArray failed");
}

- (void)test_WhenConvertedToArrayOfDictionaries_ThenReturnsArrayWithThatDictionary
{
    XCTAssertEqualObjects([self.dictionary mr_toArrayOf:[NSDictionary class]], @[ self.dictionary ], @"NSDictionary -> NSArray of NSDictionary failed");
}

- (void)test_WhenConvertedToArrayOfStringsNumbersOrArrays_ThenReturnsNil
{
    NSArray *unsupportedClasses = @[[NSString class], [NSNumber class], [NSArray class]];
    
    for (Class klass in unsupportedClasses) {
        XCTAssertNil([self.dictionary mr_toArrayOf:klass], @"NSDictionary -> unsupported class should fail");
    }
}

@end
