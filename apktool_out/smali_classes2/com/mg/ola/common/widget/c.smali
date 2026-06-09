.class public Lcom/mg/ola/common/widget/c;
.super Ljava/lang/Object;


# instance fields
.field private a:F

.field private b:F

.field private c:F

.field private d:F

.field private e:F

.field private f:F

.field private g:I

.field private h:I

.field private i:I

.field private j:I

.field private k:Z

.field private l:Landroid/widget/ListView;

.field private m:Landroid/widget/SectionIndexer;

.field private n:[Ljava/lang/String;

.field private o:Landroid/graphics/RectF;

.field private p:Landroid/os/Handler;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/widget/ListView;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/mg/ola/common/widget/c;->g:I

    const/4 v1, -0x1

    iput v1, p0, Lcom/mg/ola/common/widget/c;->j:I

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/c;->k:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/common/widget/c;->l:Landroid/widget/ListView;

    iput-object v0, p0, Lcom/mg/ola/common/widget/c;->m:Landroid/widget/SectionIndexer;

    iput-object v0, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    new-instance v0, Lcom/mg/ola/common/widget/c$1;

    invoke-direct {v0, p0}, Lcom/mg/ola/common/widget/c$1;-><init>(Lcom/mg/ola/common/widget/c;)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/c;->p:Landroid/os/Handler;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mg/ola/common/widget/c;->d:F

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p1

    iget p1, p1, Landroid/util/DisplayMetrics;->scaledDensity:F

    iput p1, p0, Lcom/mg/ola/common/widget/c;->e:F

    iput-object p2, p0, Lcom/mg/ola/common/widget/c;->l:Landroid/widget/ListView;

    iget-object p1, p0, Lcom/mg/ola/common/widget/c;->l:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getAdapter()Landroid/widget/ListAdapter;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/c;->a(Landroid/widget/Adapter;)V

    iget p1, p0, Lcom/mg/ola/common/widget/c;->d:F

    const/high16 p2, 0x41a00000    # 20.0f

    mul-float p1, p1, p2

    iput p1, p0, Lcom/mg/ola/common/widget/c;->a:F

    iget p1, p0, Lcom/mg/ola/common/widget/c;->d:F

    const/high16 p2, 0x41200000    # 10.0f

    mul-float p1, p1, p2

    iput p1, p0, Lcom/mg/ola/common/widget/c;->b:F

    iget p1, p0, Lcom/mg/ola/common/widget/c;->d:F

    const/high16 p2, 0x40a00000    # 5.0f

    mul-float p1, p1, p2

    iput p1, p0, Lcom/mg/ola/common/widget/c;->c:F

    return-void
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/c;F)F
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/widget/c;->f:F

    return p1
.end method

.method private a(F)I
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    array-length v0, v0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->top:F

    iget v2, p0, Lcom/mg/ola/common/widget/c;->b:F

    add-float/2addr v0, v2

    cmpg-float v0, p1, v0

    if-gez v0, :cond_1

    return v1

    :cond_1
    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->top:F

    iget-object v1, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    invoke-virtual {v1}, Landroid/graphics/RectF;->height()F

    move-result v1

    add-float/2addr v0, v1

    iget v1, p0, Lcom/mg/ola/common/widget/c;->b:F

    sub-float/2addr v0, v1

    cmpl-float v0, p1, v0

    if-ltz v0, :cond_2

    iget-object p1, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    array-length p1, p1

    add-int/lit8 p1, p1, -0x1

    return p1

    :cond_2
    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->top:F

    sub-float/2addr p1, v0

    iget v0, p0, Lcom/mg/ola/common/widget/c;->b:F

    sub-float/2addr p1, v0

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    invoke-virtual {v0}, Landroid/graphics/RectF;->height()F

    move-result v0

    const/high16 v1, 0x40000000    # 2.0f

    iget v2, p0, Lcom/mg/ola/common/widget/c;->b:F

    mul-float v2, v2, v1

    sub-float/2addr v0, v2

    iget-object v1, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    array-length v1, v1

    int-to-float v1, v1

    div-float/2addr v0, v1

    div-float/2addr p1, v0

    float-to-int p1, p1

    return p1

    :cond_3
    return v1
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/c;)I
    .locals 0

    iget p0, p0, Lcom/mg/ola/common/widget/c;->g:I

    return p0
.end method

