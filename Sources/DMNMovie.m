//
//  DMNMovie.m
//  MovieSearch
//
//  Created by Andrew Ervin Gierke on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import "DMNMovie.h"

@implementation DMNMovie

- (instancetype)init
{
    return [self initWithTitle:@"" rating:0 overview:@"" posterImage:@""];
}

- (instancetype)initWithTitle:(NSString *)title rating:(double)rating overview:(NSString *)overview posterImage:(NSString *)posterImage
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _rating = rating;
        _overview = [overview copy];
        _posterImage = [posterImage copy];
    }
    return self;
}

@end

@implementation DMNMovie (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *title = dictionary[@"title"];
    NSInteger rating = [dictionary[@"vote_average"] doubleValue];
    NSString *overview = dictionary[@"overview"];
    NSString *postImage = dictionary[@"poster_path"];
    
    if (![title isKindOfClass:[NSString class]] || ![overview isKindOfClass:[NSString class]]) {
        return nil;
    }
    return [self initWithTitle:title rating:rating overview:overview posterImage:postImage];
}

@end
