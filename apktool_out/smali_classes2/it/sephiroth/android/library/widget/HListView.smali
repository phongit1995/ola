.class public Lit/sephiroth/android/library/widget/HListView;
.super Lit/sephiroth/android/library/widget/AbsHListView;


# annotations
.annotation runtime Landroid/widget/RemoteViews$RemoteView;
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lit/sephiroth/android/library/widget/HListView$a;,
        Lit/sephiroth/android/library/widget/HListView$c;,
        Lit/sephiroth/android/library/widget/HListView$b;
    }
.end annotation


# instance fields
.field private aA:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lit/sephiroth/android/library/widget/HListView$b;",
            ">;"
        }
    .end annotation
.end field

.field private aB:Z

.field private aC:Z

.field private aD:Z

.field private aE:Z

.field private aF:Z

.field private aG:Z

.field private final aH:Landroid/graphics/Rect;

.field private aI:Landroid/graphics/Paint;

.field private final aJ:Lit/sephiroth/android/library/widget/HListView$a;

.field private aK:Lit/sephiroth/android/library/widget/HListView$c;

.field au:Landroid/graphics/drawable/Drawable;

.field av:I

.field aw:I

.field ax:Landroid/graphics/drawable/Drawable;

.field ay:Landroid/graphics/drawable/Drawable;

