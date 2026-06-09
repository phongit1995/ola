.class public Lchat/ola/vn/view/HighlightView;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/HighlightView$ModifyMode;
    }
.end annotation


# instance fields
.field a:Landroid/view/View;

.field b:Z

.field c:Z

.field d:Landroid/graphics/Rect;

.field e:Landroid/graphics/RectF;

.field f:Landroid/graphics/Matrix;

.field private g:Lchat/ola/vn/view/HighlightView$ModifyMode;

.field private h:Landroid/graphics/RectF;

.field private i:Z

.field private j:F

.field private k:Z

.field private l:Landroid/graphics/drawable/Drawable;

.field private m:Landroid/graphics/drawable/Drawable;

.field private n:Landroid/graphics/drawable/Drawable;

.field private final o:Landroid/graphics/Paint;

.field private final p:Landroid/graphics/Paint;

.field private final q:Landroid/graphics/Paint;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lchat/ola/vn/view/HighlightView$ModifyMode;->a:Lchat/ola/vn/view/HighlightView$ModifyMode;

    iput-object v0, p0, Lchat/ola/vn/view/HighlightView;->g:Lchat/ola/vn/view/HighlightView$ModifyMode;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/view/HighlightView;->i:Z

    iput-boolean v0, p0, Lchat/ola/vn/view/HighlightView;->k:Z

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/HighlightView;->o:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/HighlightView;->p:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/HighlightView;->q:Landroid/graphics/Paint;

    iput-object p1, p0, Lchat/ola/vn/view/HighlightView;->a:Landroid/view/View;

    return-void
.end method

.method private b(FF)V
    .locals 4

    new-instance v0, Landroid/graphics/Rect;

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    invoke-direct {v0, v1}, Landroid/graphics/Rect;-><init>(Landroid/graphics/Rect;)V

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    invoke-virtual {v1, p1, p2}, Landroid/graphics/RectF;->offset(FF)V

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget-object p2, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget p2, p2, Landroid/graphics/RectF;->left:F

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v1, v1, Landroid/graphics/RectF;->left:F

    sub-float/2addr p2, v1

    const/4 v1, 0x0

    invoke-static {v1, p2}, Ljava/lang/Math;->max(FF)F

    move-result p2

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->top:F

    iget-object v3, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v3, v3, Landroid/graphics/RectF;->top:F

    sub-float/2addr v2, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    invoke-virtual {p1, p2, v2}, Landroid/graphics/RectF;->offset(FF)V

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget-object p2, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget p2, p2, Landroid/graphics/RectF;->right:F

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->right:F

    sub-float/2addr p2, v2

    invoke-static {v1, p2}, Ljava/lang/Math;->min(FF)F

    move-result p2

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->bottom:F

    iget-object v3, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v3, v3, Landroid/graphics/RectF;->bottom:F

    sub-float/2addr v2, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->min(FF)F

    move-result v1

    invoke-virtual {p1, p2, v1}, Landroid/graphics/RectF;->offset(FF)V

    invoke-direct {p0}, Lchat/ola/vn/view/HighlightView;->e()Landroid/graphics/Rect;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    invoke-virtual {v0, p1}, Landroid/graphics/Rect;->union(Landroid/graphics/Rect;)V

    const/16 p1, -0xa

    invoke-virtual {v0, p1, p1}, Landroid/graphics/Rect;->inset(II)V

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->a:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->invalidate(Landroid/graphics/Rect;)V

    return-void
.end method

