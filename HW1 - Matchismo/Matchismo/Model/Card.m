//
//  Card.m
//  Matchismo
//
//  Created by Larry Laski on 11/20/13.
//  Copyright (c) 2013 Larry Laski. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
