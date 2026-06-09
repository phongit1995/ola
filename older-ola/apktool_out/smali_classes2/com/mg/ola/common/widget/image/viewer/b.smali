.class public Lcom/mg/ola/common/widget/image/viewer/b;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnTouchListener;
.implements Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/common/widget/image/viewer/b$d;,
        Lcom/mg/ola/common/widget/image/viewer/b$a;,
        Lcom/mg/ola/common/widget/image/viewer/b$g;,
        Lcom/mg/ola/common/widget/image/viewer/b$f;,
        Lcom/mg/ola/common/widget/image/viewer/b$e;,
        Lcom/mg/ola/common/widget/image/viewer/b$b;,
        Lcom/mg/ola/common/widget/image/viewer/b$c;
    }
.end annotation


# instance fields
.field private A:Z

.field private B:F

.field private C:Z

.field private a:F

.field private b:F

.field private c:F

.field private d:Z

.field private e:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/widget/ImageView;",
            ">;"
        }
    .end annotation
.end field

.field private f:Landroid/view/ViewTreeObserver;

.field private final g:Landroid/graphics/Matrix;

.field private final h:Landroid/graphics/Matrix;

.field private final i:Landroid/graphics/Matrix;

.field private final j:Landroid/graphics/Matrix;

.field private final k:Landroid/graphics/RectF;

