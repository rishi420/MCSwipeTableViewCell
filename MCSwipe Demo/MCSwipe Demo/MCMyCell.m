//
//  MCMyCell.m
//  MCSwipe Demo
//
//  Created by Warif Akhand Rishi on 11/25/13.
//  Copyright (c) 2013 Mad Castle. All rights reserved.
//

#import "MCMyCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MCMyCell ()
@property (nonatomic, retain) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, retain) UIView *reorderView;
@property (nonatomic, assign) BOOL swipeEnabled;
- (IBAction)actionTestButton:(id)sender;
@end

@implementation MCMyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)swipeEnable:(BOOL)enable
{
    UIColor *color = (enable) ? [UIColor clearColor] : nil;
    
    [self setFirstStateIconName:nil
                     firstColor:color
            secondStateIconName:nil
                    secondColor:color
                  thirdIconName:nil
                     thirdColor:color
                 fourthIconName:nil
                    fourthColor:color];
    
    self.modeForState1 = MCSwipeTableViewCellModeSwitch;
    self.modeForState2 = MCSwipeTableViewCellModeExit;
    self.modeForState3 = MCSwipeTableViewCellModeSwitch;
    self.modeForState4 = MCSwipeTableViewCellModeExit;
    
    [self showBorder:enable];
    self.reorderView.userInteractionEnabled = enable;
    self.swipeEnabled = enable;
    
}

- (void)createLongTapGesture
{
    if (self.longPressGesture) {
        //Gesture already created
        return;
    }
    
    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress:)];
    [self addGestureRecognizer:self.longPressGesture];
}

- (void)didLongPress:(UILongPressGestureRecognizer *)sender
{
    if (!self.enableLongPress) {
        //Long press is not enabled
        return;
    }
    
    if ([sender state] == UIGestureRecognizerStateBegan) {
        //enable cell for swipe
        [self swipeEnable:!self.swipeEnabled];
               
        if ([self.delegate respondsToSelector:@selector(didLongPressOnCell:)]) {
            [self.delegate performSelector:@selector(didLongPressOnCell:) withObject:self];
        }
    }
}

- (void)setEnableLongPress:(BOOL)enableLongPress
{
    _enableLongPress = enableLongPress;
    [self createLongTapGesture];
}

- (void)showBorder:(BOOL)border
{
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = border;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (UIView *)reorderView
{
    if(!_reorderView) {
        for(UIView* view in self.subviews) {
            if([[[view class] description] isEqualToString:@"UITableViewCellReorderControl"]) {
                self.reorderView = view;
                break;
            }
        }
        
        for (UIView * subview in _reorderView.subviews) {
            if ([subview isKindOfClass: [UIImageView class]]) {
                [(UIImageView*)subview setImage:nil];
                break;
            }
        }
    }
    
    return _reorderView;
}

- (void) layoutSubviews
{
    // Don't remove this empty method implementation or call [super layoutSubviews];
    // If ou wannat let UITableCellView handle the layout...
    // 1. call [super layoutSubviews];
    // 2. Apply your layout...
}

- (void)changeReorderView
{
    UIView *view = [self reorderView];
    view.frame = self.contentView.bounds;
    [self addSubview:view];
}

- (void)willAppear
{
    [self changeReorderView];
    [self swipeEnable:NO];
}

- (void)reset
{
    [self swipeEnable:NO];
}

- (IBAction)actionTestButton:(id)sender
{
    NSLog(@"actionTestButton");
}

@end
