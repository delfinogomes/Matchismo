//
//  PlayingCard.h
//  Matchismo
//
//  Created by Delfino on 23/02/13.
//  Copyright (c) 2013 Delfino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
- (NSString *)contents;

@end
