.class Lcom/mg/ola/common/widget/date/b;
.super Lcom/mg/ola/common/widget/date/a;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/date/a;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public a(I)V
    .locals 0

    return-void
.end method

.method protected a(II)V
    .locals 0

    return-void
.end method

.method public b(I)V
    .locals 0

    return-void
.end method

.method public onDown(Landroid/view/MotionEvent;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 4

    invoke-super {p0, p1}, Lcom/mg/ola/common/widget/date/a;->onDraw(Landroid/graphics/Canvas;)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/b;->h:[Ljava/lang/String;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    iget v1, p0, Lcom/mg/ola/common/widget/date/b;->g:I

    int-to-float v1, v1

    iget v2, p0, Lcom/mg/ola/common/widget/date/b;->e:I

    iget v3, p0, Lcom/mg/ola/common/widget/date/b;->d:I

    add-int/2addr v2, v3

    int-to-float v2, v2

    iget-object v3, p0, Lcom/mg/ola/common/widget/date/b;->c:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    return-void
.end method

.method public onFling(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method protected onFocusChanged(ZILandroid/graphics/Rect;)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Lcom/mg/ola/common/widget/date/a;->onFocusChanged(ZILandroid/graphics/Rect;)V

    return-void
.end method

.method public onLongPress(Landroid/view/MotionEvent;)V
    .locals 0

    return-void
.end method

.method public onScroll(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public onShowPress(Landroid/view/MotionEvent;)V
    .locals 0

    return-void
.end method

.method public onSingleTapUp(Landroid/view/MotionEvent;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method protected onSizeChanged(IIII)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lcom/mg/ola/common/widget/date/a;->onSizeChanged(IIII)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/b;->b:Lcom/mg/ola/common/widget/date/g;

    iget p2, p0, Lcom/mg/ola/common/widget/date/b;->f:I

    int-to-float p2, p2

    const/4 p3, 0x0

    const/4 p4, 0x0

    invoke-virtual {p1, p3, p2, p4}, Lcom/mg/ola/common/widget/date/g;->a(FFZ)V

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 0

    invoke-super {p0, p1}, Lcom/mg/ola/common/widget/date/a;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method