.field private final l:[F

.field private m:Lcom/mg/ola/common/widget/image/viewer/b$e;

.field private n:Lcom/mg/ola/common/widget/image/viewer/b$f;

.field private o:Lcom/mg/ola/common/widget/image/viewer/b$g;

.field private p:Landroid/view/View$OnLongClickListener;

.field private q:I

.field private r:I

.field private s:I

.field private t:I

.field private u:Lcom/mg/ola/common/widget/image/viewer/b$d;

.field private v:I

.field private w:Z

.field private x:Landroid/widget/ImageView$ScaleType;

.field private y:Landroid/view/ScaleGestureDetector;

.field private z:Landroid/view/GestureDetector;


# direct methods
.method public constructor <init>(Landroid/widget/ImageView;)V
    .locals 5

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->a:F

    const/high16 v0, 0x3fe00000    # 1.75f

    iput v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->b:F

    const/high16 v0, 0x40400000    # 3.0f

    iput v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->c:F

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->d:Z

    new-instance v1, Landroid/graphics/Matrix;

    invoke-direct {v1}, Landroid/graphics/Matrix;-><init>()V

    iput-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->g:Landroid/graphics/Matrix;

    new-instance v1, Landroid/graphics/Matrix;

    invoke-direct {v1}, Landroid/graphics/Matrix;-><init>()V

    iput-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->h:Landroid/graphics/Matrix;

    new-instance v1, Landroid/graphics/Matrix;

    invoke-direct {v1}, Landroid/graphics/Matrix;-><init>()V

    iput-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->i:Landroid/graphics/Matrix;

    new-instance v1, Landroid/graphics/Matrix;

    invoke-direct {v1}, Landroid/graphics/Matrix;-><init>()V

    iput-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->j:Landroid/graphics/Matrix;

    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->k:Landroid/graphics/RectF;

    const/16 v1, 0x9

    new-array v1, v1, [F

    iput-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->l:[F

    const/4 v1, 0x2

    iput v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->v:I

    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->w:Z

    sget-object v2, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    iput-object v2, p0, Lcom/mg/ola/common/widget/image/viewer/b;->x:Landroid/widget/ImageView$ScaleType;

    iput-boolean v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->A:Z

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->C:Z

    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->e:Ljava/lang/ref/WeakReference;

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    invoke-virtual {p1}, Landroid/widget/ImageView;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v1

    iput-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->f:Landroid/view/ViewTreeObserver;

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->f:Landroid/view/ViewTreeObserver;

    invoke-virtual {v1, p0}, Landroid/view/ViewTreeObserver;->addOnGlobalLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    invoke-static {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->c(Landroid/widget/ImageView;)V

    invoke-virtual {p1}, Landroid/widget/ImageView;->isInEditMode()Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Landroid/view/ScaleGestureDetector;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v2

    new-instance v3, Lcom/mg/ola/common/widget/image/viewer/b$c;

    const/4 v4, 0x0

    invoke-direct {v3, p0, v4}, Lcom/mg/ola/common/widget/image/viewer/b$c;-><init>(Lcom/mg/ola/common/widget/image/viewer/b;Lcom/mg/ola/common/widget/image/viewer/b$1;)V

    invoke-direct {v1, v2, v3}, Landroid/view/ScaleGestureDetector;-><init>(Landroid/content/Context;Landroid/view/ScaleGestureDetector$OnScaleGestureListener;)V

    iput-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->y:Landroid/view/ScaleGestureDetector;

    new-instance v1, Landroid/view/GestureDetector;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object p1

    new-instance v2, Lcom/mg/ola/common/widget/image/viewer/b$b;

    invoke-direct {v2, p0, v4}, Lcom/mg/ola/common/widget/image/viewer/b$b;-><init>(Lcom/mg/ola/common/widget/image/viewer/b;Lcom/mg/ola/common/widget/image/viewer/b$1;)V

    invoke-direct {v1, p1, v2}, Landroid/view/GestureDetector;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;)V

    iput-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->z:Landroid/view/GestureDetector;

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Z)V

    :cond_0
    return-void
.end method

.method private a(Landroid/graphics/Matrix;I)F
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->l:[F

    invoke-virtual {p1, v0}, Landroid/graphics/Matrix;->getValues([F)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->l:[F

    aget p1, p1, p2

    return p1
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/image/viewer/b;)F
    .locals 0

    iget p0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->c:F

    return p0
.end method

.method private a(Landroid/graphics/Matrix;)Landroid/graphics/RectF;
    .locals 4

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->k:Landroid/graphics/RectF;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v0

    int-to-float v0, v0

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v3, v2, v0}, Landroid/graphics/RectF;->set(FFFF)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->k:Landroid/graphics/RectF;

    invoke-virtual {p1, v0}, Landroid/graphics/Matrix;->mapRect(Landroid/graphics/RectF;)Z

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->k:Landroid/graphics/RectF;

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/image/viewer/b;Lcom/mg/ola/common/widget/image/viewer/b$d;)Lcom/mg/ola/common/widget/image/viewer/b$d;
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->u:Lcom/mg/ola/common/widget/image/viewer/b$d;

    return-object p1
.end method

.method private a(Landroid/graphics/drawable/Drawable;)V
    .locals 8

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    if-eqz v0, :cond_4

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Landroid/widget/ImageView;->getWidth()I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0}, Landroid/widget/ImageView;->getHeight()I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v2

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result p1

    iget-object v3, p0, Lcom/mg/ola/common/widget/image/viewer/b;->g:Landroid/graphics/Matrix;

    invoke-virtual {v3}, Landroid/graphics/Matrix;->reset()V

    int-to-float v2, v2

    div-float v3, v1, v2

    int-to-float p1, p1

    div-float v4, v0, p1

    iget-object v5, p0, Lcom/mg/ola/common/widget/image/viewer/b;->x:Landroid/widget/ImageView$ScaleType;

    sget-object v6, Landroid/widget/ImageView$ScaleType;->CENTER:Landroid/widget/ImageView$ScaleType;

    const/high16 v7, 0x40000000    # 2.0f

    if-ne v5, v6, :cond_1

    iget-object v3, p0, Lcom/mg/ola/common/widget/image/viewer/b;->g:Landroid/graphics/Matrix;

    sub-float/2addr v1, v2

    div-float/2addr v1, v7

    sub-float/2addr v0, p1

    div-float/2addr v0, v7

    invoke-virtual {v3, v1, v0}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    goto :goto_2

    :cond_1
    iget-object v5, p0, Lcom/mg/ola/common/widget/image/viewer/b;->x:Landroid/widget/ImageView$ScaleType;

    sget-object v6, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    if-ne v5, v6, :cond_2

    invoke-static {v3, v4}, Ljava/lang/Math;->max(FF)F

    move-result v3

    :goto_0
    iget-object v4, p0, Lcom/mg/ola/common/widget/image/viewer/b;->g:Landroid/graphics/Matrix;

    invoke-virtual {v4, v3, v3}, Landroid/graphics/Matrix;->postScale(FF)Z

    iget-object v4, p0, Lcom/mg/ola/common/widget/image/viewer/b;->g:Landroid/graphics/Matrix;

    mul-float v2, v2, v3

    sub-float/2addr v1, v2

    div-float/2addr v1, v7

    mul-float p1, p1, v3

    sub-float/2addr v0, p1

    div-float/2addr v0, v7

    invoke-virtual {v4, v1, v0}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    goto :goto_2

    :cond_2
    iget-object v5, p0, Lcom/mg/ola/common/widget/image/viewer/b;->x:Landroid/widget/ImageView$ScaleType;

    sget-object v6, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    if-ne v5, v6, :cond_3

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-static {v3, v4}, Ljava/lang/Math;->min(FF)F

    move-result v3

    invoke-static {v5, v3}, Ljava/lang/Math;->min(FF)F

    move-result v3

    goto :goto_0

    :cond_3
    new-instance v3, Landroid/graphics/RectF;

    const/4 v4, 0x0

    invoke-direct {v3, v4, v4, v2, p1}, Landroid/graphics/RectF;-><init>(FFFF)V

    new-instance p1, Landroid/graphics/RectF;

    invoke-direct {p1, v4, v4, v1, v0}, Landroid/graphics/RectF;-><init>(FFFF)V

    sget-object v0, Lcom/mg/ola/common/widget/image/viewer/b$1;->a:[I

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->x:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1}, Landroid/widget/ImageView$ScaleType;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    goto :goto_2

    :pswitch_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->g:Landroid/graphics/Matrix;

    sget-object v1, Landroid/graphics/Matrix$ScaleToFit;->FILL:Landroid/graphics/Matrix$ScaleToFit;

    goto :goto_1

    :pswitch_1
    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->g:Landroid/graphics/Matrix;

    sget-object v1, Landroid/graphics/Matrix$ScaleToFit;->CENTER:Landroid/graphics/Matrix$ScaleToFit;

    goto :goto_1

    :pswitch_2
    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->g:Landroid/graphics/Matrix;

    sget-object v1, Landroid/graphics/Matrix$ScaleToFit;->END:Landroid/graphics/Matrix$ScaleToFit;

    goto :goto_1

    :pswitch_3
    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->g:Landroid/graphics/Matrix;

    sget-object v1, Landroid/graphics/Matrix$ScaleToFit;->START:Landroid/graphics/Matrix$ScaleToFit;

    :goto_1
    invoke-virtual {v0, v3, p1, v1}, Landroid/graphics/Matrix;->setRectToRect(Landroid/graphics/RectF;Landroid/graphics/RectF;Landroid/graphics/Matrix$ScaleToFit;)Z

    :goto_2
    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->p()V

    :cond_4
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/image/viewer/b;Landroid/graphics/Matrix;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Landroid/graphics/Matrix;)V

    return-void