.method private a(I)V
    .locals 2

    if-ltz p1, :cond_1

    const/4 v0, 0x3

    if-le p1, v0, :cond_0

    return-void

    :cond_0
    iput p1, p0, Lcom/mg/ola/common/widget/c;->g:I

    iget p1, p0, Lcom/mg/ola/common/widget/c;->g:I

    const/4 v0, 0x0

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    const/high16 p1, 0x3f800000    # 1.0f

    iput p1, p0, Lcom/mg/ola/common/widget/c;->f:F

    const-wide/16 v0, 0xbb8

    goto :goto_0

    :pswitch_1
    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/c;->f:F

    const-wide/16 v0, 0x0

    :goto_0
    invoke-direct {p0, v0, v1}, Lcom/mg/ola/common/widget/c;->a(J)V

    return-void

    :pswitch_2
    iget-object p1, p0, Lcom/mg/ola/common/widget/c;->p:Landroid/os/Handler;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeMessages(I)V

    :cond_1
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_2
        :pswitch_0
    .end packed-switch
.end method

.method private a(J)V
    .locals 6

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->p:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->p:Landroid/os/Handler;

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    add-long v4, v2, p1

    invoke-virtual {v0, v1, v4, v5}, Landroid/os/Handler;->sendEmptyMessageAtTime(IJ)Z

    return-void
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/c;I)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/c;->a(I)V

    return-void
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/c;J)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/common/widget/c;->a(J)V

    return-void
.end method

.method private a(FF)Z
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->left:F

    cmpl-float p1, p1, v0

    if-ltz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    iget p1, p1, Landroid/graphics/RectF;->top:F

    cmpl-float p1, p2, p1

    if-ltz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    iget p1, p1, Landroid/graphics/RectF;->top:F

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    invoke-virtual {v0}, Landroid/graphics/RectF;->height()F

    move-result v0

    add-float/2addr p1, v0

    cmpg-float p1, p2, p1

    if-gtz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method static synthetic b(Lcom/mg/ola/common/widget/c;)F
    .locals 0

    iget p0, p0, Lcom/mg/ola/common/widget/c;->f:F

    return p0
.end method

.method static synthetic c(Lcom/mg/ola/common/widget/c;)Landroid/widget/ListView;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/c;->l:Landroid/widget/ListView;

    return-object p0
.end method


# virtual methods
.method public a()V
    .locals 2

    iget v0, p0, Lcom/mg/ola/common/widget/c;->g:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/c;->a(I)V

    return-void

    :cond_0
    iget v0, p0, Lcom/mg/ola/common/widget/c;->g:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_1

    invoke-direct {p0, v1}, Lcom/mg/ola/common/widget/c;->a(I)V

    :cond_1
    return-void
.end method

.method public a(IIII)V
    .locals 2

    iput p1, p0, Lcom/mg/ola/common/widget/c;->h:I

    iput p2, p0, Lcom/mg/ola/common/widget/c;->i:I

    new-instance p3, Landroid/graphics/RectF;

    int-to-float p1, p1

    iget p4, p0, Lcom/mg/ola/common/widget/c;->b:F

    sub-float p4, p1, p4

    iget v0, p0, Lcom/mg/ola/common/widget/c;->a:F

    sub-float/2addr p4, v0

    iget v0, p0, Lcom/mg/ola/common/widget/c;->b:F

    iget v1, p0, Lcom/mg/ola/common/widget/c;->b:F

    sub-float/2addr p1, v1

    int-to-float p2, p2

    iget v1, p0, Lcom/mg/ola/common/widget/c;->b:F

    sub-float/2addr p2, v1

    invoke-direct {p3, p4, v0, p1, p2}, Landroid/graphics/RectF;-><init>(FFFF)V

    iput-object p3, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    return-void
.end method

