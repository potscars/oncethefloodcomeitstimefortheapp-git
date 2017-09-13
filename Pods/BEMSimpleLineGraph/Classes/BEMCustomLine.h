//
//  BEMCustomLine.h
//  Pods
//
//  Created by Mohd Zulhilmi Mohd Zain on 22/11/2016.
//  Custom library for S.A.I.F.O.N.
//

@import Foundation;
@import UIKit;

@interface BEMCustomLine : NSObject


/// The color of the average line
@property (strong, nonatomic) UIColor *color;


/// The Y-Value of the average line. This could be an average, a median, a mode, sum, etc.
@property (nonatomic) CGFloat yValue;


/// The alpha of the average line
@property (nonatomic) CGFloat alpha;


/// The width of the average line
@property (nonatomic) CGFloat width;


/// Dash pattern for the average line
@property (strong, nonatomic) NSArray *dashPattern;

@end
