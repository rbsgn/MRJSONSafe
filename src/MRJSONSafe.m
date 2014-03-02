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


#import "MRJSONSafe.h"

static inline NSNumber *MRNumberFromString(NSString *string) {
    static NSNumberFormatter *f = nil;
    if (f == nil) {
        f = [[NSNumberFormatter alloc] init];
        [f setDecimalSeparator:@"."];
    }
    NSNumber *number = [f numberFromString:string];
    return number;
}

static inline NSArray *MRCastArrayUsingSelector(NSArray *array, SEL castSelector) {
    NSMutableArray *castedArray = [NSMutableArray arrayWithCapacity:[array count]];
    for (id object in array) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id castedObject = [object performSelector:castSelector];
#pragma clang diagnostic pop
        if (castedObject) {
            [castedArray addObject:castedObject];
        }
        else {
            return nil;
        }
    }
    return [castedArray copy];
}


@implementation NSObject (MRJSONSafe)

+ (void)mr_reportCastErrorFromClass:(Class)fromClass toClass:(Class)toClass
{
    NSLog(@"%@: cannot cast object from class %@ to class %@",
        NSStringFromClass([self class]),
        NSStringFromClass(fromClass),
        NSStringFromClass(toClass));
}

- (NSString *)mr_toString
{
    [[self class] mr_reportCastErrorFromClass:[self class] toClass:[NSString class]];
    return nil;
}

- (NSNumber *)mr_toNumber
{
    [[self class] mr_reportCastErrorFromClass:[self class] toClass:[NSNumber class]];
    return nil;
}

- (NSDictionary *)mr_toDictionary
{
    [[self class] mr_reportCastErrorFromClass:[self class] toClass:[NSDictionary class]];
    return nil;
}

- (NSArray *)mr_toArray
{
    [[self class] mr_reportCastErrorFromClass:[self class] toClass:[NSArray class]];
    return nil;
}

- (NSArray *)mr_toArrayOf:(Class)itemClass
{
    [[self class] mr_reportCastErrorFromClass:[self class] toClass:[NSArray class]];
    return nil;
}

- (NSObject *)mr_safeCastToClass:(Class)toClass
{
    if ([self isKindOfClass:toClass]) {
        return self;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return nil;
    }
    [[self class] mr_reportCastErrorFromClass:[self class] toClass:toClass];
    return nil;
}

@end


@implementation NSNull (MRJSONSafe)

- (NSString *)mr_toString
{
    return nil;
}

- (NSNumber *)mr_toNumber
{
    return nil;
}

- (NSDictionary *)mr_toDictionary
{
    return nil;
}

- (NSArray *)mr_toArray
{
    return nil;
}

- (NSArray *)mr_toArrayOf:(Class)itemClass
{
    return nil;
}

@end


@implementation NSArray (MRJSONSafe)

- (NSArray *)mr_toArray
{
    return self;
}

static inline SEL MRCastSelectorForClass(Class class) {
    SEL castSelector = nil;
    if (class == [NSString class]) {
        castSelector = @selector(mr_toString);
    }
    else if (class == [NSNumber class]) {
        castSelector = @selector(mr_toNumber);
    }
    else if (class == [NSDictionary class]) {
        castSelector = @selector(mr_toDictionary);
    }
    return castSelector;
}

static inline BOOL MRCheckArrayIsOfClass(NSArray *array, Class class) {
    for (id obj in array) {
        if ([obj mr_safeCastToClass:class] == nil) {
            return NO;
        }
    }
    return YES;
}

- (NSArray *)mr_toArrayOf:(Class)itemClass
{
    SEL castSelector = MRCastSelectorForClass(itemClass);
    if (castSelector) {
        return MRCastArrayUsingSelector(self, castSelector);
    }
    else {
        return MRCheckArrayIsOfClass(self, itemClass) ? self : nil;
    }
}

- (NSString *)mr_toString
{
    NSArray *arrayOfString = [self mr_toArrayOf:[NSString class]];
    if (arrayOfString) {
        return [arrayOfString componentsJoinedByString:@"\n"];
    }
    return nil;
}

@end


@implementation NSDictionary (MRJSONSafe)

- (NSDictionary *)mr_toDictionary
{
    return self;
}

- (NSArray *)mr_toArrayOf:(Class)itemClass
{
    if (itemClass == [NSDictionary class]) {
        return [self mr_toArray];
    }
    return nil;
}

- (NSArray *)mr_toArray
{
    return @[ self ];
}

@end


@implementation NSString (MRJSONSafe)

- (NSString *)mr_toString
{
    return self;
}

- (NSNumber *)mr_toNumber
{
    return MRNumberFromString(self);
}

- (NSArray *)mr_toArray
{
    return @[ self ];
}

- (NSArray *)mr_toArrayOf:(Class)itemClass
{
    SEL castSelector = MRCastSelectorForClass(itemClass);
    if (castSelector == NULL) {
        return nil;
    }
    
    return MRCastArrayUsingSelector([self mr_toArray], castSelector);
}

@end


@implementation NSNumber (MRJSONSafe)

- (NSString *)mr_toString
{
    return [self stringValue];
}

- (NSNumber *)mr_toNumber
{
    return self;
}

- (NSArray *)mr_toArray
{
    return @[ self ];
}

- (NSArray *)mr_toArrayOf:(Class)itemClass
{
    SEL castSelector = MRCastSelectorForClass(itemClass);
    if (castSelector == NULL) {
        return nil;
    }
    
    return MRCastArrayUsingSelector([self mr_toArray], castSelector);
}

@end
