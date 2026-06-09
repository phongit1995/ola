.class abstract Lcom/mg/ola/common/widget/date/a;
.super Landroid/view/View;

# interfaces
.implements Landroid/view/GestureDetector$OnGestureListener;


# instance fields
.field protected a:Landroid/os/Handler;

.field protected b:Lcom/mg/ola/common/widget/date/g;

.field protected c:Landroid/graphics/Paint;

.field protected d:I

.field protected e:I

.field protected f:I

.field protected g:I

.field protected h:[Ljava/lang/String;

.field protected i:Ljava/lang/Runnable;

.field private j:Landroid/view/GestureDetector;

.field private k:I

.field private l:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 4

    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/a;->a:Landroid/os/Handler;

    new-instance v0, Lcom/mg/ola/common/widget/date/g;

    invoke-direct {v0}, Lcom/mg/ola/common/widget/date/g;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/a;->b:Lcom/mg/ola/common/widget/date/g;

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/a;->c:Landroid/graphics/Paint;

    const/4 v0, 0x0

    new-array v1, v0, [Ljava/lang/String;

    iput-object v1, p0, Lcom/mg/ola/common/widget/date/a;->h:[Ljava/lang/String;

    const/4 v1, -0x1

    iput v1, p0, Lcom/mg/ola/common/widget/date/a;->k:I

    iput v0, p0, Lcom/mg/ola/common/widget/date/a;->l:I

    new-instance v2, Lcom/mg/ola/common/widget/date/a$1;

    invoke-direct {v2, p0}, Lcom/mg/ola/common/widget/date/a$1;-><init>(Lcom/mg/ola/common/widget/date/a;)V

    iput-object v2, p0, Lcom/mg/ola/common/widget/date/a;->i:Ljava/lang/Runnable;

    const/4 v2, 0x1

    invoke-virtual {p0, v2}, Lcom/mg/ola/common/widget/date/a;->setClickable(Z)V

    invoke-virtual {p0, v2}, Lcom/mg/ola/common/widget/date/a;->setFocusable(Z)V

    new-instance v3, Landroid/view/GestureDetector;

    invoke-direct {v3, p1, p0}, Landroid/view/GestureDetector;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;)V

    iput-object v3, p0, Lcom/mg/ola/common/widget/date/a;->j:Landroid/view/GestureDetector;

    iput v0, p0, Lcom/mg/ola/common/widget/date/a;->l:I

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/a;->c:Landroid/graphics/Paint;

    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/a;->c:Landroid/graphics/Paint;

    const v0, -0xf0f0f1

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setColor(I)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/a;->c:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Align;->RIGHT:Landroid/graphics/Paint$Align;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/a;->c:Landroid/graphics/Paint;

    const/16 v0, 0xff

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setAlpha(I)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/a;->c:Landroid/graphics/Paint;

    const/4 v0, 0x0

    const/high16 v2, 0x41700000    # 15.0f

    invoke-virtual {p1, v2, v0, v0, v1}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    return-void
.end method

.method private b(II)I
    .locals 5

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->h:[Ljava/lang/String;

    array-length v1, v0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v4, v0, v2

    invoke-static {v4}, Lcom/mg/ola/common/widget/date/d;->a(Ljava/lang/String;)I

    move-result v4

    if-ge v3, v4, :cond_0

    move v3, v4

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    int-to-float v0, v3

    const/high16 v1, 0x3f000000    # 0.5f

    mul-float v0, v0, v1

    float-to-int v0, v0

    int-to-float p1, p1

    const v1, 0x3f4ccccd    # 0.8f

    mul-float p1, p1, v1

    int-to-float p2, p2

    mul-float p2, p2, v1

    int-to-float v0, v0

    div-float/2addr p2, v0

    invoke-static {p1, p2}, Ljava/lang/Math;->min(FF)F

    move-result p1

    float-to-int p1, p1

    return p1
.end method


# virtual methods
.method public abstract a()I
.end method

.method public a(I)V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->a:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/a;->i:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/a;->isShown()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/date/g;->b(I)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/a;->invalidate()V

    return-void

    :cond_0
    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/mg/ola/common/widget/date/a;->a(II)V

    return-void
.end method

.method protected a(II)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/widget/date/a;->k:I

    iput p2, p0, Lcom/mg/ola/common/widget/date/a;->l:I

    return-void
.end method

.method public a([Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/date/a;->h:[Ljava/lang/String;

    return-void
.end method

.method protected b()V
    .locals 3

    iget v0, p0, Lcom/mg/ola/common/widget/date/a;->l:I

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->b:Lcom/mg/ola/common/widget/date/g;

    iget v2, p0, Lcom/mg/ola/common/widget/date/a;->k:I

    invoke-virtual {v0, v2}, Lcom/mg/ola/common/widget/date/g;->a(I)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->a:Landroid/os/Handler;

    iget-object v2, p0, Lcom/mg/ola/common/widget/date/a;->i:Ljava/lang/Runnable;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->b:Lcom/mg/ola/common/widget/date/g;

    iget v2, p0, Lcom/mg/ola/common/widget/date/a;->k:I

    invoke-virtual {v0, v2}, Lcom/mg/ola/common/widget/date/g;->b(I)V

    :goto_0
    iput v1, p0, Lcom/mg/ola/common/widget/date/a;->l:I

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public b(I)V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->a:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/a;->i:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/a;->isShown()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/date/g;->a(I)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/a;->a:Landroid/os/Handler;

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->i:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_0
    const/4 v0, 0x2

    invoke-virtual {p0, p1, v0}, Lcom/mg/ola/common/widget/date/a;->a(II)V

    return-void
.end method

.method public onDown(Landroid/view/MotionEvent;)Z
    .locals 1

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/a;->a:Landroid/os/Handler;

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->i:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/a;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/date/g;->b()V

    const/4 p1, 0x0

    return p1
.end method

.method public onFling(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 0

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/a;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {p1, p4}, Lcom/mg/ola/common/widget/date/g;->b(F)V

    const/4 p1, 0x0

    return p1
.end method

.method protected onFocusChanged(ZILandroid/graphics/Rect;)V
    .locals 2

    if-nez p1, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->a:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/a;->i:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_0
    invoke-super {p0, p1, p2, p3}, Landroid/view/View;->onFocusChanged(ZILandroid/graphics/Rect;)V

    return-void
.end method

.method public onLongPress(Landroid/view/MotionEvent;)V
    .locals 0

    return-void
.end method

.method protected onMeasure(II)V
    .locals 0

    invoke-super {p0, p1, p2}, Landroid/view/View;->onMeasure(II)V

    return-void
.end method

.method public onScroll(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 0

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/a;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {p1, p4}, Lcom/mg/ola/common/widget/date/g;->a(F)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/a;->invalidate()V

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

    invoke-super {p0, p1, p2, p3, p4}, Landroid/view/View;->onSizeChanged(IIII)V

    div-int/lit8 p3, p2, 0x5

    iput p3, p0, Lcom/mg/ola/common/widget/date/a;->f:I

    int-to-float p3, p1

    const p4, 0x3f6ccccd    # 0.925f

    mul-float p3, p3, p4

    float-to-int p3, p3

    iput p3, p0, Lcom/mg/ola/common/widget/date/a;->g:I

    iget p3, p0, Lcom/mg/ola/common/widget/date/a;->f:I

    invoke-direct {p0, p3, p1}, Lcom/mg/ola/common/widget/date/a;->b(II)I

    move-result p1

    iget-object p3, p0, Lcom/mg/ola/common/widget/date/a;->c:Landroid/graphics/Paint;

    int-to-float p1, p1

    invoke-virtual {p3, p1}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/a;->c:Landroid/graphics/Paint;

    invoke-virtual {p1}, Landroid/graphics/Paint;->ascent()F

    move-result p1

    neg-float p1, p1

    const p3, 0x3eb33333    # 0.35f

    mul-float p1, p1, p3

    float-to-int p1, p1

    iput p1, p0, Lcom/mg/ola/common/widget/date/a;->e:I

    int-to-float p1, p2

    const/high16 p2, 0x3f000000    # 0.5f

    mul-float p1, p1, p2

    float-to-int p1, p1

    iput p1, p0, Lcom/mg/ola/common/widget/date/a;->d:I

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->j:Landroid/view/GestureDetector;

    invoke-virtual {v0, p1}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    :cond_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/date/g;->c()V

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/date/g;->d()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a;->a:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/a;->i:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_1
    invoke-super {p0, p1}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method
