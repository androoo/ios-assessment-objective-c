//
//  DMNMovieController.h
//  MovieSearch
//
//  Created by Andrew Ervin Gierke on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIkit.h"

@class DMNMovie;

NS_ASSUME_NONNULL_BEGIN

@interface DMNMovieController : NSObject

+ (void)fetchMovieForSearchTerm:(NSString *)searchTerm completion:(void (^_Nullable)(NSArray *movies))completion;

+ (void)fetchPoster:(NSString *)imagePath completion:(void (^)(UIImage *moviePoster))completion;

@end
NS_ASSUME_NONNULL_END
