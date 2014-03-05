[![Build Status](https://travis-ci.org/nskboy/MRJSONSafe.png?branch=master)](https://travis-ci.org/nskboy/MRJSONSafe)

JSON Safe
-----------
Set of categories on Foundation objects that simplify your life while working on parsed JSON objects.

Why?
-----

Typical workflow while working with JSON looks like this:

```
NSError *error      = nil;
NSData  *JSONData   = [self populateJSONData];
id       JSONObject = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
Class expectedClass = [NSDictionary class];

if ([JSONObject isKindOfClass:expectedClass]) {
    [self processJSONDictionary:(NSDictionary *)JSONObject];
}
```

You see? All your code is scattered with `-isKindOfClass:`. This protects your app from crashes when JSON data changes a bit. However in a JSON heavy application these cast operations produce a lot of unnecessary noice and you can't read your code fluently.

That's why JSON Safe was created. You can work with your JSON safely:

```
// produces NSDictionary or nil if there was no NSDictionary parsed
NSDictionary *JSONDict = [JSONObject mr_toDictionary];
```

Example Usage
---------------

Following conversions of an arbitrary JSON object are supported:

* to NSString
* to NSNumber
* to NSArray
* to NSArray of items of specified class
* to NSDictionary

`NSNull` always gets converted to `nil`, no matter what are you trying to get: `NSString`, `NSNumber`, `NSArray` or `NSDictionary`. 

Attempt to convert `NSNumber` to `NSNumber` yield same object. To `NSString` — invoke `-[NSNumber stringValue]`. To `NSArray` — produce `NSArray` containing the receiver. To `NSDictionary` — `nil`.

Similar things happen with `NSString`:

* `NSString` → `NSString` gives the same object
* → `NSNumber` uses `NSNumberFormatter` with decimal separator set to `.`
* → `NSArray` yields to `@[ self ]`
* → `NSDictionary` returns `nil`

A bit tricky stuff happens with `NSArray` and `NSDictionary`. Here are `NSArray` conversion rules:

* Conversion from `NSArray` to `NSString` gives you `concatenated\n\content\nof\nthe\narray`
* To `NSNumber` outcomes in `nil`
* → `NSArray` yields `self`
* → `NSDictionary` — `nil`

And finally `NSDictionary`:

* Attempt to convert it to non collection object will result in `nil`
* → `NSArray` results `@[ self ]`
* → `NSDictionary` — `self`

The project is covered with set of tests that act like documentation. Go check it in `tests/` directory.


Installation
--------------
Add following lines to your `Podfile`:

```
pod 'MRJSONSafe'
```

Then run `pod install`.

Or just copy `src/MRJSONSafe.h` and `src/MSJSONSafe.m` to your project if you don't bother to use [CocoaPods](http://cocoapods.org).

Author
--------
The original idea was developed by Michael Efimov while working on Yandex.Search for iPhone application. Currently the project is maintained by Roman Busyghin.

Contributing
--------------
Want something to be changed? Clone repo, write code, tests and documentation then submit pull request.

License
---------
MRJSONSafe is available under the MIT license. See the LICENSE file for more info.
