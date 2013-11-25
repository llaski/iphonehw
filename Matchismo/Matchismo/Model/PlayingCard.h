//
//  PlayingCard.h
//  Matchismo
//
//  Created by Larry Laski on 11/22/13.
//  Copyright (c) 2013 Larry Laski. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