.method public a(Landroid/graphics/Canvas;)V
    .locals 14

    iget v0, p0, Lcom/mg/ola/common/widget/c;->g:I

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    const/high16 v1, -0x1000000

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    const/high16 v2, 0x42800000    # 64.0f

    iget v3, p0, Lcom/mg/ola/common/widget/c;->f:F

    mul-float v3, v3, v2

    float-to-int v2, v3

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setAlpha(I)V

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v3, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    iget v4, p0, Lcom/mg/ola/common/widget/c;->d:F

    const/high16 v5, 0x40a00000    # 5.0f

    mul-float v4, v4, v5

    iget v6, p0, Lcom/mg/ola/common/widget/c;->d:F

    mul-float v6, v6, v5

    invoke-virtual {p1, v3, v4, v6, v0}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_2

    iget v0, p0, Lcom/mg/ola/common/widget/c;->j:I

    const/4 v3, -0x1

    const/4 v4, 0x0

    const/high16 v6, 0x40000000    # 2.0f

    if-ltz v0, :cond_1

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    const/16 v1, 0x60

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setAlpha(I)V

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    const/high16 v1, 0x40400000    # 3.0f

    const/16 v7, 0x40

    invoke-static {v7, v4, v4, v4}, Landroid/graphics/Color;->argb(IIII)I

    move-result v7

    const/4 v8, 0x0

    invoke-virtual {v0, v1, v8, v8, v7}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setColor(I)V

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    const/high16 v7, 0x42480000    # 50.0f

    iget v8, p0, Lcom/mg/ola/common/widget/c;->e:F

    mul-float v8, v8, v7

    invoke-virtual {v1, v8}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object v7, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    iget v8, p0, Lcom/mg/ola/common/widget/c;->j:I

    aget-object v7, v7, v8

    invoke-virtual {v1, v7}, Landroid/graphics/Paint;->measureText(Ljava/lang/String;)F

    move-result v7

    iget v8, p0, Lcom/mg/ola/common/widget/c;->c:F

    mul-float v8, v8, v6

    invoke-virtual {v1}, Landroid/graphics/Paint;->descent()F

    move-result v9

    add-float/2addr v8, v9

    invoke-virtual {v1}, Landroid/graphics/Paint;->ascent()F

    move-result v9

    sub-float/2addr v8, v9

    new-instance v9, Landroid/graphics/RectF;

    iget v10, p0, Lcom/mg/ola/common/widget/c;->h:I

    int-to-float v10, v10

    sub-float/2addr v10, v8

    div-float/2addr v10, v6

    iget v11, p0, Lcom/mg/ola/common/widget/c;->i:I

    int-to-float v11, v11

    sub-float/2addr v11, v8

    div-float/2addr v11, v6

    iget v12, p0, Lcom/mg/ola/common/widget/c;->h:I

    int-to-float v12, v12

    sub-float/2addr v12, v8

    div-float/2addr v12, v6

    add-float/2addr v12, v8

    iget v13, p0, Lcom/mg/ola/common/widget/c;->i:I

    int-to-float v13, v13

    sub-float/2addr v13, v8

    div-float/2addr v13, v6

    add-float/2addr v13, v8

    invoke-direct {v9, v10, v11, v12, v13}, Landroid/graphics/RectF;-><init>(FFFF)V

    iget v10, p0, Lcom/mg/ola/common/widget/c;->d:F

    mul-float v10, v10, v5

    iget v11, p0, Lcom/mg/ola/common/widget/c;->d:F

    mul-float v11, v11, v5

    invoke-virtual {p1, v9, v10, v11, v0}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    iget v5, p0, Lcom/mg/ola/common/widget/c;->j:I

    aget-object v0, v0, v5

    iget v5, v9, Landroid/graphics/RectF;->left:F

    sub-float/2addr v8, v7

    div-float/2addr v8, v6

    add-float/2addr v5, v8

    const/high16 v7, 0x3f800000    # 1.0f

    sub-float/2addr v5, v7

    iget v8, v9, Landroid/graphics/RectF;->top:F

    iget v9, p0, Lcom/mg/ola/common/widget/c;->c:F

    add-float/2addr v8, v9

    invoke-virtual {v1}, Landroid/graphics/Paint;->ascent()F

    move-result v9

    sub-float/2addr v8, v9

    add-float/2addr v8, v7

    invoke-virtual {p1, v0, v5, v8, v1}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    :cond_1
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setColor(I)V

    const/high16 v1, 0x437f0000    # 255.0f

    iget v3, p0, Lcom/mg/ola/common/widget/c;->f:F

    mul-float v3, v3, v1

    float-to-int v1, v3

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setAlpha(I)V

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    const/high16 v1, 0x41400000    # 12.0f

    iget v2, p0, Lcom/mg/ola/common/widget/c;->e:F

    mul-float v2, v2, v1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object v1, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    invoke-virtual {v1}, Landroid/graphics/RectF;->height()F

    move-result v1

    iget v2, p0, Lcom/mg/ola/common/widget/c;->b:F

    mul-float v2, v2, v6

    sub-float/2addr v1, v2

    iget-object v2, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    array-length v2, v2

    int-to-float v2, v2

    div-float/2addr v1, v2

    invoke-virtual {v0}, Landroid/graphics/Paint;->descent()F

    move-result v2

    invoke-virtual {v0}, Landroid/graphics/Paint;->ascent()F

    move-result v3

    sub-float/2addr v2, v3

    sub-float v2, v1, v2

    div-float/2addr v2, v6

    :goto_0
    iget-object v3, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    array-length v3, v3

    if-ge v4, v3, :cond_2

    iget v3, p0, Lcom/mg/ola/common/widget/c;->a:F

    iget-object v5, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    aget-object v5, v5, v4

    invoke-virtual {v0, v5}, Landroid/graphics/Paint;->measureText(Ljava/lang/String;)F

    move-result v5

    sub-float/2addr v3, v5

    div-float/2addr v3, v6

    iget-object v5, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    aget-object v5, v5, v4

    iget-object v7, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    iget v7, v7, Landroid/graphics/RectF;->left:F

    add-float/2addr v7, v3

    iget-object v3, p0, Lcom/mg/ola/common/widget/c;->o:Landroid/graphics/RectF;

    iget v3, v3, Landroid/graphics/RectF;->top:F

    iget v8, p0, Lcom/mg/ola/common/widget/c;->b:F

    add-float/2addr v3, v8

    int-to-float v8, v4

    mul-float v8, v8, v1

    add-float/2addr v3, v8

    add-float/2addr v3, v2

    invoke-virtual {v0}, Landroid/graphics/Paint;->ascent()F

    move-result v8

    sub-float/2addr v3, v8

    invoke-virtual {p1, v5, v7, v3, v0}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_2
    return-void
