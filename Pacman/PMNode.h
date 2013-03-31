//
//  PMNode.h
//  Pacman
//
//  Created by Satansdeer satansdeer on 17.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMNode : NSObject {
    float x;
    float y;
}

@property (nonatomic, assign) PMNode*parent;
@property (nonatomic, retain) NSMutableArray*children;


-(void)setX:(float)value;
-(void)setY:(float)value;
-(float)x;
-(float)y;
-(void)addChild:(PMNode*)node;
-(void)removeChild:(PMNode*)node;
-(void)render;
-(PMNode*)getChildAt:(int)index;
-(BOOL)notAddedToParentTree:(PMNode*)node;
-(void)removeAllChildren;

@end
