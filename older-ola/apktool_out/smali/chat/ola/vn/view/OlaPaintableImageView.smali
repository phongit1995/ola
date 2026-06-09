.class public Lchat/ola/vn/view/OlaPaintableImageView;
.super Landroid/widget/ImageView;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/OlaPaintableImageView$b;,
        Lchat/ola/vn/view/OlaPaintableImageView$a;
    }
.end annotation


# instance fields
.field protected a:Ljava/lang/String;

.field private b:Ljava/util/Stack;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Stack<",
            "Lchat/ola/vn/view/OlaPaintableImageView$a;",
            ">;"
        }
    .end annotation
.end field

.field private c:Lchat/ola/vn/view/OlaPaintableImageView$a;

.field private d:Landroid/graphics/Paint;

.field private e:Lchat/ola/vn/view/OlaPaintableImageView$b;

.field private f:Z

.field private g:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    new-instance p1, Lchat/ola/vn/view/OlaPaintableImageView$b;

    const/4 v0, 0x0

    invoke-direct {p1, p0, v0, v0}, Lchat/ola/vn/view/OlaPaintableImageView$b;-><init>(Lchat/ola/vn/view/OlaPaintableImageView;FF)V

    iput-object p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->a:Ljava/lang/String;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->f:Z

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->g:Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance p1, Lchat/ola/vn/view/OlaPaintableImageView$b;

    const/4 p2, 0x0

    invoke-direct {p1, p0, p2, p2}, Lchat/ola/vn/view/OlaPaintableImageView$b;-><init>(Lchat/ola/vn/view/OlaPaintableImageView;FF)V

    iput-object p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->a:Ljava/lang/String;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->f:Z

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->g:Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    new-instance p1, Lchat/ola/vn/view/OlaPaintableImageView$b;

    const/4 p2, 0x0

    invoke-direct {p1, p0, p2, p2}, Lchat/ola/vn/view/OlaPaintableImageView$b;-><init>(Lchat/ola/vn/view/OlaPaintableImageView;FF)V

    iput-object p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->a:Ljava/lang/String;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->f:Z

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->g:Z

    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 4

    invoke-super {p0, p1}, Landroid/widget/ImageView;->draw(Landroid/graphics/Canvas;)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->b:Ljava/util/Stack;

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    iget-object v1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->b:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_0

    iget-object v2, p0, Lchat/ola/vn/view/OlaPaintableImageView;->b:Ljava/util/Stack;

    invoke-virtual {v2, v0}, Ljava/util/Stack;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaPaintableImageView$a;

    iget-object v2, v2, Lchat/ola/vn/view/OlaPaintableImageView$a;->a:Landroid/graphics/Path;

    iget-object v3, p0, Lchat/ola/vn/view/OlaPaintableImageView;->b:Ljava/util/Stack;

    invoke-virtual {v3, v0}, Ljava/util/Stack;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaPaintableImageView$a;

    iget-object v3, v3, Lchat/ola/vn/view/OlaPaintableImageView$a;->b:Landroid/graphics/Paint;

    invoke-virtual {p1, v2, v3}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    move-exception p1

    const-string v0, "draw"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v2, "---------"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method public getBitmapAfterPainting()Landroid/graphics/Bitmap;
    .locals 1

    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/view/OlaPaintableImageView;->setDrawingCacheEnabled(Z)V

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaPaintableImageView;->getDrawingCache()Landroid/graphics/Bitmap;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 7

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    const/4 v1, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v3, 0x1

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    invoke-super {p0, p1}, Landroid/widget/ImageView;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1

    :pswitch_1
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$b;->a:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    cmpl-float v0, v0, v2

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$b;->b:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    cmpl-float v0, v0, v2

    if-eqz v0, :cond_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->c:Lchat/ola/vn/view/OlaPaintableImageView$a;

    iget-object v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$a;->a:Landroid/graphics/Path;

    iget-object v2, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v2, v2, Lchat/ola/vn/view/OlaPaintableImageView$b;->a:F

    iget-object v4, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v4, v4, Lchat/ola/vn/view/OlaPaintableImageView$b;->b:F

    invoke-virtual {v0, v2, v4}, Landroid/graphics/Path;->moveTo(FF)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->c:Lchat/ola/vn/view/OlaPaintableImageView$a;

    iget-object v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$a;->a:Landroid/graphics/Path;

    iget-object v2, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v2, v2, Lchat/ola/vn/view/OlaPaintableImageView$b;->a:F

    iget-object v4, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v4, v4, Lchat/ola/vn/view/OlaPaintableImageView$b;->b:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v5

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v6

    invoke-virtual {v0, v2, v4, v5, v6}, Landroid/graphics/Path;->quadTo(FFFF)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    iput v2, v0, Lchat/ola/vn/view/OlaPaintableImageView$b;->a:F

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    iput p1, v0, Lchat/ola/vn/view/OlaPaintableImageView$b;->b:F

    iput-boolean v1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->g:Z

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaPaintableImageView;->invalidate()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return v3

    :pswitch_2
    :try_start_1
    iget-boolean v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->g:Z

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$b;->a:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v4

    cmpl-float v0, v0, v4

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$b;->b:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v4

    cmpl-float v0, v0, v4

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->c:Lchat/ola/vn/view/OlaPaintableImageView$a;

    iget-object v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$a;->a:Landroid/graphics/Path;

    iget-object v4, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v4, v4, Lchat/ola/vn/view/OlaPaintableImageView$b;->a:F

    iget-object v5, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v5, v5, Lchat/ola/vn/view/OlaPaintableImageView$b;->b:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v6

    add-float/2addr v6, v2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    add-float/2addr p1, v2

    invoke-virtual {v0, v4, v5, v6, p1}, Landroid/graphics/Path;->quadTo(FFFF)V

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$b;->a:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    cmpl-float v0, v0, v2

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$b;->b:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    cmpl-float v0, v0, v2

    if-eqz v0, :cond_4

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->c:Lchat/ola/vn/view/OlaPaintableImageView$a;

    iget-object v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$a;->a:Landroid/graphics/Path;

    iget-object v2, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v2, v2, Lchat/ola/vn/view/OlaPaintableImageView$b;->a:F

    iget-object v4, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v4, v4, Lchat/ola/vn/view/OlaPaintableImageView$b;->b:F

    invoke-virtual {v0, v2, v4}, Landroid/graphics/Path;->moveTo(FF)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->c:Lchat/ola/vn/view/OlaPaintableImageView$a;

    iget-object v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$a;->a:Landroid/graphics/Path;

    iget-object v2, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v2, v2, Lchat/ola/vn/view/OlaPaintableImageView$b;->a:F

    iget-object v4, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    iget v4, v4, Lchat/ola/vn/view/OlaPaintableImageView$b;->b:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v5

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    invoke-virtual {v0, v2, v4, v5, p1}, Landroid/graphics/Path;->quadTo(FFFF)V

    :cond_4
    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/view/OlaPaintableImageView;->invalidate()V

    iput-boolean v1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->g:Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return v3

    :pswitch_3
    :try_start_2
    new-instance v0, Lchat/ola/vn/view/OlaPaintableImageView$a;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/OlaPaintableImageView$a;-><init>(Lchat/ola/vn/view/OlaPaintableImageView;)V

    iput-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->c:Lchat/ola/vn/view/OlaPaintableImageView$a;

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->d:Landroid/graphics/Paint;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->c:Lchat/ola/vn/view/OlaPaintableImageView$a;

    iget-object v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$a;->b:Landroid/graphics/Paint;

    iget-object v1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->d:Landroid/graphics/Paint;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->set(Landroid/graphics/Paint;)V

    goto :goto_1

    :cond_5
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->d:Landroid/graphics/Paint;

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->d:Landroid/graphics/Paint;

    const/high16 v1, -0x10000

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->d:Landroid/graphics/Paint;

    const/high16 v1, 0x40000000    # 2.0f

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->d:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL_AND_STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->d:Landroid/graphics/Paint;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->d:Landroid/graphics/Paint;

    iget-object v1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->d:Landroid/graphics/Paint;

    invoke-virtual {v1}, Landroid/graphics/Paint;->getColor()I

    move-result v1

    const/4 v4, 0x0

    invoke-virtual {v0, v2, v4, v4, v1}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->c:Lchat/ola/vn/view/OlaPaintableImageView$a;

    iget-object v0, v0, Lchat/ola/vn/view/OlaPaintableImageView$a;->a:Landroid/graphics/Path;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/graphics/Path;->moveTo(FF)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->b:Ljava/util/Stack;

    if-nez v0, :cond_6

    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->b:Ljava/util/Stack;

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->b:Ljava/util/Stack;

    iget-object v1, p0, Lchat/ola/vn/view/OlaPaintableImageView;->c:Lchat/ola/vn/view/OlaPaintableImageView$a;

    invoke-virtual {v0, v1}, Ljava/util/Stack;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    iput v1, v0, Lchat/ola/vn/view/OlaPaintableImageView$b;->a:F

    iget-object v0, p0, Lchat/ola/vn/view/OlaPaintableImageView;->e:Lchat/ola/vn/view/OlaPaintableImageView$b;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    iput p1, v0, Lchat/ola/vn/view/OlaPaintableImageView$b;->b:F

    iput-boolean v3, p0, Lchat/ola/vn/view/OlaPaintableImageView;->g:Z

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaPaintableImageView;->invalidate()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    return v3

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method
