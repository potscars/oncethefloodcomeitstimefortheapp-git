//
//  BEMCustomLine.m
//  Pods
//
//  Created by Mohd Zulhilmi Mohd Zain on 22/11/2016.
//
//

#import "BEMCustomLine.h"

@implementation BEMCustomLine

- (instancetype)init {
    self = [super init];
    if (self) {
        _color = [UIColor whiteColor];
        _alpha = 1.0;
        _width = 3.0;
        _yValue = 0.0;
    }
    
    return self;
}

@end
