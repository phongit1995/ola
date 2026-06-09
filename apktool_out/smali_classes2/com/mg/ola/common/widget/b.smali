.class public Lcom/mg/ola/common/widget/b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/common/widget/b$d;,
        Lcom/mg/ola/common/widget/b$e;,
        Lcom/mg/ola/common/widget/b$f;,
        Lcom/mg/ola/common/widget/b$b;,
        Lcom/mg/ola/common/widget/b$c;,
        Lcom/mg/ola/common/widget/b$a;
    }
.end annotation


# instance fields
.field private A:Landroid/graphics/drawable/Drawable;

.field private B:I

.field private C:Z

.field private D:Z

.field private E:I

.field private F:I

.field private G:Z

.field private a:Landroid/content/Context;

.field private b:Landroid/widget/PopupWindow;

.field private c:Landroid/widget/ListAdapter;

.field private d:Lcom/mg/ola/common/widget/b$a;

.field private e:I

.field private f:I

.field private g:I

.field private h:I

.field private i:Z

.field private j:I

.field private k:Landroid/view/View;

.field private l:I

.field private m:Landroid/database/DataSetObserver;

.field private n:Landroid/view/View;

.field private o:Landroid/graphics/drawable/Drawable;

.field private p:Landroid/widget/AdapterView$OnItemClickListener;

.field private q:Landroid/widget/AdapterView$OnItemSelectedListener;

.field private final r:Lcom/mg/ola/common/widget/b$f;

.field private final s:Lcom/mg/ola/common/widget/b$e;

.field private final t:Lcom/mg/ola/common/widget/b$d;

.field private final u:Lcom/mg/ola/common/widget/b$b;

.field private v:Landroid/os/Handler;

.field private w:Landroid/graphics/Rect;

.field private x:Z

.field private y:Z

.field private z:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    const/4 v0, 0x0

    const v1, 0x7f04019d

    invoke-direct {p0, p1, v0, v1}, Lcom/mg/ola/common/widget/b;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x2

    iput v0, p0, Lcom/mg/ola/common/widget/b;->e:I

    iput v0, p0, Lcom/mg/ola/common/widget/b;->f:I

    const v0, 0x7fffffff

    iput v0, p0, Lcom/mg/ola/common/widget/b;->j:I

    const/4 v1, 0x0

    iput v1, p0, Lcom/mg/ola/common/widget/b;->l:I

    new-instance v2, Lcom/mg/ola/common/widget/b$f;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v3}, Lcom/mg/ola/common/widget/b$f;-><init>(Lcom/mg/ola/common/widget/b;Lcom/mg/ola/common/widget/b$1;)V

    iput-object v2, p0, Lcom/mg/ola/common/widget/b;->r:Lcom/mg/ola/common/widget/b$f;

    new-instance v2, Lcom/mg/ola/common/widget/b$e;

    invoke-direct {v2, p0, v3}, Lcom/mg/ola/common/widget/b$e;-><init>(Lcom/mg/ola/common/widget/b;Lcom/mg/ola/common/widget/b$1;)V

    iput-object v2, p0, Lcom/mg/ola/common/widget/b;->s:Lcom/mg/ola/common/widget/b$e;

    new-instance v2, Lcom/mg/ola/common/widget/b$d;

    invoke-direct {v2, p0, v3}, Lcom/mg/ola/common/widget/b$d;-><init>(Lcom/mg/ola/common/widget/b;Lcom/mg/ola/common/widget/b$1;)V

    iput-object v2, p0, Lcom/mg/ola/common/widget/b;->t:Lcom/mg/ola/common/widget/b$d;

    new-instance v2, Lcom/mg/ola/common/widget/b$b;

    invoke-direct {v2, p0, v3}, Lcom/mg/ola/common/widget/b$b;-><init>(Lcom/mg/ola/common/widget/b;Lcom/mg/ola/common/widget/b$1;)V

    iput-object v2, p0, Lcom/mg/ola/common/widget/b;->u:Lcom/mg/ola/common/widget/b$b;

    new-instance v2, Landroid/os/Handler;

    invoke-direct {v2}, Landroid/os/Handler;-><init>()V

    iput-object v2, p0, Lcom/mg/ola/common/widget/b;->v:Landroid/os/Handler;

    new-instance v2, Landroid/graphics/Rect;

    invoke-direct {v2}, Landroid/graphics/Rect;-><init>()V

    iput-object v2, p0, Lcom/mg/ola/common/widget/b;->w:Landroid/graphics/Rect;

    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/mg/ola/common/widget/b;->y:Z

    iput-boolean v1, p0, Lcom/mg/ola/common/widget/b;->z:Z

    iput-boolean v1, p0, Lcom/mg/ola/common/widget/b;->C:Z

    iput v0, p0, Lcom/mg/ola/common/widget/b;->E:I

    iput v0, p0, Lcom/mg/ola/common/widget/b;->F:I

    iput-object p1, p0, Lcom/mg/ola/common/widget/b;->a:Landroid/content/Context;

    new-instance v0, Landroid/widget/PopupWindow;

    invoke-direct {v0, p1, p2, p3}, Landroid/widget/PopupWindow;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {p1, v2}, Landroid/widget/PopupWindow;->setInputMethodMode(I)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/b;->a(Landroid/widget/PopupWindow;)V

    return-void
