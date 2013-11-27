//
//  MCMyCell.h
//  MCSwipe Demo
//
//  Created by Warif Akhand Rishi on 11/25/13.
//  Copyright (c) 2013 Mad Castle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSwipeTableViewCell.h"

@class MCMyCell;

@protocol MCMyCellDelegate <NSObject>

- (void)didLongPressOnCell:(MCMyCell *)cell;

@end



@interface MCMyCell : MCSwipeTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (nonatomic, assign) BOOL enableLongPress;

- (void)willAppear;
- (void)reset;

@end
