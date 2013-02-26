//
//  Deck.h
//  Matchismo
//
//  Created by Delfino on 23/02/13.
//  Copyright (c) 2013 Delfino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

-(Card *)drawRandomCard;

@end