.end method

.method public a(Landroid/widget/Adapter;)V
    .locals 1

    instance-of v0, p1, Landroid/widget/SectionIndexer;

    if-eqz v0, :cond_0

    check-cast p1, Landroid/widget/SectionIndexer;

    iput-object p1, p0, Lcom/mg/ola/common/widget/c;->m:Landroid/widget/SectionIndexer;

    iget-object p1, p0, Lcom/mg/ola/common/widget/c;->m:Landroid/widget/SectionIndexer;

    invoke-interface {p1}, Landroid/widget/SectionIndexer;->getSections()[Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/String;

    iput-object p1, p0, Lcom/mg/ola/common/widget/c;->n:[Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public a(Landroid/view/MotionEvent;)Z
    .locals 5

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x2

    const/4 v2, 0x0

    const/4 v3, 0x1

    packed-switch v0, :pswitch_data_0

    return v2

    :pswitch_0
    iget-boolean v0, p0, Lcom/mg/ola/common/widget/c;->k:Z

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    invoke-direct {p0, v0, v1}, Lcom/mg/ola/common/widget/c;->a(FF)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/c;->a(F)I

    move-result p1

    iput p1, p0, Lcom/mg/ola/common/widget/c;->j:I

    iget-object p1, p0, Lcom/mg/ola/common/widget/c;->l:Landroid/widget/ListView;

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->m:Landroid/widget/SectionIndexer;

    iget v1, p0, Lcom/mg/ola/common/widget/c;->j:I

    invoke-interface {v0, v1}, Landroid/widget/SectionIndexer;->getPositionForSection(I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setSelection(I)V

    :cond_0
    return v3

    :pswitch_1
    iget-boolean p1, p0, Lcom/mg/ola/common/widget/c;->k:Z

    if-eqz p1, :cond_1

    iput-boolean v2, p0, Lcom/mg/ola/common/widget/c;->k:Z

    const/4 p1, -0x1

    iput p1, p0, Lcom/mg/ola/common/widget/c;->j:I

    :cond_1
    iget p1, p0, Lcom/mg/ola/common/widget/c;->g:I

    if-ne p1, v1, :cond_2

    const/4 p1, 0x3

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/c;->a(I)V

    return v2

    :pswitch_2
    iget v0, p0, Lcom/mg/ola/common/widget/c;->g:I

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v4

    invoke-direct {p0, v0, v4}, Lcom/mg/ola/common/widget/c;->a(FF)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-direct {p0, v1}, Lcom/mg/ola/common/widget/c;->a(I)V

    iput-boolean v3, p0, Lcom/mg/ola/common/widget/c;->k:Z

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/c;->a(F)I

    move-result p1

    iput p1, p0, Lcom/mg/ola/common/widget/c;->j:I

    iget-object p1, p0, Lcom/mg/ola/common/widget/c;->l:Landroid/widget/ListView;

    iget-object v0, p0, Lcom/mg/ola/common/widget/c;->m:Landroid/widget/SectionIndexer;

    iget v1, p0, Lcom/mg/ola/common/widget/c;->j:I

    invoke-interface {v0, v1}, Landroid/widget/SectionIndexer;->getPositionForSection(I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setSelection(I)V

    return v3

    :cond_2
    return v2

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public b()V
    .locals 2

    iget v0, p0, Lcom/mg/ola/common/widget/c;->g:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x3

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/c;->a(I)V

    :cond_0
    return-void
.end method
