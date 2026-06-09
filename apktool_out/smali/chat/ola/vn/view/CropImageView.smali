.class public Lchat/ola/vn/view/CropImageView;
.super Lchat/ola/vn/view/c;


# instance fields
.field public a:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/view/HighlightView;",
            ">;"
        }
    .end annotation
.end field

.field b:Lchat/ola/vn/view/HighlightView;

.field c:F

.field d:F

.field e:I

.field public f:Z

.field private r:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/view/c;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/CropImageView;->b:Lchat/ola/vn/view/HighlightView;

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->a()V

    return-void
.end method

.method private a(Landroid/view/MotionEvent;)V
    .locals 4

    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/HighlightView;

    invoke-virtual {v2, v0}, Lchat/ola/vn/view/HighlightView;->a(Z)V

    invoke-virtual {v2}, Lchat/ola/vn/view/HighlightView;->c()V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    :goto_1
    iget-object v1, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/HighlightView;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v3

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/view/HighlightView;->a(FF)I

    move-result v2

    const/4 v3, 0x1

    if-eq v2, v3, :cond_1

    invoke-virtual {v1}, Lchat/ola/vn/view/HighlightView;->a()Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {v1, v3}, Lchat/ola/vn/view/HighlightView;->a(Z)V

    invoke-virtual {v1}, Lchat/ola/vn/view/HighlightView;->c()V

    goto :goto_2

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_2
    :goto_2
    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->invalidate()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/CropImageView;Lchat/ola/vn/view/HighlightView;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/CropImageView;->b(Lchat/ola/vn/view/HighlightView;)V

    return-void
.end method

.method private b(Lchat/ola/vn/view/HighlightView;)V
    .locals 5

    iget-object p1, p1, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getLeft()I

    move-result v0

    iget v1, p1, Landroid/graphics/Rect;->left:I

    sub-int/2addr v0, v1

    const/4 v1, 0x0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getRight()I

    move-result v2

    iget v3, p1, Landroid/graphics/Rect;->right:I

    sub-int/2addr v2, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getTop()I

    move-result v3

    iget v4, p1, Landroid/graphics/Rect;->top:I

    sub-int/2addr v3, v4

    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getBottom()I

    move-result v4

    iget p1, p1, Landroid/graphics/Rect;->bottom:I

    sub-int/2addr v4, p1

    invoke-static {v1, v4}, Ljava/lang/Math;->min(II)I

    move-result p1

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    move v0, v2

    :goto_0
    if-eqz v3, :cond_1

    move p1, v3

    :cond_1
    if-nez v0, :cond_2

    if-eqz p1, :cond_3

    :cond_2
    int-to-float v0, v0

    int-to-float p1, p1

    invoke-virtual {p0, v0, p1}, Lchat/ola/vn/view/CropImageView;->b(FF)V

    :cond_3
    return-void
.end method

