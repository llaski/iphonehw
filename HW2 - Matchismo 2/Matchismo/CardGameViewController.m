//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Larry Laski on 11/20/13.
//  Copyright (c) 2013 Larry Laski. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) NSUInteger numCardsToMatch;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISwitch *gameModeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameModeLabel;
@end

@implementation CardGameViewController

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI:YES];
    
    self.flipCount++;
}

@synthesize numCardsToMatch = _numCardsToMatch;

- (NSUInteger)numCardsToMatch {
    if (! _numCardsToMatch) _numCardsToMatch = 2;
    
    return _numCardsToMatch;
}

- (void)setNumCardsToMatch:(NSUInteger)numCardsToMatch {
    _numCardsToMatch = numCardsToMatch;
}

- (CardMatchingGame *)game {
    if (! _game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                           usingDeck:[self createDeck]
                                                       numCardToMatch:self.numCardsToMatch];
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
//        NSLog(@" Card Matched: %hhd", card.isMatched);
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (void)updateUI:(BOOL)switchEnabled {
        self.gameModeSwitch.enabled = switchEnabled;
        [self updateUI];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)reset:(UIButton *)sender
{
    self.game = nil;
    [self updateUI:NO];
}

- (IBAction)gameMode:(UISwitch *)sender
{
    if ([sender isOn]) {
        self.numCardsToMatch = 2;
        self.gameModeLabel.text = @"Game Mode: 2 Card Match";
    } else {
        self.numCardsToMatch = 3;
        self.gameModeLabel.text = @"Game Mode: 3 Card Match";
    }
    self.game = nil;
    [self updateUI];
}

@end