.end method

.method static synthetic a(Landroid/widget/ImageView;)Z
    .locals 0

    invoke-static {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Landroid/widget/ImageView;)Z

    move-result p0

    return p0
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/image/viewer/b;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->A:Z

    return p1
.end method

.method static synthetic b(Lcom/mg/ola/common/widget/image/viewer/b;)Landroid/graphics/Matrix;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->i:Landroid/graphics/Matrix;

    return-object p0
.end method

.method private static b(FFF)V
    .locals 0

    cmpl-float p0, p0, p1

    if-ltz p0, :cond_0

    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "MinZoom should be less than MidZoom"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_0
    cmpl-float p0, p1, p2

    if-ltz p0, :cond_1

    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "MidZoom should be less than MaxZoom"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_1
    return-void
.end method

.method private b(Landroid/graphics/Matrix;)V
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->n()V

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageMatrix(Landroid/graphics/Matrix;)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->m:Lcom/mg/ola/common/widget/image/viewer/b$e;

    if-eqz v0, :cond_0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/graphics/Matrix;)Landroid/graphics/RectF;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->m:Lcom/mg/ola/common/widget/image/viewer/b$e;

    invoke-interface {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b$e;->a(Landroid/graphics/RectF;)V

    :cond_0
    return-void
.end method

.method private static b(Landroid/widget/ImageView$ScaleType;)Z
    .locals 1

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return p0

    :cond_0
    sget-object v0, Lcom/mg/ola/common/widget/image/viewer/b$1;->a:[I

    invoke-virtual {p0}, Landroid/widget/ImageView$ScaleType;->ordinal()I

    move-result p0

    aget p0, v0, p0

    const/4 v0, 0x1

    if-eq p0, v0, :cond_1

    :cond_1
    return v0
.end method

.method private static b(Landroid/widget/ImageView;)Z
    .locals 0

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method private static c(Landroid/widget/ImageView;)V
    .locals 1

    if-eqz p0, :cond_1

    instance-of v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    if-eqz v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Landroid/widget/ImageView$ScaleType;->MATRIX:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p0, v0}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    :cond_1
    return-void
.end method

.method static synthetic c(Lcom/mg/ola/common/widget/image/viewer/b;)V
    .locals 0

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->m()V

    return-void
.end method

.method static synthetic d(Lcom/mg/ola/common/widget/image/viewer/b;)Lcom/mg/ola/common/widget/image/viewer/b$d;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->u:Lcom/mg/ola/common/widget/image/viewer/b$d;

    return-object p0
.end method

.method static synthetic e(Lcom/mg/ola/common/widget/image/viewer/b;)Landroid/view/View$OnLongClickListener;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->p:Landroid/view/View$OnLongClickListener;

    return-object p0
.end method

.method static synthetic f(Lcom/mg/ola/common/widget/image/viewer/b;)Ljava/lang/ref/WeakReference;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->e:Ljava/lang/ref/WeakReference;

    return-object p0
.end method

.method static synthetic g(Lcom/mg/ola/common/widget/image/viewer/b;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->d:Z

    return p0
.end method

.method static synthetic h(Lcom/mg/ola/common/widget/image/viewer/b;)I
    .locals 0

    iget p0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->v:I

    return p0
.end method

.method static synthetic i(Lcom/mg/ola/common/widget/image/viewer/b;)Lcom/mg/ola/common/widget/image/viewer/b$f;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->n:Lcom/mg/ola/common/widget/image/viewer/b$f;

    return-object p0
.end method

.method static synthetic j(Lcom/mg/ola/common/widget/image/viewer/b;)Lcom/mg/ola/common/widget/image/viewer/b$g;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->o:Lcom/mg/ola/common/widget/image/viewer/b$g;

    return-object p0
.end method

.method static synthetic k(Lcom/mg/ola/common/widget/image/viewer/b;)F
    .locals 0

    iget p0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->b:F

    return p0
.end method

.method static synthetic l(Lcom/mg/ola/common/widget/image/viewer/b;)F
    .locals 0

    iget p0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->a:F

    return p0
.end method

.method private l()V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->u:Lcom/mg/ola/common/widget/image/viewer/b$d;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->u:Lcom/mg/ola/common/widget/image/viewer/b$d;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b$d;->a()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->u:Lcom/mg/ola/common/widget/image/viewer/b$d;

    :cond_0
    return-void
.end method

.method private m()V
    .locals 1

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->o()V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->j()Landroid/graphics/Matrix;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Landroid/graphics/Matrix;)V

    return-void
.end method

.method private n()V
    .locals 2

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    if-eqz v0, :cond_0

    instance-of v1, v0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    if-nez v1, :cond_0

    invoke-virtual {v0}, Landroid/widget/ImageView;->getScaleType()Landroid/widget/ImageView$ScaleType;

    move-result-object v0

    sget-object v1, Landroid/widget/ImageView$ScaleType;->MATRIX:Landroid/widget/ImageView$ScaleType;

    if-eq v0, v1, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "The ImageView\'s ScaleType has been changed since attaching a PhotoViewAttacher"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    return-void
.end method

.method private o()V
    .locals 9

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->j()Landroid/graphics/Matrix;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/graphics/Matrix;)Landroid/graphics/RectF;

    move-result-object v1

    if-nez v1, :cond_1

    return-void

    :cond_1
    invoke-virtual {v1}, Landroid/graphics/RectF;->height()F

    move-result v2

    invoke-virtual {v1}, Landroid/graphics/RectF;->width()F

    move-result v3

    invoke-virtual {v0}, Landroid/widget/ImageView;->getHeight()I

    move-result v4

    int-to-float v4, v4

    cmpg-float v5, v2, v4

    const/high16 v6, 0x40000000    # 2.0f

    const/4 v7, 0x0

    if-gtz v5, :cond_2

    sget-object v5, Lcom/mg/ola/common/widget/image/viewer/b$1;->a:[I

    iget-object v8, p0, Lcom/mg/ola/common/widget/image/viewer/b;->x:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v8}, Landroid/widget/ImageView$ScaleType;->ordinal()I

    move-result v8

    aget v5, v5, v8

    packed-switch v5, :pswitch_data_0

    sub-float/2addr v4, v2

    div-float/2addr v4, v6

    :goto_0
    iget v2, v1, Landroid/graphics/RectF;->top:F

    :goto_1
    sub-float v2, v4, v2

    goto :goto_3

    :pswitch_0
    sub-float/2addr v4, v2

    goto :goto_0

    :goto_2
    :pswitch_1
    iget v2, v1, Landroid/graphics/RectF;->top:F

    neg-float v2, v2

    goto :goto_3

    :cond_2
    iget v2, v1, Landroid/graphics/RectF;->top:F

    cmpl-float v2, v2, v7

    if-lez v2, :cond_3

    goto :goto_2

    :cond_3
    iget v2, v1, Landroid/graphics/RectF;->bottom:F

    cmpg-float v2, v2, v4

    if-gez v2, :cond_4

    iget v2, v1, Landroid/graphics/RectF;->bottom:F

    goto :goto_1

    :cond_4
    const/4 v2, 0x0

    :goto_3
    invoke-virtual {v0}, Landroid/widget/ImageView;->getWidth()I

    move-result v0

    int-to-float v0, v0

    cmpg-float v4, v3, v0

    if-gtz v4, :cond_5

    sget-object v4, Lcom/mg/ola/common/widget/image/viewer/b$1;->a:[I

    iget-object v5, p0, Lcom/mg/ola/common/widget/image/viewer/b;->x:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v5}, Landroid/widget/ImageView$ScaleType;->ordinal()I

    move-result v5

    aget v4, v4, v5

    packed-switch v4, :pswitch_data_1

    sub-float/2addr v0, v3

    div-float/2addr v0, v6

    :goto_4
    iget v1, v1, Landroid/graphics/RectF;->left:F

    sub-float/2addr v0, v1

    :goto_5
    move v7, v0

    goto :goto_6

    :pswitch_2
    sub-float/2addr v0, v3

    goto :goto_4

    :pswitch_3
    iget v0, v1, Landroid/graphics/RectF;->left:F

    neg-float v0, v0

    goto :goto_5

    :goto_6
    const/4 v0, 0x2

    :goto_7
    iput v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->v:I

    goto :goto_8

    :cond_5
    iget v3, v1, Landroid/graphics/RectF;->left:F

    cmpl-float v3, v3, v7

    if-lez v3, :cond_6

    const/4 v0, 0x0

    iput v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->v:I

    iget v0, v1, Landroid/graphics/RectF;->left:F

    neg-float v7, v0

    goto :goto_8

    :cond_6
    iget v3, v1, Landroid/graphics/RectF;->right:F

    cmpg-float v3, v3, v0

    if-gez v3, :cond_7

    iget v1, v1, Landroid/graphics/RectF;->right:F

    sub-float v7, v0, v1

    const/4 v0, 0x1

    goto :goto_7

    :cond_7
    const/4 v0, -0x1

    goto :goto_7

    :goto_8
    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->i:Landroid/graphics/Matrix;

    invoke-virtual {v0, v7, v2}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x2
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method private p()V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->i:Landroid/graphics/Matrix;

    invoke-virtual {v0}, Landroid/graphics/Matrix;->reset()V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->j()Landroid/graphics/Matrix;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Landroid/graphics/Matrix;)V

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->o()V

    return-void
