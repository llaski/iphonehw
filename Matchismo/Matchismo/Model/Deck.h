//
//  Deck.h
//  Matchismo
//
//  Created by Larry Laski on 11/22/13.
//  Copyright (c) 2013 Larry Laski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
