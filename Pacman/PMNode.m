//
//  PMNode.m
//  Pacman
//
//  Created by Satansdeer satansdeer on 17.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "PMNode.h"

@implementation PMNode

@synthesize parent, children;

-(id)init{
    if(self = [super init]){
        self.children = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)render{
    for (PMNode*node in self.children){
        [node render];
    }
}

-(void)addChild:(PMNode*)node{
    if([self notAddedToParentTree:node]){
        if(![self.children containsObject:node]){
            node.parent = self;
            [node retain];
            [children addObject:node];
        }else{
           [NSException raise:@"Node already added" format:@""]; 
        }
    }
}

-(void)removeChild:(PMNode *)node{
    [self.children removeObject:node];
}

-(void)removeAllChildren{
    [self.children removeAllObjects];
}

-(PMNode*)getChildAt:(int)index{
    return nil;
}

-(void)setX:(float)value{
    x=value;
}

-(void)setY:(float)value{
    y=value;
}

-(float)x{
    return x + parent.x;
}

-(float)y{
    return y + parent.y;
}

-(BOOL)notAddedToParentTree:(PMNode*)node{
    if (self != node) {
        if(parent){
            return [parent notAddedToParentTree:node];
        }else{
            return true;
        }
    }else{
        [NSException raise:@"Infinite loop of siblings in this node tree" format:@""];
        return false;
    }
}

-(void)dealloc{
    [self.children release];
    [super dealloc];
}

@end