.end method

.method private q()V
    .locals 4

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    invoke-static {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Landroid/widget/ImageView;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->j()Landroid/graphics/Matrix;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/graphics/Matrix;)Landroid/graphics/RectF;

    move-result-object v0

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/ImageView;->getHeight()I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v2

    invoke-virtual {v2}, Landroid/widget/ImageView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {v0}, Landroid/graphics/RectF;->width()F

    move-result v3

    div-float/2addr v2, v3

    invoke-virtual {v0}, Landroid/graphics/RectF;->height()F

    move-result v0

    div-float/2addr v1, v0

    cmpl-float v0, v2, v1

    if-nez v0, :cond_1

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->i:Landroid/graphics/Matrix;

    invoke-virtual {v0, v2, v2}, Landroid/graphics/Matrix;->postScale(FF)Z

    return-void

    :cond_1
    cmpl-float v0, v2, v1

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->i:Landroid/graphics/Matrix;

    invoke-virtual {v0, v1, v1}, Landroid/graphics/Matrix;->postScale(FF)Z

    :cond_2
    return-void
.end method


# virtual methods
.method public final a()V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->f:Landroid/view/ViewTreeObserver;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->f:Landroid/view/ViewTreeObserver;

    invoke-virtual {v0}, Landroid/view/ViewTreeObserver;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->f:Landroid/view/ViewTreeObserver;

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->removeGlobalOnLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->f:Landroid/view/ViewTreeObserver;

    iput-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->m:Lcom/mg/ola/common/widget/image/viewer/b$e;

    iput-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->n:Lcom/mg/ola/common/widget/image/viewer/b$f;

    iput-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->o:Lcom/mg/ola/common/widget/image/viewer/b$g;

    iput-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->e:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method public a(F)V
    .locals 2

    iget v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->b:F

    iget v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->c:F

    invoke-static {p1, v0, v1}, Lcom/mg/ola/common/widget/image/viewer/b;->b(FFF)V

    iput p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->a:F

    return-void
