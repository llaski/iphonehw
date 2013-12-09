//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Larry Laski on 12/8/13.
//  Copyright (c) 2013 Larry Laski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//Designated Initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                   numCardToMatch:(NSUInteger)numCards
;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger numCardsToMatch;

@end
