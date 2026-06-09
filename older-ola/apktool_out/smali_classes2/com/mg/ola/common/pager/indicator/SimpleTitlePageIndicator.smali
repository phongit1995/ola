.class public Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;
.super Landroid/view/View;

# interfaces
.implements Lcom/mg/ola/common/pager/indicator/a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$SavedState;,
        Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$a;
    }
.end annotation


# instance fields
.field private a:Lcom/mg/ola/common/widget/OlaViewPager;

.field private b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

.field private c:Landroid/support/v4/view/PagerAdapter;

.field private d:I

.field private e:I

.field private f:I

.field private final g:Landroid/graphics/Paint;

.field private h:Z

.field private i:I

.field private j:I

.field private k:F

.field private l:F

.field private m:F

.field private n:I

.field private o:F

.field private p:I

.field private q:Z

.field private r:Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const v0, 0x7f040003

    invoke-direct {p0, p1, p2, v0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 10

    invoke-direct {p0, p1, p2, p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    const/high16 v0, -0x40800000    # -1.0f

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->o:F

    const/4 v0, -0x1

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->p:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f060074

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v1

    const v2, 0x7f060075

    invoke-virtual {v0, v2}, Landroid/content/res/Resources;->getColor(I)I

    move-result v2

    const v3, 0x7f050007

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v3

    const v4, 0x7f060076

    invoke-virtual {v0, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v4

    const v5, 0x7f0700a4

    invoke-virtual {v0, v5}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v5

    const v6, 0x7f0700a5

    invoke-virtual {v0, v6}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v6

    const v7, 0x7f07009f

    invoke-virtual {v0, v7}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v7

    const v8, 0x7f0700a6

    invoke-virtual {v0, v8}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v0

    sget-object v8, Lchat/ola/vn/i$b;->TitlePageIndicator:[I

    const v9, 0x7f1001d8

    invoke-virtual {p1, p2, v8, p3, v9}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[III)Landroid/content/res/TypedArray;

    move-result-object p2

    const/16 p3, 0xc

    invoke-virtual {p2, p3, v0}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result p3

    iput p3, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->l:F

    const/16 p3, 0xb

    invoke-virtual {p2, p3, v6}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result p3

    iput p3, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->k:F

    const/4 p3, 0x0

    invoke-virtual {p2, p3, v7}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result p3

    iput p3, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->m:F

    const/16 p3, 0x8

    invoke-virtual {p2, p3, v2}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result p3

    iput p3, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->j:I

    const/16 p3, 0x9

    invoke-virtual {p2, p3, v4}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result p3

    iput p3, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->i:I

    const/4 p3, 0x7

    invoke-virtual {p2, p3, v3}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result p3

    iput-boolean p3, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->h:Z

    const/16 p3, 0xa

    invoke-virtual {p2, p3, v5}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result p3

    const/4 v0, 0x1

    invoke-virtual {p2, v0, v1}, Landroid/content/res/TypedArray;->getColor(II)I

    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v1, p3}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object p3, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {p3, v0}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    invoke-virtual {p2}, Landroid/content/res/TypedArray;->recycle()V

    invoke-static {p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/view/ViewConfigurationCompat;->getScaledPagingTouchSlop(Landroid/view/ViewConfiguration;)I

    move-result p1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->n:I

    return-void
.end method

.method private a(ILandroid/graphics/Paint;)Landroid/graphics/RectF;
    .locals 2

    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->c:Landroid/support/v4/view/PagerAdapter;

    invoke-virtual {v1, p1}, Landroid/support/v4/view/PagerAdapter;->getPageTitle(I)Ljava/lang/CharSequence;

    move-result-object p1

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/graphics/Paint;->measureText(Ljava/lang/String;)F

    move-result p1

    iput p1, v0, Landroid/graphics/RectF;->right:F

    invoke-virtual {p2}, Landroid/graphics/Paint;->descent()F

    move-result p1

    invoke-virtual {p2}, Landroid/graphics/Paint;->ascent()F

    move-result p2

    sub-float/2addr p1, p2

    iput p1, v0, Landroid/graphics/RectF;->bottom:F

    return-object v0
.end method

.method private a(Landroid/graphics/Paint;)Ljava/util/ArrayList;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/graphics/Paint;",
            ")",
            "Ljava/util/ArrayList<",
            "Landroid/graphics/RectF;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v1

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->getWidth()I

    move-result v2

    div-int/lit8 v3, v2, 0x2

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v1, :cond_0

    invoke-direct {p0, v4, p1}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a(ILandroid/graphics/Paint;)Landroid/graphics/RectF;

    move-result-object v5

    iget v6, v5, Landroid/graphics/RectF;->right:F

    iget v7, v5, Landroid/graphics/RectF;->left:F

    sub-float/2addr v6, v7

    iget v7, v5, Landroid/graphics/RectF;->bottom:F

    iget v8, v5, Landroid/graphics/RectF;->top:F

    sub-float/2addr v7, v8

    int-to-float v8, v3

    const/high16 v9, 0x40000000    # 2.0f

    div-float v9, v6, v9

    sub-float/2addr v8, v9

    iget v9, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->e:I

    int-to-float v9, v9

    sub-float/2addr v8, v9

    iget v9, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    sub-int v9, v4, v9

    mul-int v9, v9, v2

    int-to-float v9, v9

    add-float/2addr v8, v9

    iput v8, v5, Landroid/graphics/RectF;->left:F

    iget v8, v5, Landroid/graphics/RectF;->left:F

    add-float/2addr v8, v6

    iput v8, v5, Landroid/graphics/RectF;->right:F

    const/4 v6, 0x0

    iput v6, v5, Landroid/graphics/RectF;->top:F

    iput v7, v5, Landroid/graphics/RectF;->bottom:F

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method private a(Landroid/graphics/RectF;FI)V
    .locals 1

    int-to-float p3, p3

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->m:F

    sub-float/2addr p3, v0

    iput p3, p1, Landroid/graphics/RectF;->right:F

    iget p3, p1, Landroid/graphics/RectF;->right:F

    sub-float/2addr p3, p2

    iput p3, p1, Landroid/graphics/RectF;->left:F

    return-void
.end method

.method private b(Landroid/graphics/RectF;FI)V
    .locals 1

    int-to-float p3, p3

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->m:F

    add-float/2addr p3, v0

    iput p3, p1, Landroid/graphics/RectF;->left:F

    iget p3, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->m:F

    add-float/2addr p3, p2

    iput p3, p1, Landroid/graphics/RectF;->right:F

    return-void
.end method


# virtual methods
.method public getClipPadding()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->m:F

    return v0
.end method

.method public getSelectedColor()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->j:I

    return v0
.end method

.method public getTextColor()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->i:I

    return v0
.end method

.method public getTextSize()F
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getTextSize()F

    move-result v0

    return v0
.end method

.method public getTitlePadding()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->k:F

    return v0
.end method

.method public getTopPadding()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->l:F

    return v0
.end method

.method public getTypeface()Landroid/graphics/Typeface;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v0

    return-object v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 22

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-super/range {p0 .. p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    if-nez v2, :cond_0

    return-void

    :cond_0
    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v2

    invoke-virtual {v2}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v2

    if-nez v2, :cond_1

    return-void

    :cond_1
    iget-object v3, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-direct {v0, v3}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a(Landroid/graphics/Paint;)Ljava/util/ArrayList;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v4

    iget v5, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    const/4 v6, 0x1

    if-lt v5, v4, :cond_2

    sub-int/2addr v4, v6

    invoke-virtual {v0, v4}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->setCurrentItem(I)V

    return-void

    :cond_2
    add-int/lit8 v4, v2, -0x1

    invoke-virtual/range {p0 .. p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->getWidth()I

    move-result v5

    int-to-float v5, v5

    const/high16 v7, 0x40000000    # 2.0f

    div-float/2addr v5, v7

    invoke-virtual/range {p0 .. p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->getLeft()I

    move-result v7

    int-to-float v8, v7

    iget v9, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->m:F

    add-float/2addr v9, v8

    invoke-virtual/range {p0 .. p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->getWidth()I

    move-result v10

    invoke-virtual/range {p0 .. p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->getHeight()I

    add-int v11, v7, v10

    int-to-float v12, v11

    iget v13, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->m:F

    sub-float v13, v12, v13

    iget v14, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    iget v15, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->e:I

    int-to-float v15, v15

    cmpg-float v5, v15, v5

    const/high16 v15, 0x3f800000    # 1.0f

    if-gtz v5, :cond_3

    iget v5, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->e:I

    :goto_0
    int-to-float v5, v5

    mul-float v5, v5, v15

    int-to-float v10, v10

    div-float/2addr v5, v10

    goto :goto_1

    :cond_3
    add-int/lit8 v14, v14, 0x1

    iget v5, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->e:I

    sub-int v5, v10, v5

    goto :goto_0

    :goto_1
    const/high16 v10, 0x3e800000    # 0.25f

    cmpg-float v15, v5, v10

    const/16 v16, 0x0

    if-gtz v15, :cond_4

    const/4 v15, 0x1

    goto :goto_2

    :cond_4
    const/4 v15, 0x0

    :goto_2
    const v17, 0x3d4ccccd    # 0.05f

    cmpg-float v17, v5, v17

    if-gtz v17, :cond_5

    const/16 v17, 0x1

    goto :goto_3

    :cond_5
    const/16 v17, 0x0

    :goto_3
    sub-float v5, v10, v5

    div-float/2addr v5, v10

    iget v10, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    invoke-virtual {v3, v10}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Landroid/graphics/RectF;

    iget v6, v10, Landroid/graphics/RectF;->right:F

    iget v1, v10, Landroid/graphics/RectF;->left:F

    sub-float/2addr v6, v1

    iget v1, v10, Landroid/graphics/RectF;->left:F

    cmpg-float v1, v1, v9

    if-gez v1, :cond_6

    invoke-direct {v0, v10, v6, v7}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->b(Landroid/graphics/RectF;FI)V

    :cond_6
    iget v1, v10, Landroid/graphics/RectF;->right:F

    cmpl-float v1, v1, v13

    if-lez v1, :cond_7

    invoke-direct {v0, v10, v6, v11}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a(Landroid/graphics/RectF;FI)V

    :cond_7
    iget v1, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    if-lez v1, :cond_a

    iget v1, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    const/4 v6, 0x1

    sub-int/2addr v1, v6

    :goto_4
    if-ltz v1, :cond_a

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/graphics/RectF;

    iget v10, v6, Landroid/graphics/RectF;->left:F

    cmpg-float v10, v10, v9

    if-gez v10, :cond_8

    iget v10, v6, Landroid/graphics/RectF;->right:F

    move/from16 v18, v9

    iget v9, v6, Landroid/graphics/RectF;->left:F

    sub-float/2addr v10, v9

    invoke-direct {v0, v6, v10, v7}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->b(Landroid/graphics/RectF;FI)V

    add-int/lit8 v9, v1, 0x1

    invoke-virtual {v3, v9}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/graphics/RectF;

    move/from16 v19, v7

    iget v7, v6, Landroid/graphics/RectF;->right:F

    move/from16 v20, v5

    iget v5, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->k:F

    add-float/2addr v7, v5

    iget v5, v9, Landroid/graphics/RectF;->left:F

    cmpl-float v5, v7, v5

    if-lez v5, :cond_9

    iget v5, v9, Landroid/graphics/RectF;->left:F

    sub-float/2addr v5, v10

    iget v7, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->k:F

    sub-float/2addr v5, v7

    iput v5, v6, Landroid/graphics/RectF;->left:F

    iget v5, v6, Landroid/graphics/RectF;->left:F

    add-float/2addr v5, v10

    iput v5, v6, Landroid/graphics/RectF;->right:F

    goto :goto_5

    :cond_8
    move/from16 v20, v5

    move/from16 v19, v7

    move/from16 v18, v9

    :cond_9
    :goto_5
    add-int/lit8 v1, v1, -0x1

    move/from16 v9, v18

    move/from16 v7, v19

    move/from16 v5, v20

    goto :goto_4

    :cond_a
    move/from16 v20, v5

    iget v1, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    if-ge v1, v4, :cond_c

    iget v1, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    const/4 v6, 0x1

    add-int/2addr v1, v6

    :goto_6
    if-ge v1, v2, :cond_d

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/graphics/RectF;

    iget v5, v4, Landroid/graphics/RectF;->right:F

    cmpl-float v5, v5, v13

    if-lez v5, :cond_b

    iget v5, v4, Landroid/graphics/RectF;->right:F

    iget v7, v4, Landroid/graphics/RectF;->left:F

    sub-float/2addr v5, v7

    invoke-direct {v0, v4, v5, v11}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a(Landroid/graphics/RectF;FI)V

    add-int/lit8 v7, v1, -0x1

    invoke-virtual {v3, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/graphics/RectF;

    iget v9, v4, Landroid/graphics/RectF;->left:F

    iget v10, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->k:F

    sub-float/2addr v9, v10

    iget v10, v7, Landroid/graphics/RectF;->right:F

    cmpg-float v9, v9, v10

    if-gez v9, :cond_b

    iget v7, v7, Landroid/graphics/RectF;->right:F

    iget v9, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->k:F

    add-float/2addr v7, v9

    iput v7, v4, Landroid/graphics/RectF;->left:F

    iget v7, v4, Landroid/graphics/RectF;->left:F

    add-float/2addr v7, v5

    iput v7, v4, Landroid/graphics/RectF;->right:F

    :cond_b
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    :cond_c
    const/4 v6, 0x1

    :cond_d
    iget v1, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->i:I

    ushr-int/lit8 v1, v1, 0x18

    const/4 v4, 0x0

    :goto_7
    if-ge v4, v2, :cond_15

    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/graphics/RectF;

    iget v7, v5, Landroid/graphics/RectF;->left:F

    cmpl-float v7, v7, v8

    if-lez v7, :cond_e

    iget v7, v5, Landroid/graphics/RectF;->left:F

    cmpg-float v7, v7, v12

    if-ltz v7, :cond_f

    :cond_e
    iget v7, v5, Landroid/graphics/RectF;->right:F

    cmpl-float v7, v7, v8

    if-lez v7, :cond_13

    iget v7, v5, Landroid/graphics/RectF;->right:F

    cmpg-float v7, v7, v12

    if-gez v7, :cond_13

    :cond_f
    if-ne v4, v14, :cond_10

    const/4 v7, 0x1

    goto :goto_8

    :cond_10
    const/4 v7, 0x0

    :goto_8
    iget-object v9, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    if-eqz v7, :cond_11

    if-eqz v17, :cond_11

    iget-boolean v10, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->h:Z

    if-eqz v10, :cond_11

    const/4 v10, 0x1

    goto :goto_9

    :cond_11
    const/4 v10, 0x0

    :goto_9
    invoke-virtual {v9, v10}, Landroid/graphics/Paint;->setFakeBoldText(Z)V

    iget-object v9, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    iget v10, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->i:I

    invoke-virtual {v9, v10}, Landroid/graphics/Paint;->setColor(I)V

    if-eqz v7, :cond_12

    if-eqz v15, :cond_12

    iget-object v9, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    int-to-float v10, v1

    mul-float v10, v10, v20

    float-to-int v10, v10

    sub-int v10, v1, v10

    invoke-virtual {v9, v10}, Landroid/graphics/Paint;->setAlpha(I)V

    :cond_12
    iget-object v9, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->c:Landroid/support/v4/view/PagerAdapter;

    invoke-virtual {v9, v4}, Landroid/support/v4/view/PagerAdapter;->getPageTitle(I)Ljava/lang/CharSequence;

    move-result-object v9

    invoke-interface {v9}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v9

    iget v10, v5, Landroid/graphics/RectF;->left:F

    iget v11, v5, Landroid/graphics/RectF;->bottom:F

    iget v13, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->l:F

    add-float/2addr v11, v13

    iget-object v13, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    move-object/from16 v6, p1

    invoke-virtual {v6, v9, v10, v11, v13}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    if-eqz v7, :cond_14

    if-eqz v15, :cond_14

    iget-object v7, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    iget v9, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->j:I

    invoke-virtual {v7, v9}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v7, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    iget v9, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->j:I

    ushr-int/lit8 v9, v9, 0x18

    int-to-float v9, v9

    mul-float v9, v9, v20

    float-to-int v9, v9

    invoke-virtual {v7, v9}, Landroid/graphics/Paint;->setAlpha(I)V

    iget-object v7, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->c:Landroid/support/v4/view/PagerAdapter;

    invoke-virtual {v7, v4}, Landroid/support/v4/view/PagerAdapter;->getPageTitle(I)Ljava/lang/CharSequence;

    move-result-object v7

    invoke-interface {v7}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v7

    iget v9, v5, Landroid/graphics/RectF;->left:F

    iget v5, v5, Landroid/graphics/RectF;->bottom:F

    iget v10, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->l:F

    add-float/2addr v5, v10

    iget-object v10, v0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v6, v7, v9, v5, v10}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    goto :goto_a

    :cond_13
    move-object/from16 v6, p1

    :cond_14
    :goto_a
    add-int/lit8 v4, v4, 0x1

    const/4 v6, 0x1

    goto/16 :goto_7

    :cond_15
    return-void
.end method

.method protected onMeasure(II)V
    .locals 2

    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p1

    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v0

    const/high16 v1, 0x40000000    # 2.0f

    if-ne v0, v1, :cond_0

    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p2

    int-to-float p2, p2

    goto :goto_0

    :cond_0
    new-instance p2, Landroid/graphics/RectF;

    invoke-direct {p2}, Landroid/graphics/RectF;-><init>()V

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->descent()F

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v1}, Landroid/graphics/Paint;->ascent()F

    move-result v1

    sub-float/2addr v0, v1

    iput v0, p2, Landroid/graphics/RectF;->bottom:F

    iget v0, p2, Landroid/graphics/RectF;->bottom:F

    iget p2, p2, Landroid/graphics/RectF;->top:F

    sub-float/2addr v0, p2

    iget p2, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->l:F

    add-float/2addr p2, v0

    :goto_0
    float-to-int p2, p2

    invoke-virtual {p0, p1, p2}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->setMeasuredDimension(II)V

    return-void
.end method

.method public onPageScrollStateChanged(I)V
    .locals 1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->f:I

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    invoke-interface {v0, p1}, Landroid/support/v4/view/ViewPager$OnPageChangeListener;->onPageScrollStateChanged(I)V

    :cond_0
    return-void
.end method

.method public onPageScrolled(IFI)V
    .locals 1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    iput p3, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->e:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    invoke-interface {v0, p1, p2, p3}, Landroid/support/v4/view/ViewPager$OnPageChangeListener;->onPageScrolled(IFI)V

    :cond_0
    return-void
.end method

.method public onPageSelected(I)V
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->f:I

    if-nez v0, :cond_0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    invoke-interface {v0, p1}, Landroid/support/v4/view/ViewPager$OnPageChangeListener;->onPageSelected(I)V

    :cond_1
    return-void
.end method

.method public onRestoreInstanceState(Landroid/os/Parcelable;)V
    .locals 1

    check-cast p1, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$SavedState;

    invoke-virtual {p1}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$SavedState;->getSuperState()Landroid/os/Parcelable;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/view/View;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    iget p1, p1, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$SavedState;->a:I

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->requestLayout()V

    return-void
.end method

.method public onSaveInstanceState()Landroid/os/Parcelable;
    .locals 2

    invoke-super {p0}, Landroid/view/View;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    new-instance v1, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$SavedState;

    invoke-direct {v1, v0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$SavedState;-><init>(Landroid/os/Parcelable;)V

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    iput v0, v1, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$SavedState;->a:I

    return-object v1
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 6

    invoke-super {p0, p1}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    const/4 v2, 0x0

    if-eqz v0, :cond_a

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v0

    if-nez v0, :cond_1

    return v2

    :cond_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    and-int/lit16 v0, v0, 0xff

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    return v1

    :pswitch_1
    invoke-static {p1}, Landroid/support/v4/view/MotionEventCompat;->getActionIndex(Landroid/view/MotionEvent;)I

    move-result v0

    invoke-static {p1, v0}, Landroid/support/v4/view/MotionEventCompat;->getPointerId(Landroid/view/MotionEvent;I)I

    move-result v3

    iget v4, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->p:I

    if-ne v3, v4, :cond_3

    if-nez v0, :cond_2

    const/4 v2, 0x1

    :cond_2
    invoke-static {p1, v2}, Landroid/support/v4/view/MotionEventCompat;->getPointerId(Landroid/view/MotionEvent;I)I

    move-result v0

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->p:I

    :cond_3
    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->p:I

    invoke-static {p1, v0}, Landroid/support/v4/view/MotionEventCompat;->findPointerIndex(Landroid/view/MotionEvent;I)I

    move-result v0

    invoke-static {p1, v0}, Landroid/support/v4/view/MotionEventCompat;->getX(Landroid/view/MotionEvent;I)F

    move-result p1

    goto/16 :goto_1

    :pswitch_2
    invoke-static {p1}, Landroid/support/v4/view/MotionEventCompat;->getActionIndex(Landroid/view/MotionEvent;)I

    move-result v0

    invoke-static {p1, v0}, Landroid/support/v4/view/MotionEventCompat;->getX(Landroid/view/MotionEvent;I)F

    move-result v2

    iput v2, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->o:F

    invoke-static {p1, v0}, Landroid/support/v4/view/MotionEventCompat;->getPointerId(Landroid/view/MotionEvent;I)I

    move-result p1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->p:I

    return v1

    :pswitch_3
    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->p:I

    invoke-static {p1, v0}, Landroid/support/v4/view/MotionEventCompat;->findPointerIndex(Landroid/view/MotionEvent;I)I

    move-result v0

    invoke-static {p1, v0}, Landroid/support/v4/view/MotionEventCompat;->getX(Landroid/view/MotionEvent;I)F

    move-result p1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->o:F

    sub-float v0, p1, v0

    iget-boolean v2, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->q:Z

    if-nez v2, :cond_4

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v2

    iget v3, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->n:I

    int-to-float v3, v3

    cmpl-float v2, v2, v3

    if-lez v2, :cond_4

    iput-boolean v1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->q:Z

    :cond_4
    iget-boolean v2, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->q:Z

    if-eqz v2, :cond_9

    iget-object v2, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/OlaViewPager;->isFakeDragging()Z

    move-result v2

    if-nez v2, :cond_5

    iget-object v2, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/OlaViewPager;->beginFakeDrag()Z

    :cond_5
    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->o:F

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/OlaViewPager;->fakeDragBy(F)V

    return v1

    :pswitch_4
    iget-boolean v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->q:Z

    if-nez v0, :cond_8

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v0

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->getWidth()I

    move-result v3

    int-to-float v3, v3

    const/high16 v4, 0x40000000    # 2.0f

    div-float v4, v3, v4

    const/high16 v5, 0x40c00000    # 6.0f

    div-float/2addr v3, v5

    sub-float v5, v4, v3

    add-float/2addr v4, v3

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result p1

    cmpg-float v3, p1, v5

    if-gez v3, :cond_6

    iget p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    if-lez p1, :cond_8

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    sub-int/2addr v0, v1

    :goto_0
    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(I)V

    return v1

    :cond_6
    cmpl-float p1, p1, v4

    if-lez p1, :cond_7

    iget p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    sub-int/2addr v0, v1

    if-ge p1, v0, :cond_8

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    add-int/2addr v0, v1

    goto :goto_0

    :cond_7
    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->r:Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$a;

    if-eqz p1, :cond_8

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->r:Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$a;

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    invoke-interface {p1, v0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$a;->a(I)V

    :cond_8
    iput-boolean v2, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->q:Z

    const/4 p1, -0x1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->p:I

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/OlaViewPager;->isFakeDragging()Z

    move-result p1

    if-eqz p1, :cond_9

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/OlaViewPager;->endFakeDrag()V

    return v1

    :pswitch_5
    invoke-static {p1, v2}, Landroid/support/v4/view/MotionEventCompat;->getPointerId(Landroid/view/MotionEvent;I)I

    move-result v0

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->p:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result p1

    :goto_1
    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->o:F

    :cond_9
    return v1

    :cond_a
    return v2

    nop

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

.method public setClipPadding(F)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->m:F

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setCurrentItem(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    if-nez v0, :cond_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "OlaViewPager has not been bound."

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(I)V

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->d:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setOnCenterItemClickListener(Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$a;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->r:Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator$a;

    return-void
.end method

.method public setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    return-void
.end method

.method public setSelectedBold(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->h:Z

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setSelectedColor(I)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->j:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setTextColor(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->i:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setTextSize(F)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setTextSize(F)V

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setTitlePadding(F)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->k:F

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setTopPadding(F)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->l:F

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setTypeface(Landroid/graphics/Typeface;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

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
    iput-object p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1, p0}, Lcom/mg/ola/common/widget/OlaViewPager;->setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V

    iput-object v0, p0, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->c:Landroid/support/v4/view/PagerAdapter;

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/SimpleTitlePageIndicator;->invalidate()V

    return-void
.end method