.end method

.method public a(FFF)V
    .locals 2

    iget v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->B:F

    add-float/2addr v0, p1

    iput v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->B:F

    iget v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->B:F

    const/high16 v1, 0x43b40000    # 360.0f

    cmpl-float v0, v0, v1

    if-ltz v0, :cond_0

    iget v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->B:F

    sub-float/2addr v0, v1

    iput v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->B:F

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->j:Landroid/graphics/Matrix;

    invoke-virtual {v0, p1, p2, p3}, Landroid/graphics/Matrix;->postRotate(FFF)Z

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->q()V

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->m()V

    return-void
.end method

.method public final a(FFFZ)V
    .locals 7

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    if-eqz v0, :cond_1

    if-eqz p4, :cond_0

    new-instance p4, Lcom/mg/ola/common/widget/image/viewer/b$a;

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->g()F

    move-result v3

    move-object v1, p4

    move-object v2, p0

    move v4, p1

    move v5, p2

    move v6, p3

    invoke-direct/range {v1 .. v6}, Lcom/mg/ola/common/widget/image/viewer/b$a;-><init>(Lcom/mg/ola/common/widget/image/viewer/b;FFFF)V

    invoke-virtual {v0, p4}, Landroid/widget/ImageView;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_0
    iget-object p4, p0, Lcom/mg/ola/common/widget/image/viewer/b;->i:Landroid/graphics/Matrix;

    invoke-virtual {p4, p1, p1, p2, p3}, Landroid/graphics/Matrix;->postScale(FFFF)Z

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->m()V

    :cond_1
    return-void
