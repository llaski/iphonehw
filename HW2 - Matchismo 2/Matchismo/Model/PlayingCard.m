//
//  PlayingCard.m
//  Matchismo
//
//  Created by Larry Laski on 11/22/13.
//  Copyright (c) 2013 Larry Laski. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

- (NSString *)contents {
    NSArray *ranksStrings = [PlayingCard rankStrings];
    return [ranksStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (PlayingCard *card in otherCards) {
        
        if (card.rank == self.rank) {
            score += 4;
        } else if ([card.suit isEqualToString:self.suit]) {
            score += 1;
        }
    }
    
    return score;
}

@end
