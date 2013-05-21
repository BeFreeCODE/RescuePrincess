//
//  tile.m
//  RescuePrincess
//
//  Created by 오 준영 on 13. 5. 20..
//  Copyright (c) 2013년 오 준영. All rights reserved.
//

#import "tile.h"
#import <QuartzCore/QuartzCore.h>


@implementation tile
@synthesize index;
@synthesize size;
@synthesize dimension;
@synthesize indexLabel;
@synthesize arrowView;
@synthesize starView;
@synthesize tileType;

static int topOffset = 20;
static int leftOffset = 5;

+ (CGRect)getRectForLocation:(int)aLocation withDimension:(int)aDimension withSize:(int)aSize{
	int x = [tile getXForLoation:aLocation withDimension:aDimension];
	int y = [tile getYForLoation:aLocation withDimension:aDimension];
	return CGRectMake(x*aSize+x+leftOffset, y*aSize+y+topOffset, aSize, aSize);
}

+ (int)getXForLoation:(int)aLocation withDimension:(int)aDimension {
	return aLocation % aDimension;
}

+ (int)getYForLoation:(int)aLocation withDimension:(int)aDimension {
	return aLocation / aDimension;
}

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

- (float)getArrowDirectionToIndex:(int)toIndex fromIndex:(int)fromIndex
{
	//NSLog([NSString stringWithFormat:@"toIndex:%d fromIndex:%d", toIndex, fromIndex]);
	CGFloat toX = toIndex % dimension;
	CGFloat toY = toIndex / dimension;
	CGFloat fromX = fromIndex % dimension;
	CGFloat fromY = fromIndex / dimension;
	double rise = toY - fromY;
	double run = toX - fromX;
	float angle = atan2(rise, run);
	return angle;
}

- (void)updateArrowPoint
{
	if (tileType != arrow) return;
	//[self updateArrowPointToIndex:self.index fromIndex:self.location];
}
//- (void)updateArrowDirectionWithAnimation:(bool)useAnimation{


//- (void)updateArrowPointToIndex:(int)toIndex fromIndex:(int)fromIndex
//{
//	if (toIndex == fromIndex)
//    {
//		[self.arrowView setHidden:true];
//		[self.starView setHidden:false];
//		return;
//	}
//    
//	[self.arrowView setHidden:false];
//	[self.starView setHidden:true];
//	// calculate the angle
//	float angle = [self getArrowDirectionToIndex:toIndex fromIndex:fromIndex];
//	//self.indexLabel.text = [NSString stringWithFormat:@"%d %f", index, angle];
//	//if(useAnimation) {
//	//	[UIView beginAnimations:nil context:self.arrowView];
//	//	[UIView setAnimationDuration:0.25];
//	//}
//	CATransform3D rotationTransform = CATransform3DIdentity;
//    rotationTransform = CATransform3DRotate(rotationTransform, angle, 0.0, 0.0, 1.0);
//    self.arrowView.layer.transform = rotationTransform;
//    //	if(useAnimation)
//    //		[UIView commitAnimations];
//	
//}

- (id)initWithIndex:(int)aIndex
         atLocation:(int)aLocation
           withSize:(int)aSize
      withDimension:(int)aDimension
           withType:(TileType)aTileType
{
	self.index = aIndex;  //0,1,2,3...
	location = aLocation;
	self.size = aSize;
	self.dimension = aDimension;
	self.tileType = aTileType;
    
    //게임의 프레임 크기만한 사각형 설정한다.
	CGRect frame = [tile getRectForLocation:aLocation withDimension:aDimension withSize:aSize];
    if (self = [super initWithFrame:frame])
    {
		// create a label for debug purposes
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 30)];
		label.text = [NSString stringWithFormat:@"%d", index];
		label.backgroundColor = [UIColor yellowColor];
		label.hidden = true;
		[self addSubview:label];
		self.indexLabel = label;

		
		// load the background image
		UIImage *backgroundImage = [UIImage imageNamed:@"TileBackground.png"];
        //UIImage *backgroundImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TileBackground" ofType:@"png"]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
		imageView.frame = self.bounds;
		[self addSubview:imageView];
        
		// create the arrow view
		UIImage *arrowImage = [UIImage imageNamed:@"Arrow.png"];
        //UIImage *arrowImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Arrow" ofType:@"png"]];
		imageView = [[UIImageView alloc] initWithImage:arrowImage];
		[self addSubview:imageView];
		imageView.frame = self.bounds;
		self.arrowView = imageView;

		[self.arrowView setHidden:true];
		//[self updateArrowPoint];
		
		// create the star view
		UIImage *starImage = [UIImage imageNamed:@"Star.png"];
		imageView = [[UIImageView alloc] initWithImage:starImage];
		[self addSubview:imageView];
		imageView.frame = self.bounds;
		self.starView = imageView;

		[self.starView setHidden:true];
		
		// load the glass image
		UIImage *glassImage = [UIImage imageNamed:@"Glass.png"];
		imageView = [[UIImageView alloc] initWithImage:glassImage];
		imageView.frame = self.bounds;
		[self addSubview:imageView];


		self.backgroundColor = [UIColor clearColor];
		//if (self.tileType !=arrow)
		//	self.backgroundColor = [UIColor grayColor];
		
	}
    return self;
}

- (void) setLocation:(int)value {
	location = value;
	self.frame = [tile getRectForLocation:self.location withDimension:self.dimension withSize:self.size];
}

- (int)location {
	return location;
}

- (void)drawRect:(CGRect) rect
{
    
}



@end