.field private az:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lit/sephiroth/android/library/widget/HListView$b;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lit/sephiroth/android/library/widget/HListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const v0, 0x7f040145

    invoke-direct {p0, p1, p2, v0}, Lit/sephiroth/android/library/widget/HListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 8

    invoke-direct {p0, p1, p2, p3}, Lit/sephiroth/android/library/widget/AbsHListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->az:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aA:Ljava/util/ArrayList;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->aF:Z

    const/4 v1, 0x0

    iput-boolean v1, p0, Lit/sephiroth/android/library/widget/HListView;->aG:Z

    new-instance v2, Landroid/graphics/Rect;

    invoke-direct {v2}, Landroid/graphics/Rect;-><init>()V

    iput-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    new-instance v2, Lit/sephiroth/android/library/widget/HListView$a;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Lit/sephiroth/android/library/widget/HListView$a;-><init>(Lit/sephiroth/android/library/widget/HListView$1;)V

    iput-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->aJ:Lit/sephiroth/android/library/widget/HListView$a;

    invoke-virtual {p1}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v2

    sget-object v4, Lchat/ola/vn/i$b;->HListView:[I

    invoke-virtual {v2, p2, v4, p3, v1}, Landroid/content/res/Resources$Theme;->obtainStyledAttributes(Landroid/util/AttributeSet;[III)Landroid/content/res/TypedArray;

    move-result-object p2

    const/4 p3, -0x1

    if-eqz p2, :cond_0

    invoke-virtual {p2, v1}, Landroid/content/res/TypedArray;->getTextArray(I)[Ljava/lang/CharSequence;

    move-result-object v3

    invoke-virtual {p2, v0}, Landroid/content/res/TypedArray;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    const/4 v4, 0x7

    invoke-virtual {p2, v4}, Landroid/content/res/TypedArray;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    const/4 v5, 0x6

    invoke-virtual {p2, v5}, Landroid/content/res/TypedArray;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    const/4 v6, 0x2

    invoke-virtual {p2, v6, v1}, Landroid/content/res/TypedArray;->getDimensionPixelSize(II)I

    move-result v1

    const/4 v6, 0x4

    invoke-virtual {p2, v6, v0}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v6

    const/4 v7, 0x3

    invoke-virtual {p2, v7, v0}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v0

    const/4 v7, 0x5

    invoke-virtual {p2, v7, p3}, Landroid/content/res/TypedArray;->getInteger(II)I

    move-result p3

    invoke-virtual {p2}, Landroid/content/res/TypedArray;->recycle()V

    move p2, v0

    move v0, v6

    goto :goto_0

    :cond_0
    move-object v2, v3

    move-object v4, v2

    move-object v5, v4

    const/4 p2, 0x1

    :goto_0
    if-eqz v3, :cond_1

    new-instance v6, Landroid/widget/ArrayAdapter;

    const v7, 0x1090003

    invoke-direct {v6, p1, v7, v3}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;I[Ljava/lang/Object;)V

    invoke-virtual {p0, v6}, Lit/sephiroth/android/library/widget/HListView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_1
    if-eqz v2, :cond_2

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/HListView;->setDivider(Landroid/graphics/drawable/Drawable;)V

    :cond_2
    if-eqz v4, :cond_3

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->setOverscrollHeader(Landroid/graphics/drawable/Drawable;)V

    :cond_3
    if-eqz v5, :cond_4

    invoke-virtual {p0, v5}, Lit/sephiroth/android/library/widget/HListView;->setOverscrollFooter(Landroid/graphics/drawable/Drawable;)V

    :cond_4
    if-eqz v1, :cond_5

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->setDividerWidth(I)V

    :cond_5
    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->aD:Z

    iput-boolean p2, p0, Lit/sephiroth/android/library/widget/HListView;->aE:Z

    iput p3, p0, Lit/sephiroth/android/library/widget/HListView;->aw:I

    return-void
.end method

.method private A()Z
    .locals 5

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v0

    add-int/lit8 v1, v0, -0x1

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getRight()I

    move-result v1

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr v2, v0

    const/4 v0, 0x1

    sub-int/2addr v2, v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getScrollX()I

    move-result v3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getWidth()I

    move-result v4

    add-int/2addr v3, v4

    iget-object v4, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->right:I

    sub-int/2addr v3, v4

    iget v4, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    sub-int/2addr v4, v0

    if-lt v2, v4, :cond_1

    if-ge v1, v3, :cond_0

    return v0

    :cond_0
    const/4 v0, 0x0

    :cond_1
    return v0
.end method

.method private a(ILandroid/view/View;I)I
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    invoke-virtual {p2, v0}, Landroid/view/View;->getDrawingRect(Landroid/graphics/Rect;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    invoke-virtual {p0, p2, v0}, Lit/sephiroth/android/library/widget/HListView;->offsetDescendantRectToMyCoords(Landroid/view/View;Landroid/graphics/Rect;)V

    const/16 p2, 0x21

    if-ne p1, p2, :cond_0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    iget p1, p1, Landroid/graphics/Rect;->left:I

    iget-object p2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->left:I

    if-ge p1, p2, :cond_1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget p1, p1, Landroid/graphics/Rect;->left:I

    iget-object p2, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->left:I

    sub-int/2addr p1, p2

    if-lez p3, :cond_2

    :goto_0
    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->getArrowScrollPreviewLength()I

    move-result p2

    add-int/2addr p1, p2

    return p1

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getWidth()I

    move-result p1

    iget-object p2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->right:I

    sub-int/2addr p1, p2

    iget-object p2, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->bottom:I

    if-le p2, p1, :cond_1

    iget-object p2, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->right:I

    sub-int p1, p2, p1

    iget p2, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    add-int/lit8 p2, p2, -0x1

    if-ge p3, p2, :cond_2

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    :cond_2
    return p1
.end method

.method private a(III)Landroid/view/View;
    .locals 8

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getHorizontalFadingEdgeLength()I

    move-result v0

    iget v7, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    invoke-direct {p0, p2, v0, v7}, Lit/sephiroth/android/library/widget/HListView;->c(III)I

    move-result p2

    invoke-direct {p0, p3, v0, v7}, Lit/sephiroth/android/library/widget/HListView;->b(III)I

    move-result p3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, v0, Landroid/graphics/Rect;->top:I

    const/4 v4, 0x1

    const/4 v6, 0x1

    move-object v1, p0

    move v2, v7

    move v3, p1

    invoke-direct/range {v1 .. v6}, Lit/sephiroth/android/library/widget/HListView;->a(IIZIZ)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result v0

    if-le v0, p3, :cond_0

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v0

    sub-int/2addr v0, p2

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result p2

    sub-int/2addr p2, p3

    invoke-static {v0, p2}, Ljava/lang/Math;->min(II)I

    move-result p2

    neg-int p2, p2

    :goto_0
    invoke-virtual {p1, p2}, Landroid/view/View;->offsetLeftAndRight(I)V

    goto :goto_1

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v0

    if-ge v0, p2, :cond_1

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v0

    sub-int/2addr p2, v0

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result v0

    sub-int/2addr p3, v0

    invoke-static {p2, p3}, Ljava/lang/Math;->min(II)I

    move-result p2

    goto :goto_0

    :cond_1
    :goto_1
    invoke-direct {p0, p1, v7}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;I)V

    iget-boolean p2, p0, Lit/sephiroth/android/library/widget/HListView;->K:Z

    if-nez p2, :cond_2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result p2

    invoke-direct {p0, p2}, Lit/sephiroth/android/library/widget/HListView;->l(I)V

    return-object p1

    :cond_2
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result p2

    invoke-direct {p0, p2}, Lit/sephiroth/android/library/widget/HListView;->m(I)V

    return-object p1
.end method

.method private a(IIZIZ)Landroid/view/View;
    .locals 9

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->aj:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v0, p1}, Lit/sephiroth/android/library/widget/AbsHListView$k;->c(I)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v8, 0x1

    :goto_0
    move-object v1, p0

    move-object v2, v0

    move v3, p1

    move v4, p2

    move v5, p3

    move v6, p4

    move v7, p5

    invoke-direct/range {v1 .. v8}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;IIZIZZ)V

    return-object v0

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->P:[Z

    invoke-virtual {p0, p1, v0}, Lit/sephiroth/android/library/widget/HListView;->a(I[Z)Landroid/view/View;

    move-result-object v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->P:[Z

    const/4 v2, 0x0

    aget-boolean v8, v1, v2

    goto :goto_0
.end method

.method private a(Landroid/view/View;Landroid/view/View;III)Landroid/view/View;
    .locals 9

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getHorizontalFadingEdgeLength()I

    move-result v0

    iget v7, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    invoke-direct {p0, p4, v0, v7}, Lit/sephiroth/android/library/widget/HListView;->c(III)I

    move-result v8

    invoke-direct {p0, p4, v0, v7}, Lit/sephiroth/android/library/widget/HListView;->b(III)I

    move-result v0

    if-lez p3, :cond_2

    add-int/lit8 v2, v7, -0x1

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v3

    const/4 v4, 0x1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, p1, Landroid/graphics/Rect;->top:I

    const/4 v6, 0x0

    move-object v1, p0

    invoke-direct/range {v1 .. v6}, Lit/sephiroth/android/library/widget/HListView;->a(IIZIZ)Landroid/view/View;

    move-result-object p1

    iget p2, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result p3

    add-int v3, p3, p2

    iget-object p3, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, p3, Landroid/graphics/Rect;->top:I

    const/4 v6, 0x1

    move v2, v7

    invoke-direct/range {v1 .. v6}, Lit/sephiroth/android/library/widget/HListView;->a(IIZIZ)Landroid/view/View;

    move-result-object p3

    invoke-virtual {p3}, Landroid/view/View;->getRight()I

    move-result v1

    if-le v1, v0, :cond_0

    invoke-virtual {p3}, Landroid/view/View;->getLeft()I

    move-result v1

    sub-int/2addr v1, v8

    invoke-virtual {p3}, Landroid/view/View;->getRight()I

    move-result v2

    sub-int/2addr v2, v0

    sub-int/2addr p5, p4

    div-int/lit8 p5, p5, 0x2

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result p4

    invoke-static {p4, p5}, Ljava/lang/Math;->min(II)I

    move-result p4

    neg-int p4, p4

    invoke-virtual {p1, p4}, Landroid/view/View;->offsetLeftAndRight(I)V

    invoke-virtual {p3, p4}, Landroid/view/View;->offsetLeftAndRight(I)V

    :cond_0
    iget-boolean p1, p0, Lit/sephiroth/android/library/widget/HListView;->K:Z

    if-nez p1, :cond_1

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    add-int/lit8 p1, p1, -0x2

    invoke-virtual {p3}, Landroid/view/View;->getLeft()I

    move-result p4

    sub-int/2addr p4, p2

    invoke-direct {p0, p1, p4}, Lit/sephiroth/android/library/widget/HListView;->g(II)Landroid/view/View;

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->y()V

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    add-int/lit8 p1, p1, 0x1

    invoke-virtual {p3}, Landroid/view/View;->getRight()I

    move-result p4

    add-int/2addr p4, p2

    invoke-direct {p0, p1, p4}, Lit/sephiroth/android/library/widget/HListView;->f(II)Landroid/view/View;

    return-object p3

    :cond_1
    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    add-int/lit8 p1, p1, 0x1

    invoke-virtual {p3}, Landroid/view/View;->getRight()I

    move-result p4

    add-int/2addr p4, p2

    invoke-direct {p0, p1, p4}, Lit/sephiroth/android/library/widget/HListView;->f(II)Landroid/view/View;

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->y()V

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    add-int/lit8 p1, p1, -0x2

    invoke-virtual {p3}, Landroid/view/View;->getLeft()I

    move-result p4

    sub-int/2addr p4, p2

    invoke-direct {p0, p1, p4}, Lit/sephiroth/android/library/widget/HListView;->g(II)Landroid/view/View;

    return-object p3

    :cond_2
    if-gez p3, :cond_4

    if-eqz p2, :cond_3

    invoke-virtual {p2}, Landroid/view/View;->getLeft()I

    move-result v3

    const/4 v4, 0x1

    :goto_0
    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, p1, Landroid/graphics/Rect;->top:I

    const/4 v6, 0x1

    move-object v1, p0

    move v2, v7

    invoke-direct/range {v1 .. v6}, Lit/sephiroth/android/library/widget/HListView;->a(IIZIZ)Landroid/view/View;

    move-result-object p1

    move-object p3, p1

    goto :goto_1

    :cond_3
    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v3

    const/4 v4, 0x0

    goto :goto_0

    :goto_1
    invoke-virtual {p3}, Landroid/view/View;->getLeft()I

    move-result p1

    if-ge p1, v8, :cond_5

    invoke-virtual {p3}, Landroid/view/View;->getLeft()I

    move-result p1

    sub-int/2addr v8, p1

    invoke-virtual {p3}, Landroid/view/View;->getRight()I

    move-result p1

    sub-int/2addr v0, p1

    sub-int/2addr p5, p4

    div-int/lit8 p5, p5, 0x2

    invoke-static {v8, v0}, Ljava/lang/Math;->min(II)I

    move-result p1

    invoke-static {p1, p5}, Ljava/lang/Math;->min(II)I

    move-result p1

    invoke-virtual {p3, p1}, Landroid/view/View;->offsetLeftAndRight(I)V

    goto :goto_2

    :cond_4
    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result p1

    const/4 v4, 0x1

    iget-object p2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, p2, Landroid/graphics/Rect;->top:I

    const/4 v6, 0x1

    move-object v1, p0

    move v2, v7

    move v3, p1

    invoke-direct/range {v1 .. v6}, Lit/sephiroth/android/library/widget/HListView;->a(IIZIZ)Landroid/view/View;

    move-result-object p3

    if-ge p1, p4, :cond_5

    invoke-virtual {p3}, Landroid/view/View;->getRight()I

    move-result p1

    add-int/lit8 p2, p4, 0x14

    if-ge p1, p2, :cond_5

    invoke-virtual {p3}, Landroid/view/View;->getLeft()I

    move-result p1

    sub-int/2addr p4, p1

    invoke-virtual {p3, p4}, Landroid/view/View;->offsetLeftAndRight(I)V

    :cond_5
    :goto_2
    invoke-direct {p0, p3, v7}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;I)V

    return-object p3
.end method

.method private a(Landroid/view/View;I)V
    .locals 3

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    iget-boolean v1, p0, Lit/sephiroth/android/library/widget/HListView;->K:Z

    if-nez v1, :cond_0

    add-int/lit8 v1, p2, -0x1

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v2

    sub-int/2addr v2, v0

    invoke-direct {p0, v1, v2}, Lit/sephiroth/android/library/widget/HListView;->g(II)Landroid/view/View;

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->y()V

    add-int/lit8 p2, p2, 0x1

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result p1

    add-int/2addr p1, v0

    invoke-direct {p0, p2, p1}, Lit/sephiroth/android/library/widget/HListView;->f(II)Landroid/view/View;

    return-void

    :cond_0
    add-int/lit8 v1, p2, 0x1

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result v2

    add-int/2addr v2, v0

    invoke-direct {p0, v1, v2}, Lit/sephiroth/android/library/widget/HListView;->f(II)Landroid/view/View;

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->y()V

    add-int/lit8 p2, p2, -0x1

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result p1

    sub-int/2addr p1, v0

    invoke-direct {p0, p2, p1}, Lit/sephiroth/android/library/widget/HListView;->g(II)Landroid/view/View;

    return-void
.end method

.method private a(Landroid/view/View;II)V
    .locals 2

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/AbsHListView$f;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->generateDefaultLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/AbsHListView$f;

    invoke-virtual {p1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_0
    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v1, p2}, Landroid/widget/ListAdapter;->getItemViewType(I)I

    move-result p2

    iput p2, v0, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    const/4 p2, 0x1

    iput-boolean p2, v0, Lit/sephiroth/android/library/widget/AbsHListView$f;->c:Z

    iget-object p2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->top:I

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->bottom:I

    add-int/2addr p2, v1

    iget v1, v0, Lit/sephiroth/android/library/widget/AbsHListView$f;->height:I

    invoke-static {p3, p2, v1}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    move-result p2

    iget p3, v0, Lit/sephiroth/android/library/widget/AbsHListView$f;->width:I

    if-lez p3, :cond_1

    const/high16 v0, 0x40000000    # 2.0f

    invoke-static {p3, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p3

    goto :goto_0

    :cond_1
    const/4 p3, 0x0

    invoke-static {p3, p3}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p3

    :goto_0
    invoke-virtual {p1, p3, p2}, Landroid/view/View;->measure(II)V

    return-void
.end method

.method private a(Landroid/view/View;IIZ)V
    .locals 6

    const/4 v0, -0x1

    if-ne p3, v0, :cond_0

    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "newSelectedPosition needs to be valid"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    sub-int/2addr v0, v1

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    sub-int/2addr p3, v1

    const/16 v1, 0x21

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-ne p2, v1, :cond_1

    invoke-virtual {p0, p3}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p2

    move v1, v0

    move-object v0, p1

    move-object p1, p2

    const/4 p2, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {p0, p3}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p2

    move v1, p3

    move p3, v0

    move-object v0, p2

    const/4 p2, 0x0

    :goto_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v4

    if-eqz p1, :cond_3

    if-nez p4, :cond_2

    if-eqz p2, :cond_2

    const/4 v5, 0x1

    goto :goto_1

    :cond_2
    const/4 v5, 0x0

    :goto_1
    invoke-virtual {p1, v5}, Landroid/view/View;->setSelected(Z)V

    invoke-direct {p0, p1, p3, v4}, Lit/sephiroth/android/library/widget/HListView;->b(Landroid/view/View;II)V

    :cond_3
    if-eqz v0, :cond_5

    if-nez p4, :cond_4

    if-nez p2, :cond_4

    goto :goto_2

    :cond_4
    const/4 v2, 0x0

    :goto_2
    invoke-virtual {v0, v2}, Landroid/view/View;->setSelected(Z)V

    invoke-direct {p0, v0, v1, v4}, Lit/sephiroth/android/library/widget/HListView;->b(Landroid/view/View;II)V

    :cond_5
    return-void
.end method

.method private a(Landroid/view/View;IIZIZZ)V
    .locals 16
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p2

    move/from16 v4, p5

    const/4 v5, 0x1

    const/4 v6, 0x0

    if-eqz p6, :cond_0

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->h()Z

    move-result v7

    if-eqz v7, :cond_0

    const/4 v7, 0x1

    goto :goto_0

    :cond_0
    const/4 v7, 0x0

    :goto_0
    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->isSelected()Z

    move-result v8

    if-eq v7, v8, :cond_1

    const/4 v8, 0x1

    goto :goto_1

    :cond_1
    const/4 v8, 0x0

    :goto_1
    iget v9, v0, Lit/sephiroth/android/library/widget/HListView;->F:I

    if-lez v9, :cond_2

    const/4 v10, 0x3

    if-ge v9, v10, :cond_2

    iget v9, v0, Lit/sephiroth/android/library/widget/HListView;->A:I

    if-ne v9, v2, :cond_2

    const/4 v9, 0x1

    goto :goto_2

    :cond_2
    const/4 v9, 0x0

    :goto_2
    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->isPressed()Z

    move-result v10

    if-eq v9, v10, :cond_3

    const/4 v10, 0x1

    goto :goto_3

    :cond_3
    const/4 v10, 0x0

    :goto_3
    if-eqz p7, :cond_5

    if-nez v8, :cond_5

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->isLayoutRequested()Z

    move-result v11

    if-eqz v11, :cond_4

    goto :goto_4

    :cond_4
    const/4 v11, 0x0

    goto :goto_5

    :cond_5
    :goto_4
    const/4 v11, 0x1

    :goto_5
    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v12

    check-cast v12, Lit/sephiroth/android/library/widget/AbsHListView$f;

    if-nez v12, :cond_6

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->generateDefaultLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v12

    check-cast v12, Lit/sephiroth/android/library/widget/AbsHListView$f;

    :cond_6
    iget-object v13, v0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v13, v2}, Landroid/widget/ListAdapter;->getItemViewType(I)I

    move-result v13

    iput v13, v12, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    if-eqz p7, :cond_7

    iget-boolean v14, v12, Lit/sephiroth/android/library/widget/AbsHListView$f;->c:Z

    if-eqz v14, :cond_8

    :cond_7
    iget-boolean v14, v12, Lit/sephiroth/android/library/widget/AbsHListView$f;->b:Z

    const/4 v13, -0x2

    if-eqz v14, :cond_a

    iget v14, v12, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    if-ne v14, v13, :cond_a

    :cond_8
    if-eqz p4, :cond_9

    const/4 v13, -0x1

    goto :goto_6

    :cond_9
    const/4 v13, 0x0

    :goto_6
    invoke-virtual {v0, v1, v13, v12}, Lit/sephiroth/android/library/widget/HListView;->attachViewToParent(Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;)V

    goto :goto_8

    :cond_a
    iput-boolean v6, v12, Lit/sephiroth/android/library/widget/AbsHListView$f;->c:Z

    iget v14, v12, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    if-ne v14, v13, :cond_b

    iput-boolean v5, v12, Lit/sephiroth/android/library/widget/AbsHListView$f;->b:Z

    :cond_b
    if-eqz p4, :cond_c

    const/4 v13, -0x1

    goto :goto_7

    :cond_c
    const/4 v13, 0x0

    :goto_7
    invoke-virtual {v0, v1, v13, v12, v5}, Lit/sephiroth/android/library/widget/HListView;->addViewInLayout(Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;Z)Z

    :goto_8
    if-eqz v8, :cond_d

    invoke-virtual {v1, v7}, Landroid/view/View;->setSelected(Z)V

    :cond_d
    if-eqz v10, :cond_e

    invoke-virtual {v1, v9}, Landroid/view/View;->setPressed(Z)V

    :cond_e
    iget v7, v0, Lit/sephiroth/android/library/widget/HListView;->b:I

    const/16 v8, 0xb

    if-eqz v7, :cond_10

    iget-object v7, v0, Lit/sephiroth/android/library/widget/HListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz v7, :cond_10

    instance-of v7, v1, Landroid/widget/Checkable;

    if-eqz v7, :cond_f

    move-object v7, v1

    check-cast v7, Landroid/widget/Checkable;

    iget-object v9, v0, Lit/sephiroth/android/library/widget/HListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v10

    invoke-virtual {v9, v2, v10}, Landroid/support/v4/util/SparseArrayCompat;->get(ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Boolean;

    invoke-virtual {v9}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v9

    invoke-interface {v7, v9}, Landroid/widget/Checkable;->setChecked(Z)V

    goto :goto_9

    :cond_f
    sget v7, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v7, v8, :cond_10

    iget-object v7, v0, Lit/sephiroth/android/library/widget/HListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v9

    invoke-virtual {v7, v2, v9}, Landroid/support/v4/util/SparseArrayCompat;->get(ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Boolean;

    invoke-virtual {v7}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v7

    invoke-virtual {v1, v7}, Landroid/view/View;->setActivated(Z)V

    :cond_10
    :goto_9
    if-eqz v11, :cond_12

    iget v7, v0, Lit/sephiroth/android/library/widget/HListView;->v:I

    iget-object v9, v0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v9, v9, Landroid/graphics/Rect;->top:I

    iget-object v10, v0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v10, v10, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v9, v10

    iget v10, v12, Lit/sephiroth/android/library/widget/AbsHListView$f;->height:I

    invoke-static {v7, v9, v10}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    move-result v7

    iget v9, v12, Lit/sephiroth/android/library/widget/AbsHListView$f;->width:I

    if-lez v9, :cond_11

    const/high16 v6, 0x40000000    # 2.0f

    invoke-static {v9, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v6

    goto :goto_a

    :cond_11
    invoke-static {v6, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v6

    :goto_a
    invoke-virtual {v1, v6, v7}, Landroid/view/View;->measure(II)V

    goto :goto_b

    :cond_12
    invoke-virtual/range {p0 .. p1}, Lit/sephiroth/android/library/widget/HListView;->cleanupLayoutState(Landroid/view/View;)V

    :goto_b
    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getMeasuredWidth()I

    move-result v6

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getMeasuredHeight()I

    move-result v7

    if-eqz p4, :cond_13

    move/from16 v3, p3

    goto :goto_c

    :cond_13
    sub-int v3, p3, v6

    :goto_c
    if-eqz v11, :cond_14

    add-int/2addr v7, v4

    add-int/2addr v6, v3

    invoke-virtual {v1, v3, v4, v6, v7}, Landroid/view/View;->layout(IIII)V

    goto :goto_d

    :cond_14
    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getLeft()I

    move-result v6

    sub-int/2addr v3, v6

    invoke-virtual {v1, v3}, Landroid/view/View;->offsetLeftAndRight(I)V

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getTop()I

    move-result v3

    sub-int v3, v4, v3

    invoke-virtual {v1, v3}, Landroid/view/View;->offsetTopAndBottom(I)V

    :goto_d
    iget-boolean v3, v0, Lit/sephiroth/android/library/widget/HListView;->y:Z

    if-eqz v3, :cond_15

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->isDrawingCacheEnabled()Z

    move-result v3

    if-nez v3, :cond_15

    invoke-virtual {v1, v5}, Landroid/view/View;->setDrawingCacheEnabled(Z)V

    :cond_15
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v3, v8, :cond_16

    if-eqz p7, :cond_16

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Lit/sephiroth/android/library/widget/AbsHListView$f;

    iget v3, v3, Lit/sephiroth/android/library/widget/AbsHListView$f;->d:I

    if-eq v3, v2, :cond_16

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->jumpDrawablesToCurrentState()V

    :cond_16
    return-void
.end method

.method private a(Ljava/util/ArrayList;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lit/sephiroth/android/library/widget/HListView$b;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_1

    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lit/sephiroth/android/library/widget/HListView$b;

    iget-object v3, v3, Lit/sephiroth/android/library/widget/HListView$b;->a:Landroid/view/View;

    invoke-virtual {v3}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Lit/sephiroth/android/library/widget/AbsHListView$f;

    if-eqz v3, :cond_0

    iput-boolean v1, v3, Lit/sephiroth/android/library/widget/AbsHListView$f;->b:Z

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method private a(IILandroid/view/KeyEvent;)Z
    .locals 6
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    const/4 v1, 0x0

    if-eqz v0, :cond_10

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->S:Z

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->aj:Z

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->e()V

    :cond_1
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0xb

    if-ge v0, v2, :cond_2

    return v1

    :cond_2
    invoke-virtual {p3}, Landroid/view/KeyEvent;->getAction()I

    move-result v0

    const/4 v2, 0x1

    if-eq v0, v2, :cond_d

    const/16 v3, 0x3e

    const/16 v4, 0x21

    const/16 v5, 0x82

    if-eq p1, v3, :cond_a

    const/16 v3, 0x42

    if-eq p1, v3, :cond_9

    const/4 v3, 0x2

    packed-switch p1, :pswitch_data_0

    packed-switch p1, :pswitch_data_1

    packed-switch p1, :pswitch_data_2

    goto/16 :goto_3

    :pswitch_0
    invoke-virtual {p3}, Landroid/view/KeyEvent;->hasNoModifiers()Z

    move-result v3

    if-eqz v3, :cond_d

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_c

    invoke-virtual {p0, v5}, Lit/sephiroth/android/library/widget/HListView;->i(I)Z

    move-result v3

    if-eqz v3, :cond_d

    goto/16 :goto_2

    :pswitch_1
    invoke-virtual {p3}, Landroid/view/KeyEvent;->hasNoModifiers()Z

    move-result v3

    if-eqz v3, :cond_d

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_c

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->i(I)Z

    move-result v3

    if-eqz v3, :cond_d

    goto/16 :goto_2

    :pswitch_2
    invoke-virtual {p3}, Landroid/view/KeyEvent;->hasNoModifiers()Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_c

    invoke-virtual {p0, v5}, Lit/sephiroth/android/library/widget/HListView;->h(I)Z

    move-result v3

    if-eqz v3, :cond_d

    goto/16 :goto_2

    :cond_3
    invoke-virtual {p3, v3}, Landroid/view/KeyEvent;->hasModifiers(I)Z

    move-result v3

    if-eqz v3, :cond_d

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_c

    invoke-virtual {p0, v5}, Lit/sephiroth/android/library/widget/HListView;->i(I)Z

    move-result v3

    if-eqz v3, :cond_d

    goto/16 :goto_2

    :pswitch_3
    invoke-virtual {p3}, Landroid/view/KeyEvent;->hasNoModifiers()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_c

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->h(I)Z

    move-result v3

    if-eqz v3, :cond_d

    goto/16 :goto_2

    :cond_4
    invoke-virtual {p3, v3}, Landroid/view/KeyEvent;->hasModifiers(I)Z

    move-result v3

    if-eqz v3, :cond_d

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_c

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->i(I)Z

    move-result v3

    if-eqz v3, :cond_d

    goto/16 :goto_2

    :pswitch_4
    invoke-virtual {p3}, Landroid/view/KeyEvent;->hasNoModifiers()Z

    move-result v4

    if-eqz v4, :cond_6

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_e

    :goto_0
    add-int/lit8 v4, p2, -0x1

    if-lez p2, :cond_5

    invoke-virtual {p0, v5}, Lit/sephiroth/android/library/widget/HListView;->j(I)Z

    move-result p2

    if-eqz p2, :cond_5

    move p2, v4

    const/4 v3, 0x1

    goto :goto_0

    :cond_5
    move p2, v4

    goto/16 :goto_4

    :cond_6
    invoke-virtual {p3, v3}, Landroid/view/KeyEvent;->hasModifiers(I)Z

    move-result v3

    if-eqz v3, :cond_d

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_c

    invoke-virtual {p0, v5}, Lit/sephiroth/android/library/widget/HListView;->i(I)Z

    move-result v3

    if-eqz v3, :cond_d

    goto/16 :goto_2

    :pswitch_5
    invoke-virtual {p3}, Landroid/view/KeyEvent;->hasNoModifiers()Z

    move-result v5

    if-eqz v5, :cond_8

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_e

    :goto_1
    add-int/lit8 v5, p2, -0x1

    if-lez p2, :cond_7

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->j(I)Z

    move-result p2

    if-eqz p2, :cond_7

    move p2, v5

    const/4 v3, 0x1

    goto :goto_1

    :cond_7
    move p2, v5

    goto/16 :goto_4

    :cond_8
    invoke-virtual {p3, v3}, Landroid/view/KeyEvent;->hasModifiers(I)Z

    move-result v3

    if-eqz v3, :cond_d

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_c

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->i(I)Z

    move-result v3

    if-eqz v3, :cond_d

    goto :goto_2

    :pswitch_6
    invoke-virtual {p3}, Landroid/view/KeyEvent;->hasNoModifiers()Z

    move-result v3

    if-eqz v3, :cond_d

    invoke-direct {p0, v5}, Lit/sephiroth/android/library/widget/HListView;->n(I)Z

    move-result v3

    goto :goto_4

    :pswitch_7
    invoke-virtual {p3}, Landroid/view/KeyEvent;->hasNoModifiers()Z

    move-result v3

    if-eqz v3, :cond_d

    invoke-direct {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->n(I)Z

    move-result v3

    goto :goto_4

    :cond_9
    :pswitch_8
    invoke-virtual {p3}, Landroid/view/KeyEvent;->hasNoModifiers()Z

    move-result v3

    if-eqz v3, :cond_d

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_e

    invoke-virtual {p3}, Landroid/view/KeyEvent;->getRepeatCount()I

    move-result v4

    if-nez v4, :cond_e

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v4

    if-lez v4, :cond_e

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->i()V

    goto :goto_2

    :cond_a
    invoke-virtual {p3}, Landroid/view/KeyEvent;->hasNoModifiers()Z

    move-result v3

    if-eqz v3, :cond_b

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_c

    invoke-virtual {p0, v5}, Lit/sephiroth/android/library/widget/HListView;->h(I)Z

    move-result v3

    goto :goto_2

    :cond_b
    invoke-virtual {p3, v2}, Landroid/view/KeyEvent;->hasModifiers(I)Z

    move-result v3

    if-eqz v3, :cond_c

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->n()Z

    move-result v3

    if-nez v3, :cond_c

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->h(I)Z

    move-result v3

    :cond_c
    :goto_2
    const/4 v3, 0x1

    goto :goto_4

    :cond_d
    :goto_3
    const/4 v3, 0x0

    :cond_e
    :goto_4
    if-eqz v3, :cond_f

    return v2

    :cond_f
    packed-switch v0, :pswitch_data_3

    return v1

    :pswitch_9
    invoke-super {p0, p1, p2, p3}, Lit/sephiroth/android/library/widget/AbsHListView;->onKeyMultiple(IILandroid/view/KeyEvent;)Z

    move-result p1

    return p1

    :pswitch_a
    invoke-super {p0, p1, p3}, Lit/sephiroth/android/library/widget/AbsHListView;->onKeyUp(ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1

    :pswitch_b
    invoke-super {p0, p1, p3}, Lit/sephiroth/android/library/widget/AbsHListView;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1

    :cond_10
    return v1

    nop

    :pswitch_data_0
    .packed-switch 0x13
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_8
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x5c
        :pswitch_3
        :pswitch_2
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x7a
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_3
    .packed-switch 0x0
        :pswitch_b
        :pswitch_a
        :pswitch_9
    .end packed-switch
.end method

.method private a(Landroid/view/View;Landroid/view/View;)Z
    .locals 2

    const/4 v0, 0x1

    if-ne p1, p2, :cond_0

    return v0

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p1

    instance-of v1, p1, Landroid/view/ViewGroup;

    if-eqz v1, :cond_1

    check-cast p1, Landroid/view/View;

    invoke-direct {p0, p1, p2}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;Landroid/view/View;)Z

    move-result p1

    if-eqz p1, :cond_1

    return v0

    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method private b(III)I
    .locals 1

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    add-int/lit8 v0, v0, -0x1

    if-eq p3, v0, :cond_0

    sub-int/2addr p1, p2

    :cond_0
    return p1
.end method

.method private b(Landroid/view/View;I)Landroid/view/View;
    .locals 8

    add-int/lit8 v2, p2, -0x1

    iget-object p2, p0, Lit/sephiroth/android/library/widget/HListView;->P:[Z

    invoke-virtual {p0, v2, p2}, Lit/sephiroth/android/library/widget/HListView;->a(I[Z)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result p1

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    sub-int v3, p1, v0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, p1, Landroid/graphics/Rect;->top:I

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->P:[Z

    const/4 v0, 0x0

    aget-boolean v7, p1, v0

    const/4 v4, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    move-object v1, p2

    invoke-direct/range {v0 .. v7}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;IIZIZZ)V

    return-object p2
.end method

.method private b(Landroid/view/View;II)V
    .locals 2

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v0

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->d(Landroid/view/View;)V

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredWidth()I

    move-result v1

    if-eq v1, v0, :cond_0

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->e(Landroid/view/View;)V

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredWidth()I

    move-result p1

    sub-int/2addr p1, v0

    :goto_0
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    invoke-virtual {p0, p2}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/view/View;->offsetLeftAndRight(I)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method private c(III)I
    .locals 0

    if-lez p3, :cond_0

    add-int/2addr p1, p2

    :cond_0
    return p1
.end method

.method private c(Landroid/view/View;I)Landroid/view/View;
    .locals 8

    add-int/lit8 v2, p2, 0x1

    iget-object p2, p0, Lit/sephiroth/android/library/widget/HListView;->P:[Z

    invoke-virtual {p0, v2, p2}, Lit/sephiroth/android/library/widget/HListView;->a(I[Z)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result p1

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    add-int v3, p1, v0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, p1, Landroid/graphics/Rect;->top:I

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->P:[Z

    const/4 v0, 0x0

    aget-boolean v7, p1, v0

    const/4 v4, 0x1

    const/4 v6, 0x0

    move-object v0, p0

    move-object v1, p2

    invoke-direct/range {v0 .. v7}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;IIZIZZ)V

    return-object p2
.end method

.method private c(Landroid/view/View;)Z
    .locals 6

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->az:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    const/4 v4, 0x1

    if-ge v3, v1, :cond_1

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lit/sephiroth/android/library/widget/HListView$b;

    iget-object v5, v5, Lit/sephiroth/android/library/widget/HListView$b;->a:Landroid/view/View;

    if-ne p1, v5, :cond_0

    return v4

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aA:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v3, 0x0

    :goto_1
    if-ge v3, v1, :cond_3

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lit/sephiroth/android/library/widget/HListView$b;

    iget-object v5, v5, Lit/sephiroth/android/library/widget/HListView$b;->a:Landroid/view/View;

    if-ne p1, v5, :cond_2

    return v4

    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_3
    return v2
.end method

.method private d(Landroid/view/View;)V
    .locals 4

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    const/4 v1, -0x2

    const/4 v2, -0x1

    invoke-direct {v0, v1, v2}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    :cond_0
    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->v:I

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->top:I

    iget-object v3, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v2, v3

    iget v3, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-static {v1, v2, v3}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    move-result v1

    iget v0, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    if-lez v0, :cond_1

    const/high16 v2, 0x40000000    # 2.0f

    invoke-static {v0, v2}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v0

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    invoke-static {v0, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v0

    :goto_0
    invoke-virtual {p1, v0, v1}, Landroid/view/View;->measure(II)V

    return-void
.end method

.method private e(Landroid/view/View;)V
    .locals 4

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredWidth()I

    move-result v0

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredHeight()I

    move-result v1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->top:I

    add-int/2addr v1, v2

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v3

    add-int/2addr v0, v3

    invoke-virtual {p1, v3, v2, v0, v1}, Landroid/view/View;->layout(IIII)V

    return-void
.end method

.method private f(Landroid/view/View;)I
    .locals 3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-direct {p0, p1, v2}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;Landroid/view/View;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr p1, v1

    return p1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "newFocus is not a child of any of the children of the list!"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method private f(II)Landroid/view/View;
    .locals 8

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getRight()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getLeft()I

    move-result v1

    sub-int/2addr v0, v1

    const/4 v1, 0x0

    move v4, p2

    :goto_0
    const/4 p2, 0x1

    if-ge v4, v0, :cond_2

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    if-ge p1, v2, :cond_2

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    if-ne p1, v2, :cond_0

    goto :goto_1

    :cond_0
    const/4 p2, 0x0

    :goto_1
    const/4 v5, 0x1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v6, v2, Landroid/graphics/Rect;->top:I

    move-object v2, p0

    move v3, p1

    move v7, p2

    invoke-direct/range {v2 .. v7}, Lit/sephiroth/android/library/widget/HListView;->a(IIZIZ)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getRight()I

    move-result v3

    iget v4, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    add-int/2addr v4, v3

    if-eqz p2, :cond_1

    move-object v1, v2

    :cond_1
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_2
    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v2

    add-int/2addr v0, v2

    sub-int/2addr v0, p2

    invoke-virtual {p0, p1, v0}, Lit/sephiroth/android/library/widget/HListView;->d(II)V

    return-object v1
.end method

.method private g(Landroid/view/View;)I
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    invoke-virtual {p1, v0}, Landroid/view/View;->getDrawingRect(Landroid/graphics/Rect;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    invoke-virtual {p0, p1, v0}, Lit/sephiroth/android/library/widget/HListView;->offsetDescendantRectToMyCoords(Landroid/view/View;Landroid/graphics/Rect;)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getRight()I

    move-result p1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getLeft()I

    move-result v0

    sub-int/2addr p1, v0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->right:I

    sub-int/2addr p1, v0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->right:I

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->left:I

    if-ge v0, v1, :cond_0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget p1, p1, Landroid/graphics/Rect;->left:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->right:I

    sub-int/2addr p1, v0

    return p1

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    if-le v0, p1, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    sub-int p1, v0, p1

    return p1

    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method private g(II)Landroid/view/View;
    .locals 7

    const/4 v0, 0x0

    move v3, p2

    :goto_0
    const/4 p2, 0x1

    if-lez v3, :cond_2

    if-ltz p1, :cond_2

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    if-ne p1, v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 p2, 0x0

    :goto_1
    const/4 v4, 0x0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, v1, Landroid/graphics/Rect;->top:I

    move-object v1, p0

    move v2, p1

    move v6, p2

    invoke-direct/range {v1 .. v6}, Lit/sephiroth/android/library/widget/HListView;->a(IIZIZ)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v2

    iget v3, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    sub-int v3, v2, v3

    if-eqz p2, :cond_1

    move-object v0, v1

    :cond_1
    add-int/lit8 p1, p1, -0x1

    goto :goto_0

    :cond_2
    add-int/2addr p1, p2

    iput p1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v2

    add-int/2addr v1, v2

    sub-int/2addr v1, p2

    invoke-virtual {p0, p1, v1}, Lit/sephiroth/android/library/widget/HListView;->d(II)V

    return-object v0
.end method

.method private getArrowScrollPreviewLength()I
    .locals 2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getHorizontalFadingEdgeLength()I

    move-result v0

    const/4 v1, 0x2

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0
.end method

.method private h(II)Landroid/view/View;
    .locals 7

    sub-int/2addr p2, p1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->m()I

    move-result v6

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v4, v0, Landroid/graphics/Rect;->top:I

    const/4 v3, 0x1

    const/4 v5, 0x1

    move-object v0, p0

    move v1, v6

    move v2, p1

    invoke-direct/range {v0 .. v5}, Lit/sephiroth/android/library/widget/HListView;->a(IIZIZ)Landroid/view/View;

    move-result-object p1

    iput v6, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredWidth()I

    move-result v0

    if-gt v0, p2, :cond_0

    sub-int/2addr p2, v0

    div-int/lit8 p2, p2, 0x2

    invoke-virtual {p1, p2}, Landroid/view/View;->offsetLeftAndRight(I)V

    :cond_0
    invoke-direct {p0, p1, v6}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;I)V

    iget-boolean p2, p0, Lit/sephiroth/android/library/widget/HListView;->K:Z

    if-nez p2, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result p2

    invoke-direct {p0, p2}, Lit/sephiroth/android/library/widget/HListView;->l(I)V

    return-object p1

    :cond_1
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result p2

    invoke-direct {p0, p2}, Lit/sephiroth/android/library/widget/HListView;->m(I)V

    return-object p1
.end method

.method private i(II)Landroid/view/View;
    .locals 9

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    const/4 v1, 0x1

    if-ne p1, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    const/4 v5, 0x1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v6, v2, Landroid/graphics/Rect;->top:I

    move-object v2, p0

    move v3, p1

    move v4, p2

    move v7, v0

    invoke-direct/range {v2 .. v7}, Lit/sephiroth/android/library/widget/HListView;->a(IIZIZ)Landroid/view/View;

    move-result-object p2

    iput p1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    iget-boolean v3, p0, Lit/sephiroth/android/library/widget/HListView;->K:Z

    if-nez v3, :cond_2

    add-int/lit8 v3, p1, -0x1

    invoke-virtual {p2}, Landroid/view/View;->getLeft()I

    move-result v4

    sub-int/2addr v4, v2

    invoke-direct {p0, v3, v4}, Lit/sephiroth/android/library/widget/HListView;->g(II)Landroid/view/View;

    move-result-object v3

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->y()V

    add-int/2addr p1, v1

    invoke-virtual {p2}, Landroid/view/View;->getRight()I

    move-result v1

    add-int/2addr v1, v2

    invoke-direct {p0, p1, v1}, Lit/sephiroth/android/library/widget/HListView;->f(II)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v1

    if-lez v1, :cond_1

    invoke-direct {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->l(I)V

    :cond_1
    move-object v8, v3

    move-object v3, p1

    move-object p1, v8

    goto :goto_1

    :cond_2
    add-int/lit8 v3, p1, 0x1

    invoke-virtual {p2}, Landroid/view/View;->getRight()I

    move-result v4

    add-int/2addr v4, v2

    invoke-direct {p0, v3, v4}, Lit/sephiroth/android/library/widget/HListView;->f(II)Landroid/view/View;

    move-result-object v3

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->y()V

    sub-int/2addr p1, v1

    invoke-virtual {p2}, Landroid/view/View;->getLeft()I

    move-result v1

    sub-int/2addr v1, v2

    invoke-direct {p0, p1, v1}, Lit/sephiroth/android/library/widget/HListView;->g(II)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v1

    if-lez v1, :cond_3

    invoke-direct {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->m(I)V

    :cond_3
    :goto_1
    if-eqz v0, :cond_4

    return-object p2

    :cond_4
    if-eqz p1, :cond_5

    return-object p1

    :cond_5
    return-object v3
.end method

.method private j(II)I
    .locals 7

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getWidth()I

    move-result v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->right:I

    sub-int/2addr v0, v1

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->left:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v2

    const/4 v3, -0x1

    const/4 v4, 0x0

    const/16 v5, 0x82

    if-ne p1, v5, :cond_5

    add-int/lit8 p1, v2, -0x1

    if-eq p2, v3, :cond_0

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    sub-int v1, p2, v1

    goto :goto_0

    :cond_0
    move v1, p1

    :goto_0
    iget v5, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr v5, v1

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    iget v6, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    add-int/lit8 v6, v6, -0x1

    if-ge v5, v6, :cond_1

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->getArrowScrollPreviewLength()I

    move-result v5

    sub-int v5, v0, v5

    goto :goto_1

    :cond_1
    move v5, v0

    :goto_1
    invoke-virtual {v1}, Landroid/view/View;->getRight()I

    move-result v6

    if-gt v6, v5, :cond_2

    return v4

    :cond_2
    if-eq p2, v3, :cond_3

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result p2

    sub-int p2, v5, p2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getMaxScrollAmount()I

    move-result v3

    if-lt p2, v3, :cond_3

    return v4

    :cond_3
    invoke-virtual {v1}, Landroid/view/View;->getRight()I

    move-result p2

    sub-int/2addr p2, v5

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr v1, v2

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    if-ne v1, v2, :cond_4

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result p1

    sub-int/2addr p1, v0

    invoke-static {p2, p1}, Ljava/lang/Math;->min(II)I

    move-result p2

    :cond_4
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getMaxScrollAmount()I

    move-result p1

    invoke-static {p2, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    return p1

    :cond_5
    if-eq p2, v3, :cond_6

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    sub-int p1, p2, p1

    goto :goto_2

    :cond_6
    const/4 p1, 0x0

    :goto_2
    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr v0, p1

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    if-lez v0, :cond_7

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->getArrowScrollPreviewLength()I

    move-result v0

    add-int/2addr v0, v1

    goto :goto_3

    :cond_7
    move v0, v1

    :goto_3
    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v2

    if-lt v2, v0, :cond_8

    return v4

    :cond_8
    if-eq p2, v3, :cond_9

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result p2

    sub-int/2addr p2, v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getMaxScrollAmount()I

    move-result v2

    if-lt p2, v2, :cond_9

    return v4

    :cond_9
    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result p1

    sub-int/2addr v0, p1

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    if-nez p1, :cond_a

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result p1

    sub-int/2addr v1, p1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    :cond_a
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getMaxScrollAmount()I

    move-result p1

    invoke-static {v0, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    return p1
.end method

.method private k(I)Landroid/view/View;
    .locals 2

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    add-int/lit8 v1, v1, -0x1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    if-gez v0, :cond_0

    const/4 v0, 0x0

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    invoke-direct {p0, v0, p1}, Lit/sephiroth/android/library/widget/HListView;->f(II)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method private l(I)V
    .locals 3

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr v0, p1

    add-int/lit8 v0, v0, -0x1

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    add-int/lit8 v1, v1, -0x1

    if-ne v0, v1, :cond_2

    if-lez p1, :cond_2

    add-int/lit8 p1, p1, -0x1

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result p1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getRight()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getLeft()I

    move-result v1

    sub-int/2addr v0, v1

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->right:I

    sub-int/2addr v0, v1

    sub-int/2addr v0, p1

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v1

    if-lez v0, :cond_2

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    if-gtz v2, :cond_0

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->top:I

    if-ge v1, v2, :cond_2

    :cond_0
    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    if-nez v2, :cond_1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->top:I

    sub-int/2addr v2, v1

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v0

    :cond_1
    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/HListView;->d(I)V

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    if-lez v0, :cond_2

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result p1

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    sub-int/2addr p1, v1

    invoke-direct {p0, v0, p1}, Lit/sephiroth/android/library/widget/HListView;->g(II)Landroid/view/View;

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->y()V

    :cond_2
    return-void
.end method

.method private m(I)V
    .locals 5

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    if-nez v0, :cond_3

    if-lez p1, :cond_3

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->left:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getRight()I

    move-result v2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getLeft()I

    move-result v3

    sub-int/2addr v2, v3

    iget-object v3, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->right:I

    sub-int/2addr v2, v3

    sub-int/2addr v0, v1

    add-int/lit8 v1, p1, -0x1

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getRight()I

    move-result v3

    iget v4, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr v4, p1

    add-int/lit8 v4, v4, -0x1

    if-lez v0, :cond_3

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    add-int/lit8 p1, p1, -0x1

    if-lt v4, p1, :cond_1

    if-le v3, v2, :cond_0

    goto :goto_1

    :cond_0
    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    add-int/lit8 p1, p1, -0x1

    if-ne v4, p1, :cond_3

    :goto_0
    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->y()V

    return-void

    :cond_1
    :goto_1
    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    add-int/lit8 p1, p1, -0x1

    if-ne v4, p1, :cond_2

    sub-int/2addr v3, v2

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    :cond_2
    neg-int p1, v0

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->d(I)V

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    add-int/lit8 p1, p1, -0x1

    if-ge v4, p1, :cond_3

    add-int/lit8 v4, v4, 0x1

    invoke-virtual {v1}, Landroid/view/View;->getRight()I

    move-result p1

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    add-int/2addr p1, v0

    invoke-direct {p0, v4, p1}, Lit/sephiroth/android/library/widget/HListView;->f(II)Landroid/view/View;

    goto :goto_0

    :cond_3
    return-void
.end method

.method private n(I)Z
    .locals 3

    const/16 v0, 0x21

    if-eq p1, v0, :cond_0

    const/16 v0, 0x82

    if-eq p1, v0, :cond_0

    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "direction must be one of {View.FOCUS_UP, View.FOCUS_DOWN}"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v0

    iget-boolean v1, p0, Lit/sephiroth/android/library/widget/HListView;->aG:Z

    if-eqz v1, :cond_2

    if-lez v0, :cond_2

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getSelectedView()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/view/View;->hasFocus()Z

    move-result v1

    if-eqz v1, :cond_2

    instance-of v1, v0, Landroid/view/ViewGroup;

    if-eqz v1, :cond_2

    invoke-virtual {v0}, Landroid/view/View;->findFocus()Landroid/view/View;

    move-result-object v1

    invoke-static {}, Landroid/view/FocusFinder;->getInstance()Landroid/view/FocusFinder;

    move-result-object v2

    check-cast v0, Landroid/view/ViewGroup;

    invoke-virtual {v2, v0, v1, p1}, Landroid/view/FocusFinder;->findNextFocus(Landroid/view/ViewGroup;Landroid/view/View;I)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    invoke-virtual {v1, v2}, Landroid/view/View;->getFocusedRect(Landroid/graphics/Rect;)V

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    invoke-virtual {p0, v1, v2}, Lit/sephiroth/android/library/widget/HListView;->offsetDescendantRectToMyCoords(Landroid/view/View;Landroid/graphics/Rect;)V

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    invoke-virtual {p0, v0, v2}, Lit/sephiroth/android/library/widget/HListView;->offsetRectIntoDescendantCoords(Landroid/view/View;Landroid/graphics/Rect;)V

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    invoke-virtual {v0, p1, v2}, Landroid/view/View;->requestFocus(ILandroid/graphics/Rect;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 p1, 0x1

    return p1

    :cond_1
    invoke-static {}, Landroid/view/FocusFinder;->getInstance()Landroid/view/FocusFinder;

    move-result-object v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getRootView()Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/view/ViewGroup;

    invoke-virtual {v0, v2, v1, p1}, Landroid/view/FocusFinder;->findNextFocus(Landroid/view/ViewGroup;Landroid/view/View;I)Landroid/view/View;

    move-result-object p1

    if-eqz p1, :cond_2

    invoke-direct {p0, p1, p0}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;Landroid/view/View;)Z

    move-result p1

    return p1

    :cond_2
    const/4 p1, 0x0

    return p1
.end method

.method private o(I)Z
    .locals 10

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v0

    const/4 v1, 0x0

    if-gtz v0, :cond_0

    return v1

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getSelectedView()Landroid/view/View;

    move-result-object v0

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->p(I)I

    move-result v3

    invoke-direct {p0, p1, v3}, Lit/sephiroth/android/library/widget/HListView;->j(II)I

    move-result v4

    iget-boolean v5, p0, Lit/sephiroth/android/library/widget/HListView;->aG:Z

    const/4 v6, 0x0

    if-eqz v5, :cond_1

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->q(I)Lit/sephiroth/android/library/widget/HListView$a;

    move-result-object v5

    goto :goto_0

    :cond_1
    move-object v5, v6

    :goto_0
    if-eqz v5, :cond_2

    invoke-virtual {v5}, Lit/sephiroth/android/library/widget/HListView$a;->a()I

    move-result v3

    invoke-virtual {v5}, Lit/sephiroth/android/library/widget/HListView$a;->b()I

    move-result v4

    :cond_2
    const/4 v7, 0x1

    if-eqz v5, :cond_3

    const/4 v8, 0x1

    goto :goto_1

    :cond_3
    const/4 v8, 0x0

    :goto_1
    const/4 v9, -0x1

    if-eq v3, v9, :cond_6

    if-eqz v5, :cond_4

    const/4 v2, 0x1

    goto :goto_2

    :cond_4
    const/4 v2, 0x0

    :goto_2
    invoke-direct {p0, v0, p1, v3, v2}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;IIZ)V

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/HListView;->setSelectedPositionInt(I)V

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/HListView;->setNextSelectedPositionInt(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getSelectedView()Landroid/view/View;

    move-result-object v0

    iget-boolean v2, p0, Lit/sephiroth/android/library/widget/HListView;->aG:Z

    if-eqz v2, :cond_5

    if-nez v5, :cond_5

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getFocusedChild()Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_5

    invoke-virtual {v2}, Landroid/view/View;->clearFocus()V

    :cond_5
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->u()V

    move v2, v3

    const/4 v8, 0x1

    :cond_6
    if-lez v4, :cond_8

    const/16 v8, 0x21

    if-ne p1, v8, :cond_7

    goto :goto_3

    :cond_7
    neg-int v4, v4

    :goto_3
    invoke-direct {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->r(I)V

    const/4 v8, 0x1

    :cond_8
    iget-boolean p1, p0, Lit/sephiroth/android/library/widget/HListView;->aG:Z

    if-eqz p1, :cond_a

    if-nez v5, :cond_a

    if-eqz v0, :cond_a

    invoke-virtual {v0}, Landroid/view/View;->hasFocus()Z

    move-result p1

    if-eqz p1, :cond_a

    invoke-virtual {v0}, Landroid/view/View;->findFocus()Landroid/view/View;

    move-result-object p1

    invoke-direct {p0, p1, p0}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;Landroid/view/View;)Z

    move-result v4

    if-eqz v4, :cond_9

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->g(Landroid/view/View;)I

    move-result v4

    if-lez v4, :cond_a

    :cond_9
    invoke-virtual {p1}, Landroid/view/View;->clearFocus()V

    :cond_a
    if-ne v3, v9, :cond_b

    if-eqz v0, :cond_b

    invoke-direct {p0, v0, p0}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;Landroid/view/View;)Z

    move-result p1

    if-nez p1, :cond_b

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->l()V

    iput v9, p0, Lit/sephiroth/android/library/widget/HListView;->M:I

    move-object v0, v6

    :cond_b
    if-eqz v8, :cond_e

    if-eqz v0, :cond_c

    invoke-virtual {p0, v2, v0}, Lit/sephiroth/android/library/widget/HListView;->a(ILandroid/view/View;)V

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result p1

    iput p1, p0, Lit/sephiroth/android/library/widget/HListView;->J:I

    :cond_c
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->awakenScrollBars()Z

    move-result p1

    if-nez p1, :cond_d

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->invalidate()V

    :cond_d
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->b()V

    return v7

    :cond_e
    return v1
.end method

.method private p(I)I
    .locals 5

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    const/4 v1, -0x1

    const/16 v2, 0x82

    if-ne p1, v2, :cond_4

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    if-eq p1, v1, :cond_0

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_0
    move p1, v0

    :goto_0
    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v2}, Landroid/widget/ListAdapter;->getCount()I

    move-result v2

    if-lt p1, v2, :cond_1

    return v1

    :cond_1
    if-ge p1, v0, :cond_2

    move p1, v0

    :cond_2
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getLastVisiblePosition()I

    move-result v2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getAdapter()Landroid/widget/ListAdapter;

    move-result-object v3

    :goto_1
    if-gt p1, v2, :cond_9

    invoke-interface {v3, p1}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v4

    if-eqz v4, :cond_3

    sub-int v4, p1, v0

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/View;->getVisibility()I

    move-result v4

    if-nez v4, :cond_3

    return p1

    :cond_3
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    :cond_4
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result p1

    add-int/2addr p1, v0

    add-int/lit8 p1, p1, -0x1

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    if-eq v2, v1, :cond_5

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    :goto_2
    add-int/lit8 v2, v2, -0x1

    goto :goto_3

    :cond_5
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v2

    add-int/2addr v2, v0

    goto :goto_2

    :goto_3
    if-ltz v2, :cond_9

    iget-object v3, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v3}, Landroid/widget/ListAdapter;->getCount()I

    move-result v3

    if-lt v2, v3, :cond_6

    return v1

    :cond_6
    if-le v2, p1, :cond_7

    goto :goto_4

    :cond_7
    move p1, v2

    :goto_4
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getAdapter()Landroid/widget/ListAdapter;

    move-result-object v2

    :goto_5
    if-lt p1, v0, :cond_9

    invoke-interface {v2, p1}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v3

    if-eqz v3, :cond_8

    sub-int v3, p1, v0

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getVisibility()I

    move-result v3

    if-nez v3, :cond_8

    return p1

    :cond_8
    add-int/lit8 p1, p1, -0x1

    goto :goto_5

    :cond_9
    return v1
.end method

.method private q(I)Lit/sephiroth/android/library/widget/HListView$a;
    .locals 6

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getSelectedView()Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x82

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->hasFocus()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->findFocus()Landroid/view/View;

    move-result-object v0

    invoke-static {}, Landroid/view/FocusFinder;->getInstance()Landroid/view/FocusFinder;

    move-result-object v2

    invoke-virtual {v2, p0, v0, p1}, Landroid/view/FocusFinder;->findNextFocus(Landroid/view/ViewGroup;Landroid/view/View;I)Landroid/view/View;

    move-result-object v0

    goto :goto_6

    :cond_0
    const/4 v2, 0x1

    const/4 v3, 0x0

    if-ne p1, v1, :cond_4

    iget v4, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    if-lez v4, :cond_1

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    :goto_0
    iget-object v4, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->left:I

    if-eqz v2, :cond_2

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->getArrowScrollPreviewLength()I

    move-result v2

    goto :goto_1

    :cond_2
    const/4 v2, 0x0

    :goto_1
    add-int/2addr v4, v2

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v2

    if-le v2, v4, :cond_3

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v4

    :cond_3
    :goto_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    invoke-virtual {v0, v4, v3, v4, v3}, Landroid/graphics/Rect;->set(IIII)V

    goto :goto_5

    :cond_4
    iget v4, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v5

    add-int/2addr v4, v5

    sub-int/2addr v4, v2

    iget v5, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    if-ge v4, v5, :cond_5

    goto :goto_3

    :cond_5
    const/4 v2, 0x0

    :goto_3
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getWidth()I

    move-result v4

    iget-object v5, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, v5, Landroid/graphics/Rect;->right:I

    sub-int/2addr v4, v5

    if-eqz v2, :cond_6

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->getArrowScrollPreviewLength()I

    move-result v2

    goto :goto_4

    :cond_6
    const/4 v2, 0x0

    :goto_4
    sub-int/2addr v4, v2

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v2

    if-ge v2, v4, :cond_3

    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v4

    goto :goto_2

    :goto_5
    invoke-static {}, Landroid/view/FocusFinder;->getInstance()Landroid/view/FocusFinder;

    move-result-object v0

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    invoke-virtual {v0, p0, v2, p1}, Landroid/view/FocusFinder;->findNextFocusFromRect(Landroid/view/ViewGroup;Landroid/graphics/Rect;I)Landroid/view/View;

    move-result-object v0

    :goto_6
    const/4 v2, 0x0

    if-eqz v0, :cond_b

    invoke-direct {p0, v0}, Lit/sephiroth/android/library/widget/HListView;->f(Landroid/view/View;)I

    move-result v3

    iget v4, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    const/4 v5, -0x1

    if-eq v4, v5, :cond_9

    iget v4, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    if-eq v3, v4, :cond_9

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->p(I)I

    move-result v4

    if-eq v4, v5, :cond_9

    if-ne p1, v1, :cond_7

    if-lt v4, v3, :cond_8

    :cond_7
    const/16 v1, 0x21

    if-ne p1, v1, :cond_9

    if-le v4, v3, :cond_9

    :cond_8
    return-object v2

    :cond_9
    invoke-direct {p0, p1, v0, v3}, Lit/sephiroth/android/library/widget/HListView;->a(ILandroid/view/View;I)I

    move-result v1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getMaxScrollAmount()I

    move-result v4

    if-ge v1, v4, :cond_a

    invoke-virtual {v0, p1}, Landroid/view/View;->requestFocus(I)Z

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->aJ:Lit/sephiroth/android/library/widget/HListView$a;

    invoke-virtual {p1, v3, v1}, Lit/sephiroth/android/library/widget/HListView$a;->a(II)V

    :goto_7
    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->aJ:Lit/sephiroth/android/library/widget/HListView$a;

    return-object p1

    :cond_a
    invoke-direct {p0, v0}, Lit/sephiroth/android/library/widget/HListView;->g(Landroid/view/View;)I

    move-result v1

    if-ge v1, v4, :cond_b

    invoke-virtual {v0, p1}, Landroid/view/View;->requestFocus(I)Z

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->aJ:Lit/sephiroth/android/library/widget/HListView$a;

    invoke-virtual {p1, v3, v4}, Lit/sephiroth/android/library/widget/HListView$a;->a(II)V

    goto :goto_7

    :cond_b
    return-object v2
.end method

.method private r(I)V
    .locals 7

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->d(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getWidth()I

    move-result v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->right:I

    sub-int/2addr v0, v1

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->left:I

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    const/4 v3, 0x0

    if-gez p1, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result p1

    add-int/lit8 v4, p1, -0x1

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v4

    :goto_0
    invoke-virtual {v4}, Landroid/view/View;->getRight()I

    move-result v5

    if-ge v5, v0, :cond_0

    iget v5, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr v5, p1

    add-int/lit8 v5, v5, -0x1

    iget v6, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    add-int/lit8 v6, v6, -0x1

    if-ge v5, v6, :cond_0

    invoke-direct {p0, v4, v5}, Lit/sephiroth/android/library/widget/HListView;->c(Landroid/view/View;I)Landroid/view/View;

    move-result-object v4

    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {v4}, Landroid/view/View;->getBottom()I

    move-result p1

    if-ge p1, v0, :cond_1

    invoke-virtual {v4}, Landroid/view/View;->getRight()I

    move-result p1

    sub-int/2addr v0, p1

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/HListView;->d(I)V

    :cond_1
    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    :goto_1
    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result v0

    if-ge v0, v1, :cond_7

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/AbsHListView$f;

    iget v0, v0, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    invoke-virtual {v2, v0}, Lit/sephiroth/android/library/widget/AbsHListView$k;->b(I)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->detachViewFromParent(Landroid/view/View;)V

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    invoke-virtual {v2, p1, v0}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(Landroid/view/View;I)V

    goto :goto_2

    :cond_2
    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->removeViewInLayout(Landroid/view/View;)V

    :goto_2
    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    goto :goto_1

    :cond_3
    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    :goto_3
    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v3

    if-le v3, v1, :cond_4

    iget v3, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    if-lez v3, :cond_4

    iget v3, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    invoke-direct {p0, p1, v3}, Lit/sephiroth/android/library/widget/HListView;->b(Landroid/view/View;I)Landroid/view/View;

    move-result-object p1

    iget v3, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/lit8 v3, v3, -0x1

    iput v3, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    goto :goto_3

    :cond_4
    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v3

    if-le v3, v1, :cond_5

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result p1

    sub-int/2addr v1, p1

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->d(I)V

    :cond_5
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result p1

    add-int/lit8 p1, p1, -0x1

    :goto_4
    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v3

    if-le v3, v0, :cond_7

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Lit/sephiroth/android/library/widget/AbsHListView$f;

    iget v3, v3, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    invoke-virtual {v2, v3}, Lit/sephiroth/android/library/widget/AbsHListView$k;->b(I)Z

    move-result v3

    if-eqz v3, :cond_6

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->detachViewFromParent(Landroid/view/View;)V

    iget v3, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr v3, p1

    invoke-virtual {v2, v1, v3}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(Landroid/view/View;I)V

    goto :goto_5

    :cond_6
    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->removeViewInLayout(Landroid/view/View;)V

    :goto_5
    add-int/lit8 p1, p1, -0x1

    goto :goto_4

    :cond_7
    return-void
.end method

.method private y()V
    .locals 5

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v0

    if-lez v0, :cond_5

    iget-boolean v1, p0, Lit/sephiroth/android/library/widget/HListView;->K:Z

    const/4 v2, 0x0

    if-nez v1, :cond_2

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->left:I

    sub-int/2addr v0, v1

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    if-eqz v1, :cond_0

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    sub-int/2addr v0, v1

    :cond_0
    if-gez v0, :cond_1

    goto :goto_0

    :cond_1
    move v2, v0

    goto :goto_0

    :cond_2
    add-int/lit8 v1, v0, -0x1

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getRight()I

    move-result v1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getWidth()I

    move-result v3

    iget-object v4, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->right:I

    sub-int/2addr v3, v4

    sub-int/2addr v1, v3

    iget v3, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr v3, v0

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    if-ge v3, v0, :cond_3

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    add-int/2addr v1, v0

    :cond_3
    if-lez v1, :cond_4

    goto :goto_0

    :cond_4
    move v2, v1

    :goto_0
    if-eqz v2, :cond_5

    neg-int v0, v2

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/HListView;->d(I)V

    :cond_5
    return-void
.end method

.method private z()Z
    .locals 3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getScrollX()I

    move-result v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->left:I

    add-int/2addr v0, v1

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    const/4 v2, 0x0

    if-gtz v1, :cond_0

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v1

    if-le v1, v0, :cond_1

    :cond_0
    const/4 v2, 0x1

    :cond_1
    return v2
.end method


# virtual methods
.method final a(IIIII)I
    .locals 9

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    if-nez v0, :cond_0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget p1, p1, Landroid/graphics/Rect;->left:I

    iget-object p2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->right:I

    add-int/2addr p1, p2

    return p1

    :cond_0
    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->left:I

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->right:I

    add-int/2addr v1, v2

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    const/4 v3, 0x0

    if-lez v2, :cond_1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->au:Landroid/graphics/drawable/Drawable;

    if-eqz v2, :cond_1

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    :goto_0
    const/4 v4, -0x1

    if-ne p3, v4, :cond_2

    invoke-interface {v0}, Landroid/widget/ListAdapter;->getCount()I

    move-result p3

    add-int/lit8 p3, p3, -0x1

    :cond_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->x()Z

    move-result v5

    iget-object v6, p0, Lit/sephiroth/android/library/widget/HListView;->P:[Z

    :goto_1
    if-gt p2, p3, :cond_8

    invoke-virtual {p0, p2, v6}, Lit/sephiroth/android/library/widget/HListView;->a(I[Z)Landroid/view/View;

    move-result-object v7

    invoke-direct {p0, v7, p2, p1}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;II)V

    if-lez p2, :cond_3

    add-int/2addr v1, v2

    :cond_3
    if-eqz v5, :cond_4

    invoke-virtual {v7}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v8

    check-cast v8, Lit/sephiroth/android/library/widget/AbsHListView$f;

    iget v8, v8, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    invoke-virtual {v0, v8}, Lit/sephiroth/android/library/widget/AbsHListView$k;->b(I)Z

    move-result v8

    if-eqz v8, :cond_4

    invoke-virtual {v0, v7, v4}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(Landroid/view/View;I)V

    :cond_4
    invoke-virtual {v7}, Landroid/view/View;->getMeasuredWidth()I

    move-result v7

    add-int/2addr v1, v7

    if-lt v1, p4, :cond_6

    if-ltz p5, :cond_5

    if-le p2, p5, :cond_5

    if-lez v3, :cond_5

    if-eq v1, p4, :cond_5

    move p4, v3

    :cond_5
    return p4

    :cond_6
    if-ltz p5, :cond_7

    if-lt p2, p5, :cond_7

    move v3, v1

    :cond_7
    add-int/lit8 p2, p2, 0x1

    goto :goto_1

    :cond_8
    return v1
.end method

.method a(Landroid/graphics/Canvas;Landroid/graphics/Rect;I)V
    .locals 0

    iget-object p3, p0, Lit/sephiroth/android/library/widget/HListView;->au:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p3, p2}, Landroid/graphics/drawable/Drawable;->setBounds(Landroid/graphics/Rect;)V

    invoke-virtual {p3, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    return-void
.end method

.method a(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Landroid/graphics/Rect;)V
    .locals 3

    invoke-virtual {p2}, Landroid/graphics/drawable/Drawable;->getMinimumWidth()I

    move-result v0

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    invoke-virtual {p1, p3}, Landroid/graphics/Canvas;->clipRect(Landroid/graphics/Rect;)Z

    iget v1, p3, Landroid/graphics/Rect;->right:I

    iget v2, p3, Landroid/graphics/Rect;->left:I

    sub-int/2addr v1, v2

    if-ge v1, v0, :cond_0

    iget v1, p3, Landroid/graphics/Rect;->right:I

    sub-int/2addr v1, v0

    iput v1, p3, Landroid/graphics/Rect;->left:I

    :cond_0
    invoke-virtual {p2, p3}, Landroid/graphics/drawable/Drawable;->setBounds(Landroid/graphics/Rect;)V

    invoke-virtual {p2, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    return-void
.end method

.method public a(Landroid/view/View;Ljava/lang/Object;Z)V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    instance-of v0, v0, Lit/sephiroth/android/library/widget/b;

    if-nez v0, :cond_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Cannot add header view to list -- setAdapter has already been called."

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    new-instance v0, Lit/sephiroth/android/library/widget/HListView$b;

    invoke-direct {v0}, Lit/sephiroth/android/library/widget/HListView$b;-><init>()V

    iput-object p1, v0, Lit/sephiroth/android/library/widget/HListView$b;->a:Landroid/view/View;

    iput-object p2, v0, Lit/sephiroth/android/library/widget/HListView$b;->b:Ljava/lang/Object;

    iput-boolean p3, v0, Lit/sephiroth/android/library/widget/HListView$b;->c:Z

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->az:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$a;->onChanged()V

    :cond_1
    return-void
.end method

.method protected a(Z)V
    .locals 2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v0

    const/4 v1, 0x0

    if-eqz p1, :cond_1

    if-lez v0, :cond_0

    add-int/lit8 p1, v0, -0x1

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result p1

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    add-int/2addr v1, p1

    :cond_0
    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr p1, v0

    invoke-direct {p0, p1, v1}, Lit/sephiroth/android/library/widget/HListView;->f(II)Landroid/view/View;

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result p1

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->l(I)V

    return-void

    :cond_1
    if-lez v0, :cond_2

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result p1

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    sub-int/2addr p1, v0

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getWidth()I

    move-result p1

    sub-int/2addr p1, v1

    :goto_0
    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/lit8 v0, v0, -0x1

    invoke-direct {p0, v0, p1}, Lit/sephiroth/android/library/widget/HListView;->g(II)Landroid/view/View;

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result p1

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->m(I)V

    return-void
.end method

.method final a(IIIIII)[I
    .locals 18

    move-object/from16 v0, p0

    iget-object v1, v0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    const/4 v2, 0x2

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-nez v1, :cond_0

    new-array v1, v2, [I

    iget-object v2, v0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->left:I

    iget-object v5, v0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, v5, Landroid/graphics/Rect;->right:I

    add-int/2addr v2, v5

    aput v2, v1, v4

    iget-object v2, v0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->top:I

    iget-object v4, v0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v2, v4

    aput v2, v1, v3

    return-object v1

    :cond_0
    iget-object v5, v0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, v5, Landroid/graphics/Rect;->left:I

    iget-object v6, v0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v6, v6, Landroid/graphics/Rect;->right:I

    add-int/2addr v5, v6

    iget-object v6, v0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v6, v6, Landroid/graphics/Rect;->top:I

    iget-object v7, v0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v7, v7, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v6, v7

    iget v7, v0, Lit/sephiroth/android/library/widget/HListView;->av:I

    if-lez v7, :cond_1

    iget-object v7, v0, Lit/sephiroth/android/library/widget/HListView;->au:Landroid/graphics/drawable/Drawable;

    if-eqz v7, :cond_1

    iget v7, v0, Lit/sephiroth/android/library/widget/HListView;->av:I

    goto :goto_0

    :cond_1
    const/4 v7, 0x0

    :goto_0
    const/4 v8, -0x1

    move/from16 v9, p3

    if-ne v9, v8, :cond_2

    invoke-interface {v1}, Landroid/widget/ListAdapter;->getCount()I

    move-result v1

    sub-int/2addr v1, v3

    move v9, v1

    :cond_2
    iget-object v1, v0, Lit/sephiroth/android/library/widget/HListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->x()Z

    move-result v10

    iget-object v11, v0, Lit/sephiroth/android/library/widget/HListView;->P:[Z

    move/from16 v12, p2

    const/4 v13, 0x0

    const/4 v14, 0x0

    :goto_1
    if-gt v12, v9, :cond_4

    invoke-virtual {v0, v12, v11}, Lit/sephiroth/android/library/widget/HListView;->a(I[Z)Landroid/view/View;

    move-result-object v15

    move/from16 v3, p1

    invoke-direct {v0, v15, v12, v3}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;II)V

    if-eqz v10, :cond_3

    invoke-virtual {v15}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v16

    move-object/from16 v4, v16

    check-cast v4, Lit/sephiroth/android/library/widget/AbsHListView$f;

    iget v4, v4, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    invoke-virtual {v1, v4}, Lit/sephiroth/android/library/widget/AbsHListView$k;->b(I)Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-virtual {v1, v15, v8}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(Landroid/view/View;I)V

    :cond_3
    invoke-virtual {v15}, Landroid/view/View;->getMeasuredWidth()I

    move-result v4

    add-int/2addr v4, v7

    invoke-static {v13, v4}, Ljava/lang/Math;->max(II)I

    move-result v13

    invoke-virtual {v15}, Landroid/view/View;->getMeasuredHeight()I

    move-result v4

    invoke-static {v14, v4}, Ljava/lang/Math;->max(II)I

    move-result v14

    add-int/lit8 v12, v12, 0x1

    const/4 v3, 0x1

    const/4 v4, 0x0

    goto :goto_1

    :cond_4
    add-int/2addr v5, v13

    add-int/2addr v6, v14

    new-array v1, v2, [I

    move/from16 v2, p4

    invoke-static {v5, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    const/4 v3, 0x0

    aput v2, v1, v3

    move/from16 v2, p5

    invoke-static {v6, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    const/4 v3, 0x1

    aput v2, v1, v3

    return-object v1
.end method

.method protected b(IZ)I
    .locals 4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    const/4 v1, -0x1

    if-eqz v0, :cond_7

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->isInTouchMode()Z

    move-result v2

    if-eqz v2, :cond_0

    return v1

    :cond_0
    invoke-interface {v0}, Landroid/widget/ListAdapter;->getCount()I

    move-result v2

    iget-boolean v3, p0, Lit/sephiroth/android/library/widget/HListView;->aF:Z

    if-nez v3, :cond_5

    if-eqz p2, :cond_1

    const/4 p2, 0x0

    invoke-static {p2, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    :goto_0
    if-ge p1, v2, :cond_2

    invoke-interface {v0, p1}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result p2

    if-nez p2, :cond_2

    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_1
    add-int/lit8 p2, v2, -0x1

    invoke-static {p1, p2}, Ljava/lang/Math;->min(II)I

    move-result p1

    :goto_1
    if-ltz p1, :cond_2

    invoke-interface {v0, p1}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result p2

    if-nez p2, :cond_2

    add-int/lit8 p1, p1, -0x1

    goto :goto_1

    :cond_2
    if-ltz p1, :cond_4

    if-lt p1, v2, :cond_3

    return v1

    :cond_3
    return p1

    :cond_4
    return v1

    :cond_5
    if-ltz p1, :cond_7

    if-lt p1, v2, :cond_6

    return v1

    :cond_6
    return p1

    :cond_7
    return v1
.end method

.method b(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Landroid/graphics/Rect;)V
    .locals 3

    invoke-virtual {p2}, Landroid/graphics/drawable/Drawable;->getMinimumWidth()I

    move-result v0

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    invoke-virtual {p1, p3}, Landroid/graphics/Canvas;->clipRect(Landroid/graphics/Rect;)Z

    iget v1, p3, Landroid/graphics/Rect;->right:I

    iget v2, p3, Landroid/graphics/Rect;->left:I

    sub-int/2addr v1, v2

    if-ge v1, v0, :cond_0

    iget v1, p3, Landroid/graphics/Rect;->left:I

    add-int/2addr v1, v0

    iput v1, p3, Landroid/graphics/Rect;->right:I

    :cond_0
    invoke-virtual {p2, p3}, Landroid/graphics/drawable/Drawable;->setBounds(Landroid/graphics/Rect;)V

    invoke-virtual {p2, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    return-void
.end method

.method public b(Landroid/view/View;)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-virtual {p0, p1, v0, v1}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;Ljava/lang/Object;Z)V

    return-void
.end method

.method public c(I)V
    .locals 0

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->c(I)V

    return-void
.end method

.method protected canAnimate()Z
    .locals 1

    invoke-super {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->canAnimate()Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    if-lez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method protected d()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->az:Ljava/util/ArrayList;

    invoke-direct {p0, v0}, Lit/sephiroth/android/library/widget/HListView;->a(Ljava/util/ArrayList;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aA:Ljava/util/ArrayList;

    invoke-direct {p0, v0}, Lit/sephiroth/android/library/widget/HListView;->a(Ljava/util/ArrayList;)V

    invoke-super {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->d()V

    const/4 v0, 0x0

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->h:I

    return-void
.end method

.method protected dispatchDraw(Landroid/graphics/Canvas;)V
    .locals 30

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    iget-boolean v2, v0, Lit/sephiroth/android/library/widget/HListView;->y:Z

    const/4 v3, 0x1

    if-eqz v2, :cond_0

    iput-boolean v3, v0, Lit/sephiroth/android/library/widget/HListView;->z:Z

    :cond_0
    iget v2, v0, Lit/sephiroth/android/library/widget/HListView;->av:I

    iget-object v4, v0, Lit/sephiroth/android/library/widget/HListView;->ax:Landroid/graphics/drawable/Drawable;

    iget-object v5, v0, Lit/sephiroth/android/library/widget/HListView;->ay:Landroid/graphics/drawable/Drawable;

    if-eqz v4, :cond_1

    const/4 v7, 0x1

    goto :goto_0

    :cond_1
    const/4 v7, 0x0

    :goto_0
    if-eqz v5, :cond_2

    const/4 v8, 0x1

    goto :goto_1

    :cond_2
    const/4 v8, 0x0

    :goto_1
    if-lez v2, :cond_3

    iget-object v9, v0, Lit/sephiroth/android/library/widget/HListView;->au:Landroid/graphics/drawable/Drawable;

    if-eqz v9, :cond_3

    const/4 v9, 0x1

    goto :goto_2

    :cond_3
    const/4 v9, 0x0

    :goto_2
    if-nez v9, :cond_4

    if-nez v7, :cond_4

    if-eqz v8, :cond_20

    :cond_4
    iget-object v10, v0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getPaddingTop()I

    move-result v11

    iput v11, v10, Landroid/graphics/Rect;->top:I

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getBottom()I

    move-result v11

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getTop()I

    move-result v12

    sub-int/2addr v11, v12

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getPaddingBottom()I

    move-result v12

    sub-int/2addr v11, v12

    iput v11, v10, Landroid/graphics/Rect;->bottom:I

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v11

    iget-object v12, v0, Lit/sephiroth/android/library/widget/HListView;->az:Ljava/util/ArrayList;

    invoke-virtual {v12}, Ljava/util/ArrayList;->size()I

    move-result v12

    iget v13, v0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    iget-object v14, v0, Lit/sephiroth/android/library/widget/HListView;->aA:Ljava/util/ArrayList;

    invoke-virtual {v14}, Ljava/util/ArrayList;->size()I

    move-result v14

    sub-int v14, v13, v14

    sub-int/2addr v14, v3

    iget-boolean v15, v0, Lit/sephiroth/android/library/widget/HListView;->aD:Z

    iget-boolean v3, v0, Lit/sephiroth/android/library/widget/HListView;->aE:Z

    iget v6, v0, Lit/sephiroth/android/library/widget/HListView;->V:I

    move-object/from16 v18, v5

    iget-boolean v5, v0, Lit/sephiroth/android/library/widget/HListView;->aF:Z

    move/from16 v19, v13

    iget-object v13, v0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->isOpaque()Z

    move-result v20

    if-eqz v20, :cond_5

    invoke-super/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isOpaque()Z

    move-result v20

    if-nez v20, :cond_5

    const/16 v16, 0x1

    goto :goto_3

    :cond_5
    const/16 v16, 0x0

    :goto_3
    if-eqz v16, :cond_7

    move-object/from16 v21, v13

    iget-object v13, v0, Lit/sephiroth/android/library/widget/HListView;->aI:Landroid/graphics/Paint;

    if-nez v13, :cond_6

    iget-boolean v13, v0, Lit/sephiroth/android/library/widget/HListView;->aB:Z

    if-eqz v13, :cond_6

    new-instance v13, Landroid/graphics/Paint;

    invoke-direct {v13}, Landroid/graphics/Paint;-><init>()V

    iput-object v13, v0, Lit/sephiroth/android/library/widget/HListView;->aI:Landroid/graphics/Paint;

    iget-object v13, v0, Lit/sephiroth/android/library/widget/HListView;->aI:Landroid/graphics/Paint;

    move/from16 v22, v5

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getCacheColorHint()I

    move-result v5

    invoke-virtual {v13, v5}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_4

    :cond_6
    move/from16 v22, v5

    goto :goto_4

    :cond_7
    move/from16 v22, v5

    move-object/from16 v21, v13

    :goto_4
    iget-object v5, v0, Lit/sephiroth/android/library/widget/HListView;->aI:Landroid/graphics/Paint;

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getRight()I

    move-result v13

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getLeft()I

    move-result v20

    sub-int v13, v13, v20

    move-object/from16 v23, v5

    const/4 v5, 0x0

    sub-int/2addr v13, v5

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getScrollX()I

    move-result v17

    add-int v13, v13, v17

    iget-boolean v5, v0, Lit/sephiroth/android/library/widget/HListView;->K:Z

    move/from16 v24, v8

    const/4 v8, -0x1

    if-nez v5, :cond_14

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getScrollX()I

    move-result v5

    if-lez v11, :cond_9

    if-gez v5, :cond_9

    if-eqz v7, :cond_8

    const/4 v7, 0x0

    iput v7, v10, Landroid/graphics/Rect;->right:I

    iput v5, v10, Landroid/graphics/Rect;->left:I

    invoke-virtual {v0, v1, v4, v10}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Landroid/graphics/Rect;)V

    goto :goto_5

    :cond_8
    const/4 v7, 0x0

    if-eqz v9, :cond_9

    iput v7, v10, Landroid/graphics/Rect;->right:I

    neg-int v4, v2

    iput v4, v10, Landroid/graphics/Rect;->left:I

    invoke-virtual {v0, v1, v10, v8}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/graphics/Canvas;Landroid/graphics/Rect;I)V

    :cond_9
    :goto_5
    const/4 v4, 0x0

    const/4 v5, 0x0

    :goto_6
    if-ge v4, v11, :cond_13

    if-nez v15, :cond_a

    add-int v7, v6, v4

    if-lt v7, v12, :cond_b

    :cond_a
    if-nez v3, :cond_d

    add-int v7, v6, v4

    if-ge v7, v14, :cond_b

    goto :goto_7

    :cond_b
    move/from16 v25, v13

    move-object/from16 v8, v21

    :cond_c
    move-object/from16 v13, v23

    goto :goto_9

    :cond_d
    :goto_7
    invoke-virtual {v0, v4}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v5

    invoke-virtual {v5}, Landroid/view/View;->getRight()I

    move-result v5

    if-eqz v9, :cond_b

    if-ge v5, v13, :cond_b

    if-eqz v24, :cond_e

    add-int/lit8 v7, v11, -0x1

    if-eq v4, v7, :cond_b

    :cond_e
    if-nez v22, :cond_11

    add-int v7, v6, v4

    move-object/from16 v8, v21

    invoke-interface {v8, v7}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v17

    if-eqz v17, :cond_f

    move/from16 v25, v13

    add-int/lit8 v13, v11, -0x1

    if-eq v4, v13, :cond_12

    add-int/lit8 v7, v7, 0x1

    invoke-interface {v8, v7}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v7

    if-eqz v7, :cond_10

    goto :goto_8

    :cond_f
    move/from16 v25, v13

    :cond_10
    if-eqz v16, :cond_c

    iput v5, v10, Landroid/graphics/Rect;->left:I

    add-int v7, v5, v2

    iput v7, v10, Landroid/graphics/Rect;->right:I

    move-object/from16 v13, v23

    invoke-virtual {v1, v10, v13}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    goto :goto_9

    :cond_11
    move/from16 v25, v13

    move-object/from16 v8, v21

    :cond_12
    :goto_8
    move-object/from16 v13, v23

    iput v5, v10, Landroid/graphics/Rect;->left:I

    add-int v7, v5, v2

    iput v7, v10, Landroid/graphics/Rect;->right:I

    invoke-virtual {v0, v1, v10, v4}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/graphics/Canvas;Landroid/graphics/Rect;I)V

    :goto_9
    add-int/lit8 v4, v4, 0x1

    move-object/from16 v21, v8

    move-object/from16 v23, v13

    move/from16 v13, v25

    goto :goto_6

    :cond_13
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getRight()I

    move-result v2

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getScrollX()I

    move-result v3

    add-int/2addr v2, v3

    if-eqz v24, :cond_20

    add-int/2addr v6, v11

    move/from16 v3, v19

    if-ne v6, v3, :cond_20

    if-le v2, v5, :cond_20

    iput v5, v10, Landroid/graphics/Rect;->left:I

    iput v2, v10, Landroid/graphics/Rect;->right:I

    move-object/from16 v5, v18

    goto/16 :goto_f

    :cond_14
    move/from16 v26, v9

    move/from16 v25, v13

    move-object/from16 v5, v18

    move-object/from16 v8, v21

    move-object/from16 v13, v23

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getScrollX()I

    move-result v9

    if-lez v11, :cond_15

    if-eqz v7, :cond_15

    iput v9, v10, Landroid/graphics/Rect;->left:I

    move/from16 v27, v7

    const/4 v7, 0x0

    invoke-virtual {v0, v7}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v7

    invoke-virtual {v7}, Landroid/view/View;->getLeft()I

    move-result v7

    iput v7, v10, Landroid/graphics/Rect;->right:I

    invoke-virtual {v0, v1, v4, v10}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Landroid/graphics/Rect;)V

    goto :goto_a

    :cond_15
    move/from16 v27, v7

    :goto_a
    move/from16 v4, v27

    :goto_b
    if-ge v4, v11, :cond_1e

    if-nez v15, :cond_17

    add-int v7, v6, v4

    if-lt v7, v12, :cond_16

    goto :goto_c

    :cond_16
    move/from16 v28, v3

    move/from16 v29, v6

    goto :goto_e

    :cond_17
    :goto_c
    if-nez v3, :cond_18

    add-int v7, v6, v4

    if-ge v7, v14, :cond_16

    :cond_18
    invoke-virtual {v0, v4}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v7

    invoke-virtual {v7}, Landroid/view/View;->getLeft()I

    move-result v7

    if-lez v7, :cond_16

    if-nez v22, :cond_1b

    move/from16 v28, v3

    add-int v3, v6, v4

    invoke-interface {v8, v3}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v17

    if-eqz v17, :cond_19

    move/from16 v29, v6

    add-int/lit8 v6, v11, -0x1

    if-eq v4, v6, :cond_1c

    add-int/lit8 v3, v3, 0x1

    invoke-interface {v8, v3}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v3

    if-eqz v3, :cond_1a

    goto :goto_d

    :cond_19
    move/from16 v29, v6

    :cond_1a
    if-eqz v16, :cond_1d

    sub-int v3, v7, v2

    iput v3, v10, Landroid/graphics/Rect;->left:I

    iput v7, v10, Landroid/graphics/Rect;->right:I

    invoke-virtual {v1, v10, v13}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    goto :goto_e

    :cond_1b
    move/from16 v28, v3

    move/from16 v29, v6

    :cond_1c
    :goto_d
    sub-int v3, v7, v2

    iput v3, v10, Landroid/graphics/Rect;->left:I

    iput v7, v10, Landroid/graphics/Rect;->right:I

    add-int/lit8 v3, v4, -0x1

    invoke-virtual {v0, v1, v10, v3}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/graphics/Canvas;Landroid/graphics/Rect;I)V

    :cond_1d
    :goto_e
    add-int/lit8 v4, v4, 0x1

    move/from16 v3, v28

    move/from16 v6, v29

    goto :goto_b

    :cond_1e
    if-lez v11, :cond_20

    if-lez v9, :cond_20

    if-eqz v24, :cond_1f

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getRight()I

    move-result v2

    iput v2, v10, Landroid/graphics/Rect;->left:I

    add-int/2addr v2, v9

    iput v2, v10, Landroid/graphics/Rect;->right:I

    :goto_f
    invoke-virtual {v0, v1, v5, v10}, Lit/sephiroth/android/library/widget/HListView;->b(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Landroid/graphics/Rect;)V

    goto :goto_10

    :cond_1f
    if-eqz v26, :cond_20

    move/from16 v13, v25

    iput v13, v10, Landroid/graphics/Rect;->left:I

    add-int/2addr v13, v2

    iput v13, v10, Landroid/graphics/Rect;->right:I

    const/4 v2, -0x1

    invoke-virtual {v0, v1, v10, v2}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/graphics/Canvas;Landroid/graphics/Rect;I)V

    :cond_20
    :goto_10
    invoke-super/range {p0 .. p1}, Lit/sephiroth/android/library/widget/AbsHListView;->dispatchDraw(Landroid/graphics/Canvas;)V

    return-void
.end method

.method public dispatchKeyEvent(Landroid/view/KeyEvent;)Z
    .locals 2

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->dispatchKeyEvent(Landroid/view/KeyEvent;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getFocusedChild()Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {p1}, Landroid/view/KeyEvent;->getAction()I

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p1}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v0

    invoke-virtual {p0, v0, p1}, Lit/sephiroth/android/library/widget/HListView;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    :cond_0
    return v0
.end method

.method protected drawChild(Landroid/graphics/Canvas;Landroid/view/View;J)Z
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lit/sephiroth/android/library/widget/AbsHListView;->drawChild(Landroid/graphics/Canvas;Landroid/view/View;J)Z

    move-result p1

    iget-boolean p2, p0, Lit/sephiroth/android/library/widget/HListView;->z:Z

    if-eqz p2, :cond_0

    const/4 p2, 0x0

    iput-boolean p2, p0, Lit/sephiroth/android/library/widget/HListView;->z:Z

    :cond_0
    return p1
.end method

.method protected e(I)I
    .locals 3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v0

    if-lez v0, :cond_3

    iget-boolean v1, p0, Lit/sephiroth/android/library/widget/HListView;->K:Z

    if-nez v1, :cond_1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_3

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getRight()I

    move-result v2

    if-gt p1, v2, :cond_0

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr p1, v1

    return p1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    add-int/lit8 v0, v0, -0x1

    :goto_1
    if-ltz v0, :cond_3

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v1

    if-lt p1, v1, :cond_2

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr p1, v0

    return p1

    :cond_2
    add-int/lit8 v0, v0, -0x1

    goto :goto_1

    :cond_3
    const/4 p1, -0x1

    return p1
.end method

.method protected e()V
    .locals 18

    move-object/from16 v7, p0

    iget-boolean v8, v7, Lit/sephiroth/android/library/widget/HListView;->at:Z

    if-nez v8, :cond_24

    const/4 v9, 0x1

    iput-boolean v9, v7, Lit/sephiroth/android/library/widget/HListView;->at:Z

    const/4 v10, 0x0

    :try_start_0
    invoke-super/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->e()V

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->invalidate()V

    iget-object v1, v7, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    if-nez v1, :cond_1

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->d()V

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->b()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v8, :cond_0

    iput-boolean v10, v7, Lit/sephiroth/android/library/widget/HListView;->at:Z

    :cond_0
    return-void

    :cond_1
    :try_start_1
    iget-object v1, v7, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v5, v1, Landroid/graphics/Rect;->left:I

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getRight()I

    move-result v1

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getLeft()I

    move-result v2

    sub-int/2addr v1, v2

    iget-object v2, v7, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->right:I

    sub-int v6, v1, v2

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v1

    iget v2, v7, Lit/sephiroth/android/library/widget/HListView;->h:I

    packed-switch v2, :pswitch_data_0

    iget v2, v7, Lit/sephiroth/android/library/widget/HListView;->am:I

    goto :goto_1

    :pswitch_0
    iget v2, v7, Lit/sephiroth/android/library/widget/HListView;->ak:I

    iget v3, v7, Lit/sephiroth/android/library/widget/HListView;->V:I

    sub-int/2addr v2, v3

    if-ltz v2, :cond_2

    if-ge v2, v1, :cond_2

    invoke-virtual {v7, v2}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    move-object v3, v2

    const/4 v2, 0x0

    goto :goto_0

    :cond_2
    :pswitch_1
    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    const/4 v4, 0x0

    const/4 v12, 0x0

    goto :goto_4

    :goto_1
    iget v3, v7, Lit/sephiroth/android/library/widget/HListView;->V:I

    sub-int/2addr v2, v3

    if-ltz v2, :cond_3

    if-ge v2, v1, :cond_3

    invoke-virtual {v7, v2}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    goto :goto_2

    :cond_3
    const/4 v3, 0x0

    :goto_2
    invoke-virtual {v7, v10}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v4

    iget v12, v7, Lit/sephiroth/android/library/widget/HListView;->ak:I

    if-ltz v12, :cond_4

    iget v12, v7, Lit/sephiroth/android/library/widget/HListView;->ak:I

    iget v13, v7, Lit/sephiroth/android/library/widget/HListView;->am:I

    sub-int/2addr v12, v13

    goto :goto_3

    :cond_4
    const/4 v12, 0x0

    :goto_3
    add-int/2addr v2, v12

    invoke-virtual {v7, v2}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    move-object/from16 v16, v3

    move-object v3, v2

    move-object/from16 v2, v16

    move/from16 v17, v12

    move-object v12, v4

    move/from16 v4, v17

    :goto_4
    iget-boolean v13, v7, Lit/sephiroth/android/library/widget/HListView;->aj:Z

    if-eqz v13, :cond_5

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->q()V

    :cond_5
    iget v14, v7, Lit/sephiroth/android/library/widget/HListView;->ao:I

    if-nez v14, :cond_7

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->d()V

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->b()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez v8, :cond_6

    iput-boolean v10, v7, Lit/sephiroth/android/library/widget/HListView;->at:Z

    :cond_6
    return-void

    :cond_7
    :try_start_2
    iget v14, v7, Lit/sephiroth/android/library/widget/HListView;->ao:I

    iget-object v15, v7, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v15}, Landroid/widget/ListAdapter;->getCount()I

    move-result v15

    if-eq v14, v15, :cond_8

    new-instance v1, Ljava/lang/IllegalStateException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "The content of the adapter has changed but ListView did not receive a notification. Make sure the content of your adapter is not modified from a background thread, but only from the UI thread. [in ListView("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getId()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, ", "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual/range {p0 .. p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v3, ") with Adapter("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, v7, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v3, ")]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_8
    iget v14, v7, Lit/sephiroth/android/library/widget/HListView;->ak:I

    invoke-virtual {v7, v14}, Lit/sephiroth/android/library/widget/HListView;->setSelectedPositionInt(I)V

    iget v14, v7, Lit/sephiroth/android/library/widget/HListView;->V:I

    iget-object v15, v7, Lit/sephiroth/android/library/widget/HListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    if-eqz v13, :cond_9

    const/4 v11, 0x0

    :goto_5
    if-ge v11, v1, :cond_a

    invoke-virtual {v7, v11}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v10

    add-int v9, v14, v11

    invoke-virtual {v15, v10, v9}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(Landroid/view/View;I)V

    add-int/lit8 v11, v11, 0x1

    const/4 v9, 0x1

    const/4 v10, 0x0

    goto :goto_5

    :cond_9
    invoke-virtual {v15, v1, v14}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(II)V

    :cond_a
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getFocusedChild()Landroid/view/View;

    move-result-object v9

    if-eqz v9, :cond_e

    if-eqz v13, :cond_c

    invoke-direct {v7, v9}, Lit/sephiroth/android/library/widget/HListView;->c(Landroid/view/View;)Z

    move-result v10

    if-eqz v10, :cond_b

    goto :goto_6

    :cond_b
    const/4 v10, 0x0

    const/4 v11, 0x0

    goto :goto_7

    :cond_c
    :goto_6
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->findFocus()Landroid/view/View;

    move-result-object v10

    if-eqz v10, :cond_d

    invoke-virtual {v10}, Landroid/view/View;->onStartTemporaryDetach()V

    :cond_d
    move-object v11, v9

    :goto_7
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->requestFocus()Z

    goto :goto_8

    :cond_e
    const/4 v10, 0x0

    const/4 v11, 0x0

    :goto_8
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->detachAllViewsFromParent()V

    invoke-virtual {v15}, Lit/sephiroth/android/library/widget/AbsHListView$k;->d()V

    iget v9, v7, Lit/sephiroth/android/library/widget/HListView;->h:I

    packed-switch v9, :pswitch_data_1

    if-nez v1, :cond_11

    iget-boolean v1, v7, Lit/sephiroth/android/library/widget/HListView;->K:Z

    goto :goto_c

    :pswitch_2
    move-object v1, v7

    invoke-direct/range {v1 .. v6}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;Landroid/view/View;III)Landroid/view/View;

    move-result-object v1

    :goto_9
    const/4 v3, 0x1

    goto/16 :goto_e

    :pswitch_3
    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->aa:I

    iget v2, v7, Lit/sephiroth/android/library/widget/HListView;->W:I

    :goto_a
    invoke-direct {v7, v1, v2}, Lit/sephiroth/android/library/widget/HListView;->i(II)Landroid/view/View;

    move-result-object v1

    goto :goto_9

    :pswitch_4
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->m()I

    move-result v1

    iget v2, v7, Lit/sephiroth/android/library/widget/HListView;->W:I

    goto :goto_a

    :pswitch_5
    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->ao:I

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    invoke-direct {v7, v1, v6}, Lit/sephiroth/android/library/widget/HListView;->g(II)Landroid/view/View;

    move-result-object v1

    :goto_b
    invoke-direct/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->y()V

    goto :goto_9

    :pswitch_6
    if-eqz v3, :cond_f

    invoke-virtual {v3}, Landroid/view/View;->getLeft()I

    move-result v1

    invoke-direct {v7, v1, v5, v6}, Lit/sephiroth/android/library/widget/HListView;->a(III)Landroid/view/View;

    move-result-object v1

    goto :goto_9

    :cond_f
    invoke-direct {v7, v5, v6}, Lit/sephiroth/android/library/widget/HListView;->h(II)Landroid/view/View;

    move-result-object v1

    goto :goto_9

    :pswitch_7
    const/4 v1, 0x0

    iput v1, v7, Lit/sephiroth/android/library/widget/HListView;->V:I

    invoke-direct {v7, v5}, Lit/sephiroth/android/library/widget/HListView;->k(I)Landroid/view/View;

    move-result-object v1

    goto :goto_b

    :goto_c
    if-nez v1, :cond_10

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v7, v1, v2}, Lit/sephiroth/android/library/widget/HListView;->b(IZ)I

    move-result v3

    invoke-virtual {v7, v3}, Lit/sephiroth/android/library/widget/HListView;->setSelectedPositionInt(I)V

    invoke-direct {v7, v5}, Lit/sephiroth/android/library/widget/HListView;->k(I)Landroid/view/View;

    move-result-object v1

    goto :goto_9

    :cond_10
    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->ao:I

    const/4 v3, 0x1

    sub-int/2addr v1, v3

    const/4 v2, 0x0

    invoke-virtual {v7, v1, v2}, Lit/sephiroth/android/library/widget/HListView;->b(IZ)I

    move-result v1

    invoke-virtual {v7, v1}, Lit/sephiroth/android/library/widget/HListView;->setSelectedPositionInt(I)V

    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->ao:I

    sub-int/2addr v1, v3

    invoke-direct {v7, v1, v6}, Lit/sephiroth/android/library/widget/HListView;->g(II)Landroid/view/View;

    move-result-object v1

    goto :goto_e

    :cond_11
    const/4 v3, 0x1

    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->am:I

    if-ltz v1, :cond_13

    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->am:I

    iget v4, v7, Lit/sephiroth/android/library/widget/HListView;->ao:I

    if-ge v1, v4, :cond_13

    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->am:I

    if-nez v2, :cond_12

    goto :goto_d

    :cond_12
    invoke-virtual {v2}, Landroid/view/View;->getLeft()I

    move-result v5

    :goto_d
    invoke-direct {v7, v1, v5}, Lit/sephiroth/android/library/widget/HListView;->i(II)Landroid/view/View;

    move-result-object v1

    goto :goto_e

    :cond_13
    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->V:I

    iget v2, v7, Lit/sephiroth/android/library/widget/HListView;->ao:I

    if-ge v1, v2, :cond_15

    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->V:I

    if-nez v12, :cond_14

    goto :goto_d

    :cond_14
    invoke-virtual {v12}, Landroid/view/View;->getLeft()I

    move-result v5

    goto :goto_d

    :cond_15
    const/4 v1, 0x0

    invoke-direct {v7, v1, v5}, Lit/sephiroth/android/library/widget/HListView;->i(II)Landroid/view/View;

    move-result-object v2

    move-object v1, v2

    :goto_e
    invoke-virtual {v15}, Lit/sephiroth/android/library/widget/AbsHListView$k;->e()V

    if-eqz v1, :cond_1b

    iget-boolean v2, v7, Lit/sephiroth/android/library/widget/HListView;->aG:Z

    const/4 v4, -0x1

    if-eqz v2, :cond_19

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->hasFocus()Z

    move-result v2

    if-eqz v2, :cond_19

    invoke-virtual {v1}, Landroid/view/View;->hasFocus()Z

    move-result v2

    if-nez v2, :cond_19

    if-ne v1, v11, :cond_16

    if-eqz v10, :cond_16

    invoke-virtual {v10}, Landroid/view/View;->requestFocus()Z

    move-result v2

    if-nez v2, :cond_18

    :cond_16
    invoke-virtual {v1}, Landroid/view/View;->requestFocus()Z

    move-result v2

    if-eqz v2, :cond_17

    goto :goto_f

    :cond_17
    const/4 v3, 0x0

    :cond_18
    :goto_f
    if-nez v3, :cond_1a

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->getFocusedChild()Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_19

    invoke-virtual {v2}, Landroid/view/View;->clearFocus()V

    :cond_19
    invoke-virtual {v7, v4, v1}, Lit/sephiroth/android/library/widget/HListView;->a(ILandroid/view/View;)V

    goto :goto_10

    :cond_1a
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/view/View;->setSelected(Z)V

    iget-object v2, v7, Lit/sephiroth/android/library/widget/HListView;->o:Landroid/graphics/Rect;

    invoke-virtual {v2}, Landroid/graphics/Rect;->setEmpty()V

    :goto_10
    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v1

    iput v1, v7, Lit/sephiroth/android/library/widget/HListView;->J:I

    goto :goto_12

    :cond_1b
    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->F:I

    if-lez v1, :cond_1c

    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->F:I

    const/4 v2, 0x3

    if-ge v1, v2, :cond_1c

    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->A:I

    iget v2, v7, Lit/sephiroth/android/library/widget/HListView;->V:I

    sub-int/2addr v1, v2

    invoke-virtual {v7, v1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_1d

    iget v2, v7, Lit/sephiroth/android/library/widget/HListView;->A:I

    invoke-virtual {v7, v2, v1}, Lit/sephiroth/android/library/widget/HListView;->a(ILandroid/view/View;)V

    goto :goto_11

    :cond_1c
    const/4 v1, 0x0

    iput v1, v7, Lit/sephiroth/android/library/widget/HListView;->J:I

    iget-object v1, v7, Lit/sephiroth/android/library/widget/HListView;->o:Landroid/graphics/Rect;

    invoke-virtual {v1}, Landroid/graphics/Rect;->setEmpty()V

    :cond_1d
    :goto_11
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->hasFocus()Z

    move-result v1

    if-eqz v1, :cond_1e

    if-eqz v10, :cond_1e

    invoke-virtual {v10}, Landroid/view/View;->requestFocus()Z

    :cond_1e
    :goto_12
    if-eqz v10, :cond_1f

    invoke-virtual {v10}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v1

    if-eqz v1, :cond_1f

    invoke-virtual {v10}, Landroid/view/View;->onFinishTemporaryDetach()V

    :cond_1f
    const/4 v1, 0x0

    iput v1, v7, Lit/sephiroth/android/library/widget/HListView;->h:I

    iput-boolean v1, v7, Lit/sephiroth/android/library/widget/HListView;->aj:Z

    iget-object v1, v7, Lit/sephiroth/android/library/widget/HListView;->O:Ljava/lang/Runnable;

    if-eqz v1, :cond_20

    iget-object v1, v7, Lit/sephiroth/android/library/widget/HListView;->O:Ljava/lang/Runnable;

    invoke-virtual {v7, v1}, Lit/sephiroth/android/library/widget/HListView;->post(Ljava/lang/Runnable;)Z

    const/4 v1, 0x0

    iput-object v1, v7, Lit/sephiroth/android/library/widget/HListView;->O:Ljava/lang/Runnable;

    :cond_20
    const/4 v1, 0x0

    iput-boolean v1, v7, Lit/sephiroth/android/library/widget/HListView;->ad:Z

    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->am:I

    invoke-virtual {v7, v1}, Lit/sephiroth/android/library/widget/HListView;->setNextSelectedPositionInt(I)V

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->f()V

    iget v1, v7, Lit/sephiroth/android/library/widget/HListView;->ao:I

    if-lez v1, :cond_21

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->u()V

    :cond_21
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/HListView;->b()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-nez v8, :cond_22

    const/4 v1, 0x0

    iput-boolean v1, v7, Lit/sephiroth/android/library/widget/HListView;->at:Z

    :cond_22
    return-void

    :catchall_0
    move-exception v0

    move-object v1, v0

    if-nez v8, :cond_23

    const/4 v2, 0x0

    iput-boolean v2, v7, Lit/sephiroth/android/library/widget/HListView;->at:Z

    :cond_23
    throw v1

    :cond_24
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
        :pswitch_1
        :pswitch_1
        :pswitch_1
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method public e(II)V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->isInTouchMode()Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lit/sephiroth/android/library/widget/HListView;->b(IZ)I

    move-result p1

    if-ltz p1, :cond_2

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->setNextSelectedPositionInt(I)V

    goto :goto_0

    :cond_1
    iput p1, p0, Lit/sephiroth/android/library/widget/HListView;->M:I

    :cond_2
    :goto_0
    if-ltz p1, :cond_5

    const/4 v0, 0x4

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->h:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    add-int/2addr v0, p2

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->W:I

    iget-boolean p2, p0, Lit/sephiroth/android/library/widget/HListView;->ad:Z

    if-eqz p2, :cond_3

    iput p1, p0, Lit/sephiroth/android/library/widget/HListView;->aa:I

    iget-object p2, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {p2, p1}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide p1

    iput-wide p1, p0, Lit/sephiroth/android/library/widget/HListView;->ab:J

    :cond_3
    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    :cond_4
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->requestLayout()V

    :cond_5
    return-void
.end method

.method public bridge synthetic getAdapter()Landroid/widget/Adapter;
    .locals 1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getAdapter()Landroid/widget/ListAdapter;

    move-result-object v0

    return-object v0
.end method

.method public getAdapter()Landroid/widget/ListAdapter;
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    return-object v0
.end method

.method public getCheckItemIds()[J
    .locals 10
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v0}, Landroid/widget/ListAdapter;->hasStableIds()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getCheckedItemIds()[J

    move-result-object v0

    return-object v0

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->b:I

    const/4 v1, 0x0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0}, Landroid/support/v4/util/SparseArrayCompat;->size()I

    move-result v2

    new-array v3, v2, [J

    iget-object v4, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    const/4 v5, 0x0

    const/4 v6, 0x0

    :goto_0
    if-ge v5, v2, :cond_2

    invoke-virtual {v0, v5}, Landroid/support/v4/util/SparseArrayCompat;->valueAt(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Boolean;

    invoke-virtual {v7}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v7

    if-eqz v7, :cond_1

    add-int/lit8 v7, v6, 0x1

    invoke-virtual {v0, v5}, Landroid/support/v4/util/SparseArrayCompat;->keyAt(I)I

    move-result v8

    invoke-interface {v4, v8}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v8

    aput-wide v8, v3, v6

    move v6, v7

    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_2
    if-ne v6, v2, :cond_3

    return-object v3

    :cond_3
    new-array v0, v6, [J

    invoke-static {v3, v1, v0, v1, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v0

    :cond_4
    new-array v0, v1, [J

    return-object v0
.end method

.method public getDivider()Landroid/graphics/drawable/Drawable;
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->au:Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method public getDividerWidth()I
    .locals 1

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    return v0
.end method

.method public getFooterViewsCount()I
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aA:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public getHeaderViewsCount()I
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->az:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public getItemsCanFocus()Z
    .locals 1

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->aG:Z

    return v0
.end method

.method public getMaxScrollAmount()I
    .locals 2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getRight()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getLeft()I

    move-result v1

    sub-int/2addr v0, v1

    int-to-float v0, v0

    const v1, 0x3ea8f5c3    # 0.33f

    mul-float v0, v0, v1

    float-to-int v0, v0

    return v0
.end method

.method public getOverscrollFooter()Landroid/graphics/drawable/Drawable;
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->ay:Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method public getOverscrollHeader()Landroid/graphics/drawable/Drawable;
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->ax:Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method h(I)Z
    .locals 4

    const/4 v0, 0x0

    const/4 v1, 0x1

    const/16 v2, 0x21

    if-ne p1, v2, :cond_0

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v2

    sub-int/2addr p1, v2

    sub-int/2addr p1, v1

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    :goto_0
    const/4 v2, 0x0

    goto :goto_1

    :cond_0
    const/16 v2, 0x82

    if-ne p1, v2, :cond_1

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    sub-int/2addr p1, v1

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v3

    add-int/2addr v2, v3

    sub-int/2addr v2, v1

    invoke-static {p1, v2}, Ljava/lang/Math;->min(II)I

    move-result p1

    const/4 v2, 0x1

    goto :goto_1

    :cond_1
    const/4 p1, -0x1

    goto :goto_0

    :goto_1
    if-ltz p1, :cond_5

    invoke-virtual {p0, p1, v2}, Lit/sephiroth/android/library/widget/HListView;->b(IZ)I

    move-result p1

    if-ltz p1, :cond_5

    const/4 v0, 0x4

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->h:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getPaddingLeft()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getHorizontalFadingEdgeLength()I

    move-result v3

    add-int/2addr v0, v3

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->W:I

    if-eqz v2, :cond_2

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v3

    sub-int/2addr v0, v3

    if-le p1, v0, :cond_2

    const/4 v0, 0x3

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->h:I

    :cond_2
    if-nez v2, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v0

    if-ge p1, v0, :cond_3

    iput v1, p0, Lit/sephiroth/android/library/widget/HListView;->h:I

    :cond_3
    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->setSelectionInt(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->b()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->awakenScrollBars()Z

    move-result p1

    if-nez p1, :cond_4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->invalidate()V

    :cond_4
    return v1

    :cond_5
    return v0
.end method

.method i(I)Z
    .locals 3

    const/4 v0, 0x0

    const/4 v1, 0x1

    const/16 v2, 0x21

    if-ne p1, v2, :cond_0

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    if-eqz p1, :cond_1

    invoke-virtual {p0, v0, v1}, Lit/sephiroth/android/library/widget/HListView;->b(IZ)I

    move-result p1

    if-ltz p1, :cond_2

    iput v1, p0, Lit/sephiroth/android/library/widget/HListView;->h:I

    :goto_0
    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->setSelectionInt(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->b()V

    goto :goto_1

    :cond_0
    const/16 v2, 0x82

    if-ne p1, v2, :cond_1

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    sub-int/2addr v2, v1

    if-ge p1, v2, :cond_1

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    sub-int/2addr p1, v1

    invoke-virtual {p0, p1, v1}, Lit/sephiroth/android/library/widget/HListView;->b(IZ)I

    move-result p1

    if-ltz p1, :cond_2

    const/4 v0, 0x3

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->h:I

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :cond_2
    :goto_1
    if-eqz v1, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->awakenScrollBars()Z

    move-result p1

    if-nez p1, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->awakenScrollBars()Z

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->invalidate()V

    :cond_3
    return v1
.end method

.method public isOpaque()Z
    .locals 5

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->z:Z

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->aB:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->aC:Z

    if-nez v0, :cond_1

    :cond_0
    invoke-super {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isOpaque()Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    const/4 v0, 0x1

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_7

    iget-object v3, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    if-eqz v3, :cond_3

    iget-object v3, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->left:I

    goto :goto_1

    :cond_3
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getPaddingLeft()I

    move-result v3

    :goto_1
    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v4

    if-eqz v4, :cond_6

    invoke-virtual {v4}, Landroid/view/View;->getLeft()I

    move-result v4

    if-le v4, v3, :cond_4

    return v2

    :cond_4
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getWidth()I

    move-result v3

    iget-object v4, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    if-eqz v4, :cond_5

    iget-object v4, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->right:I

    goto :goto_2

    :cond_5
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getPaddingRight()I

    move-result v4

    :goto_2
    sub-int/2addr v3, v4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v4

    sub-int/2addr v4, v1

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_6

    invoke-virtual {v1}, Landroid/view/View;->getRight()I

    move-result v1

    if-ge v1, v3, :cond_7

    :cond_6
    return v2

    :cond_7
    return v0
.end method

.method j(I)Z
    .locals 2

    const/4 v0, 0x1

    const/4 v1, 0x0

    :try_start_0
    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->af:Z

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->o(I)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p1}, Landroid/view/SoundEffectConstants;->getContantForFocusDirection(I)I

    move-result p1

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->playSoundEffect(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iput-boolean v1, p0, Lit/sephiroth/android/library/widget/HListView;->af:Z

    return v0

    :catchall_0
    move-exception p1

    iput-boolean v1, p0, Lit/sephiroth/android/library/widget/HListView;->af:Z

    throw p1
.end method

.method protected onFinishInflate()V
    .locals 3

    invoke-super {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->onFinishInflate()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v0

    if-lez v0, :cond_1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/HListView;->b(Landroid/view/View;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->removeAllViews()V

    :cond_1
    return-void
.end method

.method protected onFocusChanged(ZILandroid/graphics/Rect;)V
    .locals 9

    invoke-super {p0, p1, p2, p3}, Lit/sephiroth/android/library/widget/AbsHListView;->onFocusChanged(ZILandroid/graphics/Rect;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    const/4 v1, 0x0

    const/4 v2, -0x1

    if-eqz v0, :cond_4

    if-eqz p1, :cond_4

    if-eqz p3, :cond_4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getScrollX()I

    move-result p1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getScrollY()I

    move-result v3

    invoke-virtual {p3, p1, v3}, Landroid/graphics/Rect;->offset(II)V

    invoke-interface {v0}, Landroid/widget/ListAdapter;->getCount()I

    move-result p1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v3

    iget v4, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr v3, v4

    if-ge p1, v3, :cond_0

    iput v1, p0, Lit/sephiroth/android/library/widget/HListView;->h:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->e()V

    :cond_0
    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->aH:Landroid/graphics/Rect;

    const v3, 0x7fffffff

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v4

    iget v5, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    const/4 v3, 0x0

    const v6, 0x7fffffff

    :goto_0
    if-ge v1, v4, :cond_3

    add-int v7, v5, v1

    invoke-interface {v0, v7}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v7

    if-nez v7, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object v7

    invoke-virtual {v7, p1}, Landroid/view/View;->getDrawingRect(Landroid/graphics/Rect;)V

    invoke-virtual {p0, v7, p1}, Lit/sephiroth/android/library/widget/HListView;->offsetDescendantRectToMyCoords(Landroid/view/View;Landroid/graphics/Rect;)V

    invoke-static {p3, p1, p2}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/graphics/Rect;Landroid/graphics/Rect;I)I

    move-result v8

    if-ge v8, v6, :cond_2

    invoke-virtual {v7}, Landroid/view/View;->getLeft()I

    move-result v3

    move v2, v1

    move v6, v8

    :cond_2
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_3
    move v1, v3

    :cond_4
    if-ltz v2, :cond_5

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    add-int/2addr v2, p1

    invoke-virtual {p0, v2, v1}, Lit/sephiroth/android/library/widget/HListView;->e(II)V

    return-void

    :cond_5
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->requestLayout()V

    return-void
.end method

.method public onGlobalLayout()V
    .locals 0

    return-void
.end method

.method public onInitializeAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V
    .locals 1

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->onInitializeAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V

    const-class v0, Lit/sephiroth/android/library/widget/HListView;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityEvent;->setClassName(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public onInitializeAccessibilityNodeInfo(Landroid/view/accessibility/AccessibilityNodeInfo;)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->onInitializeAccessibilityNodeInfo(Landroid/view/accessibility/AccessibilityNodeInfo;)V

    const-class v0, Lit/sephiroth/android/library/widget/HListView;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityNodeInfo;->setClassName(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0, p2}, Lit/sephiroth/android/library/widget/HListView;->a(IILandroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method

.method public onKeyMultiple(IILandroid/view/KeyEvent;)Z
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lit/sephiroth/android/library/widget/HListView;->a(IILandroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0, p2}, Lit/sephiroth/android/library/widget/HListView;->a(IILandroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method

.method protected onMeasure(II)V
    .locals 11
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    invoke-super {p0, p1, p2}, Lit/sephiroth/android/library/widget/AbsHListView;->onMeasure(II)V

    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v0

    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v1

    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p1

    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v7

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    const/4 v3, 0x0

    if-nez v2, :cond_0

    const/4 v2, 0x0

    goto :goto_0

    :cond_0
    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v2}, Landroid/widget/ListAdapter;->getCount()I

    move-result v2

    :goto_0
    iput v2, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    iget v2, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    const/4 v4, -0x1

    const/16 v5, 0xb

    if-lez v2, :cond_4

    if-eqz v0, :cond_1

    if-nez v1, :cond_4

    :cond_1
    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->P:[Z

    invoke-virtual {p0, v3, v2}, Lit/sephiroth/android/library/widget/HListView;->a(I[Z)Landroid/view/View;

    move-result-object v2

    invoke-direct {p0, v2, v3, p2}, Lit/sephiroth/android/library/widget/HListView;->a(Landroid/view/View;II)V

    invoke-virtual {v2}, Landroid/view/View;->getMeasuredWidth()I

    move-result v6

    invoke-virtual {v2}, Landroid/view/View;->getMeasuredHeight()I

    move-result v8

    sget v9, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v9, v5, :cond_2

    invoke-virtual {v2}, Landroid/view/View;->getMeasuredState()I

    move-result v9

    invoke-static {v3, v9}, Lit/sephiroth/android/library/widget/HListView;->combineMeasuredStates(II)I

    move-result v3

    :cond_2
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->x()Z

    move-result v9

    if-eqz v9, :cond_3

    iget-object v9, p0, Lit/sephiroth/android/library/widget/HListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v10

    check-cast v10, Lit/sephiroth/android/library/widget/AbsHListView$f;

    iget v10, v10, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    invoke-virtual {v9, v10}, Lit/sephiroth/android/library/widget/AbsHListView$k;->b(I)Z

    move-result v9

    if-eqz v9, :cond_3

    iget-object v9, p0, Lit/sephiroth/android/library/widget/HListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v9, v2, v4}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(Landroid/view/View;I)V

    :cond_3
    move v2, v3

    move v9, v6

    move v3, v8

    goto :goto_1

    :cond_4
    const/4 v2, 0x0

    const/4 v9, 0x0

    :goto_1
    const/high16 v10, -0x80000000

    if-nez v1, :cond_5

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->top:I

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v1, v2

    add-int/2addr v1, v3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getHorizontalScrollbarHeight()I

    move-result v2

    add-int v7, v1, v2

    goto :goto_2

    :cond_5
    if-ne v1, v10, :cond_6

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    if-lez v1, :cond_6

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->aw:I

    if-le v1, v4, :cond_6

    iget v4, p0, Lit/sephiroth/android/library/widget/HListView;->aw:I

    iget v5, p0, Lit/sephiroth/android/library/widget/HListView;->aw:I

    const/4 v8, -0x1

    move-object v2, p0

    move v3, p2

    move v6, p1

    invoke-virtual/range {v2 .. v8}, Lit/sephiroth/android/library/widget/HListView;->a(IIIIII)[I

    move-result-object v1

    const/4 v2, 0x1

    aget v7, v1, v2

    goto :goto_2

    :cond_6
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v1, v5, :cond_7

    const/high16 v1, -0x1000000

    and-int/2addr v1, v2

    or-int/2addr v7, v1

    :cond_7
    :goto_2
    if-nez v0, :cond_8

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget p1, p1, Landroid/graphics/Rect;->left:I

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->u:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->right:I

    add-int/2addr p1, v1

    add-int/2addr p1, v9

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getHorizontalFadingEdgeLength()I

    move-result v1

    mul-int/lit8 v1, v1, 0x2

    add-int/2addr p1, v1

    :cond_8
    move v5, p1

    if-ne v0, v10, :cond_9

    const/4 v3, 0x0

    const/4 v4, -0x1

    const/4 v6, -0x1

    move-object v1, p0

    move v2, p2

    invoke-virtual/range {v1 .. v6}, Lit/sephiroth/android/library/widget/HListView;->a(IIIII)I

    move-result v5

    :cond_9
    invoke-virtual {p0, v5, v7}, Lit/sephiroth/android/library/widget/HListView;->setMeasuredDimension(II)V

    iput p2, p0, Lit/sephiroth/android/library/widget/HListView;->v:I

    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 5

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result v0

    if-lez v0, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getFocusedChild()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_1

    iget v1, p0, Lit/sephiroth/android/library/widget/HListView;->V:I

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/HListView;->indexOfChild(Landroid/view/View;)I

    move-result v2

    add-int/2addr v1, v2

    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getPaddingLeft()I

    move-result v4

    sub-int v4, p1, v4

    sub-int/2addr v2, v4

    invoke-static {v3, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    sub-int/2addr v0, v2

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->aK:Lit/sephiroth/android/library/widget/HListView$c;

    if-nez v2, :cond_0

    new-instance v2, Lit/sephiroth/android/library/widget/HListView$c;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v3}, Lit/sephiroth/android/library/widget/HListView$c;-><init>(Lit/sephiroth/android/library/widget/HListView;Lit/sephiroth/android/library/widget/HListView$1;)V

    iput-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->aK:Lit/sephiroth/android/library/widget/HListView$c;

    :cond_0
    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->aK:Lit/sephiroth/android/library/widget/HListView$c;

    invoke-virtual {v2, v1, v0}, Lit/sephiroth/android/library/widget/HListView$c;->a(II)Lit/sephiroth/android/library/widget/HListView$c;

    move-result-object v0

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/HListView;->post(Ljava/lang/Runnable;)Z

    :cond_1
    invoke-super {p0, p1, p2, p3, p4}, Lit/sephiroth/android/library/widget/AbsHListView;->onSizeChanged(IIII)V

    return-void
.end method

.method public requestChildRectangleOnScreen(Landroid/view/View;Landroid/graphics/Rect;Z)Z
    .locals 7

    iget p3, p2, Landroid/graphics/Rect;->left:I

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v0

    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result v1

    invoke-virtual {p2, v0, v1}, Landroid/graphics/Rect;->offset(II)V

    invoke-virtual {p1}, Landroid/view/View;->getScrollX()I

    move-result v0

    neg-int v0, v0

    invoke-virtual {p1}, Landroid/view/View;->getScrollY()I

    move-result v1

    neg-int v1, v1

    invoke-virtual {p2, v0, v1}, Landroid/graphics/Rect;->offset(II)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getScrollX()I

    move-result v1

    add-int v2, v1, v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getHorizontalFadingEdgeLength()I

    move-result v3

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->z()Z

    move-result v4

    if-eqz v4, :cond_1

    iget v4, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    if-gtz v4, :cond_0

    if-le p3, v3, :cond_1

    :cond_0
    add-int/2addr v1, v3

    :cond_1
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getChildCount()I

    move-result p3

    const/4 v4, 0x1

    sub-int/2addr p3, v4

    invoke-virtual {p0, p3}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p3

    invoke-virtual {p3}, Landroid/view/View;->getRight()I

    move-result p3

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/HListView;->A()Z

    move-result v5

    if-eqz v5, :cond_3

    iget v5, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    iget v6, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    sub-int/2addr v6, v4

    if-lt v5, v6, :cond_2

    iget v5, p2, Landroid/graphics/Rect;->right:I

    sub-int v6, p3, v3

    if-ge v5, v6, :cond_3

    :cond_2
    sub-int/2addr v2, v3

    :cond_3
    iget v3, p2, Landroid/graphics/Rect;->right:I

    const/4 v5, 0x0

    if-le v3, v2, :cond_5

    iget v3, p2, Landroid/graphics/Rect;->left:I

    if-le v3, v1, :cond_5

    invoke-virtual {p2}, Landroid/graphics/Rect;->width()I

    move-result v3

    if-le v3, v0, :cond_4

    iget p2, p2, Landroid/graphics/Rect;->left:I

    sub-int/2addr p2, v1

    :goto_0
    add-int/2addr p2, v5

    goto :goto_1

    :cond_4
    iget p2, p2, Landroid/graphics/Rect;->right:I

    sub-int/2addr p2, v2

    goto :goto_0

    :goto_1
    sub-int/2addr p3, v2

    invoke-static {p2, p3}, Ljava/lang/Math;->min(II)I

    move-result p2

    goto :goto_3

    :cond_5
    iget p3, p2, Landroid/graphics/Rect;->left:I

    if-ge p3, v1, :cond_7

    iget p3, p2, Landroid/graphics/Rect;->right:I

    if-ge p3, v2, :cond_7

    invoke-virtual {p2}, Landroid/graphics/Rect;->width()I

    move-result p3

    if-le p3, v0, :cond_6

    iget p2, p2, Landroid/graphics/Rect;->right:I

    sub-int/2addr v2, p2

    rsub-int/lit8 p2, v2, 0x0

    goto :goto_2

    :cond_6
    iget p2, p2, Landroid/graphics/Rect;->left:I

    sub-int p2, v1, p2

    rsub-int/lit8 p2, p2, 0x0

    :goto_2
    invoke-virtual {p0, v5}, Lit/sephiroth/android/library/widget/HListView;->getChildAt(I)Landroid/view/View;

    move-result-object p3

    invoke-virtual {p3}, Landroid/view/View;->getLeft()I

    move-result p3

    sub-int/2addr p3, v1

    invoke-static {p2, p3}, Ljava/lang/Math;->max(II)I

    move-result p2

    goto :goto_3

    :cond_7
    const/4 p2, 0x0

    :goto_3
    if-eqz p2, :cond_8

    goto :goto_4

    :cond_8
    const/4 v4, 0x0

    :goto_4
    if-eqz v4, :cond_9

    neg-int p2, p2

    invoke-direct {p0, p2}, Lit/sephiroth/android/library/widget/HListView;->r(I)V

    const/4 p2, -0x1

    invoke-virtual {p0, p2, p1}, Lit/sephiroth/android/library/widget/HListView;->a(ILandroid/view/View;)V

    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result p1

    iput p1, p0, Lit/sephiroth/android/library/widget/HListView;->J:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->invalidate()V

    :cond_9
    return v4
.end method

.method public bridge synthetic setAdapter(Landroid/widget/Adapter;)V
    .locals 0

    check-cast p1, Landroid/widget/ListAdapter;

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->setAdapter(Landroid/widget/ListAdapter;)V

    return-void
.end method

.method public setAdapter(Landroid/widget/ListAdapter;)V
    .locals 3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    invoke-interface {v0, v1}, Landroid/widget/ListAdapter;->unregisterDataSetObserver(Landroid/database/DataSetObserver;)V

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->d()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView$k;->b()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->az:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-gtz v0, :cond_2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aA:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_1

    goto :goto_0

    :cond_1
    iput-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    goto :goto_1

    :cond_2
    :goto_0
    new-instance v0, Lit/sephiroth/android/library/widget/b;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->az:Ljava/util/ArrayList;

    iget-object v2, p0, Lit/sephiroth/android/library/widget/HListView;->aA:Ljava/util/ArrayList;

    invoke-direct {v0, v1, v2, p1}, Lit/sephiroth/android/library/widget/b;-><init>(Ljava/util/ArrayList;Ljava/util/ArrayList;Landroid/widget/ListAdapter;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    :goto_1
    const/4 v0, -0x1

    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->ar:I

    const-wide/high16 v0, -0x8000000000000000L

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/HListView;->as:J

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    const/4 v0, 0x1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {p1}, Landroid/widget/ListAdapter;->areAllItemsEnabled()Z

    move-result p1

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/HListView;->aF:Z

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    iput p1, p0, Lit/sephiroth/android/library/widget/HListView;->ap:I

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {p1}, Landroid/widget/ListAdapter;->getCount()I

    move-result p1

    iput p1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->s()V

    new-instance p1, Lit/sephiroth/android/library/widget/AbsHListView$a;

    invoke-direct {p1, p0}, Lit/sephiroth/android/library/widget/AbsHListView$a;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    invoke-interface {p1, v1}, Landroid/widget/ListAdapter;->registerDataSetObserver(Landroid/database/DataSetObserver;)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/HListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v1}, Landroid/widget/ListAdapter;->getViewTypeCount()I

    move-result v1

    invoke-virtual {p1, v1}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(I)V

    iget-boolean p1, p0, Lit/sephiroth/android/library/widget/HListView;->K:Z

    const/4 v1, 0x0

    if-eqz p1, :cond_3

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    sub-int/2addr p1, v0

    invoke-virtual {p0, p1, v1}, Lit/sephiroth/android/library/widget/HListView;->b(IZ)I

    move-result p1

    goto :goto_2

    :cond_3
    invoke-virtual {p0, v1, v0}, Lit/sephiroth/android/library/widget/HListView;->b(IZ)I

    move-result p1

    :goto_2
    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->setSelectedPositionInt(I)V

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->setNextSelectedPositionInt(I)V

    iget p1, p0, Lit/sephiroth/android/library/widget/HListView;->ao:I

    if-nez p1, :cond_5

    goto :goto_3

    :cond_4
    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->aF:Z

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->s()V

    :goto_3
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->u()V

    :cond_5
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->requestLayout()V

    return-void
.end method

.method public setCacheColorHint(I)V
    .locals 2

    ushr-int/lit8 v0, p1, 0x18

    const/16 v1, 0xff

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->aB:Z

    if-eqz v0, :cond_2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aI:Landroid/graphics/Paint;

    if-nez v0, :cond_1

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aI:Landroid/graphics/Paint;

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/HListView;->aI:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    :cond_2
    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->setCacheColorHint(I)V

    return-void
.end method

.method public setDivider(Landroid/graphics/drawable/Drawable;)V
    .locals 2

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v1

    iput v1, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    goto :goto_0

    :cond_0
    iput v0, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    :goto_0
    iput-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->au:Landroid/graphics/drawable/Drawable;

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getOpacity()I

    move-result p1

    const/4 v1, -0x1

    if-ne p1, v1, :cond_2

    :cond_1
    const/4 v0, 0x1

    :cond_2
    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/HListView;->aC:Z

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->requestLayout()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->invalidate()V

    return-void
.end method

.method public setDividerWidth(I)V
    .locals 0

    iput p1, p0, Lit/sephiroth/android/library/widget/HListView;->av:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->requestLayout()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->invalidate()V

    return-void
.end method

.method public setFooterDividersEnabled(Z)V
    .locals 0

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/HListView;->aE:Z

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->invalidate()V

    return-void
.end method

.method public setHeaderDividersEnabled(Z)V
    .locals 0

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/HListView;->aD:Z

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->invalidate()V

    return-void
.end method

.method public setItemsCanFocus(Z)V
    .locals 0

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/HListView;->aG:Z

    if-nez p1, :cond_0

    const/high16 p1, 0x60000

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->setDescendantFocusability(I)V

    :cond_0
    return-void
.end method

.method public setOverscrollFooter(Landroid/graphics/drawable/Drawable;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->ay:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->invalidate()V

    return-void
.end method

.method public setOverscrollHeader(Landroid/graphics/drawable/Drawable;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->ax:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->getScrollX()I

    move-result p1

    if-gez p1, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->invalidate()V

    :cond_0
    return-void
.end method

.method public setSelection(I)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lit/sephiroth/android/library/widget/HListView;->e(II)V

    return-void
.end method

.method public setSelectionInt(I)V
    .locals 3

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/HListView;->setNextSelectedPositionInt(I)V

    iget v0, p0, Lit/sephiroth/android/library/widget/HListView;->am:I

    const/4 v1, 0x1

    if-ltz v0, :cond_1

    add-int/lit8 v2, v0, -0x1

    if-ne p1, v2, :cond_0

    goto :goto_0

    :cond_0
    add-int/2addr v0, v1

    if-ne p1, v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :goto_0
    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lit/sephiroth/android/library/widget/HListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    :cond_2
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->e()V

    if-eqz v1, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/HListView;->awakenScrollBars()Z

    :cond_3
    return-void
.end method

.method protected x()Z
    .locals 1
    .annotation runtime Landroid/view/ViewDebug$ExportedProperty;
        category = "list"
    .end annotation

    const/4 v0, 0x1

    return v0
.end method
