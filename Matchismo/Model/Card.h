//
//  Card.h
//  Matchismo
//
//  Created by Delfino on 23/02/13.
//  Copyright (c) 2013 Delfino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;
- (BOOL)isFlippable;

@end
