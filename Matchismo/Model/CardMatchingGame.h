//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Delfino on 26/02/13.
//  Copyright (c) 2013 Delfino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;

@end
