//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Larry Laski on 12/8/13.
//  Copyright (c) 2013 Larry Laski. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger numCardsToMatch;
@property (nonatomic, strong) NSMutableArray *cards; //of Card objects

//Private Properties
@property (nonatomic) NSMutableArray *chosenCards;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (! _cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)chosenCards
{
    if (! _chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                   numCardToMatch:(NSUInteger)numCards
{
    self = [super init]; //Super's Designated Intializer
    
    if (self)
    {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
               [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        
        self.numCardsToMatch = numCards - 1;
    }

    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chosenCardsMatched:(BOOL)match
{
    if ([self.cards count]) {
        for (Card *card in self.cards) {
            if (card.isChosen && !card.isMatched) {
                if (match)
                    card.matched = YES;
                else
                    card.chosen = NO;
            }
        }
        
        [self.chosenCards removeAllObjects];
    }
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index]; //Card to be chosen
    
    if ( ! card.isMatched) {
        if (card.isChosen) {
            //Unchoose card
            card.chosen = NO;
        } else {
            
            //Need to check how many cards are chosen so far - if it matches the number in the game then we should check for matches
            
            
            if ([self.chosenCards count] == self.numCardsToMatch) {
                int matchScore = [card  match:self.chosenCards];
                
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS * self.numCardsToMatch;
                    [self chosenCardsMatched:YES];
                    card.matched = YES;
                } else {
                    self.score -= MISMATCH_PENALTY * self.numCardsToMatch;
                    [self chosenCardsMatched:NO];
                }
                
                //Loop through the chosen cards and check for a match
//                for (Card *otherCard in self.cards) {
//                    if (otherCard.isChosen && !otherCard.isMatched) {
//                        int matchScore = [card match:@[otherCard]];
//                    
//                        if (matchScore) {
//                            self.score += matchScore * MATCH_BONUS;
//                            otherCard.matched = YES;
//                            card.matched = YES;
//                        } else {
//                            self.score -= MISMATCH_PENALTY;
//                            otherCard.chosen = NO;
//                        }
//                        break; //can only choose 2 cards for now
//                    }
//                }
            
                
            } else {
                
            }
            
            if (!card.isMatched) [self.chosenCards addObject:card];
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
//
//            for (Card *card in self.cards) {
//                if (card.isMatched) NSLog(@"%@", card.contents);
//            }
        }
    }
}

@end