//
//  PlayingCard.m
//  Matchismo
//
//  Created by Delfino on 23/02/13.
//  Copyright (c) 2013 Delfino. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 2;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
    } else if ([otherCards count] == 2) {
        
        NSArray *allCards = [otherCards arrayByAddingObject:self];
        
        int countSuit = 0;
        int countRank = 0;
        
        for (int i = 0; i < allCards.count; i++) {
            PlayingCard *card = allCards[i];
            for (int j = i + 1; j < allCards.count; j++) {
                PlayingCard *card2 = allCards[j];
                if (card.suit == card2.suit) {
                    countSuit++;
                }
                if (card.rank == card2.rank) {
                    countRank++;
                }
            }
        }
        
        BOOL considerRank = countRank > countSuit;
        
        if (considerRank) {
            if (countRank == 3) {
                score = 5;
            } else if (countRank == 2) {
                score = 3;
            }
        } else {
            if (countSuit == 3) {
                score = 3;
            } else if (countSuit == 2) {
                score = 1;
            }
        }
        
    }

    return score;
}

- (NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide the getter AND the setter

+ (NSArray *)validSuits
{
    return @[@"♠",@"♣",@"♥",@"♦"];
}

- (void)setSuit:(NSString *) suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"1",@"2",@"3",@"4",@"5",
             @"6",@"7",@"8",@"9",@"J",@"Q",@"K"];
}

+ (NSUInteger) maxRank { return [self rankStrings].count-1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