.end method

.method public final a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->p:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public final a(Landroid/widget/ImageView$ScaleType;)V
    .locals 1

    invoke-static {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Landroid/widget/ImageView$ScaleType;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->x:Landroid/widget/ImageView$ScaleType;

    if-eq p1, v0, :cond_0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->x:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->i()V

    :cond_0
    return-void
.end method

.method public final a(Lcom/mg/ola/common/widget/image/viewer/b$e;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->m:Lcom/mg/ola/common/widget/image/viewer/b$e;

    return-void
.end method

.method public final a(Lcom/mg/ola/common/widget/image/viewer/b$f;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->n:Lcom/mg/ola/common/widget/image/viewer/b$f;

    return-void
.end method

.method public final a(Lcom/mg/ola/common/widget/image/viewer/b$g;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->o:Lcom/mg/ola/common/widget/image/viewer/b$g;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->d:Z

    return-void
.end method

.method public final b()Landroid/graphics/RectF;
    .locals 1

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->o()V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->j()Landroid/graphics/Matrix;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/graphics/Matrix;)Landroid/graphics/RectF;

    move-result-object v0

    return-object v0
.end method

.method public b(F)V
    .locals 2

    iget v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->a:F

    iget v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->c:F

    invoke-static {v0, p1, v1}, Lcom/mg/ola/common/widget/image/viewer/b;->b(FFF)V

    iput p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->b:F

    return-void
.end method

.method public final b(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->w:Z

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->i()V

    return-void
.end method

.method public final c()Landroid/widget/ImageView;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->e:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->e:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->a()V

    :cond_1
    return-object v0
.end method

.method public c(F)V
    .locals 2

    iget v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->a:F

    iget v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->b:F

    invoke-static {v0, v1, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->b(FFF)V

    iput p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->c:F

    return-void
.end method

.method public c(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->C:Z

    return-void
.end method

.method public d()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->a:F

    return v0
.end method

.method public e()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->b:F

    return v0
.end method

.method public f()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->c:F

    return v0
.end method

.method public final g()F
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->i:Landroid/graphics/Matrix;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/graphics/Matrix;I)F

    move-result v0

    return v0
.end method

.method public final h()Landroid/widget/ImageView$ScaleType;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->x:Landroid/widget/ImageView$ScaleType;

    return-object v0
.end method

.method public final i()V
    .locals 2

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-boolean v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->w:Z

    if-eqz v1, :cond_0

    invoke-static {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->c(Landroid/widget/ImageView;)V

    invoke-virtual {v0}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/graphics/drawable/Drawable;)V

    return-void

    :cond_0
    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->p()V

    :cond_1
    return-void
.end method

.method protected j()Landroid/graphics/Matrix;
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->h:Landroid/graphics/Matrix;

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->g:Landroid/graphics/Matrix;

    invoke-virtual {v0, v1}, Landroid/graphics/Matrix;->set(Landroid/graphics/Matrix;)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->h:Landroid/graphics/Matrix;

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->j:Landroid/graphics/Matrix;

    invoke-virtual {v0, v1}, Landroid/graphics/Matrix;->postConcat(Landroid/graphics/Matrix;)Z

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->h:Landroid/graphics/Matrix;

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->i:Landroid/graphics/Matrix;

    invoke-virtual {v0, v1}, Landroid/graphics/Matrix;->postConcat(Landroid/graphics/Matrix;)Z

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->h:Landroid/graphics/Matrix;

    return-object v0
.end method

.method public k()Z
    .locals 1

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->A:Z

    return v0
.end method

.method public final onGlobalLayout()V
    .locals 6

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-boolean v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->w:Z

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Landroid/widget/ImageView;->getTop()I

    move-result v1

    invoke-virtual {v0}, Landroid/widget/ImageView;->getRight()I

    move-result v2

    invoke-virtual {v0}, Landroid/widget/ImageView;->getBottom()I

    move-result v3

    invoke-virtual {v0}, Landroid/widget/ImageView;->getLeft()I

    move-result v4

    iget v5, p0, Lcom/mg/ola/common/widget/image/viewer/b;->q:I

    if-ne v1, v5, :cond_0

    iget v5, p0, Lcom/mg/ola/common/widget/image/viewer/b;->s:I

    if-ne v3, v5, :cond_0

    iget v5, p0, Lcom/mg/ola/common/widget/image/viewer/b;->t:I

    if-ne v4, v5, :cond_0

    iget v5, p0, Lcom/mg/ola/common/widget/image/viewer/b;->r:I

    if-eq v2, v5, :cond_1

    :cond_0
    invoke-virtual {v0}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/graphics/drawable/Drawable;)V

    iput v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->q:I

    iput v2, p0, Lcom/mg/ola/common/widget/image/viewer/b;->r:I

    iput v3, p0, Lcom/mg/ola/common/widget/image/viewer/b;->s:I

    iput v4, p0, Lcom/mg/ola/common/widget/image/viewer/b;->t:I

    :cond_1
    return-void
.end method

.method public final onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 10

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/image/viewer/b;->w:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_4

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v2, 0x3

    const/4 v3, 0x1

    if-eq v0, v2, :cond_0

    packed-switch v0, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p1

    invoke-interface {p1, v3}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->l()V

    goto :goto_1

    :cond_0
    :pswitch_1
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->g()F

    move-result v0

    iget v2, p0, Lcom/mg/ola/common/widget/image/viewer/b;->a:F

    cmpg-float v0, v0, v2

    if-gez v0, :cond_2

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->b()Landroid/graphics/RectF;

    move-result-object v0

    if-eqz v0, :cond_1

    new-instance v2, Lcom/mg/ola/common/widget/image/viewer/b$a;

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/b;->g()F

    move-result v6

    iget v7, p0, Lcom/mg/ola/common/widget/image/viewer/b;->a:F

    invoke-virtual {v0}, Landroid/graphics/RectF;->centerX()F

    move-result v8

    invoke-virtual {v0}, Landroid/graphics/RectF;->centerY()F

    move-result v9

    move-object v4, v2

    move-object v5, p0

    invoke-direct/range {v4 .. v9}, Lcom/mg/ola/common/widget/image/viewer/b$a;-><init>(Lcom/mg/ola/common/widget/image/viewer/b;FFFF)V

    invoke-virtual {p1, v2}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    const/4 p1, 0x1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    :goto_0
    iput-boolean v1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->A:Z

    move v1, p1

    :cond_2
    :goto_1
    iget-boolean p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->C:Z

    if-eqz p1, :cond_4

    :try_start_0
    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->z:Landroid/view/GestureDetector;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->z:Landroid/view/GestureDetector;

    invoke-virtual {p1, p2}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    if-eqz p1, :cond_3

    const/4 v1, 0x1

    :cond_3
    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->y:Landroid/view/ScaleGestureDetector;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b;->y:Landroid/view/ScaleGestureDetector;

    invoke-virtual {p1, p2}, Landroid/view/ScaleGestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p1, :cond_4

    const/4 v1, 0x1

    return v1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_4
    return v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