.method private c(Lchat/ola/vn/view/HighlightView;)V
    .locals 8

    iget-object v0, p1, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getHeight()I

    move-result v3

    int-to-float v3, v3

    div-float/2addr v2, v1

    const v1, 0x3f19999a    # 0.6f

    mul-float v2, v2, v1

    div-float/2addr v3, v0

    mul-float v3, v3, v1

    invoke-static {v2, v3}, Ljava/lang/Math;->min(FF)F

    move-result v0

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getScale()F

    move-result v1

    mul-float v0, v0, v1

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-static {v1, v0}, Ljava/lang/Math;->max(FF)F

    move-result v3

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getScale()F

    move-result v0

    sub-float v0, v3, v0

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    div-float/2addr v0, v3

    float-to-double v0, v0

    const-wide v4, 0x3fb999999999999aL    # 0.1

    cmpl-double v2, v0, v4

    if-lez v2, :cond_0

    const/4 v0, 0x2

    new-array v0, v0, [F

    iget-object v1, p1, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    invoke-virtual {v1}, Landroid/graphics/RectF;->centerX()F

    move-result v1

    const/4 v2, 0x0

    aput v1, v0, v2

    iget-object v1, p1, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    invoke-virtual {v1}, Landroid/graphics/RectF;->centerY()F

    move-result v1

    const/4 v4, 0x1

    aput v1, v0, v4

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getImageMatrix()Landroid/graphics/Matrix;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/graphics/Matrix;->mapPoints([F)V

    aget v1, v0, v2

    aget v5, v0, v4

    const/high16 v6, 0x43960000    # 300.0f

    new-instance v7, Lchat/ola/vn/view/CropImageView$2;

    invoke-direct {v7, p0, p1}, Lchat/ola/vn/view/CropImageView$2;-><init>(Lchat/ola/vn/view/CropImageView;Lchat/ola/vn/view/HighlightView;)V

    move-object v2, p0

    move v4, v1

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/view/CropImageView;->a(FFFFLjava/lang/Runnable;)V

    :cond_0
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-super {p0}, Lchat/ola/vn/view/c;->a()V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Lchat/ola/vn/view/CropImageView$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/CropImageView$1;-><init>(Lchat/ola/vn/view/CropImageView;)V

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/CropImageView;->post(Ljava/lang/Runnable;)Z

    :cond_0
    return-void
.end method

.method protected a(FF)V
    .locals 3

    invoke-super {p0, p1, p2}, Lchat/ola/vn/view/c;->a(FF)V

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/HighlightView;

    iget-object v2, v1, Lchat/ola/vn/view/HighlightView;->f:Landroid/graphics/Matrix;

    invoke-virtual {v2, p1, p2}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    invoke-virtual {v1}, Lchat/ola/vn/view/HighlightView;->c()V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method protected a(FFF)V
    .locals 1

    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/view/c;->a(FFF)V

    iget-object p1, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/HighlightView;

    iget-object p3, p2, Lchat/ola/vn/view/HighlightView;->f:Landroid/graphics/Matrix;

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getImageMatrix()Landroid/graphics/Matrix;

    move-result-object v0

    invoke-virtual {p3, v0}, Landroid/graphics/Matrix;->set(Landroid/graphics/Matrix;)V

    invoke-virtual {p2}, Lchat/ola/vn/view/HighlightView;->c()V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/view/HighlightView;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->invalidate()V

    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    :try_start_0
    invoke-super {p0, p1}, Lchat/ola/vn/view/c;->onDraw(Landroid/graphics/Canvas;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->r:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/view/CropImageView$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/CropImageView$3;-><init>(Lchat/ola/vn/view/CropImageView;)V

    iput-object v0, p0, Lchat/ola/vn/view/CropImageView;->r:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->r:Ljava/lang/Runnable;

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/CropImageView;->post(Ljava/lang/Runnable;)Z

    :cond_1
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/HighlightView;

    invoke-virtual {v1, p1}, Lchat/ola/vn/view/HighlightView;->a(Landroid/graphics/Canvas;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_2
    return-void
.end method

.method protected onLayout(ZIIII)V
    .locals 0

    invoke-super/range {p0 .. p5}, Lchat/ola/vn/view/c;->onLayout(ZIIII)V

    iget-object p1, p0, Lchat/ola/vn/view/CropImageView;->i:Lcom/mg/ola/common/a/a;

    invoke-virtual {p1}, Lcom/mg/ola/common/a/a;->b()Landroid/graphics/Bitmap;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/HighlightView;

    iget-object p3, p2, Lchat/ola/vn/view/HighlightView;->f:Landroid/graphics/Matrix;

    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getImageMatrix()Landroid/graphics/Matrix;

    move-result-object p4

    invoke-virtual {p3, p4}, Landroid/graphics/Matrix;->set(Landroid/graphics/Matrix;)V

    invoke-virtual {p2}, Lchat/ola/vn/view/HighlightView;->c()V

    iget-boolean p3, p2, Lchat/ola/vn/view/HighlightView;->b:Z

    if-eqz p3, :cond_0

    invoke-direct {p0, p2}, Lchat/ola/vn/view/CropImageView;->c(Lchat/ola/vn/view/HighlightView;)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 6

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_6

    :pswitch_0
    iget-boolean v0, p0, Lchat/ola/vn/view/CropImageView;->f:Z

    if-eqz v0, :cond_0

    goto/16 :goto_3

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->b:Lchat/ola/vn/view/HighlightView;

    if-eqz v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->b:Lchat/ola/vn/view/HighlightView;

    iget v1, p0, Lchat/ola/vn/view/CropImageView;->e:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v3

    iget v4, p0, Lchat/ola/vn/view/CropImageView;->c:F

    sub-float/2addr v3, v4

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v4

    iget v5, p0, Lchat/ola/vn/view/CropImageView;->d:F

    sub-float/2addr v4, v5

    invoke-virtual {v0, v1, v3, v4}, Lchat/ola/vn/view/HighlightView;->a(IFF)V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    iput v0, p0, Lchat/ola/vn/view/CropImageView;->c:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v0

    iput v0, p0, Lchat/ola/vn/view/CropImageView;->d:F

    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->b:Lchat/ola/vn/view/HighlightView;

    invoke-direct {p0, v0}, Lchat/ola/vn/view/CropImageView;->b(Lchat/ola/vn/view/HighlightView;)V

    goto/16 :goto_6

    :pswitch_1
    iget-boolean v0, p0, Lchat/ola/vn/view/CropImageView;->f:Z

    if-eqz v0, :cond_4

    const/4 v0, 0x0

    :goto_0
    iget-object v3, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v0, v3, :cond_5

    iget-object v3, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/HighlightView;

    invoke-virtual {v3}, Lchat/ola/vn/view/HighlightView;->a()Z

    move-result v4

    if-eqz v4, :cond_3

    const/4 p1, 0x0

    :goto_1
    iget-object v4, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-ge p1, v4, :cond_2

    if-ne p1, v0, :cond_1

    goto :goto_2

    :cond_1
    iget-object v4, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v4, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/view/HighlightView;

    invoke-virtual {v4, v2}, Lchat/ola/vn/view/HighlightView;->b(Z)V

    :goto_2
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    :cond_2
    invoke-direct {p0, v3}, Lchat/ola/vn/view/CropImageView;->c(Lchat/ola/vn/view/HighlightView;)V

    iput-boolean v1, p0, Lchat/ola/vn/view/CropImageView;->f:Z

    return v2

    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->b:Lchat/ola/vn/view/HighlightView;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->b:Lchat/ola/vn/view/HighlightView;

    invoke-direct {p0, v0}, Lchat/ola/vn/view/CropImageView;->c(Lchat/ola/vn/view/HighlightView;)V

    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->b:Lchat/ola/vn/view/HighlightView;

    sget-object v1, Lchat/ola/vn/view/HighlightView$ModifyMode;->a:Lchat/ola/vn/view/HighlightView$ModifyMode;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/HighlightView;->a(Lchat/ola/vn/view/HighlightView$ModifyMode;)V

    :cond_5
    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/view/CropImageView;->b:Lchat/ola/vn/view/HighlightView;

    goto :goto_6

    :pswitch_2
    iget-boolean v0, p0, Lchat/ola/vn/view/CropImageView;->f:Z

    if-eqz v0, :cond_6

    :goto_3
    invoke-direct {p0, p1}, Lchat/ola/vn/view/CropImageView;->a(Landroid/view/MotionEvent;)V

    goto :goto_6

    :cond_6
    :goto_4
    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/HighlightView;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v3

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v4

    invoke-virtual {v0, v3, v4}, Lchat/ola/vn/view/HighlightView;->a(FF)I

    move-result v3

    if-eq v3, v2, :cond_8

    iput v3, p0, Lchat/ola/vn/view/CropImageView;->e:I

    iput-object v0, p0, Lchat/ola/vn/view/CropImageView;->b:Lchat/ola/vn/view/HighlightView;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    iput v0, p0, Lchat/ola/vn/view/CropImageView;->c:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v0

    iput v0, p0, Lchat/ola/vn/view/CropImageView;->d:F

    iget-object v0, p0, Lchat/ola/vn/view/CropImageView;->b:Lchat/ola/vn/view/HighlightView;

    const/16 v1, 0x20

    if-ne v3, v1, :cond_7

    sget-object v1, Lchat/ola/vn/view/HighlightView$ModifyMode;->b:Lchat/ola/vn/view/HighlightView$ModifyMode;

    goto :goto_5

    :cond_7
    sget-object v1, Lchat/ola/vn/view/HighlightView$ModifyMode;->c:Lchat/ola/vn/view/HighlightView$ModifyMode;

    :goto_5
    invoke-virtual {v0, v1}, Lchat/ola/vn/view/HighlightView;->a(Lchat/ola/vn/view/HighlightView$ModifyMode;)V

    goto :goto_6

    :cond_8
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    :cond_9
    :goto_6
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    packed-switch p1, :pswitch_data_1

    return v2

    :pswitch_3
    invoke-virtual {p0}, Lchat/ola/vn/view/CropImageView;->getScale()F

    move-result p1

    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float p1, p1, v0

    if-nez p1, :cond_a

    :pswitch_4
    invoke-virtual {p0, v2, v2}, Lchat/ola/vn/view/CropImageView;->a(ZZ)V

    :cond_a
    return v2

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
    .end packed-switch
.end method
