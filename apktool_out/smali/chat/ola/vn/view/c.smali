.class public abstract Lchat/ola/vn/view/c;
.super Landroid/widget/ImageView;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/c$a;
    }
.end annotation


# instance fields
.field private final a:Landroid/graphics/Matrix;

.field private final b:[F

.field private c:Lchat/ola/vn/view/c$a;

.field private d:Ljava/lang/Runnable;

.field protected g:Landroid/graphics/Matrix;

.field protected h:Landroid/graphics/Matrix;

.field protected final i:Lcom/mg/ola/common/a/a;

.field j:I

.field k:I

.field l:F

.field m:I

.field n:I

.field o:I

.field p:I

.field protected q:Landroid/os/Handler;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    new-instance p1, Landroid/graphics/Matrix;

    invoke-direct {p1}, Landroid/graphics/Matrix;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/c;->g:Landroid/graphics/Matrix;

    new-instance p1, Landroid/graphics/Matrix;

    invoke-direct {p1}, Landroid/graphics/Matrix;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/c;->h:Landroid/graphics/Matrix;

    new-instance p1, Landroid/graphics/Matrix;

    invoke-direct {p1}, Landroid/graphics/Matrix;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/c;->a:Landroid/graphics/Matrix;

    const/16 p1, 0x9

    new-array p1, p1, [F

    iput-object p1, p0, Lchat/ola/vn/view/c;->b:[F

    new-instance p1, Lcom/mg/ola/common/a/a;

    const/4 v0, 0x0

    invoke-direct {p1, v0}, Lcom/mg/ola/common/a/a;-><init>(Landroid/graphics/Bitmap;)V

    iput-object p1, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    const/4 p1, -0x1

    iput p1, p0, Lchat/ola/vn/view/c;->j:I

    iput p1, p0, Lchat/ola/vn/view/c;->k:I

    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/c;->q:Landroid/os/Handler;

    iput-object v0, p0, Lchat/ola/vn/view/c;->d:Ljava/lang/Runnable;

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->a()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance p1, Landroid/graphics/Matrix;

    invoke-direct {p1}, Landroid/graphics/Matrix;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/c;->g:Landroid/graphics/Matrix;

    new-instance p1, Landroid/graphics/Matrix;

    invoke-direct {p1}, Landroid/graphics/Matrix;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/c;->h:Landroid/graphics/Matrix;

    new-instance p1, Landroid/graphics/Matrix;

    invoke-direct {p1}, Landroid/graphics/Matrix;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/c;->a:Landroid/graphics/Matrix;

    const/16 p1, 0x9

    new-array p1, p1, [F

    iput-object p1, p0, Lchat/ola/vn/view/c;->b:[F

    new-instance p1, Lcom/mg/ola/common/a/a;

    const/4 p2, 0x0

    invoke-direct {p1, p2}, Lcom/mg/ola/common/a/a;-><init>(Landroid/graphics/Bitmap;)V

    iput-object p1, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    const/4 p1, -0x1

    iput p1, p0, Lchat/ola/vn/view/c;->j:I

    iput p1, p0, Lchat/ola/vn/view/c;->k:I

    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/c;->q:Landroid/os/Handler;

    iput-object p2, p0, Lchat/ola/vn/view/c;->d:Ljava/lang/Runnable;

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->a()V

    return-void
.end method

.method private a(Landroid/graphics/Bitmap;I)V
    .locals 2

    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setDither(Z)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/a/a;->b()Landroid/graphics/Bitmap;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    invoke-virtual {v1, p1}, Lcom/mg/ola/common/a/a;->a(Landroid/graphics/Bitmap;)V

    iget-object v1, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    invoke-virtual {v1, p2}, Lcom/mg/ola/common/a/a;->a(I)V

    if-eqz v0, :cond_1

    if-eq v0, p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/c;->c:Lchat/ola/vn/view/c$a;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/c;->c:Lchat/ola/vn/view/c$a;

    invoke-interface {p1, v0}, Lchat/ola/vn/view/c$a;->a(Landroid/graphics/Bitmap;)V

    :cond_1
    return-void
.end method

.method private a(Lcom/mg/ola/common/a/a;Landroid/graphics/Matrix;)V
    .locals 7

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getWidth()I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getHeight()I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {p1}, Lcom/mg/ola/common/a/a;->f()I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {p1}, Lcom/mg/ola/common/a/a;->e()I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {p2}, Landroid/graphics/Matrix;->reset()V

    div-float v4, v0, v2

    const/high16 v5, 0x40000000    # 2.0f

    invoke-static {v4, v5}, Ljava/lang/Math;->min(FF)F

    move-result v4

    div-float v6, v1, v3

    invoke-static {v6, v5}, Ljava/lang/Math;->min(FF)F

    move-result v6

    invoke-static {v4, v6}, Ljava/lang/Math;->min(FF)F

    move-result v4

    invoke-virtual {p1}, Lcom/mg/ola/common/a/a;->c()Landroid/graphics/Matrix;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/graphics/Matrix;->postConcat(Landroid/graphics/Matrix;)Z

    invoke-virtual {p2, v4, v4}, Landroid/graphics/Matrix;->postScale(FF)Z

    mul-float v2, v2, v4

    sub-float/2addr v0, v2

    div-float/2addr v0, v5

    mul-float v3, v3, v4

    sub-float/2addr v1, v3

    div-float/2addr v1, v5

    invoke-virtual {p2, v0, v1}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    return-void
.end method


# virtual methods
.method protected a(Landroid/graphics/Matrix;)F
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/view/c;->a(Landroid/graphics/Matrix;I)F

    move-result p1

    return p1
.end method

.method protected a(Landroid/graphics/Matrix;I)F
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/c;->b:[F

    invoke-virtual {p1, v0}, Landroid/graphics/Matrix;->getValues([F)V

    iget-object p1, p0, Lchat/ola/vn/view/c;->b:[F

    aget p1, p1, p2

    return p1
.end method

.method protected a()V
    .locals 1

    sget-object v0, Landroid/widget/ImageView$ScaleType;->MATRIX:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/c;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void
.end method

.method protected a(F)V
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getWidth()I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getHeight()I

    move-result v2

    int-to-float v2, v2

    div-float/2addr v2, v1

    invoke-virtual {p0, p1, v0, v2}, Lchat/ola/vn/view/c;->a(FFF)V

    return-void
.end method

.method protected a(FF)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/c;->h:Landroid/graphics/Matrix;

    invoke-virtual {v0, p1, p2}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    return-void
.end method

.method protected a(FFF)V
    .locals 1

    iget v0, p0, Lchat/ola/vn/view/c;->l:F

    cmpl-float v0, p1, v0

    if-lez v0, :cond_0

    iget p1, p0, Lchat/ola/vn/view/c;->l:F

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getScale()F

    move-result v0

    div-float/2addr p1, v0

    iget-object v0, p0, Lchat/ola/vn/view/c;->h:Landroid/graphics/Matrix;

    invoke-virtual {v0, p1, p1, p2, p3}, Landroid/graphics/Matrix;->postScale(FFFF)Z

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getImageViewMatrix()Landroid/graphics/Matrix;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/c;->setImageMatrix(Landroid/graphics/Matrix;)V

    const/4 p1, 0x1

    invoke-virtual {p0, p1, p1}, Lchat/ola/vn/view/c;->a(ZZ)V

    return-void
.end method

.method protected a(FFFFLjava/lang/Runnable;)V
    .locals 13

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getScale()F

    move-result v0

    sub-float v0, p1, v0

    div-float v7, v0, p4

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getScale()F

    move-result v6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    move-object v0, p0

    iget-object v11, v0, Lchat/ola/vn/view/c;->q:Landroid/os/Handler;

    new-instance v12, Lchat/ola/vn/view/c$2;

    move-object v1, v12

    move-object v2, v0

    move/from16 v3, p4

    move v8, p2

    move/from16 v9, p3

    move-object/from16 v10, p5

    invoke-direct/range {v1 .. v10}, Lchat/ola/vn/view/c$2;-><init>(Lchat/ola/vn/view/c;FJFFFFLjava/lang/Runnable;)V

    invoke-virtual {v11, v12}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Landroid/graphics/Bitmap;Z)V
    .locals 1

    new-instance v0, Lcom/mg/ola/common/a/a;

    invoke-direct {v0, p1}, Lcom/mg/ola/common/a/a;-><init>(Landroid/graphics/Bitmap;)V

    invoke-virtual {p0, v0, p2}, Lchat/ola/vn/view/c;->a(Lcom/mg/ola/common/a/a;Z)V

    return-void
.end method

.method public a(Lcom/mg/ola/common/a/a;Z)V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getWidth()I

    move-result v0

    if-gtz v0, :cond_0

    new-instance v0, Lchat/ola/vn/view/c$1;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/view/c$1;-><init>(Lchat/ola/vn/view/c;Lcom/mg/ola/common/a/a;Z)V

    iput-object v0, p0, Lchat/ola/vn/view/c;->d:Ljava/lang/Runnable;

    return-void

    :cond_0
    invoke-virtual {p1}, Lcom/mg/ola/common/a/a;->b()Landroid/graphics/Bitmap;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/c;->g:Landroid/graphics/Matrix;

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/view/c;->a(Lcom/mg/ola/common/a/a;Landroid/graphics/Matrix;)V

    invoke-virtual {p1}, Lcom/mg/ola/common/a/a;->b()Landroid/graphics/Bitmap;

    move-result-object v0

    invoke-virtual {p1}, Lcom/mg/ola/common/a/a;->a()I

    move-result p1

    invoke-direct {p0, v0, p1}, Lchat/ola/vn/view/c;->a(Landroid/graphics/Bitmap;I)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/view/c;->g:Landroid/graphics/Matrix;

    invoke-virtual {p1}, Landroid/graphics/Matrix;->reset()V

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/c;->setImageBitmap(Landroid/graphics/Bitmap;)V

    :goto_0
    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/view/c;->h:Landroid/graphics/Matrix;

    invoke-virtual {p1}, Landroid/graphics/Matrix;->reset()V

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getImageViewMatrix()Landroid/graphics/Matrix;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/c;->setImageMatrix(Landroid/graphics/Matrix;)V

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->b()F

    move-result p1

    iput p1, p0, Lchat/ola/vn/view/c;->l:F

    return-void
.end method

.method protected a(ZZ)V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/a/a;->b()Landroid/graphics/Bitmap;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getImageViewMatrix()Landroid/graphics/Matrix;

    move-result-object v0

    new-instance v1, Landroid/graphics/RectF;

    iget-object v2, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    invoke-virtual {v2}, Lcom/mg/ola/common/a/a;->b()Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    int-to-float v2, v2

    iget-object v3, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    invoke-virtual {v3}, Lcom/mg/ola/common/a/a;->b()Landroid/graphics/Bitmap;

    move-result-object v3

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v3

    int-to-float v3, v3

    const/4 v4, 0x0

    invoke-direct {v1, v4, v4, v2, v3}, Landroid/graphics/RectF;-><init>(FFFF)V

    invoke-virtual {v0, v1}, Landroid/graphics/Matrix;->mapRect(Landroid/graphics/RectF;)Z

    invoke-virtual {v1}, Landroid/graphics/RectF;->height()F

    move-result v0

    invoke-virtual {v1}, Landroid/graphics/RectF;->width()F

    move-result v2

    const/high16 v3, 0x40000000    # 2.0f

    if-eqz p2, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getHeight()I

    move-result p2

    int-to-float p2, p2

    cmpg-float v5, v0, p2

    if-gez v5, :cond_1

    sub-float/2addr p2, v0

    div-float/2addr p2, v3

    iget v0, v1, Landroid/graphics/RectF;->top:F

    :goto_0
    sub-float/2addr p2, v0

    goto :goto_1

    :cond_1
    iget v0, v1, Landroid/graphics/RectF;->top:F

    cmpl-float v0, v0, v4

    if-lez v0, :cond_2

    iget p2, v1, Landroid/graphics/RectF;->top:F

    neg-float p2, p2

    goto :goto_1

    :cond_2
    iget v0, v1, Landroid/graphics/RectF;->bottom:F

    cmpg-float p2, v0, p2

    if-gez p2, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getHeight()I

    move-result p2

    int-to-float p2, p2

    iget v0, v1, Landroid/graphics/RectF;->bottom:F

    goto :goto_0

    :cond_3
    const/4 p2, 0x0

    :goto_1
    if-eqz p1, :cond_6

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getWidth()I

    move-result p1

    int-to-float p1, p1

    cmpg-float v0, v2, p1

    if-gez v0, :cond_4

    sub-float/2addr p1, v2

    div-float/2addr p1, v3

    iget v0, v1, Landroid/graphics/RectF;->left:F

    :goto_2
    sub-float v4, p1, v0

    goto :goto_3

    :cond_4
    iget v0, v1, Landroid/graphics/RectF;->left:F

    cmpl-float v0, v0, v4

    if-lez v0, :cond_5

    iget p1, v1, Landroid/graphics/RectF;->left:F

    neg-float v4, p1

    goto :goto_3

    :cond_5
    iget v0, v1, Landroid/graphics/RectF;->right:F

    cmpg-float v0, v0, p1

    if-gez v0, :cond_6

    iget v0, v1, Landroid/graphics/RectF;->right:F

    goto :goto_2

    :cond_6
    :goto_3
    invoke-virtual {p0, v4, p2}, Lchat/ola/vn/view/c;->a(FF)V

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getImageViewMatrix()Landroid/graphics/Matrix;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/c;->setImageMatrix(Landroid/graphics/Matrix;)V

    return-void
.end method

.method protected b()F
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/a/a;->b()Landroid/graphics/Bitmap;

    move-result-object v0

    if-nez v0, :cond_0

    const/high16 v0, 0x3f800000    # 1.0f

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/a/a;->f()I

    move-result v0

    int-to-float v0, v0

    iget v1, p0, Lchat/ola/vn/view/c;->j:I

    int-to-float v1, v1

    div-float/2addr v0, v1

    iget-object v1, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    invoke-virtual {v1}, Lcom/mg/ola/common/a/a;->e()I

    move-result v1

    int-to-float v1, v1

    iget v2, p0, Lchat/ola/vn/view/c;->k:I

    int-to-float v2, v2

    div-float/2addr v1, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    const/high16 v1, 0x40800000    # 4.0f

    mul-float v0, v0, v1

    return v0
.end method

.method protected b(FF)V
    .locals 0

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/view/c;->a(FF)V

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getImageViewMatrix()Landroid/graphics/Matrix;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/c;->setImageMatrix(Landroid/graphics/Matrix;)V

    return-void
.end method

.method protected getImageViewMatrix()Landroid/graphics/Matrix;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/c;->a:Landroid/graphics/Matrix;

    iget-object v1, p0, Lchat/ola/vn/view/c;->g:Landroid/graphics/Matrix;

    invoke-virtual {v0, v1}, Landroid/graphics/Matrix;->set(Landroid/graphics/Matrix;)V

    iget-object v0, p0, Lchat/ola/vn/view/c;->a:Landroid/graphics/Matrix;

    iget-object v1, p0, Lchat/ola/vn/view/c;->h:Landroid/graphics/Matrix;

    invoke-virtual {v0, v1}, Landroid/graphics/Matrix;->postConcat(Landroid/graphics/Matrix;)Z

    iget-object v0, p0, Lchat/ola/vn/view/c;->a:Landroid/graphics/Matrix;

    return-object v0
.end method

.method protected getScale()F
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/c;->h:Landroid/graphics/Matrix;

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/c;->a(Landroid/graphics/Matrix;)F

    move-result v0

    return v0
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 2

    const/4 v0, 0x4

    if-ne p1, v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getScale()F

    move-result v0

    const/high16 v1, 0x3f800000    # 1.0f

    cmpl-float v0, v0, v1

    if-lez v0, :cond_0

    invoke-virtual {p0, v1}, Lchat/ola/vn/view/c;->a(F)V

    const/4 p1, 0x1

    return p1

    :cond_0
    invoke-super {p0, p1, p2}, Landroid/widget/ImageView;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method

.method protected onLayout(ZIIII)V
    .locals 0

    invoke-super/range {p0 .. p5}, Landroid/widget/ImageView;->onLayout(ZIIII)V

    iput p2, p0, Lchat/ola/vn/view/c;->m:I

    iput p4, p0, Lchat/ola/vn/view/c;->n:I

    iput p3, p0, Lchat/ola/vn/view/c;->o:I

    iput p5, p0, Lchat/ola/vn/view/c;->p:I

    sub-int/2addr p4, p2

    iput p4, p0, Lchat/ola/vn/view/c;->j:I

    sub-int/2addr p5, p3

    iput p5, p0, Lchat/ola/vn/view/c;->k:I

    iget-object p1, p0, Lchat/ola/vn/view/c;->d:Ljava/lang/Runnable;

    if-eqz p1, :cond_0

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/view/c;->d:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    invoke-virtual {p1}, Lcom/mg/ola/common/a/a;->b()Landroid/graphics/Bitmap;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/c;->i:Lcom/mg/ola/common/a/a;

    iget-object p2, p0, Lchat/ola/vn/view/c;->g:Landroid/graphics/Matrix;

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/view/c;->a(Lcom/mg/ola/common/a/a;Landroid/graphics/Matrix;)V

    invoke-virtual {p0}, Lchat/ola/vn/view/c;->getImageViewMatrix()Landroid/graphics/Matrix;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/c;->setImageMatrix(Landroid/graphics/Matrix;)V

    :cond_1
    return-void
.end method

.method public setImageBitmap(Landroid/graphics/Bitmap;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/view/c;->a(Landroid/graphics/Bitmap;I)V

    return-void
.end method

.method public setRecycler(Lchat/ola/vn/view/c$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/c;->c:Lchat/ola/vn/view/c$a;

    return-void
.end method
