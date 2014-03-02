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


@interface NSArrayConversionTests : XCTestCase

@property (nonatomic, copy) NSArray *array;

@end


@implementation NSArrayConversionTests

- (void)setUp
{
    [super setUp];
    self.array = @[@"foo", @"bar"];
}

- (void)test_WhenConvertedToString_ThenReturnsArrayContentConcatenatedWithNewlineChar
{
    NSArray *strings = @[@"foo", @"bar"];
    XCTAssertEqualObjects([strings mr_toString], @"foo\nbar", @"NSArray (NSStrings) -> NSString failed");

    NSArray *numbers = @[ @1, @1.5 ];
    XCTAssertEqualObjects([numbers mr_toString], @"1\n1.5", @"NSArray (NSNumber) -> NSString failed");

    NSArray *empty = @[ ];
    XCTAssertEqualObjects([empty mr_toString], @"", @"NSArray (empty) -> NSString failed");
}

- (void)test_WhenConvertedToNumber_ThenReturnsNil
{
    XCTAssertNil([self.array mr_toNumber], @"NSArray -> NSNumber should fail");
}

- (void)test_WhenConvertedToDictionary_ThenReturnsNil
{
    XCTAssertNil([self.array mr_toDictionary], @"NSArray -> NSDictionary should fail");
}

- (void)test_WhenConvertedToArray_ThenReturnsSameObject
{
    XCTAssertEqualObjects([self.array mr_toArray], self.array, @"NSArray -> NSArray failed");
}

- (void)test_WhenConvertedToArrayOfStrings_ThenReturnStringRepresentationsOfItsContent
{
    [self assertArray:@[ @"foo", @"bar" ]
      whenConvertedTo:[NSString class]
         equalToArray:@[ @"foo", @"bar" ]];

    [self assertArray:@[ @1, @1.5 ]
      whenConvertedTo:[NSString class]
         equalToArray:@[ @"1", @"1.5" ]];

    [self assertArray:@[ @[ @"foo", @"bar" ], @[ @"baz", @"qux"] ]
      whenConvertedTo:[NSString class]
         equalToArray:@[ @"foo\nbar", @"baz\nqux" ]];

    [self assertArray:@[ @1, @"foo", @[ @"bar", @1.5 ]]
      whenConvertedTo:[NSString class]
         equalToArray:@[ @"1", @"foo", @"bar\n1.5" ]];
}

- (void)test_GivenArrayWithItemNotConvertableToStrings_WhenConvertedToArrayOfStrings_ThenReturnsNil
{
    NSArray *array = @[ @"foo", @{ @"bar": @"baz" } ];
    XCTAssertNil([array mr_toArrayOf:[NSString class]], @"NSArray with non-convertable item -> NSString should fail");
}

- (void)test_GivenArrayOfPotentiallyConvertableToNumberItems_WhenConvertedToArrayOfNumbers_ThenReturnNumberRepresentationOfItsContent
{
    [self assertArray:@[ @1, @1.5] whenConvertedTo:[NSNumber class] equalToArray:@[ @1, @1.5 ]];
    [self assertArray:@[ @"1", @"1.5" ] whenConvertedTo:[NSNumber class] equalToArray:@[ @1, @1.5 ]];
    [self assertArray:@[ @1, @"1.5" ] whenConvertedTo:[NSNumber class] equalToArray:@[ @1, @1.5 ]];
}

- (void)test_GivenArrayWithItemNotConvertableToNumber_WhenConvertedToArrayOfNumbers_ThenThenReturnsNil
{
    NSArray *array = @[ @1, @[ @"1", @1.5 ]];
    XCTAssertNil([array mr_toArrayOf:[NSNumber class]], @"NSArray with non-convertable item -> NSNumber should fail");
}

- (void)test_GivenArrayOfPotentiallyConvertableToDictionaryItems_WhenConvertedToArrayOfDictionaries_ThenReturnDictionaryRepresentationsOfItsContent
{
    [self assertArray:@[ @{ @"foo": @"bar" }, @{ @"baz": @"foobar" }]
      whenConvertedTo:[NSDictionary class]
         equalToArray:@[ @{ @"foo": @"bar" }, @{ @"baz": @"foobar" }]];
}

- (void)test_GivenArrayOfWithItemNotConvertableToDictionary_WhenConvertedToArrayOfDictionaries_ThenReturnsNil
{
    NSArray *array = @[ @1, @"foo" ];
    XCTAssertNil([array mr_toArrayOf:[NSDictionary class]], @"NSArray with non-convertable item -> NSDictionary should fail");
}


- (void)assertArray:(NSArray *)actual whenConvertedTo:(Class)classItem equalToArray:(NSArray *)expected
{
    XCTAssertEqualObjects([actual mr_toArrayOf:classItem],
                          expected,
                          @"NSArray -> Array of %@ failed", NSStringFromClass(classItem));

}


@end
