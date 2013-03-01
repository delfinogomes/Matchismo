//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Delfino on 26/02/13.
//  Copyright (c) 2013 Delfino. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSArray *)flipResults
{
    if (!_flipResults) _flipResults = [[NSArray alloc] init];
    return _flipResults;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSString *lastFlipResult;
    
    NSLog(@"This card is: %@", card.contents);
    
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            lastFlipResult = [@"Flipped up " stringByAppendingString:card.contents];
            
            NSMutableArray *cardsFliped = [self cardsFacedUp];
            
            if (self.numberOfCards == [cardsFliped count] + 1) {
                int matchScore = [card match:cardsFliped];
                [cardsFliped addObject:card];
                if (matchScore) {
                    
                    for (Card *otherCard in cardsFliped) {
                        otherCard.unplayable = YES;
                    }
                    self.score += matchScore * MATCH_BONUS;
                    lastFlipResult = [NSString stringWithFormat:@"Matched %@ for %d points",
                                           [self joinCardsContents:cardsFliped byString:@", "], matchScore * MATCH_BONUS];
                } else {
                    for (Card *otherCard in cardsFliped) {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    lastFlipResult = [NSString stringWithFormat:@"%@ don't match! %d point penalty!",
                                           [self joinCardsContents:cardsFliped byString:@", "], MISMATCH_PENALTY];
                }
            }
            
            self.score -= FLIP_COST;
            self.flipResults = [self.flipResults arrayByAddingObject:lastFlipResult];
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (NSMutableArray *)cardsFacedUp
{
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (Card *card in self.cards) {
        if (card.isFlippable) {
            [result addObject:card];
        }
    }
    
    return result;
}

- (NSString *)joinCardsContents:(NSArray *)cards byString:(NSString *)separator
{
    NSMutableArray *cardContents = [[NSMutableArray alloc] init];
    
    for (Card *card in cards) {
        [cardContents addObject:card.contents];
    }
    
    return [cardContents componentsJoinedByString:separator];
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
            
        }
    }

    return self;
}

- (NSString *)lastFlipResult
{
    return [self.flipResults lastObject];
}

@end
