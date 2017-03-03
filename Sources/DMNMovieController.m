//
//  DMNMovieController.m
//  MovieSearch
//
//  Created by Andrew Ervin Gierke on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import "DMNMovieController.h"
#import "DMNMovie.h"
#import "MovieSearch-Swift.h"

static NSString * const baseURLString = @"https://api.themoviedb.org/3/search/movie";
static NSString * const imageURLString = @"http://image.tmdb.org/t/p/w500";
static NSString * const apiKey = @"1796c09fd7616b8f1534c86ee98cc305";


@implementation DMNMovieController

+ (void)fetchMovieForSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray * _Nonnull))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    // build parameters
    NSMutableDictionary *urlParameters = [[NSMutableDictionary alloc] init];
    
    [urlParameters setValue:apiKey forKey:@"api_key"];
    [urlParameters setValue:searchTerm forKey:@"query"];
    
    // perform request
    [NetworkController performRequestFor:baseURL httpMethodString:@"GET" urlParameters:urlParameters body:nil completion:^(NSData * data, NSError * error) {
        if (error) {
            NSLog(@"Error returning movie for search term: %@");
            completion(nil);
            return;
        }
        
        // Convert from data to JSON to dict
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error parsing json: %@", error);
            completion(nil);
            return;
        }
        
        //Use Failable, get results array
        NSArray *movieDicts = jsonDictionary[@"results"];
        NSMutableArray *movies = [NSMutableArray new];
        
        for (NSDictionary *movie in movieDicts) {
            DMNMovie *newMovie = [[DMNMovie alloc]initWithDictionary:movie];
            [movies addObject:newMovie];
        }
        completion(movies);
    }];
}

+ (void)fetchPoster:(NSString *)imagePath completion:(void (^)(UIImage * _Nonnull))completion
{
    
    NSURL *baseImageURL = [NSURL URLWithString:imageURLString];
    NSURL *posterEndpoint = [baseImageURL URLByAppendingPathComponent:imagePath];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:posterEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { NSLog(@"Error: %@", error); completion(nil); }
        if (!data) { NSLog(@"Error: No data from data task: %@, error"); completion(nil); }
        
        UIImage *posterImage = [[UIImage alloc] initWithData: data];
        
        completion(posterImage);
        
    }] resume];
}

@end
