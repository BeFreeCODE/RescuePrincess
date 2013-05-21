//
//  game.h
//  RescuePrincess
//
//  Created by 오 준영 on 13. 5. 20..
//  Copyright (c) 2013년 오 준영. All rights reserved.
//


typedef enum
{
	empty,
	blank,
	arrow
} TileType;

typedef enum
{
	bachelors,
	masters,
	doctorate
} Difficulty;

typedef struct
{
	int location;
	TileType tileType;
} Tile;

typedef struct
{
	Difficulty difficulity;
	int tileSize;
	int gridSize;
	Tile tiles[15];// 각 레벨의 타일은 4*4 이다.
} Level;


@interface game : NSObject
{
	Level levels[5];
}

+ (Difficulty)getBestDifficulty;
+ (void)setCurrentLevelIndex:(int)aLevelIndex;
+ (Level)getLevelAtLevelIndex:(int)aLevelIndex;
+ (game*)gameWithLevels;
- (void)setLevelAtIndex:(int)aIndex level:(Level)aLevel;
- (Level)getLevelAtIndex:(int)aIndex;
@end

