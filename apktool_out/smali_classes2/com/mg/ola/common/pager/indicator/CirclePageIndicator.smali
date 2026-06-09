.class public Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;
.super Landroid/view/View;

# interfaces
.implements Landroid/support/v4/view/ViewPager$OnPageChangeListener;
.implements Lcom/mg/ola/common/pager/indicator/a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/common/pager/indicator/CirclePageIndicator$SavedState;
    }
.end annotation


# instance fields
.field private a:F

.field private final b:Landroid/graphics/Paint;

.field private final c:Landroid/graphics/Paint;

.field private final d:Landroid/graphics/Paint;

.field private e:Lcom/mg/ola/common/widget/OlaViewPager;

.field private f:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

.field private g:I

.field private h:I

.field private i:I

.field private j:I

.field private k:I

.field private l:I

.field private m:Z

.field private n:Z

.field private o:I

.field private p:F

.field private q:I

.field private r:Z

.field private s:F


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const/high16 v0, 0x7f040000

    invoke-direct {p0, p1, p2, v0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 10

    invoke-direct {p0, p1, p2, p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/high16 v0, -0x40800000    # -1.0f

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->p:F

    const/4 v0, -0x1

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->q:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f060072

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v1

    const v2, 0x7f060071

    invoke-virtual {v0, v2}, Landroid/content/res/Resources;->getColor(I)I

    move-result v2

    const v3, 0x7f0a000a

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v3

    const v4, 0x7f060073

    invoke-virtual {v0, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v4

    const v5, 0x7f07009e

    invoke-virtual {v0, v5}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v5

    const v6, 0x7f07009d

    invoke-virtual {v0, v6}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v6

    const v7, 0x7f050005

    invoke-virtual {v0, v7}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v7

    const v8, 0x7f050006

    invoke-virtual {v0, v8}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v0

    sget-object v8, Lchat/ola/vn/i$b;->CirclePageIndicator:[I

    const v9, 0x7f1001c7

    invoke-virtual {p1, p2, v8, p3, v9}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[III)Landroid/content/res/TypedArray;

    move-result-object p2

    const/4 p3, 0x0

    invoke-virtual {p2, p3, v7}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result p3

    iput-boolean p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->m:Z

    const/4 p3, 0x2

    invoke-virtual {p2, p3, v3}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result p3

    iput p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->l:I

    new-instance p3, Landroid/graphics/Paint;

    const/4 v3, 0x1

    invoke-direct {p3, v3}, Landroid/graphics/Paint;-><init>(I)V

    iput-object p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->b:Landroid/graphics/Paint;

    iget-object p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->b:Landroid/graphics/Paint;

    sget-object v7, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p3, v7}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->b:Landroid/graphics/Paint;

    const/4 v7, 0x3

    invoke-virtual {p2, v7, v1}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v1

    invoke-virtual {p3, v1}, Landroid/graphics/Paint;->setColor(I)V

    new-instance p3, Landroid/graphics/Paint;

    invoke-direct {p3, v3}, Landroid/graphics/Paint;-><init>(I)V

    iput-object p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->c:Landroid/graphics/Paint;

    iget-object p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->c:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p3, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->c:Landroid/graphics/Paint;

    const/4 v1, 0x6

    invoke-virtual {p2, v1, v4}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v1

    invoke-virtual {p3, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->c:Landroid/graphics/Paint;

    const/4 v1, 0x7

    invoke-virtual {p2, v1, v5}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v1

    invoke-virtual {p3, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    new-instance p3, Landroid/graphics/Paint;

    invoke-direct {p3, v3}, Landroid/graphics/Paint;-><init>(I)V

    iput-object p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->d:Landroid/graphics/Paint;

    iget-object p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->d:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p3, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->d:Landroid/graphics/Paint;

    invoke-virtual {p2, v3, v2}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v1

    invoke-virtual {p3, v1}, Landroid/graphics/Paint;->setColor(I)V

    const/4 p3, 0x4

    invoke-virtual {p2, p3, v6}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result p3

    iput p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    const/4 p3, 0x5

    invoke-virtual {p2, p3, v0}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result p3

    iput-boolean p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->n:Z

    invoke-virtual {p2}, Landroid/content/res/TypedArray;->recycle()V

    invoke-static {p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/view/ViewConfigurationCompat;->getScaledPagingTouchSlop(Landroid/view/ViewConfiguration;)I

    move-result p1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->o:I

    return-void
.end method

.method private a(I)I
    .locals 6

    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v0

    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p1

    const/high16 v1, 0x40000000    # 2.0f

    if-eq v0, v1, :cond_2

    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    if-nez v1, :cond_0

    return p1

    :cond_0
    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v1

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getPaddingLeft()I

    move-result v2

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getPaddingRight()I

    move-result v3

    add-int/2addr v2, v3

    int-to-float v2, v2

    mul-int/lit8 v3, v1, 0x2

    int-to-float v3, v3

    iget v4, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    iget v5, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->s:F

    add-float/2addr v4, v5

    mul-float v3, v3, v4

    add-float/2addr v2, v3

    add-int/lit8 v1, v1, -0x1

    int-to-float v1, v1

    iget v3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    mul-float v1, v1, v3

    add-float/2addr v2, v1

    const/high16 v1, 0x3f800000    # 1.0f

    add-float/2addr v2, v1

    float-to-int v1, v2

    const/high16 v2, -0x80000000

    if-ne v0, v2, :cond_1

    invoke-static {v1, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    return p1

    :cond_1
    move p1, v1

    :cond_2
    return p1
.end method

.method private a()V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->l:I

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getWidth()I

    move-result v0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getHeight()I

    move-result v0

    :goto_0
    iput v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->k:I

    :cond_1
    return-void
.end method

.method private b(I)I
    .locals 3

    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v0

    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p1

    const/high16 v1, 0x40000000    # 2.0f

    if-ne v0, v1, :cond_0

    return p1

    :cond_0
    const/high16 v1, 0x40000000    # 2.0f

    iget v2, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    mul-float v2, v2, v1

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getPaddingTop()I

    move-result v1

    int-to-float v1, v1

    add-float/2addr v2, v1

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getPaddingBottom()I

    move-result v1

    int-to-float v1, v1

    add-float/2addr v2, v1

    const/high16 v1, 0x3f800000    # 1.0f

    add-float/2addr v2, v1

    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->s:F

    add-float/2addr v2, v1

    float-to-int v1, v2

    const/high16 v2, -0x80000000

    if-ne v0, v2, :cond_1

    invoke-static {v1, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    return p1

    :cond_1
    move p1, v1

    return p1
.end method


# virtual methods
.method public getFillColor()I
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->d:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    return v0
.end method

.method public getOrientation()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->l:I

    return v0
.end method

.method public getPageColor()I
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->b:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    return v0
.end method

.method public getRadius()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    return v0
.end method

.method public getStrokeColor()I
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->c:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    return v0
.end method

.method public getStrokeWidth()F
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->c:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getStrokeWidth()F

    move-result v0

    return v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 11

    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    if-lt v1, v0, :cond_2

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->setCurrentItem(I)V

    return-void

    :cond_2
    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->l:I

    if-nez v1, :cond_3

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getWidth()I

    move-result v1

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getPaddingLeft()I

    move-result v2

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getPaddingRight()I

    move-result v3

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getPaddingTop()I

    move-result v4

    goto :goto_0

    :cond_3
    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getHeight()I

    move-result v1

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getPaddingTop()I

    move-result v2

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getPaddingBottom()I

    move-result v3

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getPaddingLeft()I

    move-result v4

    :goto_0
    iget v5, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    const/high16 v6, 0x40400000    # 3.0f

    mul-float v5, v5, v6

    int-to-float v4, v4

    iget v6, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    add-float/2addr v4, v6

    int-to-float v6, v2

    iget v7, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    add-float/2addr v6, v7

    iget v7, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->s:F

    add-float/2addr v6, v7

    iget-boolean v7, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->m:Z

    const/high16 v8, 0x40000000    # 2.0f

    if-eqz v7, :cond_4

    sub-int/2addr v1, v2

    sub-int/2addr v1, v3

    int-to-float v1, v1

    div-float/2addr v1, v8

    int-to-float v2, v0

    mul-float v2, v2, v5

    div-float/2addr v2, v8

    sub-float/2addr v1, v2

    add-float/2addr v6, v1

    :cond_4
    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    iget-object v2, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->c:Landroid/graphics/Paint;

    invoke-virtual {v2}, Landroid/graphics/Paint;->getStrokeWidth()F

    move-result v2

    const/4 v3, 0x0

    cmpl-float v2, v2, v3

    if-lez v2, :cond_5

    iget-object v2, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->c:Landroid/graphics/Paint;

    invoke-virtual {v2}, Landroid/graphics/Paint;->getStrokeWidth()F

    move-result v2

    div-float/2addr v2, v8

    sub-float/2addr v1, v2

    :cond_5
    const/4 v2, 0x0

    :goto_1
    const/high16 v3, 0x3f800000    # 1.0f

    if-ge v2, v0, :cond_9

    int-to-float v7, v2

    mul-float v7, v7, v5

    add-float/2addr v7, v6

    iget v8, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->l:I

    if-nez v8, :cond_6

    add-float/2addr v3, v4

    move v10, v7

    move v7, v3

    move v3, v10

    goto :goto_2

    :cond_6
    add-float/2addr v3, v4

    :goto_2
    iget-object v8, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->b:Landroid/graphics/Paint;

    invoke-virtual {v8}, Landroid/graphics/Paint;->getAlpha()I

    move-result v8

    if-lez v8, :cond_7

    iget-object v8, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->b:Landroid/graphics/Paint;

    invoke-virtual {p1, v3, v7, v1, v8}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    :cond_7
    iget v8, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    cmpl-float v8, v1, v8

    if-eqz v8, :cond_8

    iget v8, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    iget-object v9, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->c:Landroid/graphics/Paint;

    invoke-virtual {p1, v3, v7, v8, v9}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    :cond_8
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_9
    iget-boolean v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->n:Z

    if-eqz v0, :cond_a

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->h:I

    goto :goto_3

    :cond_a
    iget v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    :goto_3
    int-to-float v0, v0

    mul-float v0, v0, v5

    iget-boolean v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->n:Z

    if-nez v1, :cond_b

    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->k:I

    if-eqz v1, :cond_b

    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->i:I

    int-to-float v1, v1

    mul-float v1, v1, v3

    iget v2, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->k:I

    int-to-float v2, v2

    div-float/2addr v1, v2

    mul-float v1, v1, v5

    add-float/2addr v0, v1

    :cond_b
    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->l:I

    if-nez v1, :cond_c

    add-float/2addr v6, v0

    add-float/2addr v4, v3

    move v1, v6

    goto :goto_4

    :cond_c
    add-float v1, v4, v3

    add-float v4, v6, v0

    :goto_4
    iget v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    iget-object v2, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->d:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v4, v0, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    return-void
.end method

.method protected onMeasure(II)V
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->l:I

    if-nez v0, :cond_0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a(I)I

    move-result p1

    invoke-direct {p0, p2}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->b(I)I

    move-result p2

    :goto_0
    invoke-virtual {p0, p1, p2}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->setMeasuredDimension(II)V

    return-void

    :cond_0
    invoke-direct {p0, p1}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->b(I)I

    move-result p1

    invoke-direct {p0, p2}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a(I)I

    move-result p2

    goto :goto_0

    return-void
.end method

.method public onPageScrollStateChanged(I)V
    .locals 1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->j:I

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v0

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v0

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->h:I

    const/4 v0, 0x0

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->i:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->f:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->f:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    invoke-interface {v0, p1}, Landroid/support/v4/view/ViewPager$OnPageChangeListener;->onPageScrollStateChanged(I)V

    :cond_1
    return-void
.end method

.method public onPageScrolled(IFI)V
    .locals 1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    iput p3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->i:I

    invoke-direct {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a()V

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->f:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->f:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    invoke-interface {v0, p1, p2, p3}, Landroid/support/v4/view/ViewPager$OnPageChangeListener;->onPageScrolled(IFI)V

    :cond_0
    return-void
.end method

.method public onPageSelected(I)V
    .locals 1

    iget-boolean v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->n:Z

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->j:I

    if-nez v0, :cond_1

    :cond_0
    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->h:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V

    :cond_1
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->f:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->f:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    invoke-interface {v0, p1}, Landroid/support/v4/view/ViewPager$OnPageChangeListener;->onPageSelected(I)V

    :cond_2
    return-void
.end method

.method public onRestoreInstanceState(Landroid/os/Parcelable;)V
    .locals 1

    check-cast p1, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator$SavedState;

    invoke-virtual {p1}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator$SavedState;->getSuperState()Landroid/os/Parcelable;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/view/View;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    iget v0, p1, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator$SavedState;->a:I

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    iget p1, p1, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator$SavedState;->a:I

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->h:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->requestLayout()V

    return-void
.end method

.method public onSaveInstanceState()Landroid/os/Parcelable;
    .locals 2

    invoke-super {p0}, Landroid/view/View;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    new-instance v1, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator$SavedState;

    invoke-direct {v1, v0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator$SavedState;-><init>(Landroid/os/Parcelable;)V

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    iput v0, v1, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator$SavedState;->a:I

    return-object v1
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 7

    const/4 v0, 0x1

    :try_start_0
    invoke-super {p0, p1}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v1

    if-eqz v1, :cond_0

    return v0

    :cond_0
    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const/4 v2, 0x0

    if-eqz v1, :cond_8

    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v1

    if-nez v1, :cond_1

    return v2

    :cond_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v1

    and-int/lit16 v1, v1, 0xff

    packed-switch v1, :pswitch_data_0

    :pswitch_0
    return v0

    :pswitch_1
    invoke-static {p1}, Landroid/support/v4/view/MotionEventCompat;->getActionIndex(Landroid/view/MotionEvent;)I

    move-result v1

    invoke-static {p1, v1}, Landroid/support/v4/view/MotionEventCompat;->getPointerId(Landroid/view/MotionEvent;I)I

    move-result v3

    iget v4, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->q:I

    if-ne v3, v4, :cond_3

    if-nez v1, :cond_2

    const/4 v2, 0x1

    :cond_2
    invoke-static {p1, v2}, Landroid/support/v4/view/MotionEventCompat;->getPointerId(Landroid/view/MotionEvent;I)I

    move-result v1

    iput v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->q:I

    :cond_3
    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->q:I

    invoke-static {p1, v1}, Landroid/support/v4/view/MotionEventCompat;->findPointerIndex(Landroid/view/MotionEvent;I)I

    move-result v1

    invoke-static {p1, v1}, Landroid/support/v4/view/MotionEventCompat;->getX(Landroid/view/MotionEvent;I)F

    move-result p1

    :goto_0
    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->p:F

    return v0

    :pswitch_2
    invoke-static {p1}, Landroid/support/v4/view/MotionEventCompat;->getActionIndex(Landroid/view/MotionEvent;)I

    move-result v1

    invoke-static {p1, v1}, Landroid/support/v4/view/MotionEventCompat;->getX(Landroid/view/MotionEvent;I)F

    move-result v2

    iput v2, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->p:F

    invoke-static {p1, v1}, Landroid/support/v4/view/MotionEventCompat;->getPointerId(Landroid/view/MotionEvent;I)I

    move-result p1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->q:I

    return v0

    :pswitch_3
    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->q:I

    invoke-static {p1, v1}, Landroid/support/v4/view/MotionEventCompat;->findPointerIndex(Landroid/view/MotionEvent;I)I

    move-result v1

    invoke-static {p1, v1}, Landroid/support/v4/view/MotionEventCompat;->getX(Landroid/view/MotionEvent;I)F

    move-result p1

    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->p:F

    sub-float v1, p1, v1

    iget-boolean v2, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->r:Z

    if-nez v2, :cond_4

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v2

    iget v3, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->o:I

    int-to-float v3, v3

    cmpl-float v2, v2, v3

    if-lez v2, :cond_4

    iput-boolean v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->r:Z

    :cond_4
    iget-boolean v2, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->r:Z

    if-eqz v2, :cond_9

    iget-object v2, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/OlaViewPager;->isFakeDragging()Z

    move-result v2

    if-nez v2, :cond_5

    iget-object v2, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/OlaViewPager;->beginFakeDrag()Z

    :cond_5
    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->p:F

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->fakeDragBy(F)V

    return v0

    :pswitch_4
    iget-boolean v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->r:Z

    if-nez v1, :cond_7

    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v1

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->getWidth()I

    move-result v3

    int-to-float v3, v3

    const/high16 v4, 0x40000000    # 2.0f

    div-float v4, v3, v4

    const/high16 v5, 0x40c00000    # 6.0f

    div-float/2addr v3, v5

    iget v5, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    if-lez v5, :cond_6

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v5

    sub-float v6, v4, v3

    cmpg-float v5, v5, v6

    if-gez v5, :cond_6

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    sub-int/2addr v1, v0

    invoke-virtual {p1, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(I)V

    return v0

    :cond_6
    iget v5, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    sub-int/2addr v1, v0

    if-ge v5, v1, :cond_7

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result p1

    add-float/2addr v4, v3

    cmpl-float p1, p1, v4

    if-lez p1, :cond_7

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    iget v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    add-int/2addr v1, v0

    invoke-virtual {p1, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(I)V

    return v0

    :cond_7
    iput-boolean v2, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->r:Z

    const/4 p1, -0x1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->q:I

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/OlaViewPager;->isFakeDragging()Z

    move-result p1

    if-eqz p1, :cond_9

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/OlaViewPager;->endFakeDrag()V

    return v0

    :pswitch_5
    invoke-static {p1, v2}, Landroid/support/v4/view/MotionEventCompat;->getPointerId(Landroid/view/MotionEvent;I)I

    move-result v1

    iput v1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->q:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    :cond_8
    return v2

    :catch_0
    :cond_9
    return v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_4
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method public setCentered(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->m:Z

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V

    return-void
.end method

.method public setCurrentItem(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    if-nez v0, :cond_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "OlaViewPager has not been bound."

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(I)V

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->g:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V

    return-void
.end method

.method public setFillColor(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->d:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V

    return-void
.end method

.method public setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->f:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    return-void
.end method

.method public setOrientation(I)V
    .locals 1

    packed-switch p1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Orientation must be either HORIZONTAL or VERTICAL."

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->l:I

    invoke-direct {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a()V

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->requestLayout()V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public setPageColor(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->b:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V

    return-void
.end method

.method public setRadius(F)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a:F

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V

    return-void
.end method

.method public setSnap(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->n:Z

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V

    return-void
.end method

.method public setStrokeColor(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->c:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V

    return-void
.end method

.method public setStrokeWidth(F)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->c:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->s:F

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V

    return-void
.end method

.method public setViewPager(Lcom/mg/ola/common/widget/OlaViewPager;)V
    .locals 1

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "OlaViewPager does not have adapter instance."

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    iput-object p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1, p0}, Lcom/mg/ola/common/widget/OlaViewPager;->setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V

    invoke-direct {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->a()V

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->invalidate()V

    return-void
.end method
