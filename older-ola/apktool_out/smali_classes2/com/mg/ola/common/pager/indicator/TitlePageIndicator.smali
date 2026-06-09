.class public Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;
.super Landroid/view/View;

# interfaces
.implements Lcom/mg/ola/common/pager/indicator/a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$SavedState;,
        Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;,
        Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$a;
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

.field private k:Landroid/graphics/Path;

.field private final l:Landroid/graphics/Paint;

.field private m:Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;

.field private final n:Landroid/graphics/Paint;

.field private o:F

.field private p:F

.field private q:F

.field private r:F

.field private s:F

.field private t:F

.field private u:F

.field private v:I

.field private w:F

.field private x:I

.field private y:Z

.field private z:Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const v0, 0x7f040003

    invoke-direct {p0, p1, p2, v0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 19

    move-object/from16 v0, p0

    invoke-direct/range {p0 .. p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    iput-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    iput-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->l:Landroid/graphics/Paint;

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    iput-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->n:Landroid/graphics/Paint;

    const/high16 v1, -0x40800000    # -1.0f

    iput v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->w:F

    const/4 v1, -0x1

    iput v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->x:I

    invoke-virtual/range {p0 .. p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f060074

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getColor(I)I

    move-result v2

    const v3, 0x7f0700a2

    invoke-virtual {v1, v3}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v3

    const v4, 0x7f0a000b

    invoke-virtual {v1, v4}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v4

    const v5, 0x7f0700a0

    invoke-virtual {v1, v5}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v5

    const v6, 0x7f0700a1

    invoke-virtual {v1, v6}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v6

    const v7, 0x7f0700a3

    invoke-virtual {v1, v7}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v7

    const v8, 0x7f060075

    invoke-virtual {v1, v8}, Landroid/content/res/Resources;->getColor(I)I

    move-result v8

    const v9, 0x7f050007

    invoke-virtual {v1, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v9

    const v10, 0x7f060076

    invoke-virtual {v1, v10}, Landroid/content/res/Resources;->getColor(I)I

    move-result v10

    const v11, 0x7f0700a4

    invoke-virtual {v1, v11}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v11

    const v12, 0x7f0700a5

    invoke-virtual {v1, v12}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v12

    const v13, 0x7f07009f

    invoke-virtual {v1, v13}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v13

    const v14, 0x7f0700a6

    invoke-virtual {v1, v14}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v1

    sget-object v14, Lchat/ola/vn/i$b;->TitlePageIndicator:[I

    const v15, 0x7f1001d8

    move/from16 v16, v2

    move/from16 v18, v9

    move/from16 v17, v11

    move-object/from16 v2, p1

    move-object/from16 v11, p2

    move/from16 v9, p3

    invoke-virtual {v2, v11, v14, v9, v15}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[III)Landroid/content/res/TypedArray;

    move-result-object v9

    const/4 v11, 0x5

    invoke-virtual {v9, v11, v3}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v3

    iput v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    const/4 v3, 0x3

    invoke-virtual {v9, v3, v4}, Landroid/content/res/TypedArray;->getInteger(II)I

    move-result v3

    invoke-static {v3}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;->a(I)Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;

    move-result-object v3

    iput-object v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->m:Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;

    const/4 v3, 0x2

    invoke-virtual {v9, v3, v5}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v3

    iput v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->o:F

    const/4 v3, 0x4

    invoke-virtual {v9, v3, v6}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v3

    iput v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->p:F

    const/4 v3, 0x6

    invoke-virtual {v9, v3, v7}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v3

    iput v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->q:F

    const/16 v3, 0xc

    invoke-virtual {v9, v3, v1}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v1

    iput v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->s:F

    const/16 v1, 0xb

    invoke-virtual {v9, v1, v12}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v1

    iput v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->r:F

    const/4 v1, 0x0

    invoke-virtual {v9, v1, v13}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v1

    iput v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->t:F

    const/16 v1, 0x8

    invoke-virtual {v9, v1, v8}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v1

    iput v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->j:I

    const/16 v1, 0x9

    invoke-virtual {v9, v1, v10}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v1

    iput v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->i:I

    const/4 v1, 0x7

    move/from16 v3, v18

    invoke-virtual {v9, v1, v3}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v1

    iput-boolean v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->h:Z

    const/16 v1, 0xa

    move/from16 v3, v17

    invoke-virtual {v9, v1, v3}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v1

    const/4 v3, 0x1

    move/from16 v4, v16

    invoke-virtual {v9, v3, v4}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v4

    iget-object v5, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v5, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->l:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->FILL_AND_STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->l:Landroid/graphics/Paint;

    iget v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->l:Landroid/graphics/Paint;

    invoke-virtual {v1, v4}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->n:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->FILL_AND_STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->n:Landroid/graphics/Paint;

    invoke-virtual {v1, v4}, Landroid/graphics/Paint;->setColor(I)V

    invoke-virtual {v9}, Landroid/content/res/TypedArray;->recycle()V

    invoke-static/range {p1 .. p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v1

    invoke-static {v1}, Landroid/support/v4/view/ViewConfigurationCompat;->getScaledPagingTouchSlop(Landroid/view/ViewConfiguration;)I

    move-result v1

    iput v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->v:I

    return-void
.end method

.method private a(ILandroid/graphics/Paint;)Landroid/graphics/RectF;
    .locals 2

    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->c:Landroid/support/v4/view/PagerAdapter;

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

    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v1

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->getWidth()I

    move-result v2

    div-int/lit8 v3, v2, 0x2

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v1, :cond_0

    invoke-direct {p0, v4, p1}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a(ILandroid/graphics/Paint;)Landroid/graphics/RectF;

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

    iget v9, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->e:I

    int-to-float v9, v9

    sub-float/2addr v8, v9

    iget v9, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

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

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->t:F

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

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->t:F

    add-float/2addr p3, v0

    iput p3, p1, Landroid/graphics/RectF;->left:F

    iget p3, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->t:F

    add-float/2addr p3, p2

    iput p3, p1, Landroid/graphics/RectF;->right:F

    return-void
.end method


# virtual methods
.method public getClipPadding()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->t:F

    return v0
.end method

.method public getFooterColor()I
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->l:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    return v0
.end method

.method public getFooterIndicatorHeight()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->o:F

    return v0
.end method

.method public getFooterIndicatorPadding()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->q:F

    return v0
.end method

.method public getFooterIndicatorStyle()Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->m:Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;

    return-object v0
.end method

.method public getFooterLineHeight()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    return v0
.end method

.method public getSelectedColor()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->j:I

    return v0
.end method

.method public getTextColor()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->i:I

    return v0
.end method

.method public getTextSize()F
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getTextSize()F

    move-result v0

    return v0
.end method

.method public getTitlePadding()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->r:F

    return v0
.end method

.method public getTopPadding()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->s:F

    return v0
.end method

.method public getTypeface()Landroid/graphics/Typeface;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v0

    return-object v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 26

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-super/range {p0 .. p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    if-nez v2, :cond_0

    return-void

    :cond_0
    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v2

    invoke-virtual {v2}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v2

    if-nez v2, :cond_1

    return-void

    :cond_1
    iget-object v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-direct {v0, v3}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a(Landroid/graphics/Paint;)Ljava/util/ArrayList;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v4

    iget v5, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    const/4 v6, 0x1

    if-lt v5, v4, :cond_2

    sub-int/2addr v4, v6

    invoke-virtual {v0, v4}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->setCurrentItem(I)V

    return-void

    :cond_2
    add-int/lit8 v5, v2, -0x1

    invoke-virtual/range {p0 .. p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->getWidth()I

    move-result v7

    int-to-float v7, v7

    const/high16 v8, 0x40000000    # 2.0f

    div-float/2addr v7, v8

    invoke-virtual/range {p0 .. p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->getLeft()I

    move-result v9

    int-to-float v10, v9

    iget v11, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->t:F

    add-float/2addr v11, v10

    invoke-virtual/range {p0 .. p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->getWidth()I

    move-result v12

    invoke-virtual/range {p0 .. p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->getHeight()I

    move-result v13

    add-int v14, v9, v12

    int-to-float v15, v14

    iget v8, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->t:F

    sub-float v8, v15, v8

    iget v6, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    move/from16 v16, v4

    iget v4, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->e:I

    int-to-float v4, v4

    cmpg-float v4, v4, v7

    const/high16 v17, 0x3f800000    # 1.0f

    if-gtz v4, :cond_3

    iget v4, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->e:I

    int-to-float v4, v4

    mul-float v4, v4, v17

    move/from16 v18, v7

    :goto_0
    int-to-float v7, v12

    div-float/2addr v4, v7

    goto :goto_1

    :cond_3
    move/from16 v18, v7

    add-int/lit8 v6, v6, 0x1

    iget v4, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->e:I

    sub-int v4, v12, v4

    int-to-float v4, v4

    mul-float v4, v4, v17

    goto :goto_0

    :goto_1
    const/high16 v7, 0x3e800000    # 0.25f

    cmpg-float v17, v4, v7

    const/16 v19, 0x0

    if-gtz v17, :cond_4

    const/16 v17, 0x1

    goto :goto_2

    :cond_4
    const/16 v17, 0x0

    :goto_2
    const v20, 0x3d4ccccd    # 0.05f

    cmpg-float v20, v4, v20

    if-gtz v20, :cond_5

    const/16 v20, 0x1

    goto :goto_3

    :cond_5
    const/16 v20, 0x0

    :goto_3
    sub-float v4, v7, v4

    div-float/2addr v4, v7

    iget v7, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    invoke-virtual {v3, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/graphics/RectF;

    move/from16 v21, v12

    iget v12, v7, Landroid/graphics/RectF;->right:F

    move/from16 v22, v13

    iget v13, v7, Landroid/graphics/RectF;->left:F

    sub-float/2addr v12, v13

    iget v13, v7, Landroid/graphics/RectF;->left:F

    cmpg-float v13, v13, v11

    if-gez v13, :cond_6

    invoke-direct {v0, v7, v12, v9}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->b(Landroid/graphics/RectF;FI)V

    :cond_6
    iget v13, v7, Landroid/graphics/RectF;->right:F

    cmpl-float v13, v13, v8

    if-lez v13, :cond_7

    invoke-direct {v0, v7, v12, v14}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a(Landroid/graphics/RectF;FI)V

    :cond_7
    iget v7, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    if-lez v7, :cond_a

    iget v7, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    const/4 v12, 0x1

    sub-int/2addr v7, v12

    :goto_4
    if-ltz v7, :cond_a

    invoke-virtual {v3, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Landroid/graphics/RectF;

    iget v13, v12, Landroid/graphics/RectF;->left:F

    cmpg-float v13, v13, v11

    if-gez v13, :cond_8

    iget v13, v12, Landroid/graphics/RectF;->right:F

    move/from16 v23, v11

    iget v11, v12, Landroid/graphics/RectF;->left:F

    sub-float/2addr v13, v11

    invoke-direct {v0, v12, v13, v9}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->b(Landroid/graphics/RectF;FI)V

    add-int/lit8 v11, v7, 0x1

    invoke-virtual {v3, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/graphics/RectF;

    move/from16 v24, v9

    iget v9, v12, Landroid/graphics/RectF;->right:F

    iget v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->r:F

    add-float/2addr v9, v1

    iget v1, v11, Landroid/graphics/RectF;->left:F

    cmpl-float v1, v9, v1

    if-lez v1, :cond_9

    iget v1, v11, Landroid/graphics/RectF;->left:F

    sub-float/2addr v1, v13

    iget v9, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->r:F

    sub-float/2addr v1, v9

    iput v1, v12, Landroid/graphics/RectF;->left:F

    iget v1, v12, Landroid/graphics/RectF;->left:F

    add-float/2addr v1, v13

    iput v1, v12, Landroid/graphics/RectF;->right:F

    goto :goto_5

    :cond_8
    move/from16 v24, v9

    move/from16 v23, v11

    :cond_9
    :goto_5
    add-int/lit8 v7, v7, -0x1

    move/from16 v11, v23

    move/from16 v9, v24

    move-object/from16 v1, p1

    goto :goto_4

    :cond_a
    iget v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    if-ge v1, v5, :cond_c

    iget v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    const/4 v5, 0x1

    add-int/2addr v1, v5

    :goto_6
    if-ge v1, v2, :cond_d

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/graphics/RectF;

    iget v9, v7, Landroid/graphics/RectF;->right:F

    cmpl-float v9, v9, v8

    if-lez v9, :cond_b

    iget v9, v7, Landroid/graphics/RectF;->right:F

    iget v11, v7, Landroid/graphics/RectF;->left:F

    sub-float/2addr v9, v11

    invoke-direct {v0, v7, v9, v14}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a(Landroid/graphics/RectF;FI)V

    add-int/lit8 v11, v1, -0x1

    invoke-virtual {v3, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/graphics/RectF;

    iget v12, v7, Landroid/graphics/RectF;->left:F

    iget v13, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->r:F

    sub-float/2addr v12, v13

    iget v13, v11, Landroid/graphics/RectF;->right:F

    cmpg-float v12, v12, v13

    if-gez v12, :cond_b

    iget v11, v11, Landroid/graphics/RectF;->right:F

    iget v12, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->r:F

    add-float/2addr v11, v12

    iput v11, v7, Landroid/graphics/RectF;->left:F

    iget v11, v7, Landroid/graphics/RectF;->left:F

    add-float/2addr v11, v9

    iput v11, v7, Landroid/graphics/RectF;->right:F

    :cond_b
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    :cond_c
    const/4 v5, 0x1

    :cond_d
    iget v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->i:I

    ushr-int/lit8 v1, v1, 0x18

    const/4 v7, 0x0

    :goto_7
    if-ge v7, v2, :cond_15

    invoke-virtual {v3, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Landroid/graphics/RectF;

    iget v9, v8, Landroid/graphics/RectF;->left:F

    cmpl-float v9, v9, v10

    if-lez v9, :cond_e

    iget v9, v8, Landroid/graphics/RectF;->left:F

    cmpg-float v9, v9, v15

    if-ltz v9, :cond_f

    :cond_e
    iget v9, v8, Landroid/graphics/RectF;->right:F

    cmpl-float v9, v9, v10

    if-lez v9, :cond_13

    iget v9, v8, Landroid/graphics/RectF;->right:F

    cmpg-float v9, v9, v15

    if-gez v9, :cond_13

    :cond_f
    if-ne v7, v6, :cond_10

    const/4 v9, 0x1

    goto :goto_8

    :cond_10
    const/4 v9, 0x0

    :goto_8
    iget-object v11, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    if-eqz v9, :cond_11

    if-eqz v20, :cond_11

    iget-boolean v12, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->h:Z

    if-eqz v12, :cond_11

    const/4 v12, 0x1

    goto :goto_9

    :cond_11
    const/4 v12, 0x0

    :goto_9
    invoke-virtual {v11, v12}, Landroid/graphics/Paint;->setFakeBoldText(Z)V

    iget-object v11, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    iget v12, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->i:I

    invoke-virtual {v11, v12}, Landroid/graphics/Paint;->setColor(I)V

    if-eqz v9, :cond_12

    if-eqz v17, :cond_12

    iget-object v11, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    int-to-float v12, v1

    mul-float v12, v12, v4

    float-to-int v12, v12

    sub-int v12, v1, v12

    invoke-virtual {v11, v12}, Landroid/graphics/Paint;->setAlpha(I)V

    :cond_12
    iget-object v11, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->c:Landroid/support/v4/view/PagerAdapter;

    invoke-virtual {v11, v7}, Landroid/support/v4/view/PagerAdapter;->getPageTitle(I)Ljava/lang/CharSequence;

    move-result-object v11

    invoke-interface {v11}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v11

    iget v12, v8, Landroid/graphics/RectF;->left:F

    iget v13, v8, Landroid/graphics/RectF;->bottom:F

    iget v14, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->s:F

    add-float/2addr v13, v14

    iget-object v14, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    move-object/from16 v5, p1

    invoke-virtual {v5, v11, v12, v13, v14}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    if-eqz v9, :cond_14

    if-eqz v17, :cond_14

    iget-object v9, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    iget v11, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->j:I

    invoke-virtual {v9, v11}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v9, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    iget v11, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->j:I

    ushr-int/lit8 v11, v11, 0x18

    int-to-float v11, v11

    mul-float v11, v11, v4

    float-to-int v11, v11

    invoke-virtual {v9, v11}, Landroid/graphics/Paint;->setAlpha(I)V

    iget-object v9, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->c:Landroid/support/v4/view/PagerAdapter;

    invoke-virtual {v9, v7}, Landroid/support/v4/view/PagerAdapter;->getPageTitle(I)Ljava/lang/CharSequence;

    move-result-object v9

    invoke-interface {v9}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v9

    iget v11, v8, Landroid/graphics/RectF;->left:F

    iget v8, v8, Landroid/graphics/RectF;->bottom:F

    iget v12, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->s:F

    add-float/2addr v8, v12

    iget-object v12, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v5, v9, v11, v8, v12}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    goto :goto_a

    :cond_13
    move-object/from16 v5, p1

    :cond_14
    :goto_a
    add-int/lit8 v7, v7, 0x1

    const/4 v5, 0x1

    goto/16 :goto_7

    :cond_15
    move-object/from16 v5, p1

    new-instance v1, Landroid/graphics/Path;

    invoke-direct {v1}, Landroid/graphics/Path;-><init>()V

    iput-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    const/4 v2, 0x0

    move/from16 v7, v22

    int-to-float v7, v7

    iget v8, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    const/high16 v9, 0x40000000    # 2.0f

    div-float/2addr v8, v9

    sub-float v8, v7, v8

    invoke-virtual {v1, v2, v8}, Landroid/graphics/Path;->moveTo(FF)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    move/from16 v2, v21

    int-to-float v2, v2

    iget v8, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    div-float/2addr v8, v9

    sub-float v8, v7, v8

    invoke-virtual {v1, v2, v8}, Landroid/graphics/Path;->lineTo(FF)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    invoke-virtual {v1}, Landroid/graphics/Path;->close()V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->l:Landroid/graphics/Paint;

    invoke-virtual {v5, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    sget-object v1, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$1;->a:[I

    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->m:Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;

    invoke-virtual {v2}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;->ordinal()I

    move-result v2

    aget v1, v1, v2

    packed-switch v1, :pswitch_data_0

    return-void

    :pswitch_0
    if-eqz v17, :cond_17

    move/from16 v1, v16

    if-lt v6, v1, :cond_16

    return-void

    :cond_16
    invoke-virtual {v3, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/graphics/RectF;

    new-instance v2, Landroid/graphics/Path;

    invoke-direct {v2}, Landroid/graphics/Path;-><init>()V

    iput-object v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget v3, v1, Landroid/graphics/RectF;->left:F

    iget v6, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->p:F

    sub-float/2addr v3, v6

    iget v6, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    sub-float v6, v7, v6

    invoke-virtual {v2, v3, v6}, Landroid/graphics/Path;->moveTo(FF)V

    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget v3, v1, Landroid/graphics/RectF;->right:F

    iget v6, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->p:F

    add-float/2addr v3, v6

    iget v6, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    sub-float v6, v7, v6

    invoke-virtual {v2, v3, v6}, Landroid/graphics/Path;->lineTo(FF)V

    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget v3, v1, Landroid/graphics/RectF;->right:F

    iget v6, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->p:F

    add-float/2addr v3, v6

    iget v6, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    sub-float v6, v7, v6

    iget v8, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->o:F

    sub-float/2addr v6, v8

    invoke-virtual {v2, v3, v6}, Landroid/graphics/Path;->lineTo(FF)V

    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget v1, v1, Landroid/graphics/RectF;->left:F

    iget v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->p:F

    sub-float/2addr v1, v3

    iget v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    sub-float/2addr v7, v3

    iget v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->o:F

    sub-float/2addr v7, v3

    invoke-virtual {v2, v1, v7}, Landroid/graphics/Path;->lineTo(FF)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    invoke-virtual {v1}, Landroid/graphics/Path;->close()V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->n:Landroid/graphics/Paint;

    const/high16 v2, 0x437f0000    # 255.0f

    mul-float v4, v4, v2

    float-to-int v2, v4

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setAlpha(I)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->n:Landroid/graphics/Paint;

    invoke-virtual {v5, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->n:Landroid/graphics/Paint;

    const/16 v2, 0xff

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setAlpha(I)V

    return-void

    :pswitch_1
    new-instance v1, Landroid/graphics/Path;

    invoke-direct {v1}, Landroid/graphics/Path;-><init>()V

    iput-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    sub-float v2, v7, v2

    iget v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->o:F

    sub-float/2addr v2, v3

    move/from16 v3, v18

    invoke-virtual {v1, v3, v2}, Landroid/graphics/Path;->moveTo(FF)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->o:F

    add-float/2addr v2, v3

    iget v4, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    sub-float v4, v7, v4

    invoke-virtual {v1, v2, v4}, Landroid/graphics/Path;->lineTo(FF)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->o:F

    sub-float v2, v3, v2

    iget v3, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    sub-float/2addr v7, v3

    invoke-virtual {v1, v2, v7}, Landroid/graphics/Path;->lineTo(FF)V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    invoke-virtual {v1}, Landroid/graphics/Path;->close()V

    iget-object v1, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->k:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->n:Landroid/graphics/Paint;

    invoke-virtual {v5, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    :cond_17
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
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

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->descent()F

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v1}, Landroid/graphics/Paint;->ascent()F

    move-result v1

    sub-float/2addr v0, v1

    iput v0, p2, Landroid/graphics/RectF;->bottom:F

    iget v0, p2, Landroid/graphics/RectF;->bottom:F

    iget p2, p2, Landroid/graphics/RectF;->top:F

    sub-float/2addr v0, p2

    iget p2, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    add-float/2addr v0, p2

    iget p2, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->q:F

    add-float/2addr v0, p2

    iget p2, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->s:F

    add-float/2addr p2, v0

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->m:Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;

    sget-object v1, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;->a:Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->o:F

    add-float/2addr p2, v0

    :cond_1
    :goto_0
    float-to-int p2, p2

    invoke-virtual {p0, p1, p2}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->setMeasuredDimension(II)V

    return-void
.end method

.method public onPageScrollStateChanged(I)V
    .locals 1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->f:I

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    invoke-interface {v0, p1}, Landroid/support/v4/view/ViewPager$OnPageChangeListener;->onPageScrollStateChanged(I)V

    :cond_0
    return-void
.end method

.method public onPageScrolled(IFI)V
    .locals 1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    iput p3, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->e:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    invoke-interface {v0, p1, p2, p3}, Landroid/support/v4/view/ViewPager$OnPageChangeListener;->onPageScrolled(IFI)V

    :cond_0
    return-void
.end method

.method public onPageSelected(I)V
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->f:I

    if-nez v0, :cond_0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    invoke-interface {v0, p1}, Landroid/support/v4/view/ViewPager$OnPageChangeListener;->onPageSelected(I)V

    :cond_1
    return-void
.end method

.method public onRestoreInstanceState(Landroid/os/Parcelable;)V
    .locals 1

    check-cast p1, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$SavedState;

    invoke-virtual {p1}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$SavedState;->getSuperState()Landroid/os/Parcelable;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/view/View;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    iget p1, p1, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$SavedState;->a:I

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->requestLayout()V

    return-void
.end method

.method public onSaveInstanceState()Landroid/os/Parcelable;
    .locals 2

    invoke-super {p0}, Landroid/view/View;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    new-instance v1, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$SavedState;

    invoke-direct {v1, v0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$SavedState;-><init>(Landroid/os/Parcelable;)V

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    iput v0, v1, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$SavedState;->a:I

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
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    const/4 v2, 0x0

    if-eqz v0, :cond_a

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

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

    iget v4, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->x:I

    if-ne v3, v4, :cond_3

    if-nez v0, :cond_2

    const/4 v2, 0x1

    :cond_2
    invoke-static {p1, v2}, Landroid/support/v4/view/MotionEventCompat;->getPointerId(Landroid/view/MotionEvent;I)I

    move-result v0

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->x:I

    :cond_3
    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->x:I

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

    iput v2, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->w:F

    invoke-static {p1, v0}, Landroid/support/v4/view/MotionEventCompat;->getPointerId(Landroid/view/MotionEvent;I)I

    move-result p1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->x:I

    return v1

    :pswitch_3
    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->x:I

    invoke-static {p1, v0}, Landroid/support/v4/view/MotionEventCompat;->findPointerIndex(Landroid/view/MotionEvent;I)I

    move-result v0

    invoke-static {p1, v0}, Landroid/support/v4/view/MotionEventCompat;->getX(Landroid/view/MotionEvent;I)F

    move-result p1

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->w:F

    sub-float v0, p1, v0

    iget-boolean v2, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->y:Z

    if-nez v2, :cond_4

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v2

    iget v3, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->v:I

    int-to-float v3, v3

    cmpl-float v2, v2, v3

    if-lez v2, :cond_4

    iput-boolean v1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->y:Z

    :cond_4
    iget-boolean v2, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->y:Z

    if-eqz v2, :cond_9

    iget-object v2, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/OlaViewPager;->isFakeDragging()Z

    move-result v2

    if-nez v2, :cond_5

    iget-object v2, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/OlaViewPager;->beginFakeDrag()Z

    :cond_5
    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->w:F

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/OlaViewPager;->fakeDragBy(F)V

    return v1

    :pswitch_4
    iget-boolean v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->y:Z

    if-nez v0, :cond_8

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getAdapter()Landroid/support/v4/view/PagerAdapter;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v0

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->getWidth()I

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

    iget p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    if-lez p1, :cond_8

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    sub-int/2addr v0, v1

    :goto_0
    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(I)V

    return v1

    :cond_6
    cmpl-float p1, p1, v4

    if-lez p1, :cond_7

    iget p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    sub-int/2addr v0, v1

    if-ge p1, v0, :cond_8

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    add-int/2addr v0, v1

    goto :goto_0

    :cond_7
    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->z:Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$a;

    if-eqz p1, :cond_8

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->z:Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$a;

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    invoke-interface {p1, v0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$a;->a(I)V

    :cond_8
    iput-boolean v2, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->y:Z

    const/4 p1, -0x1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->x:I

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/OlaViewPager;->isFakeDragging()Z

    move-result p1

    if-eqz p1, :cond_9

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/OlaViewPager;->endFakeDrag()V

    return v1

    :pswitch_5
    invoke-static {p1, v2}, Landroid/support/v4/view/MotionEventCompat;->getPointerId(Landroid/view/MotionEvent;I)I

    move-result v0

    iput v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->x:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result p1

    :goto_1
    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->w:F

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

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->t:F

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setCurrentItem(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    if-nez v0, :cond_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "OlaViewPager has not been bound."

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(I)V

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->d:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setFooterColor(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->l:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->n:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setFooterIndicatorHeight(F)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->o:F

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setFooterIndicatorPadding(F)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->q:F

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setFooterIndicatorStyle(Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->m:Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$IndicatorStyle;

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setFooterLineHeight(F)V
    .locals 1

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->l:Landroid/graphics/Paint;

    iget v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->u:F

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setOnCenterItemClickListener(Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$a;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->z:Lcom/mg/ola/common/pager/indicator/TitlePageIndicator$a;

    return-void
.end method

.method public setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->b:Landroid/support/v4/view/ViewPager$OnPageChangeListener;

    return-void
.end method

.method public setSelectedBold(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->h:Z

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setSelectedColor(I)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->j:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setTextColor(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->i:I

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setTextSize(F)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setTextSize(F)V

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setTitlePadding(F)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->r:F

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setTopPadding(F)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->s:F

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method

.method public setTypeface(Landroid/graphics/Typeface;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->g:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

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
    iput-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    iget-object p1, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->a:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1, p0}, Lcom/mg/ola/common/widget/OlaViewPager;->setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V

    iput-object v0, p0, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->c:Landroid/support/v4/view/PagerAdapter;

    invoke-virtual {p0}, Lcom/mg/ola/common/pager/indicator/TitlePageIndicator;->invalidate()V

    return-void
.end method