.end method

.method private a(IIIII)I
    .locals 6

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->c:Landroid/widget/ListAdapter;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/b$a;->getListPaddingTop()I

    move-result p1

    iget-object p2, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {p2}, Lcom/mg/ola/common/widget/b$a;->getListPaddingBottom()I

    move-result p2

    add-int/2addr p1, p2

    return p1

    :cond_0
    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/b$a;->getListPaddingTop()I

    move-result v1

    iget-object v2, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/b$a;->getListPaddingBottom()I

    move-result v2

    add-int/2addr v1, v2

    iget-object v2, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/b$a;->getDividerHeight()I

    move-result v2

    const/4 v3, 0x0

    if-lez v2, :cond_1

    iget-object v2, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/b$a;->getDivider()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/b$a;->getDividerHeight()I

    move-result v2

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
    :goto_1
    if-gt p2, p3, :cond_8

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->c:Landroid/widget/ListAdapter;

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-interface {v0, p2, v4, v5}, Landroid/widget/ListAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v4}, Lcom/mg/ola/common/widget/b$a;->getCacheColorHint()I

    move-result v4

    if-eqz v4, :cond_3

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v4}, Lcom/mg/ola/common/widget/b$a;->getCacheColorHint()I

    move-result v4

    invoke-virtual {v0, v4}, Landroid/view/View;->setDrawingCacheBackgroundColor(I)V

    :cond_3
    invoke-direct {p0, v0, p2, p1}, Lcom/mg/ola/common/widget/b;->a(Landroid/view/View;II)V

    if-lez p2, :cond_4

    add-int/2addr v1, v2

    :cond_4
    invoke-virtual {v0}, Landroid/view/View;->getMeasuredHeight()I

    move-result v0

    add-int/2addr v1, v0

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