.method private c(FF)V
    .locals 5

    iget-boolean v0, p0, Lchat/ola/vn/view/HighlightView;->i:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    cmpl-float v0, p1, v1

    if-eqz v0, :cond_0

    iget p2, p0, Lchat/ola/vn/view/HighlightView;->j:F

    div-float p2, p1, p2

    goto :goto_0

    :cond_0
    cmpl-float v0, p2, v1

    if-eqz v0, :cond_1

    iget p1, p0, Lchat/ola/vn/view/HighlightView;->j:F

    mul-float p1, p1, p2

    :cond_1
    :goto_0
    new-instance v0, Landroid/graphics/RectF;

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    invoke-direct {v0, v2}, Landroid/graphics/RectF;-><init>(Landroid/graphics/RectF;)V

    cmpl-float v2, p1, v1

    const/high16 v3, 0x40000000    # 2.0f

    if-lez v2, :cond_2

    invoke-virtual {v0}, Landroid/graphics/RectF;->width()F

    move-result v2

    mul-float v4, p1, v3

    add-float/2addr v2, v4

    iget-object v4, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    invoke-virtual {v4}, Landroid/graphics/RectF;->width()F

    move-result v4

    cmpl-float v2, v2, v4

    if-lez v2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    invoke-virtual {p1}, Landroid/graphics/RectF;->width()F

    move-result p1

    invoke-virtual {v0}, Landroid/graphics/RectF;->width()F

    move-result v2

    sub-float/2addr p1, v2

    div-float/2addr p1, v3

    iget-boolean v2, p0, Lchat/ola/vn/view/HighlightView;->i:Z

    if-eqz v2, :cond_2

    iget p2, p0, Lchat/ola/vn/view/HighlightView;->j:F

    div-float p2, p1, p2

    :cond_2
    cmpl-float v2, p2, v1

    if-lez v2, :cond_3

    invoke-virtual {v0}, Landroid/graphics/RectF;->height()F

    move-result v2

    mul-float v4, p2, v3

    add-float/2addr v2, v4

    iget-object v4, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    invoke-virtual {v4}, Landroid/graphics/RectF;->height()F

    move-result v4

    cmpl-float v2, v2, v4

    if-lez v2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    invoke-virtual {p2}, Landroid/graphics/RectF;->height()F

    move-result p2

    invoke-virtual {v0}, Landroid/graphics/RectF;->height()F

    move-result v2

    sub-float/2addr p2, v2

    div-float/2addr p2, v3

    iget-boolean v2, p0, Lchat/ola/vn/view/HighlightView;->i:Z

    if-eqz v2, :cond_3

    iget p1, p0, Lchat/ola/vn/view/HighlightView;->j:F

    mul-float p1, p1, p2

    :cond_3
    neg-float p1, p1

    neg-float p2, p2

    invoke-virtual {v0, p1, p2}, Landroid/graphics/RectF;->inset(FF)V

    invoke-virtual {v0}, Landroid/graphics/RectF;->width()F

    move-result p1

    const/high16 p2, 0x41c80000    # 25.0f

    cmpg-float p1, p1, p2

    if-gez p1, :cond_4

    invoke-virtual {v0}, Landroid/graphics/RectF;->width()F

    move-result p1

    sub-float p1, p2, p1

    neg-float p1, p1

    div-float/2addr p1, v3

    invoke-virtual {v0, p1, v1}, Landroid/graphics/RectF;->inset(FF)V

    :cond_4
    iget-boolean p1, p0, Lchat/ola/vn/view/HighlightView;->i:Z

    if-eqz p1, :cond_5

    iget p1, p0, Lchat/ola/vn/view/HighlightView;->j:F

    div-float/2addr p2, p1

    :cond_5
    invoke-virtual {v0}, Landroid/graphics/RectF;->height()F

    move-result p1

    cmpg-float p1, p1, p2

    if-gez p1, :cond_6

    invoke-virtual {v0}, Landroid/graphics/RectF;->height()F

    move-result p1

    sub-float/2addr p2, p1

    neg-float p1, p2

    div-float/2addr p1, v3

    invoke-virtual {v0, v1, p1}, Landroid/graphics/RectF;->inset(FF)V

    :cond_6
    iget p1, v0, Landroid/graphics/RectF;->left:F

    iget-object p2, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget p2, p2, Landroid/graphics/RectF;->left:F

    cmpg-float p1, p1, p2

    if-gez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget p1, p1, Landroid/graphics/RectF;->left:F

    iget p2, v0, Landroid/graphics/RectF;->left:F

    sub-float/2addr p1, p2

    :goto_1
    invoke-virtual {v0, p1, v1}, Landroid/graphics/RectF;->offset(FF)V

    goto :goto_2

    :cond_7
    iget p1, v0, Landroid/graphics/RectF;->right:F

    iget-object p2, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget p2, p2, Landroid/graphics/RectF;->right:F

    cmpl-float p1, p1, p2

    if-lez p1, :cond_8

    iget p1, v0, Landroid/graphics/RectF;->right:F

    iget-object p2, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget p2, p2, Landroid/graphics/RectF;->right:F

    sub-float/2addr p1, p2

    neg-float p1, p1

    goto :goto_1

    :cond_8
    :goto_2
    iget p1, v0, Landroid/graphics/RectF;->top:F

    iget-object p2, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget p2, p2, Landroid/graphics/RectF;->top:F

    cmpg-float p1, p1, p2

    if-gez p1, :cond_9

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget p1, p1, Landroid/graphics/RectF;->top:F

    iget p2, v0, Landroid/graphics/RectF;->top:F

    sub-float/2addr p1, p2

    :goto_3
    invoke-virtual {v0, v1, p1}, Landroid/graphics/RectF;->offset(FF)V

    goto :goto_4

    :cond_9
    iget p1, v0, Landroid/graphics/RectF;->bottom:F

    iget-object p2, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget p2, p2, Landroid/graphics/RectF;->bottom:F

    cmpl-float p1, p1, p2

    if-lez p1, :cond_a

    iget p1, v0, Landroid/graphics/RectF;->bottom:F

    iget-object p2, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iget p2, p2, Landroid/graphics/RectF;->bottom:F

    sub-float/2addr p1, p2

    neg-float p1, p1

    goto :goto_3

    :cond_a
    :goto_4
    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    invoke-virtual {p1, v0}, Landroid/graphics/RectF;->set(Landroid/graphics/RectF;)V

    invoke-direct {p0}, Lchat/ola/vn/view/HighlightView;->e()Landroid/graphics/Rect;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->a:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->invalidate()V

    return-void
