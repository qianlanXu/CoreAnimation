//
//  DrawView.m
//  calayer
//
//  Created by xu qianlan on 2023/4/18.
//

#import "DrawView.h"

#define BRUSH_SIZE 32

@interface DrawView ()

@property (nonatomic, strong) NSMutableArray *strokes;

@end

@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _strokes = [NSMutableArray array];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.anyObject locationInView:self];
    [self addBrushStrokeAtPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.anyObject locationInView:self];
    [self addBrushStrokeAtPoint:point];
}

- (void)addBrushStrokeAtPoint:(CGPoint)point {
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}

- (CGRect)brushRectForPoint:(CGPoint)point {
    return CGRectMake(point.x - BRUSH_SIZE * 0.5, point.y - BRUSH_SIZE * 0.5, BRUSH_SIZE, BRUSH_SIZE);
}

- (void)drawRect:(CGRect)rect {
    for (NSValue *value in _strokes) {
        CGPoint point = value.CGPointValue;
        
        CGRect brushRect = [self brushRectForPoint:point];
        
        // 避免重绘任何旧的线刷以不至于覆盖已更新过的区域。这样做会显著地提高绘制效率
        if(CGRectIntersectsRect(rect, brushRect)) {
            [[UIImage imageNamed:@"Chalk"] drawInRect:brushRect];
        }
        
    }
}
@end
