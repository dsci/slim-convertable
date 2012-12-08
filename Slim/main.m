//
//  main.m
//  Slim
//
//  Created by Daniel Schmidt on 08.12.12.
//  Copyright (c) 2012 Daniel Schmidt. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
  return macruby_main("rb_main.rb", argc, argv);
}
