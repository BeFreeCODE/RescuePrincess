//
//  tile.h
//  RescuePrincess
//
//  Created by 오 준영 on 13. 5. 20..
//  Copyright (c) 2013년 오 준영. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "game.h"

@interface tile : UIView
{
	int size;
	int index;
	int location;
	int dimension;
	TileType tileType;
	UILabel *indexLabel;
	UIImageView *arrowView;
	UIImageView *starView;
}

@property (nonatomic) int size;
@property (nonatomic) int index;
@property (nonatomic) int location;
@property (nonatomic) int dimension;
@property (nonatomic) TileType tileType;
@property (nonatomic, retain) UIImageView *arrowView;
@property (nonatomic, retain) UIImageView *starView;
@property (nonatomic, retain) UILabel *indexLabel;

- (id)initWithIndex:(int)aIndex atLocation:(int)aLocation withSize:(int)aSize withDimension:(int)aDimension withType:(TileType)aTileType;
//- (void)updateArrowDirectionWithAnimation:(bool)useAnimation;
- (void)updateArrowPoint;
//- (void)updateArrowPointToIndex:(int)toIndex fromIndex:(int)fromIndex;
+ (int)getXForLoation:(int)aLocation withDimension:(int)aDimension;
+ (int)getYForLoation:(int)aLocation withDimension:(int)aDimension;
+ (CGRect)getRectForLocation:(int)aLocation withDimension:(int)aDimension withSize:(int)aSize;
@end

