.class public Lchat/ola/vn/view/SlidingPaneLayout;
.super Landroid/view/ViewGroup;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/SlidingPaneLayout$b;,
        Lchat/ola/vn/view/SlidingPaneLayout$a;,
        Lchat/ola/vn/view/SlidingPaneLayout$i;,
        Lchat/ola/vn/view/SlidingPaneLayout$h;,
        Lchat/ola/vn/view/SlidingPaneLayout$g;,
        Lchat/ola/vn/view/SlidingPaneLayout$f;,
        Lchat/ola/vn/view/SlidingPaneLayout$SavedState;,
        Lchat/ola/vn/view/SlidingPaneLayout$d;,
        Lchat/ola/vn/view/SlidingPaneLayout$c;,
        Lchat/ola/vn/view/SlidingPaneLayout$e;
    }
.end annotation


# static fields
.field static final a:Lchat/ola/vn/view/SlidingPaneLayout$f;


# instance fields
.field private b:I

.field private c:I

.field private d:Landroid/graphics/drawable/Drawable;

.field private final e:I

.field private f:Z

.field private g:Landroid/view/View;

.field private h:F

.field private i:F

.field private j:I

.field private k:Z

.field private l:I

.field private m:F

.field private n:F

.field private o:Lchat/ola/vn/view/SlidingPaneLayout$e;

.field private final p:Landroid/support/v4/widget/ViewDragHelper;

.field private q:Z

.field private r:Z

.field private final s:Landroid/graphics/Rect;

