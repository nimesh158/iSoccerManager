//
//  Layer.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Layer.h"


@implementation Layer

@synthesize layerID;
@synthesize layerName;
@synthesize layerWidth;
@synthesize layerHeight;
@synthesize layerProperties;

- (id)initWithName:(NSString*)aName layerID:(int)aLayerID layerWidth:(int)aLayerWidth layerHeight:(int)aLayerHeight {
	if(self != nil) {
		layerName = aName;
		layerID = aLayerID;
		layerWidth = aLayerWidth;
		layerHeight = aLayerHeight;
	}
	return self;
}


- (int)getTileIDAtX:(int)aLayerX y:(int)aLayerY {
	return layerData[aLayerX][aLayerY][1];
}


- (int)getGlobalTileIDAtX:(int)aLayerX y:(int)aLayerY {
	return layerData[aLayerX][aLayerY][2];
}


- (int)getTileSetIDAtX:(int)aLayerX y:(int)aLayerY {
	return layerData[aLayerX][aLayerY][0];
}


- (void)addTileAtX:(int)aLayerX y:(int)aLayerY tileSetID:(int)aTileSetID tileID:(int)aTileID globalID:(int)aGlobalID {
	layerData[aLayerX][aLayerY][0] = aTileSetID;
	layerData[aLayerX][aLayerY][1] = aTileID;
	layerData[aLayerX][aLayerY][2] = aGlobalID;
}

@end
