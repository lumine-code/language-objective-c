//
//  A sample, kept idiomatic so it is worth opening in the editor.
//

#import <Foundation/Foundation.h>
#import "Shape.h"

/* A block comment. */

static const NSInteger kMaxRetries = 3;

typedef enum {
    ShapeKindRectangle,
    ShapeKindCircle,
} ShapeKind;

@protocol Formatter <NSObject>
- (NSString *)formattedValue;
@optional
- (void)reset;
@end

@interface Rectangle : NSObject <Formatter>

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy, readonly) NSString *name;

+ (instancetype)rectangleWithWidth:(CGFloat)width height:(CGFloat)height;
- (CGFloat)area;

@end

@implementation Rectangle {
    NSMutableArray<NSNumber *> *_history;
}

+ (instancetype)rectangleWithWidth:(CGFloat)width height:(CGFloat)height {
    Rectangle *rectangle = [[self alloc] init];
    rectangle.width = width;
    rectangle.height = height;
    return rectangle;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _history = [NSMutableArray array];
        _name = @"rectangle";
    }
    return self;
}

- (CGFloat)area {
    return self.width * self.height;
}

- (NSString *)formattedValue {
    return [NSString stringWithFormat:@"%@: %.2f", self.name, [self area]];
}

- (void)dealloc {
    [_history removeAllObjects];
}

@end

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        Rectangle *floor = [Rectangle rectangleWithWidth:4.5 height:2.0];

        NSDictionary<NSString *, id> *info = @{
            @"name": floor.name,
            @"area": @([floor area]),
            @"kind": @(ShapeKindRectangle),
        };

        NSArray *keys = @[ @"name", @"area" ];

        for (NSString *key in keys) {
            NSLog(@"%@ = %@", key, info[key]);
        }

        void (^done)(BOOL) = ^(BOOL success) {
            NSLog(success ? @"ok" : @"failed");
        };
        done(YES);

        @try {
            if (argc > kMaxRetries) {
                @throw [NSException exceptionWithName:@"TooMany" reason:nil userInfo:nil];
            }
        } @catch (NSException *exception) {
            NSLog(@"%@", exception.name);
        } @finally {
            floor = nil;
        }
    }
    return 0;
}