.end method

.method private d()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->a:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0806a6

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/view/HighlightView;->l:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/view/HighlightView;->m:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/view/HighlightView;->n:Landroid/graphics/drawable/Drawable;

    return-void
.end method

.method private e()Landroid/graphics/Rect;
    .locals 5

    new-instance v0, Landroid/graphics/RectF;

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v1, v1, Landroid/graphics/RectF;->left:F

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->top:F

    iget-object v3, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v3, v3, Landroid/graphics/RectF;->right:F

    iget-object v4, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v4, v4, Landroid/graphics/RectF;->bottom:F

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/graphics/RectF;-><init>(FFFF)V

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->f:Landroid/graphics/Matrix;

    invoke-virtual {v1, v0}, Landroid/graphics/Matrix;->mapRect(Landroid/graphics/RectF;)Z

    new-instance v1, Landroid/graphics/Rect;

    iget v2, v0, Landroid/graphics/RectF;->left:F

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    iget v3, v0, Landroid/graphics/RectF;->top:F

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    iget v4, v0, Landroid/graphics/RectF;->right:F

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    iget v0, v0, Landroid/graphics/RectF;->bottom:F

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-direct {v1, v2, v3, v4, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v1
.end method


# virtual methods
.method public a(FF)I
    .locals 9

    invoke-direct {p0}, Lchat/ola/vn/view/HighlightView;->e()Landroid/graphics/Rect;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->l:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v1

    const/4 v2, 0x2

    mul-int/lit8 v1, v1, 0x2

    new-instance v3, Landroid/graphics/Rect;

    iget v4, v0, Landroid/graphics/Rect;->left:I

    sub-int/2addr v4, v1

    iget v5, v0, Landroid/graphics/Rect;->top:I

    sub-int/2addr v5, v1

    iget v6, v0, Landroid/graphics/Rect;->right:I

    add-int/2addr v6, v1

    iget v7, v0, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v7, v1

    invoke-direct {v3, v4, v5, v6, v7}, Landroid/graphics/Rect;-><init>(IIII)V

    iget-boolean v4, p0, Lchat/ola/vn/view/HighlightView;->k:Z

    const/16 v5, 0x20

    const/4 v6, 0x1

    if-eqz v4, :cond_5

    invoke-virtual {v0}, Landroid/graphics/Rect;->centerX()I

    move-result v3

    int-to-float v3, v3

    sub-float/2addr p1, v3

    invoke-virtual {v0}, Landroid/graphics/Rect;->centerY()I

    move-result v0

    int-to-float v0, v0

    sub-float/2addr p2, v0

    mul-float v0, p1, p1

    mul-float v3, p2, p2

    add-float/2addr v0, v3

    float-to-double v3, v0

    invoke-static {v3, v4}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v3

    double-to-int v0, v3

    iget-object v3, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    invoke-virtual {v3}, Landroid/graphics/Rect;->width()I

    move-result v3

    div-int/2addr v3, v2

    sub-int v4, v0, v3

    invoke-static {v4}, Ljava/lang/Math;->abs(I)I

    move-result v4

    if-gt v4, v1, :cond_3

    invoke-static {p2}, Ljava/lang/Math;->abs(F)F

    move-result v0

    invoke-static {p1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    cmpl-float v0, v0, v1

    const/4 v1, 0x0

    if-lez v0, :cond_1

    cmpg-float p1, p2, v1

    if-gez p1, :cond_0

    const/16 v2, 0x8

    const/16 v5, 0x8

    return v5

    :cond_0
    const/16 v2, 0x10

    const/16 v5, 0x10

    return v5

    :cond_1
    cmpg-float p1, p1, v1

    if-gez p1, :cond_2

    const/4 v5, 0x2

    return v5

    :cond_2
    const/4 v2, 0x4

    const/4 v5, 0x4

    return v5

    :cond_3
    if-ge v0, v3, :cond_4

    return v5

    :cond_4
    const/4 v5, 0x1

    return v5

    :cond_5
    invoke-virtual {v0}, Landroid/graphics/Rect;->centerY()I

    move-result v2

    sub-int/2addr v2, v1

    int-to-float v2, v2

    cmpl-float v2, p2, v2

    const/4 v4, 0x0

    if-ltz v2, :cond_6

    invoke-virtual {v0}, Landroid/graphics/Rect;->centerY()I

    move-result v2

    add-int/2addr v2, v1

    int-to-float v2, v2

    cmpg-float v2, p2, v2

    if-gez v2, :cond_6

    const/4 v2, 0x1

    goto :goto_0

    :cond_6
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v0}, Landroid/graphics/Rect;->centerX()I

    move-result v7

    sub-int/2addr v7, v1

    int-to-float v7, v7

    cmpl-float v7, p1, v7

    if-ltz v7, :cond_7

    invoke-virtual {v0}, Landroid/graphics/Rect;->centerX()I

    move-result v7

    add-int/2addr v7, v1

    int-to-float v7, v7

    cmpg-float v7, p1, v7

    if-gez v7, :cond_7

    const/4 v4, 0x1

    :cond_7
    iget v7, v0, Landroid/graphics/Rect;->left:I

    int-to-float v7, v7

    sub-float/2addr v7, p1

    invoke-static {v7}, Ljava/lang/Math;->abs(F)F

    move-result v7

    int-to-float v1, v1

    cmpg-float v7, v7, v1

    if-gez v7, :cond_8

    if-eqz v2, :cond_8

    const/4 v7, 0x3

    goto :goto_1

    :cond_8
    const/4 v7, 0x1

    :goto_1
    iget v8, v0, Landroid/graphics/Rect;->right:I

    int-to-float v8, v8

    sub-float/2addr v8, p1

    invoke-static {v8}, Ljava/lang/Math;->abs(F)F

    move-result v8

    cmpg-float v8, v8, v1

    if-gez v8, :cond_9

    if-eqz v2, :cond_9

    or-int/lit8 v7, v7, 0x4

    :cond_9
    iget v2, v0, Landroid/graphics/Rect;->top:I

    int-to-float v2, v2

    sub-float/2addr v2, p2

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    cmpg-float v2, v2, v1

    if-gez v2, :cond_a

    if-eqz v4, :cond_a

    or-int/lit8 v7, v7, 0x8

    :cond_a
    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    int-to-float v0, v0

    sub-float/2addr v0, p2

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    cmpg-float v0, v0, v1

    if-gez v0, :cond_b

    if-eqz v4, :cond_b

    or-int/lit8 v0, v7, 0x10

    goto :goto_2

    :cond_b
    move v0, v7

    :goto_2
    if-ne v0, v6, :cond_c

    float-to-int p1, p1

    float-to-int p2, p2

    invoke-virtual {v3, p1, p2}, Landroid/graphics/Rect;->contains(II)Z

    move-result p1

    if-eqz p1, :cond_c

    return v5

    :cond_c
    move v5, v0

    return v5
.end method

.method a(IFF)V
    .locals 4

    invoke-direct {p0}, Lchat/ola/vn/view/HighlightView;->e()Landroid/graphics/Rect;

    move-result-object v0

    const/4 v1, 0x1

    if-ne p1, v1, :cond_0

    return-void

    :cond_0
    const/16 v2, 0x20

    if-ne p1, v2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    invoke-virtual {p1}, Landroid/graphics/RectF;->width()F

    move-result p1

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-float v1, v1

    div-float/2addr p1, v1

    mul-float p2, p2, p1

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    invoke-virtual {p1}, Landroid/graphics/RectF;->height()F

    move-result p1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v0

    int-to-float v0, v0

    div-float/2addr p1, v0

    mul-float p3, p3, p1

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/view/HighlightView;->b(FF)V

    return-void

    :cond_1
    and-int/lit8 v2, p1, 0x6

    const/4 v3, 0x0

    if-nez v2, :cond_2

    const/4 p2, 0x0

    :cond_2
    and-int/lit8 v2, p1, 0x18

    if-nez v2, :cond_3

    const/4 p3, 0x0

    :cond_3
    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    invoke-virtual {v2}, Landroid/graphics/RectF;->width()F

    move-result v2

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v3

    int-to-float v3, v3

    div-float/2addr v2, v3

    mul-float p2, p2, v2

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    invoke-virtual {v2}, Landroid/graphics/RectF;->height()F

    move-result v2

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v0

    int-to-float v0, v0

    div-float/2addr v2, v0

    mul-float p3, p3, v2

    and-int/lit8 v0, p1, 0x2

    const/4 v2, -0x1

    if-eqz v0, :cond_4

    const/4 v0, -0x1

    goto :goto_0

    :cond_4
    const/4 v0, 0x1

    :goto_0
    int-to-float v0, v0

    mul-float v0, v0, p2

    and-int/lit8 p1, p1, 0x8

    if-eqz p1, :cond_5

    const/4 v1, -0x1

    :cond_5
    int-to-float p1, v1

    mul-float p1, p1, p3

    invoke-direct {p0, v0, p1}, Lchat/ola/vn/view/HighlightView;->c(FF)V

    return-void
.end method

.method protected a(Landroid/graphics/Canvas;)V
    .locals 13
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iget-boolean v0, p0, Lchat/ola/vn/view/HighlightView;->c:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    invoke-virtual {p0}, Lchat/ola/vn/view/HighlightView;->a()Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->q:Landroid/graphics/Paint;

    const/high16 v1, -0x1000000

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->q:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    return-void

    :cond_1
    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->a:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->getDrawingRect(Landroid/graphics/Rect;)V

    iget-boolean v2, p0, Lchat/ola/vn/view/HighlightView;->k:Z

    if-eqz v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    invoke-virtual {v2}, Landroid/graphics/Rect;->width()I

    move-result v2

    int-to-float v2, v2

    iget-object v3, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    invoke-virtual {v3}, Landroid/graphics/Rect;->height()I

    move-result v3

    int-to-float v3, v3

    iget-object v4, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->left:I

    int-to-float v4, v4

    const/high16 v5, 0x40000000    # 2.0f

    div-float/2addr v2, v5

    add-float/2addr v4, v2

    iget-object v6, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v6, v6, Landroid/graphics/Rect;->top:I

    int-to-float v6, v6

    div-float/2addr v3, v5

    add-float/2addr v6, v3

    sget-object v3, Landroid/graphics/Path$Direction;->CW:Landroid/graphics/Path$Direction;

    invoke-virtual {v0, v4, v6, v2, v3}, Landroid/graphics/Path;->addCircle(FFFLandroid/graphics/Path$Direction;)V

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->q:Landroid/graphics/Paint;

    sget v3, Lchat/ola/vn/f;->H:I

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_1

    :cond_2
    new-instance v2, Landroid/graphics/RectF;

    iget-object v3, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    invoke-direct {v2, v3}, Landroid/graphics/RectF;-><init>(Landroid/graphics/Rect;)V

    sget-object v3, Landroid/graphics/Path$Direction;->CW:Landroid/graphics/Path$Direction;

    invoke-virtual {v0, v2, v3}, Landroid/graphics/Path;->addRect(Landroid/graphics/RectF;Landroid/graphics/Path$Direction;)V

    goto :goto_0

    :goto_1
    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-virtual {p1}, Landroid/graphics/Canvas;->isHardwareAccelerated()Z

    move-result v2

    if-nez v2, :cond_4

    :cond_3
    sget-object v2, Landroid/graphics/Region$Op;->DIFFERENCE:Landroid/graphics/Region$Op;

    invoke-virtual {p1, v0, v2}, Landroid/graphics/Canvas;->clipPath(Landroid/graphics/Path;Landroid/graphics/Region$Op;)Z

    :cond_4
    invoke-virtual {p0}, Lchat/ola/vn/view/HighlightView;->a()Z

    move-result v2

    if-eqz v2, :cond_5

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->o:Landroid/graphics/Paint;

    goto :goto_2

    :cond_5
    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->p:Landroid/graphics/Paint;

    :goto_2
    invoke-virtual {p1, v1, v2}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->q:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    iget-boolean v0, p0, Lchat/ola/vn/view/HighlightView;->k:Z

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->n:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->n:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v1

    const-wide v2, 0x3fe921fb54442d18L    # 0.7853981633974483

    invoke-static {v2, v3}, Ljava/lang/Math;->cos(D)D

    move-result-wide v2

    iget-object v4, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    invoke-virtual {v4}, Landroid/graphics/Rect;->width()I

    move-result v4

    int-to-double v4, v4

    const-wide/high16 v6, 0x4000000000000000L    # 2.0

    div-double/2addr v4, v6

    mul-double v2, v2, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->round(D)J

    move-result-wide v2

    long-to-int v2, v2

    iget-object v3, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->left:I

    iget-object v4, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    invoke-virtual {v4}, Landroid/graphics/Rect;->width()I

    move-result v4

    div-int/lit8 v4, v4, 0x2

    add-int/2addr v3, v4

    add-int/2addr v3, v2

    div-int/lit8 v0, v0, 0x2

    sub-int/2addr v3, v0

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->top:I

    iget-object v4, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    invoke-virtual {v4}, Landroid/graphics/Rect;->height()I

    move-result v4

    div-int/lit8 v4, v4, 0x2

    add-int/2addr v0, v4

    sub-int/2addr v0, v2

    div-int/lit8 v1, v1, 0x2

    sub-int/2addr v0, v1

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->n:Landroid/graphics/drawable/Drawable;

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->n:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v2}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v2

    add-int/2addr v2, v3

    iget-object v4, p0, Lchat/ola/vn/view/HighlightView;->n:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v4}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v4

    add-int/2addr v4, v0

    invoke-virtual {v1, v3, v0, v2, v4}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->n:Landroid/graphics/drawable/Drawable;

    :goto_3
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    return-void

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    add-int/lit8 v0, v0, 0x1

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->right:I

    add-int/lit8 v1, v1, 0x1

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->top:I

    iget-object v3, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->bottom:I

    iget-object v4, p0, Lchat/ola/vn/view/HighlightView;->l:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v4}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v4

    div-int/lit8 v4, v4, 0x2

    iget-object v5, p0, Lchat/ola/vn/view/HighlightView;->l:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v5}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v5

    div-int/lit8 v5, v5, 0x2

    iget-object v6, p0, Lchat/ola/vn/view/HighlightView;->m:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v6}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v6

    iget-object v7, p0, Lchat/ola/vn/view/HighlightView;->m:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v7}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v7

    div-int/lit8 v7, v7, 0x2

    iget-object v8, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v8, v8, Landroid/graphics/Rect;->left:I

    iget-object v9, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v9, v9, Landroid/graphics/Rect;->right:I

    iget-object v10, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v10, v10, Landroid/graphics/Rect;->left:I

    sub-int/2addr v9, v10

    div-int/lit8 v9, v9, 0x2

    add-int/2addr v8, v9

    iget-object v9, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v9, v9, Landroid/graphics/Rect;->top:I

    iget-object v10, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v10, v10, Landroid/graphics/Rect;->bottom:I

    iget-object v11, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget v11, v11, Landroid/graphics/Rect;->top:I

    sub-int/2addr v10, v11

    div-int/lit8 v10, v10, 0x2

    add-int/2addr v9, v10

    iget-object v10, p0, Lchat/ola/vn/view/HighlightView;->l:Landroid/graphics/drawable/Drawable;

    sub-int v11, v0, v4

    sub-int v12, v9, v5

    add-int/2addr v0, v4

    add-int/2addr v9, v5

    invoke-virtual {v10, v11, v12, v0, v9}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->l:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->l:Landroid/graphics/drawable/Drawable;

    sub-int v5, v1, v4

    add-int/2addr v1, v4

    invoke-virtual {v0, v5, v12, v1, v9}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->l:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    div-int/lit8 v0, v6, 0x2

    sub-int/2addr v2, v0

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->m:Landroid/graphics/drawable/Drawable;

    sub-int v4, v8, v7

    add-int/2addr v8, v7

    add-int v5, v2, v6

    invoke-virtual {v1, v4, v2, v8, v5}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->m:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    sub-int/2addr v3, v0

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->m:Landroid/graphics/drawable/Drawable;

    add-int/2addr v6, v3

    invoke-virtual {v0, v4, v3, v8, v6}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->m:Landroid/graphics/drawable/Drawable;

    goto/16 :goto_3

    return-void