.field private final t:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/view/SlidingPaneLayout$b;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x11

    if-lt v0, v1, :cond_0

    new-instance v0, Lchat/ola/vn/view/SlidingPaneLayout$i;

    invoke-direct {v0}, Lchat/ola/vn/view/SlidingPaneLayout$i;-><init>()V

    :goto_0
    sput-object v0, Lchat/ola/vn/view/SlidingPaneLayout;->a:Lchat/ola/vn/view/SlidingPaneLayout$f;

    return-void

    :cond_0
    const/16 v1, 0x10

    if-lt v0, v1, :cond_1

    new-instance v0, Lchat/ola/vn/view/SlidingPaneLayout$h;

    invoke-direct {v0}, Lchat/ola/vn/view/SlidingPaneLayout$h;-><init>()V

    goto :goto_0

    :cond_1
    new-instance v0, Lchat/ola/vn/view/SlidingPaneLayout$g;

    invoke-direct {v0}, Lchat/ola/vn/view/SlidingPaneLayout$g;-><init>()V

    goto :goto_0

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/view/SlidingPaneLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/view/SlidingPaneLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 2

    invoke-direct {p0, p1, p2, p3}, Landroid/view/ViewGroup;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const p2, -0x33333334

    iput p2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->b:I

    const/4 p2, 0x1

    iput-boolean p2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->r:Z

    new-instance p3, Landroid/graphics/Rect;

    invoke-direct {p3}, Landroid/graphics/Rect;-><init>()V

    iput-object p3, p0, Lchat/ola/vn/view/SlidingPaneLayout;->s:Landroid/graphics/Rect;

    new-instance p3, Ljava/util/ArrayList;

    invoke-direct {p3}, Ljava/util/ArrayList;-><init>()V

    iput-object p3, p0, Lchat/ola/vn/view/SlidingPaneLayout;->t:Ljava/util/ArrayList;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p3

    invoke-virtual {p3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p3

    iget p3, p3, Landroid/util/DisplayMetrics;->density:F

    const/high16 v0, 0x42000000    # 32.0f

    mul-float v0, v0, p3

    const/high16 v1, 0x3f000000    # 0.5f

    add-float/2addr v0, v1

    float-to-int v0, v0

    iput v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->e:I

    invoke-static {p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/SlidingPaneLayout;->setWillNotDraw(Z)V

    new-instance p1, Lchat/ola/vn/view/SlidingPaneLayout$a;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/SlidingPaneLayout$a;-><init>(Lchat/ola/vn/view/SlidingPaneLayout;)V

    invoke-static {p0, p1}, Landroid/support/v4/view/ViewCompat;->setAccessibilityDelegate(Landroid/view/View;Landroid/support/v4/view/AccessibilityDelegateCompat;)V

    invoke-static {p0, p2}, Landroid/support/v4/view/ViewCompat;->setImportantForAccessibility(Landroid/view/View;I)V

    new-instance p1, Lchat/ola/vn/view/SlidingPaneLayout$c;

    const/4 v0, 0x0

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/view/SlidingPaneLayout$c;-><init>(Lchat/ola/vn/view/SlidingPaneLayout;Lchat/ola/vn/view/SlidingPaneLayout$1;)V

    invoke-static {p0, v1, p1}, Landroid/support/v4/widget/ViewDragHelper;->create(Landroid/view/ViewGroup;FLandroid/support/v4/widget/ViewDragHelper$Callback;)Landroid/support/v4/widget/ViewDragHelper;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    iget-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {p1, p2}, Landroid/support/v4/widget/ViewDragHelper;->setEdgeTrackingEnabled(I)V

    iget-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    const/high16 p2, 0x43c80000    # 400.0f

    mul-float p3, p3, p2

    invoke-virtual {p1, p3}, Landroid/support/v4/widget/ViewDragHelper;->setMinVelocity(F)V

    return-void
.end method

.method private a(F)V
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/SlidingPaneLayout$d;

    iget-boolean v1, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->c:Z

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    iget v0, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->leftMargin:I

    if-gtz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildCount()I

    move-result v1

    :goto_1
    if-ge v2, v1, :cond_3

    invoke-virtual {p0, v2}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    iget-object v4, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    if-ne v3, v4, :cond_1

    goto :goto_2

    :cond_1
    iget v4, p0, Lchat/ola/vn/view/SlidingPaneLayout;->i:F

    const/high16 v5, 0x3f800000    # 1.0f

    sub-float v4, v5, v4

    iget v6, p0, Lchat/ola/vn/view/SlidingPaneLayout;->l:I

    int-to-float v6, v6

    mul-float v4, v4, v6

    float-to-int v4, v4

    iput p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->i:F

    sub-float v6, v5, p1

    iget v7, p0, Lchat/ola/vn/view/SlidingPaneLayout;->l:I

    int-to-float v7, v7

    mul-float v6, v6, v7

    float-to-int v6, v6

    sub-int/2addr v4, v6

    invoke-virtual {v3, v4}, Landroid/view/View;->offsetLeftAndRight(I)V

    if-eqz v0, :cond_2

    iget v4, p0, Lchat/ola/vn/view/SlidingPaneLayout;->i:F

    sub-float/2addr v5, v4

    iget v4, p0, Lchat/ola/vn/view/SlidingPaneLayout;->c:I

    invoke-direct {p0, v3, v5, v4}, Lchat/ola/vn/view/SlidingPaneLayout;->a(Landroid/view/View;FI)V

    :cond_2
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_3
    return-void
.end method

.method private a(I)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    if-nez v0, :cond_0

    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/SlidingPaneLayout$d;

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingLeft()I

    move-result v1

    iget v2, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->leftMargin:I

    add-int/2addr v1, v2

    sub-int/2addr p1, v1

    int-to-float p1, p1

    iget v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->j:I

    int-to-float v1, v1

    div-float/2addr p1, v1

    iput p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    iget p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->l:I

    if-eqz p1, :cond_1

    iget p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    invoke-direct {p0, p1}, Lchat/ola/vn/view/SlidingPaneLayout;->a(F)V

    :cond_1
    iget-boolean p1, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->c:Z

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    iget v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    iget v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->b:I

    invoke-direct {p0, p1, v0, v1}, Lchat/ola/vn/view/SlidingPaneLayout;->a(Landroid/view/View;FI)V

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/SlidingPaneLayout;->a(Landroid/view/View;)V

    return-void
.end method

.method private a(Landroid/view/View;FI)V
    .locals 3

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/SlidingPaneLayout$d;

    const/4 v1, 0x0

    cmpl-float v1, p2, v1

    if-lez v1, :cond_2

    if-eqz p3, :cond_2

    const/high16 v1, -0x1000000

    and-int/2addr v1, p3

    ushr-int/lit8 v1, v1, 0x18

    int-to-float v1, v1

    mul-float v1, v1, p2

    float-to-int p2, v1

    shl-int/lit8 p2, p2, 0x18

    const v1, 0xffffff

    and-int/2addr p3, v1

    or-int/2addr p2, p3

    iget-object p3, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->d:Landroid/graphics/Paint;

    if-nez p3, :cond_0

    new-instance p3, Landroid/graphics/Paint;

    invoke-direct {p3}, Landroid/graphics/Paint;-><init>()V

    iput-object p3, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->d:Landroid/graphics/Paint;

    :cond_0
    iget-object p3, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->d:Landroid/graphics/Paint;

    new-instance v1, Landroid/graphics/PorterDuffColorFilter;

    sget-object v2, Landroid/graphics/PorterDuff$Mode;->SRC_OVER:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v1, p2, v2}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    invoke-virtual {p3, v1}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    invoke-static {p1}, Landroid/support/v4/view/ViewCompat;->getLayerType(Landroid/view/View;)I

    move-result p2

    const/4 p3, 0x2

    if-eq p2, p3, :cond_1

    iget-object p2, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->d:Landroid/graphics/Paint;

    invoke-static {p1, p3, p2}, Landroid/support/v4/view/ViewCompat;->setLayerType(Landroid/view/View;ILandroid/graphics/Paint;)V

    :cond_1
    invoke-direct {p0, p1}, Lchat/ola/vn/view/SlidingPaneLayout;->g(Landroid/view/View;)V

    return-void

    :cond_2
    invoke-static {p1}, Landroid/support/v4/view/ViewCompat;->getLayerType(Landroid/view/View;)I

    move-result p2

    if-eqz p2, :cond_4

    iget-object p2, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->d:Landroid/graphics/Paint;

    if-eqz p2, :cond_3

    iget-object p2, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->d:Landroid/graphics/Paint;

    const/4 p3, 0x0

    invoke-virtual {p2, p3}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    :cond_3
    new-instance p2, Lchat/ola/vn/view/SlidingPaneLayout$b;

    invoke-direct {p2, p0, p1}, Lchat/ola/vn/view/SlidingPaneLayout$b;-><init>(Lchat/ola/vn/view/SlidingPaneLayout;Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->t:Ljava/util/ArrayList;

    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-static {p0, p2}, Landroid/support/v4/view/ViewCompat;->postOnAnimation(Landroid/view/View;Ljava/lang/Runnable;)V

    :cond_4
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/SlidingPaneLayout;I)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/SlidingPaneLayout;->a(I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/SlidingPaneLayout;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/SlidingPaneLayout;->g(Landroid/view/View;)V

    return-void
.end method

.method private a(Landroid/view/View;I)Z
    .locals 1

    iget-boolean p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->r:Z

    const/4 v0, 0x0

    if-nez p1, :cond_1

    const/4 p1, 0x0

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/view/SlidingPaneLayout;->a(FI)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    return v0

    :cond_1
    :goto_0
    iput-boolean v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->q:Z

    const/4 p1, 0x1

    return p1
.end method

.method static synthetic a(Lchat/ola/vn/view/SlidingPaneLayout;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->k:Z

    return p0
.end method

.method static synthetic a(Lchat/ola/vn/view/SlidingPaneLayout;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->q:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/view/SlidingPaneLayout;)Landroid/support/v4/widget/ViewDragHelper;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    return-object p0
.end method

.method private b(Landroid/view/View;I)Z
    .locals 0

    iget-boolean p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->r:Z

    if-nez p1, :cond_1

    const/high16 p1, 0x3f800000    # 1.0f

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/view/SlidingPaneLayout;->a(FI)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return p1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->q:Z

    return p1
.end method

.method static synthetic c(Lchat/ola/vn/view/SlidingPaneLayout;)F
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    return p0
.end method

.method static synthetic d(Lchat/ola/vn/view/SlidingPaneLayout;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/view/SlidingPaneLayout;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->j:I

    return p0
.end method

.method static synthetic f(Lchat/ola/vn/view/SlidingPaneLayout;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->t:Ljava/util/ArrayList;

    return-object p0
.end method

.method private static f(Landroid/view/View;)Z
    .locals 4

    invoke-static {p0}, Landroid/support/v4/view/ViewCompat;->isOpaque(Landroid/view/View;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x12

    const/4 v3, 0x0

    if-lt v0, v2, :cond_1

    return v3

    :cond_1
    invoke-virtual {p0}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object p0

    if-eqz p0, :cond_3

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getOpacity()I

    move-result p0

    const/4 v0, -0x1

    if-ne p0, v0, :cond_2

    return v1

    :cond_2
    const/4 v1, 0x0

    return v1

    :cond_3
    return v3
.end method

.method private g(Landroid/view/View;)V
    .locals 1

    sget-object v0, Lchat/ola/vn/view/SlidingPaneLayout;->a:Lchat/ola/vn/view/SlidingPaneLayout$f;

    invoke-interface {v0, p0, p1}, Lchat/ola/vn/view/SlidingPaneLayout$f;->a(Lchat/ola/vn/view/SlidingPaneLayout;Landroid/view/View;)V

    return-void
.end method


# virtual methods
.method a()V
    .locals 6

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildCount()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_1

    invoke-virtual {p0, v2}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getVisibility()I

    move-result v4

    const/4 v5, 0x4

    if-ne v4, v5, :cond_0

    invoke-virtual {v3, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method a(Landroid/view/View;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->o:Lchat/ola/vn/view/SlidingPaneLayout$e;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->o:Lchat/ola/vn/view/SlidingPaneLayout$e;

    iget v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    invoke-interface {v0, p1, v1}, Lchat/ola/vn/view/SlidingPaneLayout$e;->a(Landroid/view/View;F)V

    :cond_0
    return-void
.end method

.method a(FI)Z
    .locals 3

    iget-boolean p2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    const/4 v0, 0x0

    if-nez p2, :cond_0

    return v0

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    invoke-virtual {p2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/SlidingPaneLayout$d;

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingLeft()I

    move-result v1

    iget p2, p2, Lchat/ola/vn/view/SlidingPaneLayout$d;->leftMargin:I

    add-int/2addr v1, p2

    int-to-float p2, v1

    iget v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->j:I

    int-to-float v1, v1

    mul-float p1, p1, v1

    add-float/2addr p2, p1

    float-to-int p1, p2

    iget-object p2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    iget-object v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->getTop()I

    move-result v2

    invoke-virtual {p2, v1, p1, v2}, Landroid/support/v4/widget/ViewDragHelper;->smoothSlideViewTo(Landroid/view/View;II)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->a()V

    invoke-static {p0}, Landroid/support/v4/view/ViewCompat;->postInvalidateOnAnimation(Landroid/view/View;)V

    const/4 p1, 0x1

    return p1

    :cond_1
    return v0
.end method

.method b(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->o:Lchat/ola/vn/view/SlidingPaneLayout$e;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->o:Lchat/ola/vn/view/SlidingPaneLayout$e;

    invoke-interface {v0, p1}, Lchat/ola/vn/view/SlidingPaneLayout$e;->a(Landroid/view/View;)V

    :cond_0
    const/16 p1, 0x20

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/SlidingPaneLayout;->sendAccessibilityEvent(I)V

    return-void
.end method

.method public b()Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/view/SlidingPaneLayout;->b(Landroid/view/View;I)Z

    move-result v0

    return v0
.end method

.method c(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->o:Lchat/ola/vn/view/SlidingPaneLayout$e;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->o:Lchat/ola/vn/view/SlidingPaneLayout$e;

    invoke-interface {v0, p1}, Lchat/ola/vn/view/SlidingPaneLayout$e;->b(Landroid/view/View;)V

    :cond_0
    const/16 p1, 0x20

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/SlidingPaneLayout;->sendAccessibilityEvent(I)V

    return-void
.end method

.method public c()Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/view/SlidingPaneLayout;->a(Landroid/view/View;I)Z

    move-result v0

    return v0
.end method

.method protected checkLayoutParams(Landroid/view/ViewGroup$LayoutParams;)Z
    .locals 1

    instance-of v0, p1, Lchat/ola/vn/view/SlidingPaneLayout$d;

    if-eqz v0, :cond_0

    invoke-super {p0, p1}, Landroid/view/ViewGroup;->checkLayoutParams(Landroid/view/ViewGroup$LayoutParams;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public computeScroll()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/ViewDragHelper;->continueSettling(Z)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v0}, Landroid/support/v4/widget/ViewDragHelper;->abort()V

    return-void

    :cond_0
    invoke-static {p0}, Landroid/support/v4/view/ViewCompat;->postInvalidateOnAnimation(Landroid/view/View;)V

    :cond_1
    return-void
.end method

.method d(Landroid/view/View;)V
    .locals 17

    move-object/from16 v0, p1

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingLeft()I

    move-result v1

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getWidth()I

    move-result v2

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingRight()I

    move-result v3

    sub-int/2addr v2, v3

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingTop()I

    move-result v3

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getHeight()I

    move-result v4

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingBottom()I

    move-result v5

    sub-int/2addr v4, v5

    if-eqz v0, :cond_0

    invoke-static/range {p1 .. p1}, Lchat/ola/vn/view/SlidingPaneLayout;->f(Landroid/view/View;)Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getLeft()I

    move-result v6

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getRight()I

    move-result v7

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getTop()I

    move-result v8

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getBottom()I

    move-result v9

    goto :goto_0

    :cond_0
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    :goto_0
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildCount()I

    move-result v10

    const/4 v11, 0x0

    :goto_1
    if-ge v11, v10, :cond_3

    move-object/from16 v12, p0

    invoke-virtual {v12, v11}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v13

    if-ne v13, v0, :cond_1

    return-void

    :cond_1
    invoke-virtual {v13}, Landroid/view/View;->getLeft()I

    move-result v14

    invoke-static {v1, v14}, Ljava/lang/Math;->max(II)I

    move-result v14

    invoke-virtual {v13}, Landroid/view/View;->getTop()I

    move-result v15

    invoke-static {v3, v15}, Ljava/lang/Math;->max(II)I

    move-result v15

    invoke-virtual {v13}, Landroid/view/View;->getRight()I

    move-result v5

    invoke-static {v2, v5}, Ljava/lang/Math;->min(II)I

    move-result v5

    invoke-virtual {v13}, Landroid/view/View;->getBottom()I

    move-result v0

    invoke-static {v4, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    if-lt v14, v6, :cond_2

    if-lt v15, v8, :cond_2

    if-gt v5, v7, :cond_2

    if-gt v0, v9, :cond_2

    const/4 v5, 0x4

    goto :goto_2

    :cond_2
    const/4 v5, 0x0

    :goto_2
    invoke-virtual {v13, v5}, Landroid/view/View;->setVisibility(I)V

    add-int/lit8 v11, v11, 0x1

    move-object/from16 v0, p1

    goto :goto_1

    :cond_3
    move-object/from16 v12, p0

    return-void
.end method

.method public d()Z
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    if-eqz v0, :cond_1

    iget v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    const/high16 v1, 0x3f800000    # 1.0f

    cmpl-float v0, v0, v1

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    return v0

    :cond_1
    :goto_0
    const/4 v0, 0x1

    return v0
.end method

.method public draw(Landroid/graphics/Canvas;)V
    .locals 5

    invoke-super {p0, p1}, Landroid/view/ViewGroup;->draw(Landroid/graphics/Canvas;)V

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildCount()I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_0

    invoke-virtual {p0, v1}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_2

    iget-object v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->d:Landroid/graphics/drawable/Drawable;

    if-nez v1, :cond_1

    return-void

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->d:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v1

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v2

    invoke-virtual {v0}, Landroid/view/View;->getTop()I

    move-result v3

    invoke-virtual {v0}, Landroid/view/View;->getBottom()I

    move-result v0

    sub-int v1, v2, v1

    iget-object v4, p0, Lchat/ola/vn/view/SlidingPaneLayout;->d:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v4, v1, v3, v2, v0}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->d:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    :cond_2
    return-void
.end method

.method protected drawChild(Landroid/graphics/Canvas;Landroid/view/View;J)Z
    .locals 5

    invoke-virtual {p2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/SlidingPaneLayout$d;

    const/4 v1, 0x2

    invoke-virtual {p1, v1}, Landroid/graphics/Canvas;->save(I)I

    move-result v1

    iget-boolean v2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    if-eqz v2, :cond_0

    iget-boolean v2, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->b:Z

    if-nez v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->s:Landroid/graphics/Rect;

    invoke-virtual {p1, v2}, Landroid/graphics/Canvas;->getClipBounds(Landroid/graphics/Rect;)Z

    iget-object v2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->s:Landroid/graphics/Rect;

    iget-object v3, p0, Lchat/ola/vn/view/SlidingPaneLayout;->s:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->right:I

    iget-object v4, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    invoke-virtual {v4}, Landroid/view/View;->getLeft()I

    move-result v4

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v3

    iput v3, v2, Landroid/graphics/Rect;->right:I

    iget-object v2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->s:Landroid/graphics/Rect;

    invoke-virtual {p1, v2}, Landroid/graphics/Canvas;->clipRect(Landroid/graphics/Rect;)Z

    :cond_0
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0xb

    if-lt v2, v3, :cond_2

    :cond_1
    :goto_0
    invoke-super {p0, p1, p2, p3, p4}, Landroid/view/ViewGroup;->drawChild(Landroid/graphics/Canvas;Landroid/view/View;J)Z

    move-result p2

    goto :goto_1

    :cond_2
    iget-boolean v2, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->c:Z

    const/4 v3, 0x0

    if-eqz v2, :cond_5

    iget v2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    const/4 v4, 0x0

    cmpl-float v2, v2, v4

    if-lez v2, :cond_5

    invoke-virtual {p2}, Landroid/view/View;->isDrawingCacheEnabled()Z

    move-result v2

    if-nez v2, :cond_3

    const/4 v2, 0x1

    invoke-virtual {p2, v2}, Landroid/view/View;->setDrawingCacheEnabled(Z)V

    :cond_3
    invoke-virtual {p2}, Landroid/view/View;->getDrawingCache()Landroid/graphics/Bitmap;

    move-result-object v2

    if-eqz v2, :cond_4

    invoke-virtual {p2}, Landroid/view/View;->getLeft()I

    move-result p3

    int-to-float p3, p3

    invoke-virtual {p2}, Landroid/view/View;->getTop()I

    move-result p2

    int-to-float p2, p2

    iget-object p4, v0, Lchat/ola/vn/view/SlidingPaneLayout$d;->d:Landroid/graphics/Paint;

    invoke-virtual {p1, v2, p3, p2, p4}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    const/4 p2, 0x0

    goto :goto_1

    :cond_4
    const-string v0, "SlidingPaneLayout"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "drawChild: child view "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v3, " returned null drawing cache"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_5
    invoke-virtual {p2}, Landroid/view/View;->isDrawingCacheEnabled()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p2, v3}, Landroid/view/View;->setDrawingCacheEnabled(Z)V

    goto :goto_0

    :goto_1
    invoke-virtual {p1, v1}, Landroid/graphics/Canvas;->restoreToCount(I)V

    return p2
.end method

.method public e()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    return v0
.end method

.method e(Landroid/view/View;)Z
    .locals 2

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/SlidingPaneLayout$d;

    iget-boolean v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    if-eqz v1, :cond_1

    iget-boolean p1, p1, Lchat/ola/vn/view/SlidingPaneLayout$d;->c:Z

    if-eqz p1, :cond_1

    iget p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    const/4 v1, 0x0

    cmpl-float p1, p1, v1

    if-lez p1, :cond_1

    const/4 v0, 0x1

    :cond_1
    return v0
.end method

.method protected generateDefaultLayoutParams()Landroid/view/ViewGroup$LayoutParams;
    .locals 1

    new-instance v0, Lchat/ola/vn/view/SlidingPaneLayout$d;

    invoke-direct {v0}, Lchat/ola/vn/view/SlidingPaneLayout$d;-><init>()V

    return-object v0
.end method

.method public generateLayoutParams(Landroid/util/AttributeSet;)Landroid/view/ViewGroup$LayoutParams;
    .locals 2

    new-instance v0, Lchat/ola/vn/view/SlidingPaneLayout$d;

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Lchat/ola/vn/view/SlidingPaneLayout$d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-object v0
.end method

.method protected generateLayoutParams(Landroid/view/ViewGroup$LayoutParams;)Landroid/view/ViewGroup$LayoutParams;
    .locals 1

    instance-of v0, p1, Landroid/view/ViewGroup$MarginLayoutParams;

    if-eqz v0, :cond_0

    new-instance v0, Lchat/ola/vn/view/SlidingPaneLayout$d;

    check-cast p1, Landroid/view/ViewGroup$MarginLayoutParams;

    invoke-direct {v0, p1}, Lchat/ola/vn/view/SlidingPaneLayout$d;-><init>(Landroid/view/ViewGroup$MarginLayoutParams;)V

    return-object v0

    :cond_0
    new-instance v0, Lchat/ola/vn/view/SlidingPaneLayout$d;

    invoke-direct {v0, p1}, Lchat/ola/vn/view/SlidingPaneLayout$d;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    return-object v0
.end method

.method public getCoveredFadeColor()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->c:I

    return v0
.end method

.method public getParallaxDistance()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->l:I

    return v0
.end method

.method public getSliderFadeColor()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->b:I

    return v0
.end method

.method protected onAttachedToWindow()V
    .locals 1

    invoke-super {p0}, Landroid/view/ViewGroup;->onAttachedToWindow()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->r:Z

    return-void
.end method

.method protected onDetachedFromWindow()V
    .locals 3

    invoke-super {p0}, Landroid/view/ViewGroup;->onDetachedFromWindow()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->r:Z

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->t:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    iget-object v2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->t:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/SlidingPaneLayout$b;

    invoke-virtual {v2}, Lchat/ola/vn/view/SlidingPaneLayout$b;->run()V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->t:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    return-void
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 6

    invoke-static {p1}, Landroid/support/v4/view/MotionEventCompat;->getActionMasked(Landroid/view/MotionEvent;)I

    move-result v0

    iget-boolean v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    const/4 v2, 0x1

    if-nez v1, :cond_0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildCount()I

    move-result v1

    if-le v1, v2, :cond_0

    invoke-virtual {p0, v2}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v3, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v4

    float-to-int v4, v4

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v5

    float-to-int v5, v5

    invoke-virtual {v3, v1, v4, v5}, Landroid/support/v4/widget/ViewDragHelper;->isViewUnder(Landroid/view/View;II)Z

    move-result v1

    xor-int/2addr v1, v2

    iput-boolean v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->q:Z

    :cond_0
    iget-boolean v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    if-eqz v1, :cond_9

    iget-boolean v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->k:Z

    if-eqz v1, :cond_1

    if-eqz v0, :cond_1

    goto/16 :goto_3

    :cond_1
    const/4 v1, 0x3

    const/4 v3, 0x0

    if-eq v0, v1, :cond_8

    if-ne v0, v2, :cond_2

    goto :goto_2

    :cond_2
    if-eqz v0, :cond_4

    const/4 v1, 0x2

    if-eq v0, v1, :cond_3

    goto :goto_0

    :cond_3
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    iget v4, p0, Lchat/ola/vn/view/SlidingPaneLayout;->m:F

    sub-float/2addr v0, v4

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    iget v4, p0, Lchat/ola/vn/view/SlidingPaneLayout;->n:F

    sub-float/2addr v1, v4

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    iget-object v4, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v4}, Landroid/support/v4/widget/ViewDragHelper;->getTouchSlop()I

    move-result v4

    int-to-float v4, v4

    cmpl-float v4, v0, v4

    if-lez v4, :cond_5

    cmpl-float v0, v1, v0

    if-lez v0, :cond_5

    iget-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {p1}, Landroid/support/v4/widget/ViewDragHelper;->cancel()V

    iput-boolean v2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->k:Z

    return v3

    :cond_4
    iput-boolean v3, p0, Lchat/ola/vn/view/SlidingPaneLayout;->k:Z

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    iput v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->m:F

    iput v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->n:F

    iget-object v4, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    iget-object v5, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    float-to-int v0, v0

    float-to-int v1, v1

    invoke-virtual {v4, v5, v0, v1}, Landroid/support/v4/widget/ViewDragHelper;->isViewUnder(Landroid/view/View;II)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/SlidingPaneLayout;->e(Landroid/view/View;)Z

    move-result v0

    if-eqz v0, :cond_5

    const/4 v0, 0x1

    goto :goto_1

    :cond_5
    :goto_0
    const/4 v0, 0x0

    :goto_1
    iget-object v1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v1, p1}, Landroid/support/v4/widget/ViewDragHelper;->shouldInterceptTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    if-nez p1, :cond_7

    if-eqz v0, :cond_6

    return v2

    :cond_6
    const/4 v2, 0x0

    :cond_7
    return v2

    :cond_8
    :goto_2
    iget-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {p1}, Landroid/support/v4/widget/ViewDragHelper;->cancel()V

    return v3

    :cond_9
    :goto_3
    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v0}, Landroid/support/v4/widget/ViewDragHelper;->cancel()V

    invoke-super {p0, p1}, Landroid/view/ViewGroup;->onInterceptTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method protected onLayout(ZIIII)V
    .locals 17

    move-object/from16 v0, p0

    sub-int v1, p4, p2

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingLeft()I

    move-result v2

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingRight()I

    move-result v3

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingTop()I

    move-result v4

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildCount()I

    move-result v5

    iget-boolean v6, v0, Lchat/ola/vn/view/SlidingPaneLayout;->r:Z

    const/4 v7, 0x0

    const/high16 v8, 0x3f800000    # 1.0f

    if-eqz v6, :cond_1

    iget-boolean v6, v0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    if-eqz v6, :cond_0

    iget-boolean v6, v0, Lchat/ola/vn/view/SlidingPaneLayout;->q:Z

    if-eqz v6, :cond_0

    const/high16 v6, 0x3f800000    # 1.0f

    goto :goto_0

    :cond_0
    const/4 v6, 0x0

    :goto_0
    iput v6, v0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    :cond_1
    move v9, v2

    move v10, v9

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v5, :cond_6

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v11

    invoke-virtual {v11}, Landroid/view/View;->getVisibility()I

    move-result v12

    const/16 v13, 0x8

    if-ne v12, v13, :cond_2

    goto :goto_5

    :cond_2
    invoke-virtual {v11}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v12

    check-cast v12, Lchat/ola/vn/view/SlidingPaneLayout$d;

    invoke-virtual {v11}, Landroid/view/View;->getMeasuredWidth()I

    move-result v13

    iget-boolean v14, v12, Lchat/ola/vn/view/SlidingPaneLayout$d;->b:Z

    if-eqz v14, :cond_4

    iget v14, v12, Lchat/ola/vn/view/SlidingPaneLayout$d;->leftMargin:I

    iget v15, v12, Lchat/ola/vn/view/SlidingPaneLayout$d;->rightMargin:I

    add-int/2addr v14, v15

    sub-int v15, v1, v3

    iget v6, v0, Lchat/ola/vn/view/SlidingPaneLayout;->e:I

    sub-int v6, v15, v6

    invoke-static {v9, v6}, Ljava/lang/Math;->min(II)I

    move-result v6

    sub-int/2addr v6, v10

    sub-int/2addr v6, v14

    iput v6, v0, Lchat/ola/vn/view/SlidingPaneLayout;->j:I

    iget v14, v12, Lchat/ola/vn/view/SlidingPaneLayout$d;->leftMargin:I

    add-int/2addr v14, v10

    add-int/2addr v14, v6

    div-int/lit8 v16, v13, 0x2

    add-int v14, v14, v16

    if-le v14, v15, :cond_3

    const/4 v14, 0x1

    goto :goto_2

    :cond_3
    const/4 v14, 0x0

    :goto_2
    iput-boolean v14, v12, Lchat/ola/vn/view/SlidingPaneLayout$d;->c:Z

    int-to-float v6, v6

    iget v14, v0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    mul-float v6, v6, v14

    float-to-int v6, v6

    iget v12, v12, Lchat/ola/vn/view/SlidingPaneLayout$d;->leftMargin:I

    add-int/2addr v12, v6

    add-int/2addr v10, v12

    int-to-float v6, v6

    iget v12, v0, Lchat/ola/vn/view/SlidingPaneLayout;->j:I

    int-to-float v12, v12

    div-float/2addr v6, v12

    iput v6, v0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    goto :goto_3

    :cond_4
    iget-boolean v6, v0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    if-eqz v6, :cond_5

    iget v6, v0, Lchat/ola/vn/view/SlidingPaneLayout;->l:I

    if-eqz v6, :cond_5

    iget v6, v0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    sub-float v6, v8, v6

    iget v10, v0, Lchat/ola/vn/view/SlidingPaneLayout;->l:I

    int-to-float v10, v10

    mul-float v6, v6, v10

    float-to-int v6, v6

    move v10, v9

    goto :goto_4

    :cond_5
    move v10, v9

    :goto_3
    const/4 v6, 0x0

    :goto_4
    sub-int v6, v10, v6

    add-int/2addr v13, v6

    invoke-virtual {v11}, Landroid/view/View;->getMeasuredHeight()I

    move-result v12

    add-int/2addr v12, v4

    invoke-virtual {v11, v6, v4, v13, v12}, Landroid/view/View;->layout(IIII)V

    invoke-virtual {v11}, Landroid/view/View;->getWidth()I

    move-result v6

    add-int/2addr v9, v6

    :goto_5
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_6
    iget-boolean v1, v0, Lchat/ola/vn/view/SlidingPaneLayout;->r:Z

    if-eqz v1, :cond_a

    iget-boolean v1, v0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    if-eqz v1, :cond_8

    iget v1, v0, Lchat/ola/vn/view/SlidingPaneLayout;->l:I

    if-eqz v1, :cond_7

    iget v1, v0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    invoke-direct {v0, v1}, Lchat/ola/vn/view/SlidingPaneLayout;->a(F)V

    :cond_7
    iget-object v1, v0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/SlidingPaneLayout$d;

    iget-boolean v1, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->c:Z

    if-eqz v1, :cond_9

    iget-object v1, v0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    iget v2, v0, Lchat/ola/vn/view/SlidingPaneLayout;->h:F

    iget v3, v0, Lchat/ola/vn/view/SlidingPaneLayout;->b:I

    invoke-direct {v0, v1, v2, v3}, Lchat/ola/vn/view/SlidingPaneLayout;->a(Landroid/view/View;FI)V

    goto :goto_7

    :cond_8
    const/4 v1, 0x0

    :goto_6
    if-ge v1, v5, :cond_9

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    iget v3, v0, Lchat/ola/vn/view/SlidingPaneLayout;->b:I

    invoke-direct {v0, v2, v7, v3}, Lchat/ola/vn/view/SlidingPaneLayout;->a(Landroid/view/View;FI)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    :cond_9
    :goto_7
    iget-object v1, v0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/SlidingPaneLayout;->d(Landroid/view/View;)V

    :cond_a
    const/4 v1, 0x0

    iput-boolean v1, v0, Lchat/ola/vn/view/SlidingPaneLayout;->r:Z

    return-void
.end method

.method protected onMeasure(II)V
    .locals 20

    move-object/from16 v0, p0

    invoke-static/range {p1 .. p1}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v1

    invoke-static/range {p1 .. p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v2

    invoke-static/range {p2 .. p2}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v3

    invoke-static/range {p2 .. p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v4

    const/16 v5, 0x12c

    const/high16 v6, -0x80000000

    const/high16 v7, 0x40000000    # 2.0f

    if-eq v1, v7, :cond_2

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->isInEditMode()Z

    move-result v8

    if-eqz v8, :cond_1

    if-ne v1, v6, :cond_0

    goto :goto_0

    :cond_0
    if-nez v1, :cond_4

    const/16 v2, 0x12c

    goto :goto_0

    :cond_1
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "Width must have an exact value or MATCH_PARENT"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_2
    if-nez v3, :cond_4

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->isInEditMode()Z

    move-result v1

    if-eqz v1, :cond_3

    if-nez v3, :cond_4

    const/high16 v3, -0x80000000

    const/16 v4, 0x12c

    goto :goto_0

    :cond_3
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "Height must not be UNSPECIFIED"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_4
    :goto_0
    const/4 v5, 0x0

    if-eq v3, v6, :cond_6

    if-eq v3, v7, :cond_5

    const/4 v4, 0x0

    const/4 v8, -0x1

    goto :goto_1

    :cond_5
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingTop()I

    move-result v8

    sub-int/2addr v4, v8

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingBottom()I

    move-result v8

    sub-int/2addr v4, v8

    move v8, v4

    goto :goto_1

    :cond_6
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingTop()I

    move-result v8

    sub-int/2addr v4, v8

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingBottom()I

    move-result v8

    sub-int/2addr v4, v8

    move v8, v4

    const/4 v4, 0x0

    :goto_1
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingLeft()I

    move-result v9

    sub-int v9, v2, v9

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingRight()I

    move-result v10

    sub-int/2addr v9, v10

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildCount()I

    move-result v10

    const/4 v11, 0x2

    if-le v10, v11, :cond_7

    const-string v11, "SlidingPaneLayout"

    const-string v12, "onMeasure: More than two child views are not supported."

    invoke-static {v11, v12}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_7
    const/4 v11, 0x0

    iput-object v11, v0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    move v14, v4

    move v15, v9

    const/4 v4, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    :goto_2
    const/16 v7, 0x8

    const/16 v16, 0x1

    if-ge v4, v10, :cond_11

    invoke-virtual {v0, v4}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v18

    move-object/from16 v1, v18

    check-cast v1, Lchat/ola/vn/view/SlidingPaneLayout$d;

    invoke-virtual {v6}, Landroid/view/View;->getVisibility()I

    move-result v11

    if-ne v11, v7, :cond_8

    iput-boolean v5, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->c:Z

    goto/16 :goto_8

    :cond_8
    iget v7, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->a:F

    const/4 v11, 0x0

    cmpl-float v7, v7, v11

    if-lez v7, :cond_9

    iget v7, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->a:F

    add-float/2addr v13, v7

    iget v7, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->width:I

    if-nez v7, :cond_9

    goto/16 :goto_8

    :cond_9
    iget v7, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->leftMargin:I

    iget v11, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->rightMargin:I

    add-int/2addr v7, v11

    iget v11, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->width:I

    const/4 v5, -0x2

    if-ne v11, v5, :cond_a

    sub-int v5, v9, v7

    const/high16 v7, -0x80000000

    invoke-static {v5, v7}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v5

    const/high16 v7, 0x40000000    # 2.0f

    goto :goto_4

    :cond_a
    iget v5, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->width:I

    const/4 v11, -0x1

    if-ne v5, v11, :cond_b

    sub-int v5, v9, v7

    const/high16 v7, 0x40000000    # 2.0f

    :goto_3
    invoke-static {v5, v7}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v5

    goto :goto_4

    :cond_b
    const/high16 v7, 0x40000000    # 2.0f

    iget v5, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->width:I

    goto :goto_3

    :goto_4
    iget v11, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->height:I

    const/4 v7, -0x2

    if-ne v11, v7, :cond_c

    const/high16 v7, -0x80000000

    :goto_5
    invoke-static {v8, v7}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v11

    goto :goto_6

    :cond_c
    iget v7, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->height:I

    const/4 v11, -0x1

    if-ne v7, v11, :cond_d

    const/high16 v7, 0x40000000    # 2.0f

    goto :goto_5

    :cond_d
    const/high16 v7, 0x40000000    # 2.0f

    iget v11, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->height:I

    invoke-static {v11, v7}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v11

    :goto_6
    invoke-virtual {v6, v5, v11}, Landroid/view/View;->measure(II)V

    invoke-virtual {v6}, Landroid/view/View;->getMeasuredWidth()I

    move-result v5

    invoke-virtual {v6}, Landroid/view/View;->getMeasuredHeight()I

    move-result v7

    const/high16 v11, -0x80000000

    if-ne v3, v11, :cond_e

    if-le v7, v14, :cond_e

    invoke-static {v7, v8}, Ljava/lang/Math;->min(II)I

    move-result v14

    :cond_e
    sub-int/2addr v15, v5

    if-gez v15, :cond_f

    const/4 v5, 0x1

    goto :goto_7

    :cond_f
    const/4 v5, 0x0

    :goto_7
    iput-boolean v5, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->b:Z

    or-int/2addr v5, v12

    iget-boolean v1, v1, Lchat/ola/vn/view/SlidingPaneLayout$d;->b:Z

    if-eqz v1, :cond_10

    iput-object v6, v0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    :cond_10
    move v12, v5

    :goto_8
    add-int/lit8 v4, v4, 0x1

    const/4 v5, 0x0

    const/high16 v6, -0x80000000

    goto/16 :goto_2

    :cond_11
    if-nez v12, :cond_12

    const/4 v1, 0x0

    cmpl-float v3, v13, v1

    if-lez v3, :cond_22

    :cond_12
    iget v1, v0, Lchat/ola/vn/view/SlidingPaneLayout;->e:I

    sub-int v1, v9, v1

    const/4 v3, 0x0

    :goto_9
    if-ge v3, v10, :cond_22

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/SlidingPaneLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/View;->getVisibility()I

    move-result v5

    if-ne v5, v7, :cond_15

    :cond_13
    :goto_a
    move/from16 v19, v1

    :cond_14
    :goto_b
    const/4 v1, 0x0

    const/high16 v5, 0x40000000    # 2.0f

    goto/16 :goto_13

    :cond_15
    invoke-virtual {v4}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/view/SlidingPaneLayout$d;

    invoke-virtual {v4}, Landroid/view/View;->getVisibility()I

    move-result v6

    if-ne v6, v7, :cond_16

    goto :goto_a

    :cond_16
    iget v6, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->width:I

    if-nez v6, :cond_17

    iget v6, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->a:F

    const/4 v11, 0x0

    cmpl-float v6, v6, v11

    if-lez v6, :cond_17

    const/4 v6, 0x1

    goto :goto_c

    :cond_17
    const/4 v6, 0x0

    :goto_c
    if-eqz v6, :cond_18

    const/4 v11, 0x0

    goto :goto_d

    :cond_18
    invoke-virtual {v4}, Landroid/view/View;->getMeasuredWidth()I

    move-result v11

    :goto_d
    if-eqz v12, :cond_1d

    iget-object v7, v0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    if-eq v4, v7, :cond_1d

    iget v7, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->width:I

    if-gez v7, :cond_13

    if-gt v11, v1, :cond_19

    iget v7, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->a:F

    const/4 v11, 0x0

    cmpl-float v7, v7, v11

    if-lez v7, :cond_13

    :cond_19
    if-eqz v6, :cond_1c

    iget v6, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->height:I

    const/4 v7, -0x2

    if-ne v6, v7, :cond_1a

    const/high16 v6, -0x80000000

    invoke-static {v8, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v5

    const/high16 v6, 0x40000000    # 2.0f

    goto :goto_f

    :cond_1a
    iget v6, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->height:I

    const/4 v7, -0x1

    if-ne v6, v7, :cond_1b

    const/high16 v6, 0x40000000    # 2.0f

    invoke-static {v8, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v5

    goto :goto_f

    :cond_1b
    const/high16 v6, 0x40000000    # 2.0f

    iget v5, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->height:I

    goto :goto_e

    :cond_1c
    const/high16 v6, 0x40000000    # 2.0f

    invoke-virtual {v4}, Landroid/view/View;->getMeasuredHeight()I

    move-result v5

    :goto_e
    invoke-static {v5, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v5

    :goto_f
    invoke-static {v1, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v7

    invoke-virtual {v4, v7, v5}, Landroid/view/View;->measure(II)V

    goto :goto_a

    :cond_1d
    iget v6, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->a:F

    const/4 v7, 0x0

    cmpl-float v6, v6, v7

    if-lez v6, :cond_13

    iget v6, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->width:I

    if-nez v6, :cond_20

    iget v6, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->height:I

    const/4 v7, -0x2

    if-ne v6, v7, :cond_1e

    const/high16 v6, -0x80000000

    invoke-static {v8, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v17

    move/from16 v7, v17

    const/high16 v6, 0x40000000    # 2.0f

    goto :goto_12

    :cond_1e
    iget v6, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->height:I

    const/4 v7, -0x1

    if-ne v6, v7, :cond_1f

    const/high16 v6, 0x40000000    # 2.0f

    invoke-static {v8, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v17

    goto :goto_11

    :cond_1f
    const/high16 v6, 0x40000000    # 2.0f

    iget v7, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->height:I

    goto :goto_10

    :cond_20
    const/high16 v6, 0x40000000    # 2.0f

    invoke-virtual {v4}, Landroid/view/View;->getMeasuredHeight()I

    move-result v7

    :goto_10
    invoke-static {v7, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v17

    :goto_11
    move/from16 v7, v17

    :goto_12
    if-eqz v12, :cond_21

    iget v6, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->leftMargin:I

    iget v5, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->rightMargin:I

    add-int/2addr v6, v5

    sub-int v5, v9, v6

    move/from16 v19, v1

    const/high16 v6, 0x40000000    # 2.0f

    invoke-static {v5, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v1

    if-eq v11, v5, :cond_14

    invoke-virtual {v4, v1, v7}, Landroid/view/View;->measure(II)V

    goto/16 :goto_b

    :cond_21
    move/from16 v19, v1

    const/4 v1, 0x0

    invoke-static {v1, v15}, Ljava/lang/Math;->max(II)I

    move-result v6

    iget v5, v5, Lchat/ola/vn/view/SlidingPaneLayout$d;->a:F

    int-to-float v6, v6

    mul-float v5, v5, v6

    div-float/2addr v5, v13

    float-to-int v5, v5

    add-int/2addr v11, v5

    const/high16 v5, 0x40000000    # 2.0f

    invoke-static {v11, v5}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v6

    invoke-virtual {v4, v6, v7}, Landroid/view/View;->measure(II)V

    :goto_13
    add-int/lit8 v3, v3, 0x1

    move/from16 v1, v19

    const/16 v7, 0x8

    goto/16 :goto_9

    :cond_22
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingTop()I

    move-result v1

    add-int/2addr v14, v1

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getPaddingBottom()I

    move-result v1

    add-int/2addr v14, v1

    invoke-virtual {v0, v2, v14}, Lchat/ola/vn/view/SlidingPaneLayout;->setMeasuredDimension(II)V

    iput-boolean v12, v0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    iget-object v1, v0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v1}, Landroid/support/v4/widget/ViewDragHelper;->getViewDragState()I

    move-result v1

    if-eqz v1, :cond_23

    if-nez v12, :cond_23

    iget-object v1, v0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v1}, Landroid/support/v4/widget/ViewDragHelper;->abort()V

    :cond_23
    return-void
.end method

.method protected onRestoreInstanceState(Landroid/os/Parcelable;)V
    .locals 1

    check-cast p1, Lchat/ola/vn/view/SlidingPaneLayout$SavedState;

    invoke-virtual {p1}, Lchat/ola/vn/view/SlidingPaneLayout$SavedState;->getSuperState()Landroid/os/Parcelable;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/view/ViewGroup;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    iget-boolean v0, p1, Lchat/ola/vn/view/SlidingPaneLayout$SavedState;->a:Z

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->b()Z

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->c()Z

    :goto_0
    iget-boolean p1, p1, Lchat/ola/vn/view/SlidingPaneLayout$SavedState;->a:Z

    iput-boolean p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->q:Z

    return-void
.end method

.method protected onSaveInstanceState()Landroid/os/Parcelable;
    .locals 2

    invoke-super {p0}, Landroid/view/ViewGroup;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/view/SlidingPaneLayout$SavedState;

    invoke-direct {v1, v0}, Lchat/ola/vn/view/SlidingPaneLayout$SavedState;-><init>(Landroid/os/Parcelable;)V

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->d()Z

    move-result v0

    goto :goto_0

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->q:Z

    :goto_0
    iput-boolean v0, v1, Lchat/ola/vn/view/SlidingPaneLayout$SavedState;->a:Z

    return-object v1
.end method

.method protected onSizeChanged(IIII)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Landroid/view/ViewGroup;->onSizeChanged(IIII)V

    if-eq p1, p3, :cond_0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->r:Z

    :cond_0
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 5

    iget-boolean v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    if-nez v0, :cond_0

    invoke-super {p0, p1}, Landroid/view/ViewGroup;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v0, p1}, Landroid/support/v4/widget/ViewDragHelper;->processTouchEvent(Landroid/view/MotionEvent;)V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x1

    and-int/lit16 v0, v0, 0xff

    packed-switch v0, :pswitch_data_0

    return v1

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/SlidingPaneLayout;->e(Landroid/view/View;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    iget v2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->m:F

    sub-float v2, v0, v2

    iget v3, p0, Lchat/ola/vn/view/SlidingPaneLayout;->n:F

    sub-float v3, p1, v3

    iget-object v4, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v4}, Landroid/support/v4/widget/ViewDragHelper;->getTouchSlop()I

    move-result v4

    mul-float v2, v2, v2

    mul-float v3, v3, v3

    add-float/2addr v2, v3

    mul-int v4, v4, v4

    int-to-float v3, v4

    cmpg-float v2, v2, v3

    if-gez v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->p:Landroid/support/v4/widget/ViewDragHelper;

    iget-object v3, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    float-to-int v0, v0

    float-to-int p1, p1

    invoke-virtual {v2, v3, v0, p1}, Landroid/support/v4/widget/ViewDragHelper;->isViewUnder(Landroid/view/View;II)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/view/SlidingPaneLayout;->a(Landroid/view/View;I)Z

    return v1

    :pswitch_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    iput v0, p0, Lchat/ola/vn/view/SlidingPaneLayout;->m:F

    iput p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->n:F

    :cond_1
    return v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public requestChildFocus(Landroid/view/View;Landroid/view/View;)V
    .locals 0

    invoke-super {p0, p1, p2}, Landroid/view/ViewGroup;->requestChildFocus(Landroid/view/View;Landroid/view/View;)V

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->isInTouchMode()Z

    move-result p2

    if-nez p2, :cond_1

    iget-boolean p2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->f:Z

    if-nez p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/view/SlidingPaneLayout;->g:Landroid/view/View;

    if-ne p1, p2, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    iput-boolean p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->q:Z

    :cond_1
    return-void
.end method

.method public setCoveredFadeColor(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->c:I

    return-void
.end method

.method public setPanelSlideListener(Lchat/ola/vn/view/SlidingPaneLayout$e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->o:Lchat/ola/vn/view/SlidingPaneLayout$e;

    return-void
.end method

.method public setParallaxDistance(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->l:I

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->requestLayout()V

    return-void
.end method

.method public setShadowDrawable(Landroid/graphics/drawable/Drawable;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->d:Landroid/graphics/drawable/Drawable;

    return-void
.end method

.method public setShadowResource(I)V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/view/SlidingPaneLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/SlidingPaneLayout;->setShadowDrawable(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method public setSliderFadeColor(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/view/SlidingPaneLayout;->b:I

    return-void
.end method
