.class public Lcom/mg/ola/common/widget/RotateImageView;
.super Landroid/widget/ImageView;


# instance fields
.field private a:I

.field private b:I

.field private c:I

.field private d:Z

.field private e:J

.field private f:J


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->a:I

    iput p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->b:I

    iput p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->c:I

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->d:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/mg/ola/common/widget/RotateImageView;->e:J

    iput-wide v0, p0, Lcom/mg/ola/common/widget/RotateImageView;->f:J

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->a:I

    iput p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->b:I

    iput p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->c:I

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->d:Z

    const-wide/16 p1, 0x0

    iput-wide p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->e:J

    iput-wide p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->f:J

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->a:I

    iput p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->b:I

    iput p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->c:I

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->d:Z

    const-wide/16 p1, 0x0

    iput-wide p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->e:J

    iput-wide p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->f:J

    return-void
.end method


# virtual methods
.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 10

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/RotateImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v1

    iget v2, v1, Landroid/graphics/Rect;->right:I

    iget v3, v1, Landroid/graphics/Rect;->left:I

    sub-int/2addr v2, v3

    iget v3, v1, Landroid/graphics/Rect;->bottom:I

    iget v1, v1, Landroid/graphics/Rect;->top:I

    sub-int/2addr v3, v1

    if-eqz v2, :cond_6

    if-nez v3, :cond_1

    return-void

    :cond_1
    iget v1, p0, Lcom/mg/ola/common/widget/RotateImageView;->a:I

    iget v4, p0, Lcom/mg/ola/common/widget/RotateImageView;->c:I

    if-eq v1, v4, :cond_5

    invoke-static {}, Landroid/view/animation/AnimationUtils;->currentAnimationTimeMillis()J

    move-result-wide v4

    iget-wide v6, p0, Lcom/mg/ola/common/widget/RotateImageView;->f:J

    cmp-long v1, v4, v6

    if-gez v1, :cond_4

    iget-wide v6, p0, Lcom/mg/ola/common/widget/RotateImageView;->e:J

    sub-long v8, v4, v6

    long-to-int v1, v8

    iget v4, p0, Lcom/mg/ola/common/widget/RotateImageView;->b:I

    iget-boolean v5, p0, Lcom/mg/ola/common/widget/RotateImageView;->d:Z

    if-eqz v5, :cond_2

    goto :goto_0

    :cond_2
    neg-int v1, v1

    :goto_0
    mul-int/lit16 v1, v1, 0xb4

    div-int/lit16 v1, v1, 0x3e8

    add-int/2addr v4, v1

    if-ltz v4, :cond_3

    rem-int/lit16 v4, v4, 0x168

    goto :goto_1

    :cond_3
    rem-int/lit16 v4, v4, 0x168

    add-int/lit16 v4, v4, 0x168

    :goto_1
    iput v4, p0, Lcom/mg/ola/common/widget/RotateImageView;->a:I

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/RotateImageView;->invalidate()V

    goto :goto_2

    :cond_4
    iget v1, p0, Lcom/mg/ola/common/widget/RotateImageView;->c:I

    iput v1, p0, Lcom/mg/ola/common/widget/RotateImageView;->a:I

    :cond_5
    :goto_2
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/RotateImageView;->getPaddingLeft()I

    move-result v1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/RotateImageView;->getPaddingTop()I

    move-result v4

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/RotateImageView;->getPaddingRight()I

    move-result v5

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/RotateImageView;->getPaddingBottom()I

    move-result v6

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/RotateImageView;->getWidth()I

    move-result v7

    sub-int/2addr v7, v1

    sub-int/2addr v7, v5

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/RotateImageView;->getHeight()I

    move-result v5

    sub-int/2addr v5, v4

    sub-int/2addr v5, v6

    invoke-virtual {p1}, Landroid/graphics/Canvas;->getSaveCount()I

    move-result v6

    div-int/lit8 v7, v7, 0x2

    add-int/2addr v1, v7

    int-to-float v1, v1

    div-int/lit8 v5, v5, 0x2

    add-int/2addr v4, v5

    int-to-float v4, v4

    invoke-virtual {p1, v1, v4}, Landroid/graphics/Canvas;->translate(FF)V

    iget v1, p0, Lcom/mg/ola/common/widget/RotateImageView;->a:I

    neg-int v1, v1

    int-to-float v1, v1

    invoke-virtual {p1, v1}, Landroid/graphics/Canvas;->rotate(F)V

    neg-int v1, v2

    div-int/lit8 v1, v1, 0x2

    int-to-float v1, v1

    neg-int v2, v3

    div-int/lit8 v2, v2, 0x2

    int-to-float v2, v2

    invoke-virtual {p1, v1, v2}, Landroid/graphics/Canvas;->translate(FF)V

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    invoke-virtual {p1, v6}, Landroid/graphics/Canvas;->restoreToCount(I)V

    :cond_6
    return-void
.end method

.method public setDegree(I)V
    .locals 7

    if-ltz p1, :cond_0

    rem-int/lit16 p1, p1, 0x168

    goto :goto_0

    :cond_0
    rem-int/lit16 p1, p1, 0x168

    add-int/lit16 p1, p1, 0x168

    :goto_0
    iget v0, p0, Lcom/mg/ola/common/widget/RotateImageView;->c:I

    if-ne p1, v0, :cond_1

    return-void

    :cond_1
    iput p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->c:I

    iget p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->a:I

    iput p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->b:I

    invoke-static {}, Landroid/view/animation/AnimationUtils;->currentAnimationTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/mg/ola/common/widget/RotateImageView;->e:J

    iget p1, p0, Lcom/mg/ola/common/widget/RotateImageView;->c:I

    iget v0, p0, Lcom/mg/ola/common/widget/RotateImageView;->a:I

    sub-int/2addr p1, v0

    if-ltz p1, :cond_2

    goto :goto_1

    :cond_2
    add-int/lit16 p1, p1, 0x168

    :goto_1
    const/16 v0, 0xb4

    if-le p1, v0, :cond_3

    add-int/lit16 p1, p1, -0x168

    :cond_3
    if-ltz p1, :cond_4

    const/4 v1, 0x1

    goto :goto_2

    :cond_4
    const/4 v1, 0x0

    :goto_2
    iput-boolean v1, p0, Lcom/mg/ola/common/widget/RotateImageView;->d:Z

    iget-wide v1, p0, Lcom/mg/ola/common/widget/RotateImageView;->e:J

    invoke-static {p1}, Ljava/lang/Math;->abs(I)I

    move-result p1

    mul-int/lit16 p1, p1, 0x3e8

    div-int/2addr p1, v0

    int-to-long v3, p1

    add-long v5, v1, v3

    iput-wide v5, p0, Lcom/mg/ola/common/widget/RotateImageView;->f:J

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/RotateImageView;->invalidate()V

    return-void
.end method