.end method

.method public a(Landroid/graphics/Matrix;Landroid/graphics/Rect;Landroid/graphics/RectF;ZZ)V
    .locals 2

    const/4 v0, 0x1

    if-eqz p4, :cond_0

    const/4 p5, 0x1

    :cond_0
    new-instance v1, Landroid/graphics/Matrix;

    invoke-direct {v1, p1}, Landroid/graphics/Matrix;-><init>(Landroid/graphics/Matrix;)V

    iput-object v1, p0, Lchat/ola/vn/view/HighlightView;->f:Landroid/graphics/Matrix;

    iput-object p3, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    new-instance p1, Landroid/graphics/RectF;

    invoke-direct {p1, p2}, Landroid/graphics/RectF;-><init>(Landroid/graphics/Rect;)V

    iput-object p1, p0, Lchat/ola/vn/view/HighlightView;->h:Landroid/graphics/RectF;

    iput-boolean p5, p0, Lchat/ola/vn/view/HighlightView;->i:Z

    iput-boolean p4, p0, Lchat/ola/vn/view/HighlightView;->k:Z

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    invoke-virtual {p1}, Landroid/graphics/RectF;->width()F

    move-result p1

    iget-object p2, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    invoke-virtual {p2}, Landroid/graphics/RectF;->height()F

    move-result p2

    div-float/2addr p1, p2

    iput p1, p0, Lchat/ola/vn/view/HighlightView;->j:F

    invoke-direct {p0}, Lchat/ola/vn/view/HighlightView;->e()Landroid/graphics/Rect;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->o:Landroid/graphics/Paint;

    const/4 p2, 0x0

    const/16 p3, 0x32

    invoke-virtual {p1, p2, p3, p3, p3}, Landroid/graphics/Paint;->setARGB(IIII)V

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->p:Landroid/graphics/Paint;

    const/16 p2, 0x7d

    invoke-virtual {p1, p2, p3, p3, p3}, Landroid/graphics/Paint;->setARGB(IIII)V

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->q:Landroid/graphics/Paint;

    const/high16 p2, 0x40400000    # 3.0f

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->q:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->q:Landroid/graphics/Paint;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    sget-object p1, Lchat/ola/vn/view/HighlightView$ModifyMode;->a:Lchat/ola/vn/view/HighlightView$ModifyMode;

    iput-object p1, p0, Lchat/ola/vn/view/HighlightView;->g:Lchat/ola/vn/view/HighlightView$ModifyMode;

    invoke-direct {p0}, Lchat/ola/vn/view/HighlightView;->d()V

    return-void
