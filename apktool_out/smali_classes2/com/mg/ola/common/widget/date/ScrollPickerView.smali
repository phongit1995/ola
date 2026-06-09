.class public Lcom/mg/ola/common/widget/date/ScrollPickerView;
.super Landroid/widget/LinearLayout;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;
    }
.end annotation


# static fields
.field private static final a:Landroid/graphics/BitmapFactory$Options;

.field private static final b:[Landroid/graphics/Paint;


# instance fields
.field private c:Landroid/graphics/Rect;

.field private d:Landroid/graphics/Rect;

.field private e:Landroid/graphics/Rect;

.field private f:Landroid/graphics/Rect;

.field private g:Landroid/graphics/Bitmap;

.field private h:Landroid/graphics/Bitmap;

.field private i:[Landroid/graphics/Rect;

.field private j:[Landroid/graphics/Rect;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    sput-object v0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->a:Landroid/graphics/BitmapFactory$Options;

    sget-object v0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->a:Landroid/graphics/BitmapFactory$Options;

    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v1, v0, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    const/4 v0, 0x3

    new-array v0, v0, [Landroid/graphics/Paint;

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    const/4 v2, 0x0

    aput-object v1, v0, v2

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    const/4 v3, 0x1

    aput-object v1, v0, v3

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    const/4 v4, 0x2

    aput-object v1, v0, v4

    sput-object v0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->b:[Landroid/graphics/Paint;

    sget-object v0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->b:[Landroid/graphics/Paint;

    aget-object v0, v0, v2

    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    sget-object v0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->b:[Landroid/graphics/Paint;

    aget-object v0, v0, v3

    const v1, 0x2f1f2f2f

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    sget-object v0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->b:[Landroid/graphics/Paint;

    aget-object v0, v0, v4

    const v1, -0xf2f1f1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->c:Landroid/graphics/Rect;

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->d:Landroid/graphics/Rect;

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->e:Landroid/graphics/Rect;

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->f:Landroid/graphics/Rect;

    const/4 v0, 0x0

    new-array v1, v0, [Landroid/graphics/Rect;

    iput-object v1, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->i:[Landroid/graphics/Rect;

    new-array v0, v0, [Landroid/graphics/Rect;

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->j:[Landroid/graphics/Rect;

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    invoke-direct {p0, p1, p2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance p2, Landroid/graphics/Rect;

    invoke-direct {p2}, Landroid/graphics/Rect;-><init>()V

    iput-object p2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->c:Landroid/graphics/Rect;

    new-instance p2, Landroid/graphics/Rect;

    invoke-direct {p2}, Landroid/graphics/Rect;-><init>()V

    iput-object p2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->d:Landroid/graphics/Rect;

    new-instance p2, Landroid/graphics/Rect;

    invoke-direct {p2}, Landroid/graphics/Rect;-><init>()V

    iput-object p2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->e:Landroid/graphics/Rect;

    new-instance p2, Landroid/graphics/Rect;

    invoke-direct {p2}, Landroid/graphics/Rect;-><init>()V

    iput-object p2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->f:Landroid/graphics/Rect;

    const/4 p2, 0x0

    new-array v0, p2, [Landroid/graphics/Rect;

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->i:[Landroid/graphics/Rect;

    new-array p2, p2, [Landroid/graphics/Rect;

    iput-object p2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->j:[Landroid/graphics/Rect;

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->a(Landroid/content/Context;)V

    return-void
.end method

.method private a(IFF)I
    .locals 1

    const/high16 v0, 0x41200000    # 10.0f

    cmpg-float v0, p2, v0

    if-gtz v0, :cond_0

    div-float/2addr p2, p3

    int-to-float p1, p1

    :goto_0
    mul-float p1, p1, p2

    float-to-int p1, p1

    return p1

    :cond_0
    int-to-float p1, p1

    const p2, 0x3dcccccd    # 0.1f

    goto :goto_0
.end method

.method private a()V
    .locals 9

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    iget-object v3, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->i:[Landroid/graphics/Rect;

    array-length v3, v3

    if-ge v2, v3, :cond_0

    iget-object v3, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->i:[Landroid/graphics/Rect;

    aget-object v3, v3, v2

    new-instance v4, Landroid/graphics/Rect;

    iget v5, v3, Landroid/graphics/Rect;->left:I

    iget v6, v3, Landroid/graphics/Rect;->top:I

    iget v7, v3, Landroid/graphics/Rect;->left:I

    add-int/lit8 v7, v7, 0x4

    iget v8, v3, Landroid/graphics/Rect;->bottom:I

    invoke-direct {v4, v5, v6, v7, v8}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v5, Landroid/graphics/Rect;

    iget v6, v3, Landroid/graphics/Rect;->right:I

    add-int/lit8 v6, v6, -0x4

    iget v7, v3, Landroid/graphics/Rect;->top:I

    iget v8, v3, Landroid/graphics/Rect;->right:I

    iget v3, v3, Landroid/graphics/Rect;->bottom:I

    invoke-direct {v5, v6, v7, v8, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    new-array v1, v1, [Landroid/graphics/Rect;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Landroid/graphics/Rect;

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->j:[Landroid/graphics/Rect;

    return-void
.end method

.method private a(Landroid/content/Context;)V
    .locals 4

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget-object v1, Lcom/mg/ola/common/widget/date/ScrollPickerView;->a:Landroid/graphics/BitmapFactory$Options;

    const v2, 0x7f080187

    invoke-static {v0, v2, v1}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;ILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v0

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->h:Landroid/graphics/Bitmap;

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->c:Landroid/graphics/Rect;

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->h:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    iget-object v2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->h:Landroid/graphics/Bitmap;

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v3, v1, v2}, Landroid/graphics/Rect;->set(IIII)V

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    sget-object v0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->a:Landroid/graphics/BitmapFactory$Options;

    const v1, 0x7f080186

    invoke-static {p1, v1, v0}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;ILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object p1

    iput-object p1, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->g:Landroid/graphics/Bitmap;

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->e:Landroid/graphics/Rect;

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->g:Landroid/graphics/Bitmap;

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->g:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    invoke-virtual {p1, v3, v3, v0, v1}, Landroid/graphics/Rect;->set(IIII)V

    const/4 p1, -0x1

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->setBackgroundColor(I)V

    return-void
.end method

.method private b(I)I
    .locals 4

    int-to-double v0, p1

    const-wide v2, 0x3faeb851eb851eb8L    # 0.06

    mul-double v0, v0, v2

    double-to-int p1, v0

    return p1
.end method


# virtual methods
.method public a(I)I
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildCount()I

    move-result v0

    if-lt p1, v0, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/mg/ola/common/widget/date/a;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/date/a;->a()I

    move-result p1

    return p1
.end method

.method public a(II)V
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildCount()I

    move-result v0

    if-lt p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/mg/ola/common/widget/date/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/date/a;->a(I)V

    return-void
.end method

.method public a([Ljava/lang/String;FLcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;)V
    .locals 2

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, p3}, Lcom/mg/ola/common/widget/date/f;->a(Landroid/content/Context;Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;)Lcom/mg/ola/common/widget/date/a;

    move-result-object p3

    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {v0, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    iput p2, v0, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    invoke-virtual {p3, p1}, Lcom/mg/ola/common/widget/date/a;->a([Ljava/lang/String;)V

    invoke-virtual {p0, p3, v0}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method

.method public b(II)V
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildCount()I

    move-result v0

    if-lt p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/mg/ola/common/widget/date/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/date/a;->b(I)V

    return-void
.end method

.method c(II)V
    .locals 10

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildCount()I

    move-result v0

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    invoke-direct {p0, p2}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->b(I)I

    move-result v2

    iput v2, v1, Landroid/graphics/Rect;->top:I

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->b(I)I

    move-result v2

    iput v2, v1, Landroid/graphics/Rect;->left:I

    iget v2, v1, Landroid/graphics/Rect;->top:I

    sub-int v2, p2, v2

    iput v2, v1, Landroid/graphics/Rect;->bottom:I

    iget v2, v1, Landroid/graphics/Rect;->left:I

    sub-int/2addr p1, v2

    mul-int/lit8 v2, v0, 0x4

    sub-int/2addr p1, v2

    add-int/lit8 p1, p1, 0x4

    iput p1, v1, Landroid/graphics/Rect;->right:I

    const/4 p1, 0x0

    const/4 v2, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-ge v2, v0, :cond_0

    invoke-virtual {p0, v2}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildAt(I)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v4

    check-cast v4, Landroid/widget/LinearLayout$LayoutParams;

    iget v4, v4, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    add-float/2addr v3, v4

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    iget v2, v1, Landroid/graphics/Rect;->left:I

    iget v4, v1, Landroid/graphics/Rect;->top:I

    new-array v5, v0, [Landroid/graphics/Rect;

    iput-object v5, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->i:[Landroid/graphics/Rect;

    move v5, v2

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v0, :cond_1

    invoke-virtual {p0, v2}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildAt(I)Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v7

    check-cast v7, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {v1}, Landroid/graphics/Rect;->width()I

    move-result v8

    iget v7, v7, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    invoke-direct {p0, v8, v7, v3}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->a(IFF)I

    move-result v7

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v8

    add-int v9, v5, v7

    add-int/2addr v8, v4

    invoke-virtual {v6, v5, v4, v9, v8}, Landroid/view/View;->layout(IIII)V

    iget-object v6, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->i:[Landroid/graphics/Rect;

    new-instance v8, Landroid/graphics/Rect;

    invoke-direct {v8, v5, p1, v9, p2}, Landroid/graphics/Rect;-><init>(IIII)V

    aput-object v8, v6, v2

    add-int/lit8 v7, v7, 0x4

    add-int/2addr v5, v7

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_1
    invoke-direct {p0}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->a()V

    return-void
.end method

.method protected dispatchDraw(Landroid/graphics/Canvas;)V
    .locals 6

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->f:Landroid/graphics/Rect;

    sget-object v1, Lcom/mg/ola/common/widget/date/ScrollPickerView;->b:[Landroid/graphics/Paint;

    const/4 v2, 0x2

    aget-object v1, v1, v2

    invoke-virtual {p1, v0, v1}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->i:[Landroid/graphics/Rect;

    array-length v2, v2

    if-ge v1, v2, :cond_0

    iget-object v2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->i:[Landroid/graphics/Rect;

    aget-object v2, v2, v1

    sget-object v3, Lcom/mg/ola/common/widget/date/ScrollPickerView;->b:[Landroid/graphics/Paint;

    aget-object v3, v3, v0

    invoke-virtual {p1, v2, v3}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_1
    iget-object v2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->j:[Landroid/graphics/Rect;

    array-length v2, v2

    if-ge v1, v2, :cond_1

    iget-object v2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->j:[Landroid/graphics/Rect;

    aget-object v2, v2, v1

    sget-object v3, Lcom/mg/ola/common/widget/date/ScrollPickerView;->b:[Landroid/graphics/Paint;

    const/4 v4, 0x1

    aget-object v3, v3, v4

    invoke-virtual {p1, v2, v3}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    iget-object v1, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->h:Landroid/graphics/Bitmap;

    iget-object v2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->c:Landroid/graphics/Rect;

    iget-object v3, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->d:Landroid/graphics/Rect;

    const/4 v4, 0x0

    invoke-virtual {p1, v1, v2, v3, v4}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildCount()I

    move-result v1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getDrawingTime()J

    move-result-wide v2

    :goto_2
    if-ge v0, v1, :cond_2

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildAt(I)Landroid/view/View;

    move-result-object v5

    invoke-virtual {p0, p1, v5, v2, v3}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->drawChild(Landroid/graphics/Canvas;Landroid/view/View;J)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->g:Landroid/graphics/Bitmap;

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->e:Landroid/graphics/Rect;

    iget-object v2, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->f:Landroid/graphics/Rect;

    invoke-virtual {p1, v0, v1, v2, v4}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    return-void
.end method

.method public getAllSlotIndexes()[I
    .locals 4

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildCount()I

    move-result v0

    new-array v1, v0, [I

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_0

    invoke-virtual {p0, v2}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/common/widget/date/a;

    invoke-virtual {v3}, Lcom/mg/ola/common/widget/date/a;->a()I

    move-result v3

    aput v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-object v1
.end method

.method protected onLayout(ZIIII)V
    .locals 3

    const-string v0, "Datetimepicker#onLayout"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ch:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v2, ", l:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ", t:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ", r:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ", b:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p1, :cond_0

    sub-int/2addr p4, p2

    sub-int/2addr p5, p3

    invoke-virtual {p0, p4, p5}, Lcom/mg/ola/common/widget/date/ScrollPickerView;->c(II)V

    :cond_0
    return-void
.end method

.method public onSizeChanged(IIII)V
    .locals 3

    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/LinearLayout;->onSizeChanged(IIII)V

    int-to-float p3, p1

    iget-object p4, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->e:Landroid/graphics/Rect;

    invoke-virtual {p4}, Landroid/graphics/Rect;->width()I

    move-result p4

    int-to-float p4, p4

    div-float/2addr p3, p4

    iget-object p4, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->c:Landroid/graphics/Rect;

    invoke-virtual {p4}, Landroid/graphics/Rect;->width()I

    move-result p4

    int-to-float p4, p4

    mul-float p3, p3, p4

    float-to-int p3, p3

    int-to-float p4, p2

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->e:Landroid/graphics/Rect;

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v0

    int-to-float v0, v0

    div-float/2addr p4, v0

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->c:Landroid/graphics/Rect;

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v0

    int-to-float v0, v0

    mul-float p4, p4, v0

    float-to-int p4, p4

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->d:Landroid/graphics/Rect;

    neg-int v1, p3

    div-int/lit8 v1, v1, 0x2

    neg-int v2, p4

    div-int/lit8 v2, v2, 0x2

    div-int/lit8 p3, p3, 0x2

    div-int/lit8 p4, p4, 0x2

    invoke-virtual {v0, v1, v2, p3, p4}, Landroid/graphics/Rect;->set(IIII)V

    iget-object p3, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->d:Landroid/graphics/Rect;

    div-int/lit8 p4, p1, 0x2

    div-int/lit8 v0, p2, 0x2

    invoke-virtual {p3, p4, v0}, Landroid/graphics/Rect;->offset(II)V

    iget-object p3, p0, Lcom/mg/ola/common/widget/date/ScrollPickerView;->f:Landroid/graphics/Rect;

    const/4 p4, 0x0

    invoke-virtual {p3, p4, p4, p1, p2}, Landroid/graphics/Rect;->set(IIII)V

    return-void
.end method