.method private a(Landroid/view/View;IZ)I
    .locals 4

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    invoke-virtual {p1, v0}, Landroid/view/View;->getWindowVisibleDisplayFrame(Landroid/graphics/Rect;)V

    const/4 v1, 0x2

    new-array v1, v1, [I

    invoke-virtual {p1, v1}, Landroid/view/View;->getLocationOnScreen([I)V

    iget v2, v0, Landroid/graphics/Rect;->bottom:I

    if-eqz p3, :cond_0

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p3

    invoke-virtual {p3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p3

    invoke-virtual {p3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p3

    iget v2, p3, Landroid/util/DisplayMetrics;->heightPixels:I

    :cond_0
    const/4 p3, 0x1

    aget v3, v1, p3

    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result p1

    add-int/2addr v3, p1

    sub-int/2addr v2, v3

    sub-int/2addr v2, p2

    aget p1, v1, p3

    iget p3, v0, Landroid/graphics/Rect;->top:I

    sub-int/2addr p1, p3

    add-int/2addr p1, p2

    invoke-static {v2, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    iget-object p2, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {p2}, Landroid/widget/PopupWindow;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {p2}, Landroid/widget/PopupWindow;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    iget-object p3, p0, Lcom/mg/ola/common/widget/b;->w:Landroid/graphics/Rect;

    invoke-virtual {p2, p3}, Landroid/graphics/drawable/Drawable;->getPadding(Landroid/graphics/Rect;)Z

    iget-object p2, p0, Lcom/mg/ola/common/widget/b;->w:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->top:I

    iget-object p3, p0, Lcom/mg/ola/common/widget/b;->w:Landroid/graphics/Rect;

    iget p3, p3, Landroid/graphics/Rect;->bottom:I

    add-int/2addr p2, p3

    sub-int/2addr p1, p2

    :cond_1
    return p1
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/b;)Lcom/mg/ola/common/widget/b$a;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    return-object p0
.end method

.method private a(Landroid/view/View;II)V
    .locals 3

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p2

    check-cast p2, Landroid/widget/AbsListView$LayoutParams;

    const/4 v0, 0x0

    if-nez p2, :cond_0

    new-instance p2, Landroid/widget/AbsListView$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-direct {p2, v1, v2, v0}, Landroid/widget/AbsListView$LayoutParams;-><init>(III)V

    invoke-virtual {p1, p2}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_0
    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/b$a;->getPaddingLeft()I

    move-result v1

    iget-object v2, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/b$a;->getPaddingRight()I

    move-result v2

    add-int/2addr v1, v2

    iget v2, p2, Landroid/widget/AbsListView$LayoutParams;->width:I

    invoke-static {p3, v1, v2}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    move-result p3

    iget p2, p2, Landroid/widget/AbsListView$LayoutParams;->height:I

    if-lez p2, :cond_1

    const/high16 v0, 0x40000000    # 2.0f

    invoke-static {p2, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p2

    goto :goto_0

    :cond_1
    invoke-static {v0, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p2

    :goto_0
    invoke-virtual {p1, p3, p2}, Landroid/view/View;->measure(II)V

    return-void
.end method

.method private a(Landroid/widget/PopupWindow;)V
    .locals 4

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xe

    if-ge v0, v1, :cond_0

    :try_start_0
    const-class v0, Landroid/widget/PopupWindow;

    const-string v1, "mAnchor"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    const-class v2, Landroid/widget/PopupWindow;

    const-string v3, "mOnScrollChangedListener"

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    invoke-virtual {v2, p1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/ViewTreeObserver$OnScrollChangedListener;

    new-instance v3, Lcom/mg/ola/common/widget/b$1;

    invoke-direct {v3, p0, v0, p1, v1}, Lcom/mg/ola/common/widget/b$1;-><init>(Lcom/mg/ola/common/widget/b;Ljava/lang/reflect/Field;Landroid/widget/PopupWindow;Landroid/view/ViewTreeObserver$OnScrollChangedListener;)V

    invoke-virtual {v2, p1, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method static synthetic b(Lcom/mg/ola/common/widget/b;)I
    .locals 0

    iget p0, p0, Lcom/mg/ola/common/widget/b;->j:I

    return p0
.end method

.method static synthetic c(Lcom/mg/ola/common/widget/b;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/mg/ola/common/widget/b;->G:Z

    return p0
.end method

.method static synthetic d(Lcom/mg/ola/common/widget/b;)Landroid/widget/PopupWindow;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    return-object p0
.end method

.method static synthetic e(Lcom/mg/ola/common/widget/b;)Lcom/mg/ola/common/widget/b$f;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/b;->r:Lcom/mg/ola/common/widget/b$f;

    return-object p0
.end method

.method static synthetic f(Lcom/mg/ola/common/widget/b;)Landroid/os/Handler;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/b;->v:Landroid/os/Handler;

    return-object p0
.end method

.method private g()Z
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->getInputMethodMode()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method static synthetic g(Lcom/mg/ola/common/widget/b;)Z
    .locals 0

    invoke-direct {p0}, Lcom/mg/ola/common/widget/b;->g()Z

    move-result p0

    return p0
.end method

.method private h()I
    .locals 11

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    const/4 v1, -0x1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->a:Landroid/content/Context;

    new-instance v4, Lcom/mg/ola/common/widget/b$a;

    iget-boolean v5, p0, Lcom/mg/ola/common/widget/b;->x:Z

    xor-int/2addr v5, v2

    invoke-direct {v4, v0, v5}, Lcom/mg/ola/common/widget/b$a;-><init>(Landroid/content/Context;Z)V

    iput-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->o:Landroid/graphics/drawable/Drawable;

    if-eqz v4, :cond_0

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->o:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/widget/b$a;->setSelector(Landroid/graphics/drawable/Drawable;)V

    :cond_0
    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->c:Landroid/widget/ListAdapter;

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/widget/b$a;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->p:Landroid/widget/AdapterView$OnItemClickListener;

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/widget/b$a;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v4, v2}, Lcom/mg/ola/common/widget/b$a;->setFocusable(Z)V

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v4, v2}, Lcom/mg/ola/common/widget/b$a;->setFocusableInTouchMode(Z)V

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    new-instance v5, Lcom/mg/ola/common/widget/b$2;

    invoke-direct {v5, p0}, Lcom/mg/ola/common/widget/b$2;-><init>(Lcom/mg/ola/common/widget/b;)V

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/widget/b$a;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->t:Lcom/mg/ola/common/widget/b$d;

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/widget/b$a;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->q:Landroid/widget/AdapterView$OnItemSelectedListener;

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->q:Landroid/widget/AdapterView$OnItemSelectedListener;

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/widget/b$a;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    :cond_1
    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->k:Landroid/view/View;

    if-eqz v5, :cond_2

    new-instance v6, Landroid/widget/LinearLayout;

    invoke-direct {v6, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {v6, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v0, v1, v3, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    iget v7, p0, Lcom/mg/ola/common/widget/b;->l:I

    packed-switch v7, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    invoke-virtual {v6, v4, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v6, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_0

    :pswitch_1
    invoke-virtual {v6, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-virtual {v6, v4, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    :goto_0
    :pswitch_2
    iget v0, p0, Lcom/mg/ola/common/widget/b;->f:I

    const/high16 v4, -0x80000000

    invoke-static {v0, v4}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v0

    invoke-virtual {v5, v0, v3}, Landroid/view/View;->measure(II)V

    invoke-virtual {v5}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {v5}, Landroid/view/View;->getMeasuredHeight()I

    move-result v4

    iget v5, v0, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    add-int/2addr v4, v5

    iget v0, v0, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    add-int/2addr v4, v0

    move v0, v4

    move-object v4, v6

    goto :goto_1

    :cond_2
    const/4 v0, 0x0

    :goto_1
    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v5, v4}, Landroid/widget/PopupWindow;->setContentView(Landroid/view/View;)V

    goto :goto_2

    :cond_3
    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->getContentView()Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->k:Landroid/view/View;

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v4

    check-cast v4, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {v0}, Landroid/view/View;->getMeasuredHeight()I

    move-result v0

    iget v5, v4, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    add-int/2addr v0, v5

    iget v4, v4, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    add-int/2addr v0, v4

    goto :goto_2

    :cond_4
    const/4 v0, 0x0

    :goto_2
    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v4}, Landroid/widget/PopupWindow;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v4

    if-eqz v4, :cond_5

    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->w:Landroid/graphics/Rect;

    invoke-virtual {v4, v5}, Landroid/graphics/drawable/Drawable;->getPadding(Landroid/graphics/Rect;)Z

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->w:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->top:I

    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->w:Landroid/graphics/Rect;

    iget v5, v5, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v4, v5

    iget-boolean v5, p0, Lcom/mg/ola/common/widget/b;->i:Z

    if-nez v5, :cond_6

    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->w:Landroid/graphics/Rect;

    iget v5, v5, Landroid/graphics/Rect;->top:I

    neg-int v5, v5

    iput v5, p0, Lcom/mg/ola/common/widget/b;->h:I

    goto :goto_3

    :cond_5
    const/4 v4, 0x0

    :cond_6
    :goto_3
    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v5}, Landroid/widget/PopupWindow;->getInputMethodMode()I

    move-result v5

    const/4 v6, 0x2

    if-ne v5, v6, :cond_7

    goto :goto_4

    :cond_7
    const/4 v2, 0x0

    :goto_4
    iget-object v3, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    iget v5, p0, Lcom/mg/ola/common/widget/b;->h:I

    invoke-direct {p0, v3, v5, v2}, Lcom/mg/ola/common/widget/b;->a(Landroid/view/View;IZ)I

    move-result v2

    iget v3, p0, Lcom/mg/ola/common/widget/b;->e:I

    if-ne v3, v1, :cond_8

    add-int/2addr v2, v4

    return v2

    :cond_8
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, -0x1

    sub-int v9, v2, v0

    const/4 v10, -0x1

    move-object v5, p0

    invoke-direct/range {v5 .. v10}, Lcom/mg/ola/common/widget/b;->a(IIIII)I

    move-result v1

    if-lez v1, :cond_9

    add-int/2addr v0, v4

    :cond_9
    add-int/2addr v1, v0

    return v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method private j(I)V
    .locals 6

    iget v0, p0, Lcom/mg/ola/common/widget/b;->f:I

    const/4 v1, -0x2

    const/4 v2, 0x0

    const/4 v3, -0x1

    if-ne v0, v3, :cond_0

    iget v0, p0, Lcom/mg/ola/common/widget/b;->f:I

    goto :goto_2

    :cond_0
    iget v0, p0, Lcom/mg/ola/common/widget/b;->f:I

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    invoke-virtual {v4}, Landroid/view/View;->getWidth()I

    move-result v4

    :goto_0
    iget v5, p0, Lcom/mg/ola/common/widget/b;->F:I

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-virtual {v0, v4}, Landroid/widget/PopupWindow;->setWidth(I)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget v4, p0, Lcom/mg/ola/common/widget/b;->f:I

    goto :goto_0

    :goto_1
    const/4 v0, 0x0

    :goto_2
    iget v4, p0, Lcom/mg/ola/common/widget/b;->e:I

    if-ne v4, v3, :cond_2

    iget v2, p0, Lcom/mg/ola/common/widget/b;->e:I

    goto :goto_3

    :cond_2
    iget v4, p0, Lcom/mg/ola/common/widget/b;->e:I

    if-ne v4, v1, :cond_3

    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget v4, p0, Lcom/mg/ola/common/widget/b;->E:I

    invoke-static {p1, v4}, Ljava/lang/Math;->min(II)I

    move-result p1

    invoke-virtual {v1, p1}, Landroid/widget/PopupWindow;->setHeight(I)V

    goto :goto_3

    :cond_3
    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget v1, p0, Lcom/mg/ola/common/widget/b;->e:I

    iget v4, p0, Lcom/mg/ola/common/widget/b;->E:I

    invoke-static {v1, v4}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/widget/PopupWindow;->setHeight(I)V

    :goto_3
    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {p1, v0, v2}, Landroid/widget/PopupWindow;->setWindowLayoutMode(II)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->s:Lcom/mg/ola/common/widget/b$e;

    invoke-virtual {p1, v0}, Landroid/widget/PopupWindow;->setTouchInterceptor(Landroid/view/View$OnTouchListener;)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    iget v1, p0, Lcom/mg/ola/common/widget/b;->g:I

    iget v2, p0, Lcom/mg/ola/common/widget/b;->h:I

    invoke-virtual {p1, v0, v1, v2}, Landroid/widget/PopupWindow;->showAsDropDown(Landroid/view/View;II)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {p1, v3}, Lcom/mg/ola/common/widget/b$a;->setSelection(I)V

    iget-boolean p1, p0, Lcom/mg/ola/common/widget/b;->x:Z

    if-eqz p1, :cond_4

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/b$a;->isInTouchMode()Z

    move-result p1

    if-eqz p1, :cond_5

    :cond_4
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/b;->e()V

    :cond_5
    iget-boolean p1, p0, Lcom/mg/ola/common/widget/b;->x:Z

    if-nez p1, :cond_6

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->v:Landroid/os/Handler;

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->u:Lcom/mg/ola/common/widget/b$b;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_6
    return-void
.end method

.method private k(I)V
    .locals 10

    invoke-direct {p0}, Lcom/mg/ola/common/widget/b;->g()Z

    move-result v0

    iget v1, p0, Lcom/mg/ola/common/widget/b;->f:I

    const/4 v2, -0x2

    const/4 v3, -0x1

    if-ne v1, v3, :cond_0

    const/4 v8, -0x1

    goto :goto_1

    :cond_0
    iget v1, p0, Lcom/mg/ola/common/widget/b;->f:I

    if-ne v1, v2, :cond_1

    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getWidth()I

    move-result v1

    :goto_0
    move v8, v1

    goto :goto_1

    :cond_1
    iget v1, p0, Lcom/mg/ola/common/widget/b;->f:I

    goto :goto_0

    :goto_1
    iget v1, p0, Lcom/mg/ola/common/widget/b;->e:I

    if-ne v1, v3, :cond_6

    if-eqz v0, :cond_2

    goto :goto_2

    :cond_2
    const/4 p1, -0x1

    :goto_2
    const/4 v1, 0x0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget v2, p0, Lcom/mg/ola/common/widget/b;->f:I

    if-ne v2, v3, :cond_3

    goto :goto_3

    :cond_3
    const/4 v3, 0x0

    :goto_3
    invoke-virtual {v0, v3, v1}, Landroid/widget/PopupWindow;->setWindowLayoutMode(II)V

    goto :goto_4

    :cond_4
    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget v2, p0, Lcom/mg/ola/common/widget/b;->f:I

    if-ne v2, v3, :cond_5

    const/4 v1, -0x1

    :cond_5
    invoke-virtual {v0, v1, v3}, Landroid/widget/PopupWindow;->setWindowLayoutMode(II)V

    goto :goto_4

    :cond_6
    iget v0, p0, Lcom/mg/ola/common/widget/b;->e:I

    if-ne v0, v2, :cond_7

    :goto_4
    move v9, p1

    goto :goto_5

    :cond_7
    iget p1, p0, Lcom/mg/ola/common/widget/b;->e:I

    goto :goto_4

    :goto_5
    iget-object v4, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget-object v5, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    iget v6, p0, Lcom/mg/ola/common/widget/b;->g:I

    iget v7, p0, Lcom/mg/ola/common/widget/b;->h:I

    invoke-virtual/range {v4 .. v9}, Landroid/widget/PopupWindow;->update(Landroid/view/View;IIII)V

    return-void
.end method


# virtual methods
.method public a()Landroid/widget/ListAdapter;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->c:Landroid/widget/ListAdapter;

    return-object v0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/widget/b;->j:I

    return-void
.end method

.method public a(Landroid/graphics/drawable/Drawable;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/b$a;->setDivider(Landroid/graphics/drawable/Drawable;)V

    :cond_0
    iput-object p1, p0, Lcom/mg/ola/common/widget/b;->A:Landroid/graphics/drawable/Drawable;

    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    iget-boolean p1, p0, Lcom/mg/ola/common/widget/b;->C:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result p1

    if-lez p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result p1

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/b;->f(I)V

    :cond_0
    return-void
.end method

.method public a(Landroid/widget/AdapterView$OnItemClickListener;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/b;->p:Landroid/widget/AdapterView$OnItemClickListener;

    return-void
.end method

.method public a(Landroid/widget/ListAdapter;)V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->m:Landroid/database/DataSetObserver;

    if-nez v0, :cond_0

    new-instance v0, Lcom/mg/ola/common/widget/b$c;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/mg/ola/common/widget/b$c;-><init>(Lcom/mg/ola/common/widget/b;Lcom/mg/ola/common/widget/b$1;)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/b;->m:Landroid/database/DataSetObserver;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->c:Landroid/widget/ListAdapter;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->c:Landroid/widget/ListAdapter;

    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->m:Landroid/database/DataSetObserver;

    invoke-interface {v0, v1}, Landroid/widget/ListAdapter;->unregisterDataSetObserver(Landroid/database/DataSetObserver;)V

    :cond_1
    :goto_0
    iput-object p1, p0, Lcom/mg/ola/common/widget/b;->c:Landroid/widget/ListAdapter;

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->c:Landroid/widget/ListAdapter;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->m:Landroid/database/DataSetObserver;

    invoke-interface {p1, v0}, Landroid/widget/ListAdapter;->registerDataSetObserver(Landroid/database/DataSetObserver;)V

    :cond_2
    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->c:Landroid/widget/ListAdapter;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/b$a;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_3
    return-void
.end method

.method public a(Landroid/widget/PopupWindow$OnDismissListener;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v0, p1}, Landroid/widget/PopupWindow;->setOnDismissListener(Landroid/widget/PopupWindow$OnDismissListener;)V

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/b;->G:Z

    return-void
.end method

.method public b()V
    .locals 3

    invoke-direct {p0}, Lcom/mg/ola/common/widget/b;->h()I

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->A:Landroid/graphics/drawable/Drawable;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    iget-object v2, p0, Lcom/mg/ola/common/widget/b;->A:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/widget/b$a;->setDivider(Landroid/graphics/drawable/Drawable;)V

    :cond_0
    iget v1, p0, Lcom/mg/ola/common/widget/b;->B:I

    if-ltz v1, :cond_1

    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    iget v2, p0, Lcom/mg/ola/common/widget/b;->B:I

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/widget/b$a;->setDividerHeight(I)V

    :cond_1
    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v1}, Landroid/widget/PopupWindow;->isShowing()Z

    move-result v1

    if-nez v1, :cond_2

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/b;->j(I)V

    goto :goto_0

    :cond_2
    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/b;->k(I)V

    :goto_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget-boolean v1, p0, Lcom/mg/ola/common/widget/b;->D:Z

    if-nez v1, :cond_3

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/b;->c()Z

    move-result v1

    if-eqz v1, :cond_3

    const/4 v1, 0x1

    goto :goto_1

    :cond_3
    const/4 v1, 0x0

    :goto_1
    invoke-virtual {v0, v1}, Landroid/widget/PopupWindow;->setOutsideTouchable(Z)V

    return-void
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/widget/b;->l:I

    return-void
.end method

.method public b(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/b;->D:Z

    return-void
.end method

.method public c(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v0, p1}, Landroid/widget/PopupWindow;->setSoftInputMode(I)V

    return-void
.end method

.method public c(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/b;->C:Z

    iget-boolean p1, p0, Lcom/mg/ola/common/widget/b;->C:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result p1

    if-lez p1, :cond_1

    iget-object p1, p0, Lcom/mg/ola/common/widget/b;->n:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result p1

    goto :goto_0

    :cond_0
    const/4 p1, -0x2

    :goto_0
    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/b;->f(I)V

    :cond_1
    return-void
.end method

.method public c()Z
    .locals 1

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/b;->y:Z

    return v0
.end method

.method public d()V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->dismiss()V

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->k:Landroid/view/View;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->k:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    instance-of v1, v0, Landroid/view/ViewGroup;

    if-eqz v1, :cond_0

    check-cast v0, Landroid/view/ViewGroup;

    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->k:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/PopupWindow;->setContentView(Landroid/view/View;)V

    iput-object v1, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->v:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->r:Lcom/mg/ola/common/widget/b$f;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(I)V
    .locals 2

    if-lez p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->a:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/PopupWindow;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    :try_end_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Landroid/content/res/Resources$NotFoundException;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public d(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/b;->y:Z

    return-void
.end method

.method public e()V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/mg/ola/common/widget/b$a;->a(Lcom/mg/ola/common/widget/b$a;Z)Z

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b$a;->requestLayout()V

    :cond_0
    return-void
.end method

.method public e(I)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/widget/b;->h:I

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/b;->i:Z

    return-void
.end method

.method public f(I)V
    .locals 2

    const/4 v0, -0x2

    if-ne p1, v0, :cond_0

    iput v0, p0, Lcom/mg/ola/common/widget/b;->f:I

    return-void

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->w:Landroid/graphics/Rect;

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->getPadding(Landroid/graphics/Rect;)Z

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->w:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    iget-object v1, p0, Lcom/mg/ola/common/widget/b;->w:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->right:I

    add-int/2addr v0, v1

    add-int/2addr v0, p1

    iput v0, p0, Lcom/mg/ola/common/widget/b;->f:I

    return-void

    :cond_1
    iput p1, p0, Lcom/mg/ola/common/widget/b;->f:I

    return-void
.end method

.method public f()Z
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->isShowing()Z

    move-result v0

    return v0
.end method

.method public g(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->d:Lcom/mg/ola/common/widget/b$a;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/b$a;->setDividerHeight(I)V

    :cond_0
    iput p1, p0, Lcom/mg/ola/common/widget/b;->B:I

    return-void
.end method

.method public h(I)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/widget/b;->E:I

    return-void
.end method

.method public i(I)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v0, p1}, Landroid/widget/PopupWindow;->setInputMethodMode(I)V

    return-void
.end method