.end method

.method public a(Lchat/ola/vn/view/HighlightView$ModifyMode;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/HighlightView;->g:Lchat/ola/vn/view/HighlightView$ModifyMode;

    if-eq p1, v0, :cond_0

    iput-object p1, p0, Lchat/ola/vn/view/HighlightView;->g:Lchat/ola/vn/view/HighlightView$ModifyMode;

    iget-object p1, p0, Lchat/ola/vn/view/HighlightView;->a:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->invalidate()V

    :cond_0
    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/view/HighlightView;->b:Z

    return-void
.end method

.method public a()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/view/HighlightView;->b:Z

    return v0
.end method

.method public b()Landroid/graphics/Rect;
    .locals 5

    new-instance v0, Landroid/graphics/Rect;

    iget-object v1, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v1, v1, Landroid/graphics/RectF;->left:F

    float-to-int v1, v1

    iget-object v2, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->top:F

    float-to-int v2, v2

    iget-object v3, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v3, v3, Landroid/graphics/RectF;->right:F

    float-to-int v3, v3

    iget-object v4, p0, Lchat/ola/vn/view/HighlightView;->e:Landroid/graphics/RectF;

    iget v4, v4, Landroid/graphics/RectF;->bottom:F

    float-to-int v4, v4

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v0
.end method

.method public b(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/view/HighlightView;->c:Z

    return-void
.end method

.method public c()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/view/HighlightView;->e()Landroid/graphics/Rect;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/view/HighlightView;->d:Landroid/graphics/Rect;

    return-void
.end method
