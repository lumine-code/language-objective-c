#import <Foundation/Foundation.h>

class Counter {
public:
    int value = 0;
};

@interface Controller : NSObject
@property(nonatomic) Counter counter;
@end

@implementation Controller
@end
