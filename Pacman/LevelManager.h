//
//  LevelManager.h
//  Pacman
//
//  Created by Satansdeer satansdeer on 25.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelManager : NSObject

@property (nonatomic, retain) NSMutableArray* pellets;
@property (nonatomic, retain) NSArray* level;

@property CGPoint playerPoint;
@property CGPoint monsterPoint;

-(void)loadLevelFromFile:(NSString*)fileName;
-(BOOL)isFreeAtX:(int)x andY:(int)y;
-(void)collectPelletAtPoint:(CGPoint)point;
-(void)clearLevel;
@end
