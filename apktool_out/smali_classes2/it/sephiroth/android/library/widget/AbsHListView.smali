.class public abstract Lit/sephiroth/android/library/widget/AbsHListView;
.super Lit/sephiroth/android/library/widget/a;

# interfaces
.implements Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;
.implements Landroid/view/ViewTreeObserver$OnTouchModeChangeListener;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xb
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lit/sephiroth/android/library/widget/AbsHListView$k;,
        Lit/sephiroth/android/library/widget/AbsHListView$l;,
        Lit/sephiroth/android/library/widget/AbsHListView$f;,
        Lit/sephiroth/android/library/widget/AbsHListView$a;,
        Lit/sephiroth/android/library/widget/AbsHListView$j;,
        Lit/sephiroth/android/library/widget/AbsHListView$e;,
        Lit/sephiroth/android/library/widget/AbsHListView$d;,
        Lit/sephiroth/android/library/widget/AbsHListView$b;,
        Lit/sephiroth/android/library/widget/AbsHListView$c;,
        Lit/sephiroth/android/library/widget/AbsHListView$i;,
        Lit/sephiroth/android/library/widget/AbsHListView$n;,
        Lit/sephiroth/android/library/widget/AbsHListView$g;,
        Lit/sephiroth/android/library/widget/AbsHListView$SavedState;,
        Lit/sephiroth/android/library/widget/AbsHListView$m;,
        Lit/sephiroth/android/library/widget/AbsHListView$h;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lit/sephiroth/android/library/widget/a<",
        "Landroid/widget/ListAdapter;",
        ">;",
        "Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;",
        "Landroid/view/ViewTreeObserver$OnTouchModeChangeListener;"
    }
.end annotation


# static fields
.field static final T:Landroid/view/animation/Interpolator;

.field public static final U:[I


# instance fields
.field protected A:I

.field B:I

.field C:I

.field D:I

.field E:I

.field protected F:I

.field G:I

.field H:I

.field protected I:Lit/sephiroth/android/library/widget/AbsHListView$j;

.field protected J:I

.field protected K:Z

.field L:Z

.field protected M:I

.field protected N:I

.field protected O:Ljava/lang/Runnable;

.field protected final P:[Z

.field Q:I

.field R:I

.field protected S:Z

.field a:Lit/sephiroth/android/library/a/a$a;

.field private aA:I

.field private aB:Lit/sephiroth/android/library/widget/AbsHListView$c;

.field private aC:Ljava/lang/Runnable;

.field private aD:Lit/sephiroth/android/library/widget/AbsHListView$b;

.field private aE:Lit/sephiroth/android/library/widget/AbsHListView$i;

.field private aF:Ljava/lang/Runnable;

.field private aG:I

.field private aH:I

.field private aI:Z

.field private aJ:I

.field private aK:I

.field private aL:Ljava/lang/Runnable;

.field private aM:I

.field private aN:I

.field private aO:F

.field private aP:I

.field private aQ:Landroid/support/v4/widget/EdgeEffectCompat;

.field private aR:Landroid/support/v4/widget/EdgeEffectCompat;

.field private aS:I

.field private aT:I

.field private aU:I

.field private aV:Z

.field private aW:I

.field private aX:I

.field private aY:Lit/sephiroth/android/library/widget/AbsHListView$g;

.field private aZ:I

.field private au:Landroid/view/VelocityTracker;

.field private av:Lit/sephiroth/android/library/widget/AbsHListView$e;

.field private aw:Lit/sephiroth/android/library/widget/AbsHListView$h;

.field private ax:Z

.field private ay:Landroid/graphics/Rect;

.field private az:Landroid/view/ContextMenu$ContextMenuInfo;

.field protected b:I

.field private ba:I

.field private bb:I

.field private bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

.field private bd:F

.field public c:Ljava/lang/Object;

.field d:Ljava/lang/Object;

.field e:I

.field protected f:Landroid/support/v4/util/SparseArrayCompat;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/support/v4/util/SparseArrayCompat<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field g:Landroid/support/v4/util/LongSparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/support/v4/util/LongSparseArray<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field protected h:I

.field protected i:Lit/sephiroth/android/library/widget/AbsHListView$a;

.field protected j:Landroid/widget/ListAdapter;

.field k:Z

.field l:Z

.field m:Landroid/graphics/drawable/Drawable;

.field n:I

.field protected o:Landroid/graphics/Rect;

.field protected final p:Lit/sephiroth/android/library/widget/AbsHListView$k;

.field q:I

.field r:I

.field s:I

.field t:I

.field protected u:Landroid/graphics/Rect;

.field protected v:I

.field w:Landroid/view/View;

.field x:Landroid/view/View;

.field protected y:Z

.field protected z:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Landroid/view/animation/LinearInterpolator;

    invoke-direct {v0}, Landroid/view/animation/LinearInterpolator;-><init>()V

    sput-object v0, Lit/sephiroth/android/library/widget/AbsHListView;->T:Landroid/view/animation/Interpolator;

    const/4 v0, 0x1

    new-array v0, v0, [I

    const/4 v1, 0x0

    aput v1, v0, v1

    sput-object v0, Lit/sephiroth/android/library/widget/AbsHListView;->U:[I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 3

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/a;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->l:Z

    const/4 v0, -0x1

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->n:I

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    iput-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->o:Landroid/graphics/Rect;

    new-instance v1, Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-direct {v1, p0}, Lit/sephiroth/android/library/widget/AbsHListView$k;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->q:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->r:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->s:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->t:I

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    iput-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->v:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->J:I

    const/4 v1, 0x1

    iput-boolean v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ax:Z

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->M:I

    const/4 v2, 0x0

    iput-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->az:Landroid/view/ContextMenu$ContextMenuInfo;

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aA:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aJ:I

    const/high16 v2, 0x3f800000    # 1.0f

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aO:F

    new-array v1, v1, [Z

    iput-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->P:[Z

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aU:I

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->x()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const v0, 0x7f040136

    invoke-direct {p0, p1, p2, v0}, Lit/sephiroth/android/library/widget/AbsHListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 7

    invoke-direct {p0, p1, p2, p3}, Lit/sephiroth/android/library/widget/a;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 v0, 0x0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->l:Z

    const/4 v1, -0x1

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->n:I

    new-instance v2, Landroid/graphics/Rect;

    invoke-direct {v2}, Landroid/graphics/Rect;-><init>()V

    iput-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->o:Landroid/graphics/Rect;

    new-instance v2, Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-direct {v2, p0}, Lit/sephiroth/android/library/widget/AbsHListView$k;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->q:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->r:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->s:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->t:I

    new-instance v2, Landroid/graphics/Rect;

    invoke-direct {v2}, Landroid/graphics/Rect;-><init>()V

    iput-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->v:I

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->J:I

    const/4 v2, 0x1

    iput-boolean v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ax:Z

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->M:I

    const/4 v3, 0x0

    iput-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->az:Landroid/view/ContextMenu$ContextMenuInfo;

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aA:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aJ:I

    const/high16 v4, 0x3f800000    # 1.0f

    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aO:F

    new-array v4, v2, [Z

    iput-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->P:[Z

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aU:I

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->x()V

    invoke-virtual {p1}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object p1

    sget-object v1, Lchat/ola/vn/i$b;->AbsHListView:[I

    invoke-virtual {p1, p2, v1, p3, v0}, Landroid/content/res/Resources$Theme;->obtainStyledAttributes(Landroid/util/AttributeSet;[III)Landroid/content/res/TypedArray;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p1, v0}, Landroid/content/res/TypedArray;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {p1, v2, v0}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result p2

    const/4 p3, 0x6

    invoke-virtual {p1, p3, v0}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result p3

    const/4 v1, 0x2

    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v1

    const/4 v4, 0x7

    invoke-virtual {p1, v4, v0}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v4

    const/4 v5, 0x3

    invoke-virtual {p1, v5, v0}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v5

    const/4 v6, 0x5

    invoke-virtual {p1, v6, v2}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v2

    const/4 v6, 0x4

    invoke-virtual {p1, v6, v0}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v0

    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    move p1, v0

    move v0, v4

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    const/4 p2, 0x0

    const/4 p3, 0x0

    const/4 v1, 0x1

    const/4 v5, 0x0

    :goto_0
    if-eqz v3, :cond_1

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->setSelector(Landroid/graphics/drawable/Drawable;)V

    :cond_1
    iput-boolean p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->l:Z

    invoke-virtual {p0, p3}, Lit/sephiroth/android/library/widget/AbsHListView;->setStackFromRight(Z)V

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->setScrollingCacheEnabled(Z)V

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->setTranscriptMode(I)V

    invoke-virtual {p0, v5}, Lit/sephiroth/android/library/widget/AbsHListView;->setCacheColorHint(I)V

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->setSmoothScrollbarEnabled(Z)V

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->setChoiceMode(I)V

    return-void
.end method

.method private A()V
    .locals 2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x1080062

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->setSelector(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method private B()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    if-nez v0, :cond_0

    invoke-static {}, Landroid/view/VelocityTracker;->obtain()Landroid/view/VelocityTracker;

    move-result-object v0

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    return-void

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    invoke-virtual {v0}, Landroid/view/VelocityTracker;->clear()V

    return-void
.end method

.method private C()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    if-nez v0, :cond_0

    invoke-static {}, Landroid/view/VelocityTracker;->obtain()Landroid/view/VelocityTracker;

    move-result-object v0

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    :cond_0
    return-void
.end method

.method private D()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    invoke-virtual {v0}, Landroid/view/VelocityTracker;->recycle()V

    const/4 v0, 0x0

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    :cond_0
    return-void
.end method

.method private E()V
    .locals 1

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->L:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->y:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/a/a$a;->a()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->setChildrenDrawnWithCacheEnabled(Z)V

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->setChildrenDrawingCacheEnabled(Z)V

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->z:Z

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->y:Z

    :cond_0
    return-void
.end method

.method private F()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/a/a$a;->a()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aL:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lit/sephiroth/android/library/widget/AbsHListView$2;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/widget/AbsHListView$2;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aL:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aL:Ljava/lang/Runnable;

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->post(Ljava/lang/Runnable;)Z

    :cond_1
    return-void
.end method

.method private G()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v0}, Landroid/support/v4/widget/EdgeEffectCompat;->finish()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v0}, Landroid/support/v4/widget/EdgeEffectCompat;->finish()V

    :cond_0
    return-void
.end method

.method public static a(Landroid/graphics/Rect;Landroid/graphics/Rect;I)I
    .locals 2

    const/16 v0, 0x11

    if-eq p2, v0, :cond_3

    const/16 v0, 0x21

    if-eq p2, v0, :cond_2

    const/16 v0, 0x42

    if-eq p2, v0, :cond_1

    const/16 v0, 0x82

    if-eq p2, v0, :cond_0

    packed-switch p2, :pswitch_data_0

    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "direction must be one of {FOCUS_UP, FOCUS_DOWN, FOCUS_LEFT, FOCUS_RIGHT, FOCUS_FORWARD, FOCUS_BACKWARD}."

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :pswitch_0
    iget p2, p0, Landroid/graphics/Rect;->right:I

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result v0

    div-int/lit8 v0, v0, 0x2

    add-int/2addr p2, v0

    iget v0, p0, Landroid/graphics/Rect;->top:I

    invoke-virtual {p0}, Landroid/graphics/Rect;->height()I

    move-result p0

    div-int/lit8 p0, p0, 0x2

    add-int/2addr v0, p0

    iget p0, p1, Landroid/graphics/Rect;->left:I

    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    move-result v1

    div-int/lit8 v1, v1, 0x2

    add-int/2addr p0, v1

    :goto_0
    iget v1, p1, Landroid/graphics/Rect;->top:I

    invoke-virtual {p1}, Landroid/graphics/Rect;->height()I

    move-result p1

    div-int/lit8 p1, p1, 0x2

    add-int/2addr v1, p1

    goto :goto_1

    :cond_0
    iget p2, p0, Landroid/graphics/Rect;->left:I

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result v0

    div-int/lit8 v0, v0, 0x2

    add-int/2addr p2, v0

    iget v0, p0, Landroid/graphics/Rect;->bottom:I

    iget p0, p1, Landroid/graphics/Rect;->left:I

    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    move-result v1

    div-int/lit8 v1, v1, 0x2

    add-int/2addr p0, v1

    iget v1, p1, Landroid/graphics/Rect;->top:I

    goto :goto_1

    :cond_1
    iget p2, p0, Landroid/graphics/Rect;->right:I

    iget v0, p0, Landroid/graphics/Rect;->top:I

    invoke-virtual {p0}, Landroid/graphics/Rect;->height()I

    move-result p0

    div-int/lit8 p0, p0, 0x2

    add-int/2addr v0, p0

    iget p0, p1, Landroid/graphics/Rect;->left:I

    goto :goto_0

    :cond_2
    iget p2, p0, Landroid/graphics/Rect;->left:I

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result v0

    div-int/lit8 v0, v0, 0x2

    add-int/2addr p2, v0

    iget v0, p0, Landroid/graphics/Rect;->top:I

    iget p0, p1, Landroid/graphics/Rect;->left:I

    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    move-result v1

    div-int/lit8 v1, v1, 0x2

    add-int/2addr p0, v1

    iget v1, p1, Landroid/graphics/Rect;->bottom:I

    goto :goto_1

    :cond_3
    iget p2, p0, Landroid/graphics/Rect;->left:I

    iget v0, p0, Landroid/graphics/Rect;->top:I

    invoke-virtual {p0}, Landroid/graphics/Rect;->height()I

    move-result p0

    div-int/lit8 p0, p0, 0x2

    add-int/2addr v0, p0

    iget p0, p1, Landroid/graphics/Rect;->right:I

    goto :goto_0

    :goto_1
    sub-int/2addr p0, p2

    sub-int/2addr v1, v0

    mul-int v1, v1, v1

    mul-int p0, p0, p0

    add-int/2addr v1, p0

    return v1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/AbsHListView;)I
    .locals 0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWindowAttachCount()I

    move-result p0

    return p0
.end method

.method static a(Ljava/util/ArrayList;I)Landroid/view/View;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Landroid/view/View;",
            ">;I)",
            "Landroid/view/View;"
        }
    .end annotation

    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_2

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Lit/sephiroth/android/library/widget/AbsHListView$f;

    iget v3, v3, Lit/sephiroth/android/library/widget/AbsHListView$f;->d:I

    if-ne v3, p1, :cond_0

    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    return-object v2

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p0, v0}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/view/View;

    return-object p0

    :cond_2
    const/4 p0, 0x0

    return-object p0
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/AbsHListView;Lit/sephiroth/android/library/widget/AbsHListView$c;)Lit/sephiroth/android/library/widget/AbsHListView$c;
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aB:Lit/sephiroth/android/library/widget/AbsHListView$c;

    return-object p1
.end method

.method private a(IIII)V
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->o:Landroid/graphics/Rect;

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->q:I

    sub-int/2addr p1, v1

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->r:I

    sub-int/2addr p2, v1

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->s:I

    add-int/2addr p3, v1

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->t:I

    add-int/2addr p4, v1

    invoke-virtual {v0, p1, p2, p3, p4}, Landroid/graphics/Rect;->set(IIII)V

    return-void
.end method

.method private a(Landroid/graphics/Canvas;)V
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->o:Landroid/graphics/Rect;

    invoke-virtual {v0}, Landroid/graphics/Rect;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->o:Landroid/graphics/Rect;

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setBounds(Landroid/graphics/Rect;)V

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    :cond_0
    return-void
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Z)V
    .locals 0

    invoke-virtual {p0, p1, p2}, Lit/sephiroth/android/library/widget/AbsHListView;->removeDetachedView(Landroid/view/View;Z)V

    return-void
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/AbsHListView;Z)V
    .locals 0

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->setChildrenDrawnWithCacheEnabled(Z)V

    return-void
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/AbsHListView;IIIIIIIIZ)Z
    .locals 0

    invoke-virtual/range {p0 .. p9}, Lit/sephiroth/android/library/widget/AbsHListView;->overScrollBy(IIIIIIIIZ)Z

    move-result p0

    return p0
.end method

.method static synthetic b(Lit/sephiroth/android/library/widget/AbsHListView;)I
    .locals 0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWindowAttachCount()I

    move-result p0

    return p0
.end method

.method private b(Landroid/view/MotionEvent;)V
    .locals 3

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const v1, 0xff00

    and-int/2addr v0, v1

    shr-int/lit8 v0, v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v1

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    if-ne v1, v2, :cond_1

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v2

    float-to-int v2, v2

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->D:I

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v2

    float-to-int v2, v2

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->E:I

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->H:I

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result p1

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    :cond_1
    return-void
.end method

.method static synthetic b(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Z)V
    .locals 0

    invoke-virtual {p0, p1, p2}, Lit/sephiroth/android/library/widget/AbsHListView;->removeDetachedView(Landroid/view/View;Z)V

    return-void
.end method

.method static synthetic b(Lit/sephiroth/android/library/widget/AbsHListView;Z)V
    .locals 0

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->setChildrenDrawingCacheEnabled(Z)V

    return-void
.end method

.method static synthetic b(Lit/sephiroth/android/library/widget/AbsHListView;IIIIIIIIZ)Z
    .locals 0

    invoke-virtual/range {p0 .. p9}, Lit/sephiroth/android/library/widget/AbsHListView;->overScrollBy(IIIIIIIIZ)Z

    move-result p0

    return p0
.end method

.method static synthetic c(Lit/sephiroth/android/library/widget/AbsHListView;)Lit/sephiroth/android/library/widget/AbsHListView$c;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aB:Lit/sephiroth/android/library/widget/AbsHListView$c;

    return-object p0
.end method

.method static synthetic c(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Z)V
    .locals 0

    invoke-virtual {p0, p1, p2}, Lit/sephiroth/android/library/widget/AbsHListView;->removeDetachedView(Landroid/view/View;Z)V

    return-void
.end method

.method static synthetic c(Lit/sephiroth/android/library/widget/AbsHListView;IIIIIIIIZ)Z
    .locals 0

    invoke-virtual/range {p0 .. p9}, Lit/sephiroth/android/library/widget/AbsHListView;->overScrollBy(IIIIIIIIZ)Z

    move-result p0

    return p0
.end method

.method static synthetic d(Lit/sephiroth/android/library/widget/AbsHListView;)I
    .locals 0

    iget p0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    return p0
.end method

.method static synthetic d(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Z)V
    .locals 0

    invoke-virtual {p0, p1, p2}, Lit/sephiroth/android/library/widget/AbsHListView;->removeDetachedView(Landroid/view/View;Z)V

    return-void
.end method

.method static synthetic e(Lit/sephiroth/android/library/widget/AbsHListView;)Landroid/view/VelocityTracker;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    return-object p0
.end method

.method static synthetic e(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Z)V
    .locals 0

    invoke-virtual {p0, p1, p2}, Lit/sephiroth/android/library/widget/AbsHListView;->removeDetachedView(Landroid/view/View;Z)V

    return-void
.end method

.method static synthetic f(Lit/sephiroth/android/library/widget/AbsHListView;)I
    .locals 0

    iget p0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aN:I

    return p0
.end method

.method static synthetic g(Lit/sephiroth/android/library/widget/AbsHListView;)I
    .locals 0

    iget p0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aM:I

    return p0
.end method

.method private h(I)Z
    .locals 6

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->D:I

    sub-int v0, p1, v0

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v2

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    if-nez v2, :cond_2

    iget v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aK:I

    if-le v1, v5, :cond_1

    goto :goto_1

    :cond_1
    return v4

    :cond_2
    :goto_1
    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->E()V

    if-eqz v2, :cond_3

    const/4 v0, 0x5

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->H:I

    goto :goto_3

    :cond_3
    const/4 v1, 0x3

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    if-lez v0, :cond_4

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aK:I

    goto :goto_2

    :cond_4
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aK:I

    neg-int v0, v0

    :goto_2
    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->H:I

    :goto_3
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHandler()Landroid/os/Handler;

    move-result-object v0

    if-eqz v0, :cond_5

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aB:Lit/sephiroth/android/library/widget/AbsHListView$c;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_5
    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->setPressed(Z)V

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int/2addr v0, v1

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_6

    invoke-virtual {v0, v4}, Landroid/view/View;->setPressed(Z)V

    :cond_6
    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->b(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    if-eqz v0, :cond_7

    invoke-interface {v0, v3}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    :cond_7
    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->i(I)V

    return v3
.end method

.method static synthetic h(Lit/sephiroth/android/library/widget/AbsHListView;)Z
    .locals 0

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->z()Z

    move-result p0

    return p0
.end method

.method static synthetic i(Lit/sephiroth/android/library/widget/AbsHListView;)Landroid/support/v4/widget/EdgeEffectCompat;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    return-object p0
.end method

.method private i(I)V
    .locals 20

    move-object/from16 v10, p0

    move/from16 v11, p1

    iget v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->D:I

    sub-int v12, v11, v0

    iget v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->H:I

    sub-int v0, v12, v0

    iget v1, v10, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    const/high16 v2, -0x80000000

    if-eq v1, v2, :cond_0

    iget v1, v10, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    sub-int v1, v11, v1

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    iget v2, v10, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    const/4 v14, 0x3

    const/4 v15, 0x1

    const/4 v9, 0x0

    if-ne v2, v14, :cond_b

    iget v2, v10, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    if-eq v11, v2, :cond_19

    invoke-static {v12}, Ljava/lang/Math;->abs(I)I

    move-result v2

    iget v3, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aK:I

    if-le v2, v3, :cond_1

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-interface {v2, v15}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    :cond_1
    iget v2, v10, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    if-ltz v2, :cond_2

    iget v2, v10, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    iget v3, v10, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int/2addr v2, v3

    goto :goto_1

    :cond_2
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    :goto_1
    invoke-virtual {v10, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    if-eqz v3, :cond_3

    invoke-virtual {v3}, Landroid/view/View;->getLeft()I

    move-result v3

    goto :goto_2

    :cond_3
    const/4 v3, 0x0

    :goto_2
    if-eqz v1, :cond_4

    invoke-virtual {v10, v0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->c(II)Z

    move-result v0

    goto :goto_3

    :cond_4
    const/4 v0, 0x0

    :goto_3
    invoke-virtual {v10, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_a

    invoke-virtual {v2}, Landroid/view/View;->getLeft()I

    move-result v2

    if-eqz v0, :cond_9

    neg-int v0, v1

    sub-int/2addr v2, v3

    sub-int v14, v0, v2

    const/4 v2, 0x0

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    iget v7, v10, Lit/sephiroth/android/library/widget/AbsHListView;->Q:I

    const/4 v8, 0x0

    const/16 v16, 0x1

    move-object v0, v10

    move v1, v14

    const/4 v13, 0x0

    move/from16 v9, v16

    invoke-virtual/range {v0 .. v9}, Lit/sephiroth/android/library/widget/AbsHListView;->overScrollBy(IIIIIIIIZ)Z

    iget v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->Q:I

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    if-ne v0, v1, :cond_5

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    if-eqz v0, :cond_5

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    invoke-virtual {v0}, Landroid/view/VelocityTracker;->clear()V

    :cond_5
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getOverScrollMode()I

    move-result v0

    if-eqz v0, :cond_6

    if-ne v0, v15, :cond_9

    invoke-direct/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->z()Z

    move-result v0

    if-nez v0, :cond_9

    :cond_6
    iput v13, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aU:I

    const/4 v0, 0x5

    iput v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    if-lez v12, :cond_8

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    int-to-float v1, v14

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    div-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/EdgeEffectCompat;->onPull(F)Z

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v0}, Landroid/support/v4/widget/EdgeEffectCompat;->isFinished()Z

    move-result v0

    if-nez v0, :cond_7

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    :goto_4
    invoke-virtual {v0}, Landroid/support/v4/widget/EdgeEffectCompat;->onRelease()Z

    :cond_7
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    goto :goto_5

    :cond_8
    if-gez v12, :cond_9

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    int-to-float v1, v14

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    div-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/EdgeEffectCompat;->onPull(F)Z

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v0}, Landroid/support/v4/widget/EdgeEffectCompat;->isFinished()Z

    move-result v0

    if-nez v0, :cond_7

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    goto :goto_4

    :cond_9
    :goto_5
    iput v11, v10, Lit/sephiroth/android/library/widget/AbsHListView;->D:I

    :cond_a
    iput v11, v10, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    return-void

    :cond_b
    const/4 v13, 0x0

    iget v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    const/4 v2, 0x5

    if-ne v0, v2, :cond_19

    iget v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    if-eq v11, v0, :cond_19

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v0

    sub-int v2, v0, v1

    iget v3, v10, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    if-le v11, v3, :cond_c

    const/4 v9, 0x1

    goto :goto_6

    :cond_c
    const/4 v3, -0x1

    const/4 v9, -0x1

    :goto_6
    iget v3, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aU:I

    if-nez v3, :cond_d

    iput v9, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aU:I

    :cond_d
    neg-int v3, v1

    if-gez v2, :cond_e

    if-gez v0, :cond_f

    :cond_e
    if-lez v2, :cond_10

    if-gtz v0, :cond_10

    :cond_f
    neg-int v0, v0

    add-int/2addr v1, v0

    move v8, v0

    move v7, v1

    goto :goto_7

    :cond_10
    move v8, v3

    const/4 v7, 0x0

    :goto_7
    if-eqz v8, :cond_14

    const/4 v2, 0x0

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    iget v1, v10, Lit/sephiroth/android/library/widget/AbsHListView;->Q:I

    const/16 v16, 0x0

    const/16 v17, 0x1

    move-object v0, v10

    move/from16 v18, v1

    move v1, v8

    move v14, v7

    move/from16 v7, v18

    move v13, v8

    move/from16 v8, v16

    move/from16 v19, v9

    move/from16 v9, v17

    invoke-virtual/range {v0 .. v9}, Lit/sephiroth/android/library/widget/AbsHListView;->overScrollBy(IIIIIIIIZ)Z

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getOverScrollMode()I

    move-result v0

    if-eqz v0, :cond_11

    if-ne v0, v15, :cond_15

    invoke-direct/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->z()Z

    move-result v0

    if-nez v0, :cond_15

    :cond_11
    if-lez v12, :cond_13

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    int-to-float v1, v13

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    div-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/EdgeEffectCompat;->onPull(F)Z

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v0}, Landroid/support/v4/widget/EdgeEffectCompat;->isFinished()Z

    move-result v0

    if-nez v0, :cond_12

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    :goto_8
    invoke-virtual {v0}, Landroid/support/v4/widget/EdgeEffectCompat;->onRelease()Z

    :cond_12
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    goto :goto_9

    :cond_13
    if-gez v12, :cond_15

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    int-to-float v1, v13

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    div-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/EdgeEffectCompat;->onPull(F)Z

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v0}, Landroid/support/v4/widget/EdgeEffectCompat;->isFinished()Z

    move-result v0

    if-nez v0, :cond_12

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    goto :goto_8

    :cond_14
    move v14, v7

    move/from16 v19, v9

    :cond_15
    :goto_9
    if-eqz v14, :cond_18

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v0

    if-eqz v0, :cond_16

    iget-object v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/a/a$a;->a(I)V

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->k()V

    goto :goto_a

    :cond_16
    const/4 v1, 0x0

    :goto_a
    invoke-virtual {v10, v14, v14}, Lit/sephiroth/android/library/widget/AbsHListView;->c(II)Z

    const/4 v0, 0x3

    iput v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    invoke-virtual/range {p0 .. p1}, Lit/sephiroth/android/library/widget/AbsHListView;->f(I)I

    move-result v0

    iput v1, v10, Lit/sephiroth/android/library/widget/AbsHListView;->H:I

    iget v2, v10, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int v2, v0, v2

    invoke-virtual {v10, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_17

    invoke-virtual {v2}, Landroid/view/View;->getLeft()I

    move-result v9

    move v1, v9

    :cond_17
    iput v1, v10, Lit/sephiroth/android/library/widget/AbsHListView;->B:I

    iput v11, v10, Lit/sephiroth/android/library/widget/AbsHListView;->D:I

    iput v0, v10, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    :cond_18
    iput v11, v10, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    move/from16 v15, v19

    iput v15, v10, Lit/sephiroth/android/library/widget/AbsHListView;->aU:I

    :cond_19
    return-void
.end method

.method static synthetic j(Lit/sephiroth/android/library/widget/AbsHListView;)Landroid/support/v4/widget/EdgeEffectCompat;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    return-object p0
.end method

.method static synthetic k(Lit/sephiroth/android/library/widget/AbsHListView;)V
    .locals 0

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->F()V

    return-void
.end method

.method private x()V
    .locals 2

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->setClickable(Z)V

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->setFocusableInTouchMode(Z)V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->setWillNotDraw(Z)V

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->setAlwaysDrawnWithCacheEnabled(Z)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I

    move-result v1

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aK:I

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledMinimumFlingVelocity()I

    move-result v1

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aM:I

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledMaximumFlingVelocity()I

    move-result v1

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aN:I

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledOverscrollDistance()I

    move-result v1

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->Q:I

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledOverflingDistance()I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->R:I

    invoke-static {p0}, Lit/sephiroth/android/library/a/a;->a(Landroid/view/View;)Lit/sephiroth/android/library/a/a$a;

    move-result-object v0

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    return-void
.end method

.method private y()V
    .locals 9

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v1

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v3, 0x0

    const/16 v4, 0xb

    if-lt v2, v4, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    const/4 v4, 0x0

    :goto_1
    if-ge v4, v1, :cond_3

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v5

    add-int v6, v0, v4

    instance-of v7, v5, Landroid/widget/Checkable;

    if-eqz v7, :cond_1

    check-cast v5, Landroid/widget/Checkable;

    iget-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v8

    invoke-virtual {v7, v6, v8}, Landroid/support/v4/util/SparseArrayCompat;->get(ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Boolean;

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    invoke-interface {v5, v6}, Landroid/widget/Checkable;->setChecked(Z)V

    goto :goto_2

    :cond_1
    if-eqz v2, :cond_2

    iget-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v8

    invoke-virtual {v7, v6, v8}, Landroid/support/v4/util/SparseArrayCompat;->get(ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Boolean;

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    invoke-virtual {v5, v6}, Landroid/view/View;->setActivated(Z)V

    :cond_2
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_3
    return-void
.end method

.method private z()Z
    .locals 5

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    const/4 v3, 0x0

    if-eq v0, v2, :cond_1

    return v3

    :cond_1
    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getLeft()I

    move-result v2

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->left:I

    if-lt v2, v4, :cond_2

    sub-int/2addr v0, v1

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v2

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->right:I

    sub-int/2addr v2, v4

    if-gt v0, v2, :cond_2

    return v1

    :cond_2
    const/4 v1, 0x0

    return v1
.end method


# virtual methods
.method public a(II)I
    .locals 4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ay:Landroid/graphics/Rect;

    if-nez v0, :cond_0

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ay:Landroid/graphics/Rect;

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ay:Landroid/graphics/Rect;

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    :goto_0
    if-ltz v1, :cond_2

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getVisibility()I

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {v2, v0}, Landroid/view/View;->getHitRect(Landroid/graphics/Rect;)V

    invoke-virtual {v0, p1, p2}, Landroid/graphics/Rect;->contains(II)Z

    move-result v2

    if-eqz v2, :cond_1

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    add-int/2addr p1, v1

    return p1

    :cond_1
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    :cond_2
    const/4 p1, -0x1

    return p1
.end method

.method protected a(I[Z)Landroid/view/View;
    .locals 6
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    const/4 v0, 0x0

    aput-boolean v0, p2, v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v1, p1}, Lit/sephiroth/android/library/widget/AbsHListView$k;->d(I)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_0

    return-object v1

    :cond_0
    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v1, p1}, Lit/sephiroth/android/library/widget/AbsHListView$k;->e(I)Landroid/view/View;

    move-result-object v1

    const/16 v2, 0x10

    const/4 v3, 0x1

    if-eqz v1, :cond_3

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v4, p1, v1, p0}, Landroid/widget/ListAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v5, v2, :cond_1

    invoke-virtual {v4}, Landroid/view/View;->getImportantForAccessibility()I

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {v4, v3}, Landroid/view/View;->setImportantForAccessibility(I)V

    :cond_1
    if-eq v4, v1, :cond_2

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {p2, v1, p1}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(Landroid/view/View;I)V

    iget p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aH:I

    if-eqz p2, :cond_5

    :goto_0
    iget p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aH:I

    invoke-virtual {v4, p2}, Landroid/view/View;->setDrawingCacheBackgroundColor(I)V

    goto :goto_1

    :cond_2
    aput-boolean v3, p2, v0

    invoke-virtual {v4}, Landroid/view/View;->onFinishTemporaryDetach()V

    goto :goto_1

    :cond_3
    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    const/4 v0, 0x0

    invoke-interface {p2, p1, v0, p0}, Landroid/widget/ListAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt p2, v2, :cond_4

    invoke-virtual {v4}, Landroid/view/View;->getImportantForAccessibility()I

    move-result p2

    if-nez p2, :cond_4

    invoke-virtual {v4, v3}, Landroid/view/View;->setImportantForAccessibility(I)V

    :cond_4
    iget p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aH:I

    if-eqz p2, :cond_5

    goto :goto_0

    :cond_5
    :goto_1
    iget-boolean p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->k:Z

    if-eqz p2, :cond_8

    invoke-virtual {v4}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p2

    if-nez p2, :cond_7

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->generateDefaultLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p2

    :cond_6
    :goto_2
    check-cast p2, Lit/sephiroth/android/library/widget/AbsHListView$f;

    goto :goto_3

    :cond_7
    invoke-virtual {p0, p2}, Lit/sephiroth/android/library/widget/AbsHListView;->checkLayoutParams(Landroid/view/ViewGroup$LayoutParams;)Z

    move-result v0

    if-nez v0, :cond_6

    invoke-virtual {p0, p2}, Lit/sephiroth/android/library/widget/AbsHListView;->generateLayoutParams(Landroid/view/ViewGroup$LayoutParams;)Landroid/view/ViewGroup$LayoutParams;

    move-result-object p2

    goto :goto_2

    :goto_3
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v0, p1}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v0

    iput-wide v0, p2, Lit/sephiroth/android/library/widget/AbsHListView$f;->e:J

    invoke-virtual {v4, p2}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_8
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aq:Landroid/view/accessibility/AccessibilityManager;

    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityManager;->isEnabled()Z

    move-result p1

    if-eqz p1, :cond_9

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aY:Lit/sephiroth/android/library/widget/AbsHListView$g;

    if-nez p1, :cond_9

    new-instance p1, Lit/sephiroth/android/library/widget/AbsHListView$g;

    invoke-direct {p1, p0}, Lit/sephiroth/android/library/widget/AbsHListView$g;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aY:Lit/sephiroth/android/library/widget/AbsHListView$g;

    :cond_9
    return-object v4
.end method

.method public a(Landroid/util/AttributeSet;)Lit/sephiroth/android/library/widget/AbsHListView$f;
    .locals 2

    new-instance v0, Lit/sephiroth/android/library/widget/AbsHListView$f;

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Lit/sephiroth/android/library/widget/AbsHListView$f;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-object v0
.end method

.method public a()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0}, Landroid/support/v4/util/SparseArrayCompat;->clear()V

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {v0}, Landroid/support/v4/util/LongSparseArray;->clear()V

    :cond_1
    const/4 v0, 0x0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    return-void
.end method

.method public a(IIZ)V
    .locals 6

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    if-nez v0, :cond_0

    new-instance v0, Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/widget/AbsHListView$e;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v1

    add-int v2, v0, v1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingLeft()I

    move-result v3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingRight()I

    move-result v5

    sub-int/2addr v4, v5

    if-eqz p1, :cond_3

    iget v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-eqz v5, :cond_3

    if-eqz v1, :cond_3

    if-nez v0, :cond_1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    if-ne v0, v3, :cond_1

    if-ltz p1, :cond_3

    :cond_1
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-ne v2, v0, :cond_2

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v0

    if-ne v0, v4, :cond_2

    if-lez p1, :cond_2

    goto :goto_0

    :cond_2
    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->b(I)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {v0, p1, p2, p3}, Lit/sephiroth/android/library/widget/AbsHListView$e;->a(IIZ)V

    return-void

    :cond_3
    :goto_0
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$e;->b()V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    :cond_4
    return-void
.end method

.method protected a(ILandroid/view/View;)V
    .locals 5

    const/4 v0, -0x1

    if-eq p1, v0, :cond_0

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->n:I

    :cond_0
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->o:Landroid/graphics/Rect;

    invoke-virtual {p2}, Landroid/view/View;->getLeft()I

    move-result v1

    invoke-virtual {p2}, Landroid/view/View;->getTop()I

    move-result v2

    invoke-virtual {p2}, Landroid/view/View;->getRight()I

    move-result v3

    invoke-virtual {p2}, Landroid/view/View;->getBottom()I

    move-result v4

    invoke-virtual {p1, v1, v2, v3, v4}, Landroid/graphics/Rect;->set(IIII)V

    instance-of v1, p2, Lit/sephiroth/android/library/widget/AbsHListView$m;

    if-eqz v1, :cond_1

    move-object v1, p2

    check-cast v1, Lit/sephiroth/android/library/widget/AbsHListView$m;

    invoke-interface {v1, p1}, Lit/sephiroth/android/library/widget/AbsHListView$m;->a(Landroid/graphics/Rect;)V

    :cond_1
    iget v1, p1, Landroid/graphics/Rect;->left:I

    iget v2, p1, Landroid/graphics/Rect;->top:I

    iget v3, p1, Landroid/graphics/Rect;->right:I

    iget p1, p1, Landroid/graphics/Rect;->bottom:I

    invoke-direct {p0, v1, v2, v3, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(IIII)V

    iget-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aI:Z

    invoke-virtual {p2}, Landroid/view/View;->isEnabled()Z

    move-result p2

    if-eq p2, p1, :cond_2

    xor-int/lit8 p1, p1, 0x1

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aI:Z

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getSelectedItemPosition()I

    move-result p1

    if-eq p1, v0, :cond_2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->refreshDrawableState()V

    :cond_2
    return-void
.end method

.method public a(IZ)V
    .locals 12

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x3

    const/16 v2, 0xb

    if-lt v0, v2, :cond_3

    if-eqz p2, :cond_3

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    if-ne v0, v1, :cond_3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    if-nez v0, :cond_3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    check-cast v0, Lit/sephiroth/android/library/a/a/b;

    invoke-virtual {v0}, Lit/sephiroth/android/library/a/a/b;->a()Z

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    check-cast v0, Lit/sephiroth/android/library/a/a/b;

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->startActionMode(Landroid/view/ActionMode$Callback;)Landroid/view/ActionMode;

    move-result-object v0

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    goto :goto_1

    :cond_2
    :goto_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "AbsListView: attempted to start selection mode for CHOICE_MODE_MULTIPLE_MODAL but no choice mode callback was supplied. Call setMultiChoiceModeListener to set a callback."

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_3
    :goto_1
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x1

    if-eq v0, v3, :cond_b

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v0, v2, :cond_4

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    if-ne v0, v1, :cond_4

    goto :goto_3

    :cond_4
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v0}, Landroid/widget/ListAdapter;->hasStableIds()Z

    move-result v0

    if-eqz v0, :cond_5

    const/4 v0, 0x1

    goto :goto_2

    :cond_5
    const/4 v0, 0x0

    :goto_2
    if-nez p2, :cond_6

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(I)Z

    move-result v1

    if-eqz v1, :cond_7

    :cond_6
    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v1}, Landroid/support/v4/util/SparseArrayCompat;->clear()V

    if-eqz v0, :cond_7

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {v1}, Landroid/support/v4/util/LongSparseArray;->clear()V

    :cond_7
    if-eqz p2, :cond_9

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p2, p1, v1}, Landroid/support/v4/util/SparseArrayCompat;->put(ILjava/lang/Object;)V

    if-eqz v0, :cond_8

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v0, p1}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p2, v0, v1, p1}, Landroid/support/v4/util/LongSparseArray;->put(JLjava/lang/Object;)V

    :cond_8
    iput v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    goto/16 :goto_7

    :cond_9
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {p1}, Landroid/support/v4/util/SparseArrayCompat;->size()I

    move-result p1

    if-eqz p1, :cond_a

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {p1, v4}, Landroid/support/v4/util/SparseArrayCompat;->valueAt(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-nez p1, :cond_10

    :cond_a
    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    goto :goto_7

    :cond_b
    :goto_3
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Landroid/support/v4/util/SparseArrayCompat;->get(ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, p1, v2}, Landroid/support/v4/util/SparseArrayCompat;->put(ILjava/lang/Object;)V

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    if-eqz v1, :cond_d

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v1}, Landroid/widget/ListAdapter;->hasStableIds()Z

    move-result v1

    if-eqz v1, :cond_d

    if-eqz p2, :cond_c

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v2, p1}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v2

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Landroid/support/v4/util/LongSparseArray;->put(JLjava/lang/Object;)V

    goto :goto_4

    :cond_c
    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v2, p1}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Landroid/support/v4/util/LongSparseArray;->delete(J)V

    :cond_d
    :goto_4
    if-eq v0, p2, :cond_f

    if-eqz p2, :cond_e

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    add-int/2addr v0, v5

    :goto_5
    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    goto :goto_6

    :cond_e
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    sub-int/2addr v0, v5

    goto :goto_5

    :cond_f
    :goto_6
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    if-eqz v0, :cond_10

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v0, p1}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v9

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    move-object v6, v0

    check-cast v6, Lit/sephiroth/android/library/a/a/b;

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    move-object v7, v0

    check-cast v7, Landroid/view/ActionMode;

    move v8, p1

    move v11, p2

    invoke-virtual/range {v6 .. v11}, Lit/sephiroth/android/library/a/a/b;->a(Landroid/view/ActionMode;IJZ)V

    :cond_10
    :goto_7
    iget-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->af:Z

    if-nez p1, :cond_11

    iget-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->at:Z

    if-nez p1, :cond_11

    iput-boolean v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->w()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->requestLayout()V

    :cond_11
    return-void
.end method

.method protected abstract a(Z)V
.end method

.method public a(FFI)Z
    .locals 4

    float-to-int v0, p1

    float-to-int v1, p2

    invoke-virtual {p0, v0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(II)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v1, v0}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v1

    iget v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int v3, v0, v3

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-virtual {p0, v3, v0, v1, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->b(Landroid/view/View;IJ)Landroid/view/ContextMenu$ContextMenuInfo;

    move-result-object p1

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->az:Landroid/view/ContextMenu$ContextMenuInfo;

    invoke-super {p0, p0}, Lit/sephiroth/android/library/widget/a;->showContextMenuForChild(Landroid/view/View;)Z

    move-result p1

    return p1

    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lit/sephiroth/android/library/widget/AbsHListView;->a(FFI)Z

    move-result p1

    return p1
.end method

.method public a(I)Z
    .locals 2

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Landroid/support/v4/util/SparseArrayCompat;->get(ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    return p1

    :cond_0
    return v1
.end method

.method protected a(Landroid/view/MotionEvent;)Z
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xe

    if-lt v0, v1, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getButtonState()I

    move-result v0

    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getMetaState()I

    move-result p1

    invoke-virtual {p0, v0, v1, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(FFI)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public a(Landroid/view/View;IJ)Z
    .locals 9

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_c

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    const/4 v3, 0x2

    if-eq v0, v3, :cond_6

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0xb

    if-lt v0, v3, :cond_0

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    const/4 v3, 0x3

    if-ne v0, v3, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    if-eqz v0, :cond_0

    goto :goto_1

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    if-ne v0, v2, :cond_5

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v0, p2, v3}, Landroid/support/v4/util/SparseArrayCompat;->get(ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    xor-int/2addr v0, v2

    if-eqz v0, :cond_2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0}, Landroid/support/v4/util/SparseArrayCompat;->clear()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v0, p2, v1}, Landroid/support/v4/util/SparseArrayCompat;->put(ILjava/lang/Object;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v0}, Landroid/widget/ListAdapter;->hasStableIds()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {v0}, Landroid/support/v4/util/LongSparseArray;->clear()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v1, p2}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v3

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v3, v4, v1}, Landroid/support/v4/util/LongSparseArray;->put(JLjava/lang/Object;)V

    :cond_1
    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0}, Landroid/support/v4/util/SparseArrayCompat;->size()I

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0, v1}, Landroid/support/v4/util/SparseArrayCompat;->valueAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_4

    :cond_3
    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    :cond_4
    :goto_0
    const/4 v0, 0x1

    goto/16 :goto_6

    :cond_5
    const/4 v0, 0x1

    goto :goto_7

    :cond_6
    :goto_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v0, p2, v3}, Landroid/support/v4/util/SparseArrayCompat;->get(ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    xor-int/lit8 v8, v0, 0x1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v8}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v0, p2, v3}, Landroid/support/v4/util/SparseArrayCompat;->put(ILjava/lang/Object;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v0}, Landroid/widget/ListAdapter;->hasStableIds()Z

    move-result v0

    if-eqz v0, :cond_8

    if-eqz v8, :cond_7

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v3, p2}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v3

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v0, v3, v4, v5}, Landroid/support/v4/util/LongSparseArray;->put(JLjava/lang/Object;)V

    goto :goto_2

    :cond_7
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v3, p2}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Landroid/support/v4/util/LongSparseArray;->delete(J)V

    :cond_8
    :goto_2
    if-eqz v8, :cond_9

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    add-int/2addr v0, v2

    :goto_3
    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    goto :goto_4

    :cond_9
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    sub-int/2addr v0, v2

    goto :goto_3

    :goto_4
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    if-eqz v0, :cond_a

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    move-object v3, v0

    check-cast v3, Lit/sephiroth/android/library/a/a/b;

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    move-object v4, v0

    check-cast v4, Landroid/view/ActionMode;

    move v5, p2

    move-wide v6, p3

    invoke-virtual/range {v3 .. v8}, Lit/sephiroth/android/library/a/a/b;->a(Landroid/view/ActionMode;IJZ)V

    goto :goto_5

    :cond_a
    const/4 v1, 0x1

    :goto_5
    move v0, v1

    :goto_6
    const/4 v1, 0x1

    :goto_7
    if-eqz v1, :cond_b

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->y()V

    :cond_b
    const/4 v1, 0x1

    goto :goto_8

    :cond_c
    const/4 v0, 0x1

    :goto_8
    if-eqz v0, :cond_d

    invoke-super {p0, p1, p2, p3, p4}, Lit/sephiroth/android/library/widget/a;->a(Landroid/view/View;IJ)Z

    move-result p1

    or-int/2addr v1, p1

    :cond_d
    return v1
.end method

.method public addTouchables(Ljava/util/ArrayList;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Landroid/view/View;",
            ">;)V"
        }
    .end annotation

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    if-nez v2, :cond_0

    return-void

    :cond_0
    const/4 v3, 0x0

    :goto_0
    if-ge v3, v0, :cond_2

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v4

    add-int v5, v1, v3

    invoke-interface {v2, v5}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-virtual {p1, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-virtual {v4, p1}, Landroid/view/View;->addTouchables(Ljava/util/ArrayList;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    return-void
.end method

.method b(Landroid/view/View;IJ)Landroid/view/ContextMenu$ContextMenuInfo;
    .locals 1

    new-instance v0, Lit/sephiroth/android/library/widget/a$a;

    invoke-direct {v0, p1, p2, p3, p4}, Lit/sephiroth/android/library/widget/a$a;-><init>(Landroid/view/View;IJ)V

    return-object v0
.end method

.method protected b()V
    .locals 4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aw:Lit/sephiroth/android/library/widget/AbsHListView$h;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aw:Lit/sephiroth/android/library/widget/AbsHListView$h;

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v2

    iget v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    invoke-interface {v0, p0, v1, v2, v3}, Lit/sephiroth/android/library/widget/AbsHListView$h;->a(Lit/sephiroth/android/library/widget/AbsHListView;III)V

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p0, v0, v0, v0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->onScrollChanged(IIII)V

    return-void
.end method

.method b(I)V
    .locals 1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aJ:I

    if-eq p1, v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aw:Lit/sephiroth/android/library/widget/AbsHListView$h;

    if-eqz v0, :cond_0

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aJ:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aw:Lit/sephiroth/android/library/widget/AbsHListView$h;

    invoke-interface {v0, p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView$h;->a(Lit/sephiroth/android/library/widget/AbsHListView;I)V

    :cond_0
    return-void
.end method

.method public b(II)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->a(IIZ)V

    return-void
.end method

.method c()V
    .locals 1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    if-lez v0, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->d()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->requestLayout()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    :cond_0
    return-void
.end method

.method public c(I)V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-nez v0, :cond_0

    new-instance v0, Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/widget/AbsHListView$j;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {v0, p1}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a(I)V

    return-void
.end method

.method c(II)Z
    .locals 18

    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v3

    const/4 v4, 0x1

    if-nez v3, :cond_0

    return v4

    :cond_0
    const/4 v5, 0x0

    invoke-virtual {v0, v5}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6}, Landroid/view/View;->getLeft()I

    move-result v6

    add-int/lit8 v7, v3, -0x1

    invoke-virtual {v0, v7}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v8

    invoke-virtual {v8}, Landroid/view/View;->getRight()I

    move-result v8

    iget-object v9, v0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    rsub-int/lit8 v10, v6, 0x0

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v11

    sub-int/2addr v11, v5

    sub-int v11, v8, v11

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v12

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingRight()I

    move-result v13

    sub-int/2addr v12, v13

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingLeft()I

    move-result v13

    sub-int/2addr v12, v13

    if-gez v1, :cond_1

    add-int/lit8 v13, v12, -0x1

    neg-int v13, v13

    invoke-static {v13, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    goto :goto_0

    :cond_1
    add-int/lit8 v13, v12, -0x1

    invoke-static {v13, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    :goto_0
    if-gez v2, :cond_2

    sub-int/2addr v12, v4

    neg-int v12, v12

    invoke-static {v12, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    goto :goto_1

    :cond_2
    sub-int/2addr v12, v4

    invoke-static {v12, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    :goto_1
    iget v12, v0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    if-nez v12, :cond_3

    iget v13, v9, Landroid/graphics/Rect;->left:I

    sub-int v13, v6, v13

    :goto_2
    iput v13, v0, Lit/sephiroth/android/library/widget/AbsHListView;->aS:I

    goto :goto_3

    :cond_3
    iget v13, v0, Lit/sephiroth/android/library/widget/AbsHListView;->aS:I

    add-int/2addr v13, v2

    goto :goto_2

    :goto_3
    add-int v13, v12, v3

    iget v14, v0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-ne v13, v14, :cond_4

    iget v14, v9, Landroid/graphics/Rect;->right:I

    add-int/2addr v14, v8

    :goto_4
    iput v14, v0, Lit/sephiroth/android/library/widget/AbsHListView;->aT:I

    goto :goto_5

    :cond_4
    iget v14, v0, Lit/sephiroth/android/library/widget/AbsHListView;->aT:I

    add-int/2addr v14, v2

    goto :goto_4

    :goto_5
    if-nez v12, :cond_5

    iget v14, v9, Landroid/graphics/Rect;->left:I

    if-lt v6, v14, :cond_5

    if-ltz v2, :cond_5

    const/4 v6, 0x1

    goto :goto_6

    :cond_5
    const/4 v6, 0x0

    :goto_6
    iget v14, v0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-ne v13, v14, :cond_6

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v13

    iget v9, v9, Landroid/graphics/Rect;->right:I

    sub-int/2addr v13, v9

    if-gt v8, v13, :cond_6

    if-gtz v2, :cond_6

    const/4 v8, 0x1

    goto :goto_7

    :cond_6
    const/4 v8, 0x0

    :goto_7
    if-nez v6, :cond_19

    if-eqz v8, :cond_7

    goto/16 :goto_f

    :cond_7
    if-gez v2, :cond_8

    const/4 v6, 0x1

    goto :goto_8

    :cond_8
    const/4 v6, 0x0

    :goto_8
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isInTouchMode()Z

    move-result v8

    if-eqz v8, :cond_9

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->l()V

    :cond_9
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHeaderViewsCount()I

    move-result v9

    iget v13, v0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getFooterViewsCount()I

    move-result v14

    sub-int/2addr v13, v14

    if-eqz v6, :cond_d

    neg-int v7, v2

    const/4 v14, 0x0

    const/4 v15, 0x0

    :goto_9
    if-ge v14, v3, :cond_c

    invoke-virtual {v0, v14}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v5

    invoke-virtual {v5}, Landroid/view/View;->getRight()I

    move-result v4

    if-lt v4, v7, :cond_a

    goto :goto_b

    :cond_a
    add-int/lit8 v15, v15, 0x1

    add-int v4, v12, v14

    if-lt v4, v9, :cond_b

    if-ge v4, v13, :cond_b

    move/from16 v16, v3

    iget-object v3, v0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v3, v5, v4}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(Landroid/view/View;I)V

    goto :goto_a

    :cond_b
    move/from16 v16, v3

    :goto_a
    add-int/lit8 v14, v14, 0x1

    move/from16 v3, v16

    const/4 v4, 0x1

    const/4 v5, 0x0

    goto :goto_9

    :cond_c
    :goto_b
    const/4 v4, 0x0

    goto :goto_d

    :cond_d
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v3

    sub-int/2addr v3, v2

    move v5, v7

    const/4 v4, 0x0

    const/4 v15, 0x0

    :goto_c
    if-ltz v5, :cond_10

    invoke-virtual {v0, v5}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v7

    invoke-virtual {v7}, Landroid/view/View;->getLeft()I

    move-result v14

    if-gt v14, v3, :cond_e

    goto :goto_d

    :cond_e
    add-int/lit8 v15, v15, 0x1

    add-int v4, v12, v5

    if-lt v4, v9, :cond_f

    if-ge v4, v13, :cond_f

    iget-object v14, v0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v14, v7, v4}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(Landroid/view/View;I)V

    :cond_f
    add-int/lit8 v4, v5, -0x1

    move/from16 v17, v5

    move v5, v4

    move/from16 v4, v17

    goto :goto_c

    :cond_10
    :goto_d
    iget v3, v0, Lit/sephiroth/android/library/widget/AbsHListView;->B:I

    add-int/2addr v3, v1

    iput v3, v0, Lit/sephiroth/android/library/widget/AbsHListView;->C:I

    const/4 v1, 0x1

    iput-boolean v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->at:Z

    if-lez v15, :cond_11

    invoke-virtual {v0, v4, v15}, Lit/sephiroth/android/library/widget/AbsHListView;->detachViewsFromParent(II)V

    iget-object v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/AbsHListView$k;->d()V

    :cond_11
    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->awakenScrollBars()Z

    move-result v1

    if-nez v1, :cond_12

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    :cond_12
    invoke-virtual {v0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->d(I)V

    if-eqz v6, :cond_13

    iget v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    add-int/2addr v1, v15

    iput v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    :cond_13
    invoke-static {v2}, Ljava/lang/Math;->abs(I)I

    move-result v1

    if-lt v10, v1, :cond_14

    if-ge v11, v1, :cond_15

    :cond_14
    invoke-virtual {v0, v6}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Z)V

    :cond_15
    const/4 v1, -0x1

    if-nez v8, :cond_16

    iget v2, v0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    if-eq v2, v1, :cond_16

    iget v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    iget v2, v0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int/2addr v1, v2

    if-ltz v1, :cond_18

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_18

    iget v2, v0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(ILandroid/view/View;)V

    goto :goto_e

    :cond_16
    iget v2, v0, Lit/sephiroth/android/library/widget/AbsHListView;->n:I

    if-eq v2, v1, :cond_17

    iget v2, v0, Lit/sephiroth/android/library/widget/AbsHListView;->n:I

    iget v3, v0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int/2addr v2, v3

    if-ltz v2, :cond_18

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v3

    if-ge v2, v3, :cond_18

    invoke-virtual {v0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->a(ILandroid/view/View;)V

    goto :goto_e

    :cond_17
    iget-object v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->o:Landroid/graphics/Rect;

    invoke-virtual {v1}, Landroid/graphics/Rect;->setEmpty()V

    :cond_18
    :goto_e
    const/4 v3, 0x0

    iput-boolean v3, v0, Lit/sephiroth/android/library/widget/AbsHListView;->at:Z

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/AbsHListView;->b()V

    return v3

    :cond_19
    :goto_f
    const/4 v1, 0x1

    const/4 v3, 0x0

    if-eqz v2, :cond_1a

    return v1

    :cond_1a
    const/4 v1, 0x0

    return v1
.end method

.method c(Landroid/view/View;IJ)Z
    .locals 8

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x0

    const/16 v2, 0xb

    if-lt v0, v2, :cond_1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    const/4 v2, 0x3

    if-ne v0, v2, :cond_1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    const/4 p3, 0x1

    if-nez p1, :cond_0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    check-cast p1, Lit/sephiroth/android/library/a/a/b;

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->startActionMode(Landroid/view/ActionMode$Callback;)Landroid/view/ActionMode;

    move-result-object p1

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    if-eqz p1, :cond_0

    invoke-virtual {p0, p2, p3}, Lit/sephiroth/android/library/widget/AbsHListView;->a(IZ)V

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->performHapticFeedback(I)Z

    :cond_0
    return p3

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ai:Lit/sephiroth/android/library/widget/a$d;

    if-eqz v0, :cond_2

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ai:Lit/sephiroth/android/library/widget/a$d;

    move-object v3, p0

    move-object v4, p1

    move v5, p2

    move-wide v6, p3

    invoke-interface/range {v2 .. v7}, Lit/sephiroth/android/library/widget/a$d;->a(Lit/sephiroth/android/library/widget/a;Landroid/view/View;IJ)Z

    move-result v0

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_3

    invoke-virtual {p0, p1, p2, p3, p4}, Lit/sephiroth/android/library/widget/AbsHListView;->b(Landroid/view/View;IJ)Landroid/view/ContextMenu$ContextMenuInfo;

    move-result-object p1

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->az:Landroid/view/ContextMenu$ContextMenuInfo;

    invoke-super {p0, p0}, Lit/sephiroth/android/library/widget/a;->showContextMenuForChild(Landroid/view/View;)Z

    move-result v0

    :cond_3
    if-eqz v0, :cond_4

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->performHapticFeedback(I)Z

    :cond_4
    return v0
.end method

.method public checkInputConnectionProxy(Landroid/view/View;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method protected checkLayoutParams(Landroid/view/ViewGroup$LayoutParams;)Z
    .locals 0

    instance-of p1, p1, Lit/sephiroth/android/library/widget/AbsHListView$f;

    return p1
.end method

.method protected computeHorizontalScrollExtent()I
    .locals 5

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    const/4 v1, 0x0

    if-lez v0, :cond_3

    iget-boolean v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ax:Z

    const/4 v3, 0x1

    if-eqz v2, :cond_2

    mul-int/lit8 v2, v0, 0x64

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v4

    invoke-virtual {v1}, Landroid/view/View;->getWidth()I

    move-result v1

    if-lez v1, :cond_0

    mul-int/lit8 v4, v4, 0x64

    div-int/2addr v4, v1

    add-int/2addr v2, v4

    :cond_0
    sub-int/2addr v0, v3

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v1

    invoke-virtual {v0}, Landroid/view/View;->getWidth()I

    move-result v0

    if-lez v0, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v3

    sub-int/2addr v1, v3

    mul-int/lit8 v1, v1, 0x64

    div-int/2addr v1, v0

    sub-int/2addr v2, v1

    :cond_1
    return v2

    :cond_2
    return v3

    :cond_3
    return v1
.end method

.method protected computeHorizontalScrollOffset()I
    .locals 4

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v1

    const/4 v2, 0x0

    if-ltz v0, :cond_3

    if-lez v1, :cond_3

    iget-boolean v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ax:Z

    if-eqz v3, :cond_0

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v3

    invoke-virtual {v1}, Landroid/view/View;->getWidth()I

    move-result v1

    if-lez v1, :cond_3

    mul-int/lit8 v0, v0, 0x64

    mul-int/lit8 v3, v3, 0x64

    div-int/2addr v3, v1

    sub-int/2addr v0, v3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v3

    int-to-float v3, v3

    div-float/2addr v1, v3

    iget v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    int-to-float v3, v3

    mul-float v1, v1, v3

    const/high16 v3, 0x42c80000    # 100.0f

    mul-float v1, v1, v3

    float-to-int v1, v1

    add-int/2addr v0, v1

    invoke-static {v0, v2}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0

    :cond_0
    iget v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    add-int v2, v0, v1

    if-ne v2, v3, :cond_2

    move v2, v3

    goto :goto_0

    :cond_2
    div-int/lit8 v2, v1, 0x2

    add-int/2addr v2, v0

    :goto_0
    int-to-float v0, v0

    int-to-float v1, v1

    int-to-float v2, v2

    int-to-float v3, v3

    div-float/2addr v2, v3

    mul-float v1, v1, v2

    add-float/2addr v0, v1

    float-to-int v0, v0

    return v0

    :cond_3
    return v2
.end method

.method protected computeHorizontalScrollRange()I
    .locals 3

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ax:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    mul-int/lit8 v0, v0, 0x64

    const/4 v1, 0x0

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    div-float/2addr v1, v2

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    int-to-float v2, v2

    mul-float v1, v1, v2

    const/high16 v2, 0x42c80000    # 100.0f

    mul-float v1, v1, v2

    float-to-int v1, v1

    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    add-int/2addr v0, v1

    return v0

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    :cond_1
    return v0
.end method

.method protected d()V
    .locals 4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->removeAllViewsInLayout()V

    const/4 v0, 0x0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    const/4 v1, 0x0

    iput-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->O:Ljava/lang/Runnable;

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ad:Z

    iput-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    const/4 v1, -0x1

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ar:I

    const-wide/high16 v2, -0x8000000000000000L

    iput-wide v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->as:J

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->setSelectedPositionInt(I)V

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->setNextSelectedPositionInt(I)V

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->J:I

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->n:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->o:Landroid/graphics/Rect;

    invoke-virtual {v0}, Landroid/graphics/Rect;->setEmpty()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    return-void
.end method

.method public d(I)V
    .locals 3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2, p1}, Landroid/view/View;->offsetLeftAndRight(I)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method protected d(II)V
    .locals 0

    return-void
.end method

.method protected dispatchDraw(Landroid/graphics/Canvas;)V
    .locals 1

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->l:Z

    if-nez v0, :cond_0

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Landroid/graphics/Canvas;)V

    :cond_0
    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->dispatchDraw(Landroid/graphics/Canvas;)V

    if-eqz v0, :cond_1

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Landroid/graphics/Canvas;)V

    :cond_1
    return-void
.end method

.method protected dispatchSetPressed(Z)V
    .locals 0

    return-void
.end method

.method public draw(Landroid/graphics/Canvas;)V
    .locals 6

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->draw(Landroid/graphics/Canvas;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v1}, Landroid/support/v4/widget/EdgeEffectCompat;->isFinished()Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    move-result v1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->top:I

    iget v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aW:I

    add-int/2addr v2, v3

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->bottom:I

    iget v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aX:I

    add-int/2addr v3, v4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHeight()I

    move-result v4

    sub-int/2addr v4, v2

    sub-int/2addr v4, v3

    const/4 v3, 0x0

    iget v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aS:I

    add-int/2addr v5, v0

    invoke-static {v3, v5}, Ljava/lang/Math;->min(II)I

    move-result v3

    const/high16 v5, -0x3d4c0000    # -90.0f

    invoke-virtual {p1, v5}, Landroid/graphics/Canvas;->rotate(F)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHeight()I

    move-result v5

    neg-int v5, v5

    add-int/2addr v5, v2

    int-to-float v2, v5

    int-to-float v3, v3

    invoke-virtual {p1, v2, v3}, Landroid/graphics/Canvas;->translate(FF)V

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v2, v4, v4}, Landroid/support/v4/widget/EdgeEffectCompat;->setSize(II)V

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v2, p1}, Landroid/support/v4/widget/EdgeEffectCompat;->draw(Landroid/graphics/Canvas;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    :cond_0
    invoke-virtual {p1, v1}, Landroid/graphics/Canvas;->restoreToCount(I)V

    :cond_1
    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v1}, Landroid/support/v4/widget/EdgeEffectCompat;->isFinished()Z

    move-result v1

    if-nez v1, :cond_3

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    move-result v1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->left:I

    iget v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aW:I

    add-int/2addr v2, v3

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->right:I

    iget v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aX:I

    add-int/2addr v3, v4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHeight()I

    move-result v4

    sub-int/2addr v4, v2

    sub-int/2addr v4, v3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v3

    iget v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aT:I

    add-int/2addr v0, v5

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    const/high16 v3, 0x42b40000    # 90.0f

    invoke-virtual {p1, v3}, Landroid/graphics/Canvas;->rotate(F)V

    neg-int v2, v2

    int-to-float v2, v2

    neg-int v0, v0

    int-to-float v0, v0

    invoke-virtual {p1, v2, v0}, Landroid/graphics/Canvas;->translate(FF)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v0, v4, v4}, Landroid/support/v4/widget/EdgeEffectCompat;->setSize(II)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {v0, p1}, Landroid/support/v4/widget/EdgeEffectCompat;->draw(Landroid/graphics/Canvas;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    :cond_2
    invoke-virtual {p1, v1}, Landroid/graphics/Canvas;->restoreToCount(I)V

    :cond_3
    return-void
.end method

.method protected drawableStateChanged()V
    .locals 0

    invoke-super {p0}, Lit/sephiroth/android/library/widget/a;->drawableStateChanged()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->j()V

    return-void
.end method

.method protected abstract e(I)I
.end method

.method protected e()V
    .locals 0

    return-void
.end method

.method protected f(I)I
    .locals 2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    const/4 v1, -0x1

    if-nez v0, :cond_0

    return v1

    :cond_0
    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->e(I)I

    move-result p1

    if-eq p1, v1, :cond_1

    return p1

    :cond_1
    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    add-int/2addr p1, v0

    add-int/lit8 p1, p1, -0x1

    return p1
.end method

.method protected f()V
    .locals 6

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->w:Landroid/view/View;

    const/4 v1, 0x4

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v0, :cond_4

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    if-lez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v4

    if-lez v4, :cond_2

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->left:I

    if-ge v0, v4, :cond_1

    const/4 v0, 0x1

    goto :goto_1

    :cond_1
    const/4 v0, 0x0

    :cond_2
    :goto_1
    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->w:Landroid/view/View;

    if-eqz v0, :cond_3

    const/4 v0, 0x0

    goto :goto_2

    :cond_3
    const/4 v0, 0x4

    :goto_2
    invoke-virtual {v4, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_4
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->x:Landroid/view/View;

    if-eqz v0, :cond_9

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    iget v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    add-int/2addr v4, v0

    iget v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-ge v4, v5, :cond_5

    const/4 v4, 0x1

    goto :goto_3

    :cond_5
    const/4 v4, 0x0

    :goto_3
    if-nez v4, :cond_7

    if-lez v0, :cond_7

    sub-int/2addr v0, v2

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getRight()I

    move-result v4

    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v5, v5, Landroid/graphics/Rect;->right:I

    sub-int/2addr v4, v5

    if-le v0, v4, :cond_6

    const/4 v4, 0x1

    goto :goto_4

    :cond_6
    const/4 v4, 0x0

    :cond_7
    :goto_4
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->x:Landroid/view/View;

    if-eqz v4, :cond_8

    const/4 v1, 0x0

    :cond_8
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_9
    return-void
.end method

.method g()Z
    .locals 1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    packed-switch v0, :pswitch_data_0

    const/4 v0, 0x0

    return v0

    :pswitch_0
    const/4 v0, 0x1

    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method protected generateDefaultLayoutParams()Landroid/view/ViewGroup$LayoutParams;
    .locals 4

    new-instance v0, Lit/sephiroth/android/library/widget/AbsHListView$f;

    const/4 v1, -0x2

    const/4 v2, -0x1

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Lit/sephiroth/android/library/widget/AbsHListView$f;-><init>(III)V

    return-object v0
.end method

.method public synthetic generateLayoutParams(Landroid/util/AttributeSet;)Landroid/view/ViewGroup$LayoutParams;
    .locals 0

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Landroid/util/AttributeSet;)Lit/sephiroth/android/library/widget/AbsHListView$f;

    move-result-object p1

    return-object p1
.end method

.method protected generateLayoutParams(Landroid/view/ViewGroup$LayoutParams;)Landroid/view/ViewGroup$LayoutParams;
    .locals 1

    new-instance v0, Lit/sephiroth/android/library/widget/AbsHListView$f;

    invoke-direct {v0, p1}, Lit/sephiroth/android/library/widget/AbsHListView$f;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    return-object v0
.end method

.method public getCacheColorHint()I
    .locals 1
    .annotation runtime Landroid/view/ViewDebug$ExportedProperty;
        category = "drawing"
    .end annotation

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aH:I

    return v0
.end method

.method public getCheckedItemCount()I
    .locals 1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    return v0
.end method

.method public getCheckedItemIds()[J
    .locals 6

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    if-nez v0, :cond_0

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {v0}, Landroid/support/v4/util/LongSparseArray;->size()I

    move-result v2

    new-array v3, v2, [J

    :goto_0
    if-ge v1, v2, :cond_1

    invoke-virtual {v0, v1}, Landroid/support/v4/util/LongSparseArray;->keyAt(I)J

    move-result-wide v4

    aput-wide v4, v3, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return-object v3

    :cond_2
    :goto_1
    new-array v0, v1, [J

    return-object v0
.end method

.method public getCheckedItemPosition()I
    .locals 2

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0}, Landroid/support/v4/util/SparseArrayCompat;->size()I

    move-result v0

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/util/SparseArrayCompat;->keyAt(I)I

    move-result v0

    return v0

    :cond_0
    const/4 v0, -0x1

    return v0
.end method

.method public getCheckedItemPositions()Landroid/support/v4/util/SparseArrayCompat;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Landroid/support/v4/util/SparseArrayCompat<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getChoiceMode()I
    .locals 1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    return v0
.end method

.method protected getContextMenuInfo()Landroid/view/ContextMenu$ContextMenuInfo;
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->az:Landroid/view/ContextMenu$ContextMenuInfo;

    return-object v0
.end method

.method public getFocusedRect(Landroid/graphics/Rect;)V
    .locals 2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getSelectedView()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    if-ne v1, p0, :cond_0

    invoke-virtual {v0, p1}, Landroid/view/View;->getFocusedRect(Landroid/graphics/Rect;)V

    invoke-virtual {p0, v0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->offsetDescendantRectToMyCoords(Landroid/view/View;Landroid/graphics/Rect;)V

    return-void

    :cond_0
    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->getFocusedRect(Landroid/graphics/Rect;)V

    return-void
.end method

.method protected getFooterViewsCount()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method protected getHeaderViewsCount()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method protected getHorizontalScrollFactor()F
    .locals 4

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bd:F

    const/4 v1, 0x0

    cmpl-float v0, v0, v1

    if-nez v0, :cond_1

    new-instance v0, Landroid/util/TypedValue;

    invoke-direct {v0}, Landroid/util/TypedValue;-><init>()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v1

    const v2, 0x7f040144

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v0, v3}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/util/TypedValue;->getDimension(Landroid/util/DisplayMetrics;)F

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bd:F

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Expected theme to define hlv_listPreferredItemWidth."

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    :goto_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bd:F

    return v0
.end method

.method protected getHorizontalScrollbarHeight()I
    .locals 1

    invoke-super {p0}, Lit/sephiroth/android/library/widget/a;->getHorizontalScrollbarHeight()I

    move-result v0

    return v0
.end method

.method protected getLeftFadingEdgeStrength()F
    .locals 4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    invoke-super {p0}, Lit/sephiroth/android/library/widget/a;->getLeftFadingEdgeStrength()F

    move-result v1

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    if-lez v0, :cond_1

    const/high16 v0, 0x3f800000    # 1.0f

    return v0

    :cond_1
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHorizontalFadingEdgeLength()I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingLeft()I

    move-result v3

    if-ge v0, v3, :cond_2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingLeft()I

    move-result v1

    sub-int/2addr v0, v1

    neg-int v0, v0

    int-to-float v0, v0

    div-float v1, v0, v2

    :cond_2
    return v1
.end method

.method public getListPaddingBottom()I
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    return v0
.end method

.method public getListPaddingLeft()I
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    return v0
.end method

.method public getListPaddingRight()I
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->right:I

    return v0
.end method

.method public getListPaddingTop()I
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->top:I

    return v0
.end method

.method protected getRightFadingEdgeStrength()F
    .locals 5

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    invoke-super {p0}, Lit/sephiroth/android/library/widget/a;->getRightFadingEdgeStrength()F

    move-result v1

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    add-int/2addr v2, v0

    add-int/lit8 v2, v2, -0x1

    iget v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    add-int/lit8 v3, v3, -0x1

    if-ge v2, v3, :cond_1

    const/high16 v0, 0x3f800000    # 1.0f

    return v0

    :cond_1
    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHorizontalFadingEdgeLength()I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingRight()I

    move-result v4

    sub-int v4, v2, v4

    if-le v0, v4, :cond_2

    sub-int/2addr v0, v2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingRight()I

    move-result v1

    add-int/2addr v0, v1

    int-to-float v0, v0

    div-float v1, v0, v3

    :cond_2
    return v1
.end method

.method public getSelectedView()Landroid/view/View;
    .locals 2
    .annotation runtime Landroid/view/ViewDebug$ExportedProperty;
    .end annotation

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-lez v0, :cond_0

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    if-ltz v0, :cond_0

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int/2addr v0, v1

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getSelector()Landroid/graphics/drawable/Drawable;
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method public getSolidColor()I
    .locals 1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aH:I

    return v0
.end method

.method public getTranscriptMode()I
    .locals 1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aG:I

    return v0
.end method

.method protected h()Z
    .locals 1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->hasFocus()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isInTouchMode()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->g()Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    const/4 v0, 0x1

    return v0

    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method protected i()V
    .locals 4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isEnabled()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isClickable()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->o:Landroid/graphics/Rect;

    if-eqz v0, :cond_7

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isFocused()Z

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->g()Z

    move-result v2

    if-eqz v2, :cond_7

    :cond_1
    invoke-virtual {v1}, Landroid/graphics/Rect;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_7

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int/2addr v1, v2

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    const/4 v2, 0x1

    if-eqz v1, :cond_3

    invoke-virtual {v1}, Landroid/view/View;->hasFocusable()Z

    move-result v3

    if-eqz v3, :cond_2

    return-void

    :cond_2
    invoke-virtual {v1, v2}, Landroid/view/View;->setPressed(Z)V

    :cond_3
    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->setPressed(Z)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isLongClickable()Z

    move-result v1

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getCurrent()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_5

    instance-of v2, v0, Landroid/graphics/drawable/TransitionDrawable;

    if-eqz v2, :cond_5

    if-eqz v1, :cond_4

    check-cast v0, Landroid/graphics/drawable/TransitionDrawable;

    invoke-static {}, Landroid/view/ViewConfiguration;->getLongPressTimeout()I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/graphics/drawable/TransitionDrawable;->startTransition(I)V

    goto :goto_0

    :cond_4
    check-cast v0, Landroid/graphics/drawable/TransitionDrawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/TransitionDrawable;->resetTransition()V

    :cond_5
    :goto_0
    if-eqz v1, :cond_7

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    if-nez v0, :cond_7

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aD:Lit/sephiroth/android/library/widget/AbsHListView$b;

    if-nez v0, :cond_6

    new-instance v0, Lit/sephiroth/android/library/widget/AbsHListView$b;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView$b;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;Lit/sephiroth/android/library/widget/AbsHListView$1;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aD:Lit/sephiroth/android/library/widget/AbsHListView$b;

    :cond_6
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aD:Lit/sephiroth/android/library/widget/AbsHListView$b;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView$b;->a()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aD:Lit/sephiroth/android/library/widget/AbsHListView$b;

    invoke-static {}, Landroid/view/ViewConfiguration;->getLongPressTimeout()I

    move-result v1

    int-to-long v1, v1

    invoke-virtual {p0, v0, v1, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_7
    return-void
.end method

.method j()V
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->h()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getDrawableState()[I

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    return-void

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    sget-object v1, Lit/sephiroth/android/library/widget/AbsHListView;->U:[I

    goto :goto_0

    :cond_1
    return-void
.end method

.method public jumpDrawablesToCurrentState()V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    invoke-super {p0}, Lit/sephiroth/android/library/widget/a;->jumpDrawablesToCurrentState()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->jumpToCurrentState()V

    :cond_0
    return-void
.end method

.method protected k()V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/a/a$a;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    instance-of v0, v0, Landroid/view/View;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->invalidate()V

    :cond_0
    return-void
.end method

.method protected l()V
    .locals 3

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_2

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    const/4 v2, 0x4

    if-eq v0, v2, :cond_0

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->M:I

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ak:I

    if-ltz v0, :cond_1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ak:I

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    if-eq v0, v2, :cond_1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ak:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->M:I

    :cond_1
    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->setSelectedPositionInt(I)V

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->setNextSelectedPositionInt(I)V

    const/4 v0, 0x0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->J:I

    :cond_2
    return-void
.end method

.method protected m()I
    .locals 2

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    if-gez v0, :cond_0

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->M:I

    :cond_0
    const/4 v1, 0x0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    add-int/lit8 v1, v1, -0x1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    return v0
.end method

.method protected n()Z
    .locals 1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    if-gez v0, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->o()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->j()V

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method o()Z
    .locals 12

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    const/4 v1, 0x0

    if-gtz v0, :cond_0

    return v1

    :cond_0
    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->left:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getRight()I

    move-result v3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getLeft()I

    move-result v4

    sub-int/2addr v3, v4

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->right:I

    sub-int/2addr v3, v4

    iget v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    iget v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->M:I

    const/4 v6, 0x1

    if-lt v5, v4, :cond_3

    add-int v7, v4, v0

    if-ge v5, v7, :cond_3

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int v0, v5, v0

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v7

    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v8

    if-ge v7, v2, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHorizontalFadingEdgeLength()I

    move-result v0

    add-int v7, v2, v0

    goto :goto_0

    :cond_1
    if-le v8, v3, :cond_2

    invoke-virtual {v0}, Landroid/view/View;->getMeasuredWidth()I

    move-result v0

    sub-int/2addr v3, v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHorizontalFadingEdgeLength()I

    move-result v0

    sub-int v7, v3, v0

    :cond_2
    :goto_0
    const/4 v0, 0x1

    goto/16 :goto_a

    :cond_3
    if-ge v5, v4, :cond_9

    move v3, v2

    const/4 v2, 0x0

    const/4 v5, 0x0

    :goto_1
    if-ge v2, v0, :cond_8

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v7

    invoke-virtual {v7}, Landroid/view/View;->getLeft()I

    move-result v7

    if-nez v2, :cond_6

    if-gtz v4, :cond_5

    if-ge v7, v3, :cond_4

    goto :goto_3

    :cond_4
    :goto_2
    move v5, v7

    goto :goto_4

    :cond_5
    :goto_3
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHorizontalFadingEdgeLength()I

    move-result v5

    add-int/2addr v3, v5

    goto :goto_2

    :cond_6
    :goto_4
    if-lt v7, v3, :cond_7

    add-int v0, v4, v2

    move v5, v0

    goto :goto_0

    :cond_7
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_8
    move v7, v5

    move v5, v4

    goto :goto_0

    :cond_9
    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    add-int v5, v4, v0

    add-int/lit8 v7, v5, -0x1

    sub-int/2addr v0, v6

    move v8, v3

    const/4 v9, 0x0

    move v3, v0

    :goto_5
    if-ltz v3, :cond_e

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v10

    invoke-virtual {v10}, Landroid/view/View;->getLeft()I

    move-result v11

    invoke-virtual {v10}, Landroid/view/View;->getRight()I

    move-result v10

    if-ne v3, v0, :cond_c

    if-lt v5, v2, :cond_b

    if-le v10, v8, :cond_a

    goto :goto_7

    :cond_a
    :goto_6
    move v9, v11

    goto :goto_8

    :cond_b
    :goto_7
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHorizontalFadingEdgeLength()I

    move-result v9

    sub-int/2addr v8, v9

    goto :goto_6

    :cond_c
    :goto_8
    if-gt v10, v8, :cond_d

    add-int v5, v4, v3

    move v7, v11

    goto :goto_9

    :cond_d
    add-int/lit8 v3, v3, -0x1

    goto :goto_5

    :cond_e
    move v5, v7

    move v7, v9

    :goto_9
    const/4 v0, 0x0

    :goto_a
    const/4 v2, -0x1

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->M:I

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz v3, :cond_f

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {v3}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    :cond_f
    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->F()V

    iput v7, p0, Lit/sephiroth/android/library/widget/AbsHListView;->W:I

    invoke-virtual {p0, v5, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->b(IZ)I

    move-result v0

    if-lt v0, v4, :cond_10

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getLastVisiblePosition()I

    move-result v3

    if-gt v0, v3, :cond_10

    const/4 v2, 0x4

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->j()V

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->setSelectionInt(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->b()V

    goto :goto_b

    :cond_10
    const/4 v0, -0x1

    :goto_b
    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->b(I)V

    if-ltz v0, :cond_11

    const/4 v1, 0x1

    :cond_11
    return v1
.end method

.method protected onAttachedToWindow()V
    .locals 3

    invoke-super {p0}, Lit/sephiroth/android/library/widget/a;->onAttachedToWindow()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->addOnTouchModeChangeListener(Landroid/view/ViewTreeObserver$OnTouchModeChangeListener;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    if-nez v0, :cond_0

    new-instance v0, Lit/sephiroth/android/library/widget/AbsHListView$a;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/widget/AbsHListView$a;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    invoke-interface {v0, v2}, Landroid/widget/ListAdapter;->registerDataSetObserver(Landroid/database/DataSetObserver;)V

    iput-boolean v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ap:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v0}, Landroid/widget/ListAdapter;->getCount()I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    :cond_0
    iput-boolean v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->S:Z

    return-void
.end method

.method protected onCreateDrawableState(I)[I
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "Override"
        }
    .end annotation

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aI:Z

    if-eqz v0, :cond_0

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->onCreateDrawableState(I)[I

    move-result-object p1

    return-object p1

    :cond_0
    sget-object v0, Lit/sephiroth/android/library/widget/AbsHListView;->ENABLED_STATE_SET:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    add-int/lit8 p1, p1, 0x1

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->onCreateDrawableState(I)[I

    move-result-object p1

    array-length v1, p1

    add-int/lit8 v1, v1, -0x1

    :goto_0
    if-ltz v1, :cond_2

    aget v2, p1, v1

    if-ne v2, v0, :cond_1

    goto :goto_1

    :cond_1
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    :cond_2
    const/4 v1, -0x1

    :goto_1
    if-ltz v1, :cond_3

    add-int/lit8 v0, v1, 0x1

    array-length v2, p1

    sub-int/2addr v2, v1

    add-int/lit8 v2, v2, -0x1

    invoke-static {p1, v0, p1, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_3
    return-object p1
.end method

.method public onCreateInputConnection(Landroid/view/inputmethod/EditorInfo;)Landroid/view/inputmethod/InputConnection;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method protected onDetachedFromWindow()V
    .locals 3

    invoke-super {p0}, Lit/sephiroth/android/library/widget/a;->onDetachedFromWindow()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView$k;->b()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->removeOnTouchModeChangeListener(Landroid/view/ViewTreeObserver$OnTouchModeChangeListener;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    invoke-interface {v0, v2}, Landroid/widget/ListAdapter;->unregisterDataSetObserver(Landroid/database/DataSetObserver;)V

    iput-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->i:Lit/sephiroth/android/library/widget/AbsHListView$a;

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    :cond_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aL:Ljava/lang/Runnable;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aL:Ljava/lang/Runnable;

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    :cond_3
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aE:Lit/sephiroth/android/library/widget/AbsHListView$i;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aE:Lit/sephiroth/android/library/widget/AbsHListView$i;

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    :cond_4
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aF:Ljava/lang/Runnable;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aF:Ljava/lang/Runnable;

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    iput-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aF:Ljava/lang/Runnable;

    :cond_5
    const/4 v0, 0x0

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->S:Z

    return-void
.end method

.method protected onFocusChanged(ZILandroid/graphics/Rect;)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Lit/sephiroth/android/library/widget/a;->onFocusChanged(ZILandroid/graphics/Rect;)V

    if-eqz p1, :cond_1

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    if-gez p1, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isInTouchMode()Z

    move-result p1

    if-nez p1, :cond_1

    iget-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->S:Z

    if-nez p1, :cond_0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ap:I

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {p1}, Landroid/widget/ListAdapter;->getCount()I

    move-result p1

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->o()Z

    :cond_1
    return-void
.end method

.method public onGenericMotionEvent(Landroid/view/MotionEvent;)Z
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xc
    .end annotation

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getSource()I

    move-result v0

    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    goto :goto_0

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    const/16 v0, 0xa

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getAxisValue(I)F

    move-result v0

    const/4 v1, 0x0

    cmpl-float v1, v0, v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHorizontalScrollFactor()F

    move-result v1

    mul-float v0, v0, v1

    float-to-int v0, v0

    invoke-virtual {p0, v0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->c(II)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 p1, 0x1

    return p1

    :cond_1
    :goto_0
    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->onGenericMotionEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method public onInitializeAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->onInitializeAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V

    const-class v0, Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityEvent;->setClassName(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public onInitializeAccessibilityNodeInfo(Landroid/view/accessibility/AccessibilityNodeInfo;)V
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "Override"
        }
    .end annotation

    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->onInitializeAccessibilityNodeInfo(Landroid/view/accessibility/AccessibilityNodeInfo;)V

    const-class v0, Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityNodeInfo;->setClassName(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isEnabled()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getFirstVisiblePosition()I

    move-result v0

    if-lez v0, :cond_0

    const/16 v0, 0x2000

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityNodeInfo;->addAction(I)V

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getLastVisiblePosition()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getCount()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ge v0, v1, :cond_1

    const/16 v0, 0x1000

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityNodeInfo;->addAction(I)V

    :cond_1
    return-void
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 8

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    :cond_0
    iget-boolean v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->S:Z

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    and-int/lit16 v0, v0, 0xff

    const/4 v1, 0x6

    if-eq v0, v1, :cond_7

    const/4 v3, 0x1

    const/4 v4, -0x1

    packed-switch v0, :pswitch_data_0

    return v2

    :pswitch_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    if-eqz v0, :cond_2

    return v2

    :cond_2
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v0

    if-ne v0, v4, :cond_3

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    const/4 v0, 0x0

    :cond_3
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v0

    float-to-int v0, v0

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->C()V

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    invoke-virtual {v1, p1}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    invoke-direct {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->h(I)Z

    move-result p1

    if-eqz p1, :cond_8

    return v3

    :pswitch_1
    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->D()V

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->b(I)V

    return v2

    :pswitch_2
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    if-eq v0, v1, :cond_6

    const/4 v1, 0x5

    if-ne v0, v1, :cond_4

    goto :goto_0

    :cond_4
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    float-to-int v1, v1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v4

    float-to-int v4, v4

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v5

    iput v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->e(I)I

    move-result v5

    const/4 v6, 0x4

    if-eq v0, v6, :cond_5

    if-ltz v5, :cond_5

    iget v7, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int v7, v5, v7

    invoke-virtual {p0, v7}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v7

    invoke-virtual {v7}, Landroid/view/View;->getLeft()I

    move-result v7

    iput v7, p0, Lit/sephiroth/android/library/widget/AbsHListView;->B:I

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->D:I

    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->E:I

    iput v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->F()V

    :cond_5
    const/high16 v1, -0x80000000

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->B()V

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    invoke-virtual {v1, p1}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    if-ne v0, v6, :cond_8

    return v3

    :cond_6
    :goto_0
    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->H:I

    return v3

    :cond_7
    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->b(Landroid/view/MotionEvent;)V

    :cond_8
    return v2

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 4

    const/16 v0, 0x17

    if-eq p1, v0, :cond_0

    const/16 v0, 0x42

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isEnabled()Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isClickable()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isPressed()Z

    move-result v0

    if-eqz v0, :cond_3

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    if-ltz v0, :cond_3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    if-eqz v0, :cond_3

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v2}, Landroid/widget/ListAdapter;->getCount()I

    move-result v2

    if-ge v0, v2, :cond_3

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    iget p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int/2addr p1, p2

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    const/4 p2, 0x0

    if-eqz p1, :cond_2

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    iget-wide v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->an:J

    invoke-virtual {p0, p1, v0, v2, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Landroid/view/View;IJ)Z

    invoke-virtual {p1, p2}, Landroid/view/View;->setPressed(Z)V

    :cond_2
    invoke-virtual {p0, p2}, Lit/sephiroth/android/library/widget/AbsHListView;->setPressed(Z)V

    return v1

    :cond_3
    :goto_0
    invoke-super {p0, p1, p2}, Lit/sephiroth/android/library/widget/a;->onKeyUp(ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method

.method protected onLayout(ZIIII)V
    .locals 1

    invoke-super/range {p0 .. p5}, Lit/sephiroth/android/library/widget/a;->onLayout(ZIIII)V

    const/4 p3, 0x1

    iput-boolean p3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->af:Z

    const/4 p3, 0x0

    if-eqz p1, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result p1

    const/4 p5, 0x0

    :goto_0
    if-ge p5, p1, :cond_0

    invoke-virtual {p0, p5}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->forceLayout()V

    add-int/lit8 p5, p5, 0x1

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a()V

    :cond_1
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->e()V

    iput-boolean p3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->af:Z

    sub-int/2addr p4, p2

    div-int/lit8 p4, p4, 0x3

    iput p4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->N:I

    return-void
.end method

.method protected onMeasure(II)V
    .locals 3

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    if-nez p1, :cond_0

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->A()V

    :cond_0
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->q:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingLeft()I

    move-result v0

    add-int/2addr p2, v0

    iput p2, p1, Landroid/graphics/Rect;->left:I

    iget p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->r:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingTop()I

    move-result v0

    add-int/2addr p2, v0

    iput p2, p1, Landroid/graphics/Rect;->top:I

    iget p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->s:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingRight()I

    move-result v0

    add-int/2addr p2, v0

    iput p2, p1, Landroid/graphics/Rect;->right:I

    iget p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->t:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingBottom()I

    move-result v0

    add-int/2addr p2, v0

    iput p2, p1, Landroid/graphics/Rect;->bottom:I

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aG:I

    const/4 p2, 0x1

    if-ne p1, p2, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result p1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingRight()I

    move-result v1

    sub-int/2addr v0, v1

    add-int/lit8 v1, p1, -0x1

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Landroid/view/View;->getRight()I

    move-result v1

    goto :goto_0

    :cond_1
    move v1, v0

    :goto_0
    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    add-int/2addr v2, p1

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bb:I

    if-lt v2, p1, :cond_2

    if-gt v1, v0, :cond_2

    goto :goto_1

    :cond_2
    const/4 p2, 0x0

    :goto_1
    iput-boolean p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aV:Z

    :cond_3
    return-void
.end method

.method protected onOverScrolled(IIZZ)V
    .locals 0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result p2

    if-eq p2, p1, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollY()I

    move-result p2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result p3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollY()I

    move-result p4

    invoke-virtual {p0, p1, p2, p3, p4}, Lit/sephiroth/android/library/widget/AbsHListView;->onScrollChanged(IIII)V

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {p2, p1}, Lit/sephiroth/android/library/a/a$a;->a(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->k()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->awakenScrollBars()Z

    :cond_0
    return-void
.end method

.method public onRestoreInstanceState(Landroid/os/Parcelable;)V
    .locals 6

    check-cast p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->getSuperState()Landroid/os/Parcelable;

    move-result-object v0

    invoke-super {p0, v0}, Lit/sephiroth/android/library/widget/a;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    iget v1, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->e:I

    int-to-long v1, v1

    iput-wide v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ac:J

    iget-wide v1, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->a:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-ltz v5, :cond_0

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ad:Z

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget-wide v0, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->a:J

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ab:J

    iget v0, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->d:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aa:I

    iget v0, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->c:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->W:I

    const/4 v0, 0x0

    :goto_0
    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ae:I

    goto :goto_1

    :cond_0
    iget-wide v1, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->b:J

    cmp-long v5, v1, v3

    if-ltz v5, :cond_1

    const/4 v1, -0x1

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->setSelectedPositionInt(I)V

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->setNextSelectedPositionInt(I)V

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->n:I

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ad:Z

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget-wide v1, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->b:J

    iput-wide v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ab:J

    iget v1, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->d:I

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aa:I

    iget v1, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->c:I

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->W:I

    goto :goto_0

    :cond_1
    :goto_1
    iget-object v0, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->i:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz v0, :cond_2

    iget-object v0, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->i:Landroid/support/v4/util/SparseArrayCompat;

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    :cond_2
    iget-object v0, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->j:Landroid/support/v4/util/LongSparseArray;

    if-eqz v0, :cond_3

    iget-object v0, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->j:Landroid/support/v4/util/LongSparseArray;

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    :cond_3
    iget v0, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->h:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xb

    if-lt v0, v1, :cond_4

    iget-boolean p1, p1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->g:Z

    if-eqz p1, :cond_4

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    const/4 v0, 0x3

    if-ne p1, v0, :cond_4

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    check-cast p1, Lit/sephiroth/android/library/a/a/b;

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->startActionMode(Landroid/view/ActionMode$Callback;)Landroid/view/ActionMode;

    move-result-object p1

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    :cond_4
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->requestLayout()V

    return-void
.end method

.method public onSaveInstanceState()Landroid/os/Parcelable;
    .locals 9

    invoke-super {p0}, Lit/sephiroth/android/library/widget/a;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    new-instance v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    invoke-direct {v1, v0}, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;-><init>(Landroid/os/Parcelable;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget-wide v2, v0, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->a:J

    iput-wide v2, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->a:J

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget-wide v2, v0, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->b:J

    iput-wide v2, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->b:J

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget v0, v0, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->c:I

    iput v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->c:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget v0, v0, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->d:I

    iput v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->d:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget v0, v0, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->e:I

    iput v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->e:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget-object v0, v0, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->f:Ljava/lang/String;

    iput-object v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->f:Ljava/lang/String;

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget-boolean v0, v0, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->g:Z

    iput-boolean v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->g:Z

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget v0, v0, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->h:I

    iput v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->h:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget-object v0, v0, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->i:Landroid/support/v4/util/SparseArrayCompat;

    iput-object v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->i:Landroid/support/v4/util/SparseArrayCompat;

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget-object v0, v0, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->j:Landroid/support/v4/util/LongSparseArray;

    iput-object v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->j:Landroid/support/v4/util/LongSparseArray;

    return-object v1

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-lez v0, :cond_1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-lez v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getSelectedItemId()J

    move-result-wide v4

    iput-wide v4, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->a:J

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v6

    iput v6, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->e:I

    const-wide/16 v6, 0x0

    cmp-long v8, v4, v6

    const-wide/16 v4, -0x1

    if-ltz v8, :cond_2

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->J:I

    iput v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->c:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getSelectedItemPosition()I

    move-result v0

    iput v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->d:I

    :goto_1
    iput-wide v4, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->b:J

    goto :goto_2

    :cond_2
    if-eqz v0, :cond_4

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    if-lez v0, :cond_4

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    iput v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->c:I

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    iget v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-lt v0, v4, :cond_3

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    sub-int/2addr v0, v2

    :cond_3
    iput v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->d:I

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v4, v0}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v4

    goto :goto_1

    :cond_4
    iput v3, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->c:I

    iput-wide v4, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->b:J

    iput v3, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->d:I

    :goto_2
    const/4 v0, 0x0

    iput-object v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->f:Ljava/lang/String;

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0xb

    if-lt v0, v4, :cond_5

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    const/4 v4, 0x3

    if-ne v0, v4, :cond_5

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    if-eqz v0, :cond_5

    goto :goto_3

    :cond_5
    const/4 v2, 0x0

    :goto_3
    iput-boolean v2, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->g:Z

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz v0, :cond_6

    :try_start_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0}, Landroid/support/v4/util/SparseArrayCompat;->clone()Landroid/support/v4/util/SparseArrayCompat;

    move-result-object v0

    iput-object v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->i:Landroid/support/v4/util/SparseArrayCompat;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodError; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_4

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/NoSuchMethodError;->printStackTrace()V

    new-instance v0, Landroid/support/v4/util/SparseArrayCompat;

    invoke-direct {v0}, Landroid/support/v4/util/SparseArrayCompat;-><init>()V

    iput-object v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->i:Landroid/support/v4/util/SparseArrayCompat;

    :cond_6
    :goto_4
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    if-eqz v0, :cond_8

    new-instance v0, Landroid/support/v4/util/LongSparseArray;

    invoke-direct {v0}, Landroid/support/v4/util/LongSparseArray;-><init>()V

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {v2}, Landroid/support/v4/util/LongSparseArray;->size()I

    move-result v2

    :goto_5
    if-ge v3, v2, :cond_7

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {v4, v3}, Landroid/support/v4/util/LongSparseArray;->keyAt(I)J

    move-result-wide v4

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {v6, v3}, Landroid/support/v4/util/LongSparseArray;->valueAt(I)Ljava/lang/Object;

    move-result-object v6

    invoke-virtual {v0, v4, v5, v6}, Landroid/support/v4/util/LongSparseArray;->put(JLjava/lang/Object;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_5

    :cond_7
    iput-object v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->j:Landroid/support/v4/util/LongSparseArray;

    :cond_8
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    iput v0, v1, Lit/sephiroth/android/library/widget/AbsHListView$SavedState;->h:I

    return-object v1
.end method

.method protected onSizeChanged(IIII)V
    .locals 0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result p1

    if-lez p1, :cond_0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->w()V

    :cond_0
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 11
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "Override"
        }
    .end annotation

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isEnabled()Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-nez v0, :cond_2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isClickable()Z

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isLongClickable()Z

    move-result p1

    if-eqz p1, :cond_0

    return v1

    :cond_0
    const/4 v1, 0x0

    :cond_1
    return v1

    :cond_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    :cond_3
    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->S:Z

    if-nez v0, :cond_4

    return v2

    :cond_4
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->C()V

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    invoke-virtual {v3, p1}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    and-int/lit16 v0, v0, 0xff

    const/4 v3, 0x5

    const/4 v4, -0x1

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    return v1

    :pswitch_1
    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->b(Landroid/view/MotionEvent;)V

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->D:I

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->E:I

    invoke-virtual {p0, p1, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->a(II)I

    move-result v0

    if-ltz v0, :cond_5

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int v2, v0, v2

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getLeft()I

    move-result v2

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->B:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    :cond_5
    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    return v1

    :pswitch_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v3

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v4

    float-to-int v4, v4

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result p1

    float-to-int p1, p1

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->H:I

    iput v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->D:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->E:I

    invoke-virtual {p0, v4, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(II)I

    move-result p1

    if-ltz p1, :cond_6

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int v0, p1, v0

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->B:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    :cond_6
    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    return v1

    :pswitch_3
    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    packed-switch p1, :pswitch_data_1

    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->setPressed(Z)V

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int/2addr p1, v0

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    if-eqz p1, :cond_8

    invoke-virtual {p1, v2}, Landroid/view/View;->setPressed(Z)V

    goto :goto_0

    :pswitch_4
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    if-nez p1, :cond_7

    new-instance p1, Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-direct {p1, p0}, Lit/sephiroth/android/library/widget/AbsHListView$e;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    :cond_7
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$e;->a()V

    goto :goto_1

    :cond_8
    :goto_0
    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->F()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHandler()Landroid/os/Handler;

    move-result-object p1

    if-eqz p1, :cond_9

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aB:Lit/sephiroth/android/library/widget/AbsHListView$c;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_9
    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->D()V

    :goto_1
    :pswitch_5
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    if-eqz p1, :cond_25

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {p1}, Landroid/support/v4/widget/EdgeEffectCompat;->onRelease()Z

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {p1}, Landroid/support/v4/widget/EdgeEffectCompat;->onRelease()Z

    goto/16 :goto_8

    :pswitch_6
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v0

    if-ne v0, v4, :cond_a

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    const/4 v0, 0x0

    :cond_a
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result p1

    float-to-int p1, p1

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    if-eqz v0, :cond_b

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->e()V

    :cond_b
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    if-eq v0, v3, :cond_c

    packed-switch v0, :pswitch_data_2

    return v1

    :pswitch_7
    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->h(I)Z

    return v1

    :cond_c
    :pswitch_8
    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->i(I)V

    return v1

    :pswitch_9
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    const/4 v5, 0x2

    const/16 v6, 0x3e8

    if-eq v0, v3, :cond_1f

    packed-switch v0, :pswitch_data_3

    goto/16 :goto_7

    :pswitch_a
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result p1

    if-lez p1, :cond_13

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    add-int/lit8 v3, p1, -0x1

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getRight()I

    move-result v3

    iget-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v7, v7, Landroid/graphics/Rect;->left:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v8

    iget-object v9, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v9, v9, Landroid/graphics/Rect;->right:I

    sub-int/2addr v8, v9

    iget v9, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    if-nez v9, :cond_d

    if-lt v0, v7, :cond_d

    iget v9, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    add-int/2addr v9, p1

    iget v10, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-ge v9, v10, :cond_d

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v9

    sub-int/2addr v9, v8

    if-gt v3, v9, :cond_d

    goto :goto_2

    :cond_d
    iget-object v9, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    iget v10, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aN:I

    int-to-float v10, v10

    invoke-virtual {v9, v6, v10}, Landroid/view/VelocityTracker;->computeCurrentVelocity(IF)V

    iget v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    invoke-virtual {v9, v6}, Landroid/view/VelocityTracker;->getXVelocity(I)F

    move-result v6

    iget v9, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aO:F

    mul-float v6, v6, v9

    float-to-int v6, v6

    invoke-static {v6}, Ljava/lang/Math;->abs(I)I

    move-result v9

    iget v10, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aM:I

    if-le v9, v10, :cond_11

    iget v9, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    if-nez v9, :cond_e

    iget v9, p0, Lit/sephiroth/android/library/widget/AbsHListView;->Q:I

    sub-int/2addr v7, v9

    if-eq v0, v7, :cond_11

    :cond_e
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    add-int/2addr v0, p1

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-ne v0, p1, :cond_f

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->Q:I

    add-int/2addr v8, p1

    if-eq v3, v8, :cond_11

    :cond_f
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    if-nez p1, :cond_10

    new-instance p1, Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-direct {p1, p0}, Lit/sephiroth/android/library/widget/AbsHListView$e;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    :cond_10
    invoke-virtual {p0, v5}, Lit/sephiroth/android/library/widget/AbsHListView;->b(I)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    neg-int v0, v6

    invoke-virtual {p1, v0}, Lit/sephiroth/android/library/widget/AbsHListView$e;->a(I)V

    goto/16 :goto_7

    :cond_11
    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->b(I)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    if-eqz p1, :cond_12

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$e;->b()V

    :cond_12
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz p1, :cond_22

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    goto/16 :goto_7

    :cond_13
    :goto_2
    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->b(I)V

    goto/16 :goto_7

    :pswitch_b
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    iget v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int v3, v0, v3

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result p1

    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v5, v5, Landroid/graphics/Rect;->left:I

    int-to-float v5, v5

    cmpl-float v5, p1, v5

    if-lez v5, :cond_14

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v5

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v6, v6, Landroid/graphics/Rect;->right:I

    sub-int/2addr v5, v6

    int-to-float v5, v5

    cmpg-float p1, p1, v5

    if-gez p1, :cond_14

    const/4 p1, 0x1

    goto :goto_3

    :cond_14
    const/4 p1, 0x0

    :goto_3
    if-eqz v3, :cond_1e

    invoke-virtual {v3}, Landroid/view/View;->hasFocusable()Z

    move-result v5

    if-nez v5, :cond_1e

    if-eqz p1, :cond_1e

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    if-eqz p1, :cond_15

    invoke-virtual {v3, v2}, Landroid/view/View;->setPressed(Z)V

    :cond_15
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aE:Lit/sephiroth/android/library/widget/AbsHListView$i;

    if-nez p1, :cond_16

    new-instance p1, Lit/sephiroth/android/library/widget/AbsHListView$i;

    const/4 v5, 0x0

    invoke-direct {p1, p0, v5}, Lit/sephiroth/android/library/widget/AbsHListView$i;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;Lit/sephiroth/android/library/widget/AbsHListView$1;)V

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aE:Lit/sephiroth/android/library/widget/AbsHListView$i;

    :cond_16
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aE:Lit/sephiroth/android/library/widget/AbsHListView$i;

    iput v0, p1, Lit/sephiroth/android/library/widget/AbsHListView$i;->a:I

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$i;->a()V

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->M:I

    iget v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    if-eqz v5, :cond_18

    iget v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    if-ne v5, v1, :cond_17

    goto :goto_4

    :cond_17
    iget-boolean v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    if-nez v3, :cond_1e

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v3, v0}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v0

    if-eqz v0, :cond_1e

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$i;->run()V

    goto :goto_6

    :cond_18
    :goto_4
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHandler()Landroid/os/Handler;

    move-result-object v5

    if-eqz v5, :cond_1a

    iget v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    if-nez v6, :cond_19

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aC:Ljava/lang/Runnable;

    goto :goto_5

    :cond_19
    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aB:Lit/sephiroth/android/library/widget/AbsHListView$c;

    :goto_5
    invoke-virtual {v5, v6}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_1a
    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    iget-boolean v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    if-nez v2, :cond_1d

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v2, v0}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v0

    if-eqz v0, :cond_1d

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->setSelectedPositionInt(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->e()V

    invoke-virtual {v3, v1}, Landroid/view/View;->setPressed(Z)V

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    invoke-virtual {p0, v0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->a(ILandroid/view/View;)V

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->setPressed(Z)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_1b

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getCurrent()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_1b

    instance-of v2, v0, Landroid/graphics/drawable/TransitionDrawable;

    if-eqz v2, :cond_1b

    check-cast v0, Landroid/graphics/drawable/TransitionDrawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/TransitionDrawable;->resetTransition()V

    :cond_1b
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aF:Ljava/lang/Runnable;

    if-eqz v0, :cond_1c

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aF:Ljava/lang/Runnable;

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    :cond_1c
    new-instance v0, Lit/sephiroth/android/library/widget/AbsHListView$1;

    invoke-direct {v0, p0, v3, p1}, Lit/sephiroth/android/library/widget/AbsHListView$1;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Lit/sephiroth/android/library/widget/AbsHListView$i;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aF:Ljava/lang/Runnable;

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aF:Ljava/lang/Runnable;

    invoke-static {}, Landroid/view/ViewConfiguration;->getPressedStateDuration()I

    move-result v0

    int-to-long v2, v0

    invoke-virtual {p0, p1, v2, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->postDelayed(Ljava/lang/Runnable;J)Z

    return v1

    :cond_1d
    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->j()V

    return v1

    :cond_1e
    :goto_6
    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->j()V

    goto :goto_7

    :cond_1f
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    if-nez p1, :cond_20

    new-instance p1, Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-direct {p1, p0}, Lit/sephiroth/android/library/widget/AbsHListView$e;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    :cond_20
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->au:Landroid/view/VelocityTracker;

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aN:I

    int-to-float v0, v0

    invoke-virtual {p1, v6, v0}, Landroid/view/VelocityTracker;->computeCurrentVelocity(IF)V

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    invoke-virtual {p1, v0}, Landroid/view/VelocityTracker;->getXVelocity(I)F

    move-result p1

    float-to-int p1, p1

    invoke-virtual {p0, v5}, Lit/sephiroth/android/library/widget/AbsHListView;->b(I)V

    invoke-static {p1}, Ljava/lang/Math;->abs(I)I

    move-result v0

    iget v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aM:I

    if-le v0, v3, :cond_21

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    neg-int p1, p1

    invoke-virtual {v0, p1}, Lit/sephiroth/android/library/widget/AbsHListView$e;->b(I)V

    goto :goto_7

    :cond_21
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$e;->a()V

    :cond_22
    :goto_7
    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->setPressed(Z)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    if-eqz p1, :cond_23

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {p1}, Landroid/support/v4/widget/EdgeEffectCompat;->onRelease()Z

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-virtual {p1}, Landroid/support/v4/widget/EdgeEffectCompat;->onRelease()Z

    :cond_23
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getHandler()Landroid/os/Handler;

    move-result-object p1

    if-eqz p1, :cond_24

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aB:Lit/sephiroth/android/library/widget/AbsHListView$c;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_24
    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->D()V

    :cond_25
    :goto_8
    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    return v1

    :pswitch_c
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    const/4 v4, 0x6

    if-eq v0, v4, :cond_2a

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    float-to-int v0, v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v3

    float-to-int v3, v3

    invoke-virtual {p0, v0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->a(II)I

    move-result v4

    iget-boolean v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    if-nez v5, :cond_28

    iget v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    const/4 v6, 0x4

    if-eq v5, v6, :cond_27

    if-ltz v4, :cond_27

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getAdapter()Landroid/widget/Adapter;

    move-result-object v5

    check-cast v5, Landroid/widget/ListAdapter;

    invoke-interface {v5, v4}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v5

    if-eqz v5, :cond_27

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aC:Ljava/lang/Runnable;

    if-nez v2, :cond_26

    new-instance v2, Lit/sephiroth/android/library/widget/AbsHListView$d;

    invoke-direct {v2, p0}, Lit/sephiroth/android/library/widget/AbsHListView$d;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aC:Ljava/lang/Runnable;

    :cond_26
    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aC:Ljava/lang/Runnable;

    invoke-static {}, Landroid/view/ViewConfiguration;->getTapTimeout()I

    move-result v5

    int-to-long v5, v5

    invoke-virtual {p0, v2, v5, v6}, Lit/sephiroth/android/library/widget/AbsHListView;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_9

    :cond_27
    iget v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    if-ne v5, v6, :cond_28

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->E()V

    const/4 v4, 0x3

    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->H:I

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->e(I)I

    move-result v4

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {v2}, Lit/sephiroth/android/library/widget/AbsHListView$e;->c()V

    :cond_28
    :goto_9
    if-ltz v4, :cond_29

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int v2, v4, v2

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getLeft()I

    move-result v2

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->B:I

    :cond_29
    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->D:I

    iput v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->E:I

    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    const/high16 v0, -0x80000000

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    goto :goto_a

    :cond_2a
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView$e;->b()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz v0, :cond_2b

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    :cond_2b
    iput v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v0

    float-to-int v0, v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->E:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    float-to-int v0, v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->G:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->D:I

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->H:I

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aP:I

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aU:I

    :goto_a
    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Landroid/view/MotionEvent;)Z

    move-result p1

    if-eqz p1, :cond_2c

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    if-nez p1, :cond_2c

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aC:Ljava/lang/Runnable;

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    :cond_2c
    return v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_c
        :pswitch_9
        :pswitch_6
        :pswitch_3
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x5
        :pswitch_4
        :pswitch_5
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x0
        :pswitch_7
        :pswitch_7
        :pswitch_7
        :pswitch_8
    .end packed-switch

    :pswitch_data_3
    .packed-switch 0x0
        :pswitch_b
        :pswitch_b
        :pswitch_b
        :pswitch_a
    .end packed-switch
.end method

.method public onTouchModeChanged(Z)V
    .locals 1

    if-eqz p1, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->l()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result p1

    if-lez p1, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result p1

    if-lez p1, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->e()V

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->j()V

    return-void

    :cond_1
    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    const/4 v0, 0x5

    if-eq p1, v0, :cond_2

    const/4 v0, 0x6

    if-ne p1, v0, :cond_5

    :cond_2
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$e;->b()V

    :cond_3
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    :cond_4
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result p1

    if-eqz p1, :cond_5

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lit/sephiroth/android/library/a/a$a;->a(I)V

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->G()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    :cond_5
    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 4

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->onWindowFocusChanged(Z)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isInTouchMode()Z

    move-result v0

    const/4 v1, 0x1

    xor-int/2addr v0, v1

    const/4 v2, 0x0

    if-nez p1, :cond_2

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->setChildrenDrawingCacheEnabled(Z)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$e;->b()V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {p1, v2}, Lit/sephiroth/android/library/a/a$a;->a(I)V

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->G()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    :cond_1
    if-ne v0, v1, :cond_4

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->M:I

    goto :goto_0

    :cond_2
    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aA:I

    if-eq v0, p1, :cond_4

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aA:I

    const/4 v3, -0x1

    if-eq p1, v3, :cond_4

    if-ne v0, v1, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->o()Z

    goto :goto_0

    :cond_3
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->l()V

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->e()V

    :cond_4
    :goto_0
    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aA:I

    return-void
.end method

.method p()V
    .locals 14

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0}, Landroid/support/v4/util/SparseArrayCompat;->clear()V

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {v3}, Landroid/support/v4/util/LongSparseArray;->size()I

    move-result v3

    const/16 v4, 0xb

    if-ge v1, v3, :cond_5

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {v3, v1}, Landroid/support/v4/util/LongSparseArray;->keyAt(I)J

    move-result-wide v8

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {v3, v1}, Landroid/support/v4/util/LongSparseArray;->valueAt(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v7

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v3, v7}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v5

    cmp-long v3, v8, v5

    const/4 v11, 0x1

    if-eqz v3, :cond_3

    add-int/lit8 v3, v7, -0x14

    invoke-static {v0, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    add-int/lit8 v5, v7, 0x14

    iget v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    invoke-static {v5, v6}, Ljava/lang/Math;->min(II)I

    move-result v5

    :goto_1
    if-ge v3, v5, :cond_1

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v6, v3}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v12

    cmp-long v6, v8, v12

    if-nez v6, :cond_0

    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v11}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v5, v3, v6}, Landroid/support/v4/util/SparseArrayCompat;->put(ILjava/lang/Object;)V

    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v5, v1, v3}, Landroid/support/v4/util/LongSparseArray;->setValueAt(ILjava/lang/Object;)V

    const/4 v3, 0x1

    goto :goto_2

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_1
    const/4 v3, 0x0

    :goto_2
    if-nez v3, :cond_4

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {v2, v8, v9}, Landroid/support/v4/util/LongSparseArray;->delete(J)V

    add-int/lit8 v1, v1, -0x1

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    sub-int/2addr v2, v11

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->e:I

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-le v2, v4, :cond_2

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    move-object v5, v2

    check-cast v5, Lit/sephiroth/android/library/a/a/b;

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    move-object v6, v2

    check-cast v6, Landroid/view/ActionMode;

    const/4 v10, 0x0

    invoke-virtual/range {v5 .. v10}, Lit/sephiroth/android/library/a/a/b;->a(Landroid/view/ActionMode;IJZ)V

    :cond_2
    const/4 v2, 0x1

    goto :goto_3

    :cond_3
    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-static {v11}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v7, v4}, Landroid/support/v4/util/SparseArrayCompat;->put(ILjava/lang/Object;)V

    :cond_4
    :goto_3
    add-int/2addr v1, v11

    goto/16 :goto_0

    :cond_5
    if-eqz v2, :cond_6

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    if-eqz v0, :cond_6

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-le v0, v4, :cond_6

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    check-cast v0, Landroid/view/ActionMode;

    invoke-virtual {v0}, Landroid/view/ActionMode;->invalidate()V

    :cond_6
    return-void
.end method

.method public performAccessibilityAction(ILandroid/os/Bundle;)Z
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0x10
    .end annotation

    invoke-super {p0, p1, p2}, Lit/sephiroth/android/library/widget/a;->performAccessibilityAction(ILandroid/os/Bundle;)Z

    move-result p2

    const/4 v0, 0x1

    if-eqz p2, :cond_0

    return v0

    :cond_0
    const/16 p2, 0x1000

    const/16 v1, 0xc8

    const/4 v2, 0x0

    if-eq p1, p2, :cond_3

    const/16 p2, 0x2000

    if-eq p1, p2, :cond_1

    return v2

    :cond_1
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isEnabled()Z

    move-result p1

    if-eqz p1, :cond_2

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    if-lez p1, :cond_2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result p1

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->left:I

    sub-int/2addr p1, p2

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->right:I

    sub-int/2addr p1, p2

    neg-int p1, p1

    :goto_0
    invoke-virtual {p0, p1, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->b(II)V

    return v0

    :cond_2
    return v2

    :cond_3
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isEnabled()Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getLastVisiblePosition()I

    move-result p1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getCount()I

    move-result p2

    sub-int/2addr p2, v0

    if-ge p1, p2, :cond_4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result p1

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->left:I

    sub-int/2addr p1, p2

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->right:I

    sub-int/2addr p1, p2

    goto :goto_0

    :cond_4
    return v2
.end method

.method protected q()V
    .locals 11

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bb:I

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bb:I

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    if-eqz v2, :cond_0

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v2}, Landroid/widget/ListAdapter;->hasStableIds()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->p()V

    :cond_0
    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v2}, Lit/sephiroth/android/library/widget/AbsHListView$k;->c()V

    const/4 v2, 0x0

    const/4 v3, 0x3

    const/4 v4, 0x0

    const/4 v5, 0x1

    if-lez v0, :cond_d

    iget-boolean v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ad:Z

    if-eqz v6, :cond_8

    iput-boolean v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ad:Z

    iput-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iget v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aG:I

    const/4 v7, 0x2

    if-ne v6, v7, :cond_1

    iput v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    return-void

    :cond_1
    iget v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aG:I

    if-ne v6, v5, :cond_5

    iget-boolean v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aV:Z

    if-eqz v6, :cond_2

    iput-boolean v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aV:Z

    iput v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    return-void

    :cond_2
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v6

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v8

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingRight()I

    move-result v9

    sub-int/2addr v8, v9

    add-int/lit8 v9, v6, -0x1

    invoke-virtual {p0, v9}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v9

    if-eqz v9, :cond_3

    invoke-virtual {v9}, Landroid/view/View;->getBottom()I

    move-result v9

    goto :goto_0

    :cond_3
    move v9, v8

    :goto_0
    iget v10, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    add-int/2addr v10, v6

    if-lt v10, v1, :cond_4

    if-gt v9, v8, :cond_4

    iput v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    return-void

    :cond_4
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->awakenScrollBars()Z

    :cond_5
    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ae:I

    const/4 v6, 0x5

    packed-switch v1, :pswitch_data_0

    goto :goto_2

    :pswitch_0
    iput v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aa:I

    invoke-static {v4, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    sub-int/2addr v0, v5

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aa:I

    return-void

    :pswitch_1
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isInTouchMode()Z

    move-result v1

    if-eqz v1, :cond_6

    iput v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aa:I

    invoke-static {v4, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    sub-int/2addr v0, v5

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aa:I

    return-void

    :cond_6
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->v()I

    move-result v1

    if-ltz v1, :cond_8

    invoke-virtual {p0, v1, v5}, Lit/sephiroth/android/library/widget/AbsHListView;->b(IZ)I

    move-result v8

    if-ne v8, v1, :cond_8

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aa:I

    iget-wide v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ac:J

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v0

    int-to-long v4, v0

    cmp-long v0, v2, v4

    if-nez v0, :cond_7

    iput v6, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    goto :goto_1

    :cond_7
    iput v7, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    :goto_1
    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->setNextSelectedPositionInt(I)V

    return-void

    :cond_8
    :goto_2
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->isInTouchMode()Z

    move-result v1

    if-nez v1, :cond_c

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getSelectedItemPosition()I

    move-result v1

    if-lt v1, v0, :cond_9

    sub-int/2addr v0, v5

    goto :goto_3

    :cond_9
    move v0, v1

    :goto_3
    if-gez v0, :cond_a

    const/4 v0, 0x0

    :cond_a
    invoke-virtual {p0, v0, v5}, Lit/sephiroth/android/library/widget/AbsHListView;->b(IZ)I

    move-result v1

    if-ltz v1, :cond_b

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->setNextSelectedPositionInt(I)V

    return-void

    :cond_b
    invoke-virtual {p0, v0, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->b(IZ)I

    move-result v0

    if-ltz v0, :cond_d

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->setNextSelectedPositionInt(I)V

    return-void

    :cond_c
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->M:I

    if-ltz v0, :cond_d

    return-void

    :cond_d
    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->K:Z

    if-eqz v0, :cond_e

    goto :goto_4

    :cond_e
    const/4 v3, 0x1

    :goto_4
    iput v3, p0, Lit/sephiroth/android/library/widget/AbsHListView;->h:I

    const/4 v0, -0x1

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    const-wide/high16 v5, -0x8000000000000000L

    iput-wide v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->an:J

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ak:I

    iput-wide v5, p0, Lit/sephiroth/android/library/widget/AbsHListView;->al:J

    iput-boolean v4, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ad:Z

    iput-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->bc:Lit/sephiroth/android/library/widget/AbsHListView$SavedState;

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->n:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->u()V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public requestDisallowInterceptTouchEvent(Z)V
    .locals 0

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->D()V

    :cond_0
    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->requestDisallowInterceptTouchEvent(Z)V

    return-void
.end method

.method public requestLayout()V
    .locals 1

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->at:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->af:Z

    if-nez v0, :cond_0

    invoke-super {p0}, Lit/sephiroth/android/library/widget/a;->requestLayout()V

    :cond_0
    return-void
.end method

.method public sendAccessibilityEvent(I)V
    .locals 3

    const/16 v0, 0x1000

    if-ne p1, v0, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getFirstVisiblePosition()I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getLastVisiblePosition()I

    move-result v1

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aZ:I

    if-ne v2, v0, :cond_0

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ba:I

    if-ne v2, v1, :cond_0

    return-void

    :cond_0
    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aZ:I

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ba:I

    :cond_1
    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->sendAccessibilityEvent(I)V

    return-void
.end method

.method public bridge synthetic setAdapter(Landroid/widget/Adapter;)V
    .locals 0

    check-cast p1, Landroid/widget/ListAdapter;

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->setAdapter(Landroid/widget/ListAdapter;)V

    return-void
.end method

.method public setAdapter(Landroid/widget/ListAdapter;)V
    .locals 0

    if-eqz p1, :cond_0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {p1}, Landroid/widget/ListAdapter;->hasStableIds()Z

    move-result p1

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->k:Z

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    if-eqz p1, :cond_0

    iget-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->k:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    if-nez p1, :cond_0

    new-instance p1, Landroid/support/v4/util/LongSparseArray;

    invoke-direct {p1}, Landroid/support/v4/util/LongSparseArray;-><init>()V

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    :cond_0
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {p1}, Landroid/support/v4/util/SparseArrayCompat;->clear()V

    :cond_1
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    invoke-virtual {p1}, Landroid/support/v4/util/LongSparseArray;->clear()V

    :cond_2
    return-void
.end method

.method public setCacheColorHint(I)V
    .locals 3

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aH:I

    if-eq p1, v0, :cond_1

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aH:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2, p1}, Landroid/view/View;->setDrawingCacheBackgroundColor(I)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-virtual {v0, p1}, Lit/sephiroth/android/library/widget/AbsHListView$k;->f(I)V

    :cond_1
    return-void
.end method

.method public setChoiceMode(I)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0xb

    if-lt p1, v0, :cond_1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    if-eqz p1, :cond_1

    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt p1, v0, :cond_0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    check-cast p1, Landroid/view/ActionMode;

    invoke-virtual {p1}, Landroid/view/ActionMode;->finish()V

    :cond_0
    const/4 p1, 0x0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->c:Ljava/lang/Object;

    :cond_1
    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    if-eqz p1, :cond_4

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    if-nez p1, :cond_2

    new-instance p1, Landroid/support/v4/util/SparseArrayCompat;

    invoke-direct {p1}, Landroid/support/v4/util/SparseArrayCompat;-><init>()V

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->f:Landroid/support/v4/util/SparseArrayCompat;

    :cond_2
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    if-nez p1, :cond_3

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {p1}, Landroid/widget/ListAdapter;->hasStableIds()Z

    move-result p1

    if-eqz p1, :cond_3

    new-instance p1, Landroid/support/v4/util/LongSparseArray;

    invoke-direct {p1}, Landroid/support/v4/util/LongSparseArray;-><init>()V

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->g:Landroid/support/v4/util/LongSparseArray;

    :cond_3
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt p1, v0, :cond_4

    iget p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->b:I

    const/4 v0, 0x3

    if-ne p1, v0, :cond_4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->a()V

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->setLongClickable(Z)V

    :cond_4
    return-void
.end method

.method public setDrawSelectorOnTop(Z)V
    .locals 0

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->l:Z

    return-void
.end method

.method public setFriction(F)V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    if-nez v0, :cond_0

    new-instance v0, Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/widget/AbsHListView$e;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->av:Lit/sephiroth/android/library/widget/AbsHListView$e;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/AbsHListView$e;->a(Lit/sephiroth/android/library/widget/AbsHListView$e;)Lit/sephiroth/android/library/widget/c;

    move-result-object v0

    invoke-virtual {v0, p1}, Lit/sephiroth/android/library/widget/c;->b(F)V

    return-void
.end method

.method public setMultiChoiceModeListener(Lit/sephiroth/android/library/a/a/a;)V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xb

    if-lt v0, v1, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    if-nez v0, :cond_0

    new-instance v0, Lit/sephiroth/android/library/a/a/b;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/a/a/b;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->d:Ljava/lang/Object;

    check-cast v0, Lit/sephiroth/android/library/a/a/b;

    invoke-virtual {v0, p1}, Lit/sephiroth/android/library/a/a/b;->a(Lit/sephiroth/android/library/a/a/a;)V

    return-void

    :cond_1
    const-string p1, "AbsListView"

    const-string v0, "setMultiChoiceModeListener not supported for this version of Android"

    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public setOnScrollListener(Lit/sephiroth/android/library/widget/AbsHListView$h;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aw:Lit/sephiroth/android/library/widget/AbsHListView$h;

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->b()V

    return-void
.end method

.method public setOverScrollMode(I)V
    .locals 2

    const/4 v0, 0x2

    if-eq p1, v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getContext()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-direct {v1, v0}, Landroid/support/v4/widget/EdgeEffectCompat;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    new-instance v1, Landroid/support/v4/widget/EdgeEffectCompat;

    invoke-direct {v1, v0}, Landroid/support/v4/widget/EdgeEffectCompat;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aQ:Landroid/support/v4/widget/EdgeEffectCompat;

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aR:Landroid/support/v4/widget/EdgeEffectCompat;

    :cond_1
    :goto_0
    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->setOverScrollMode(I)V

    return-void
.end method

.method public setRecyclerListener(Lit/sephiroth/android/library/widget/AbsHListView$l;)V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->p:Lit/sephiroth/android/library/widget/AbsHListView$k;

    invoke-static {v0, p1}, Lit/sephiroth/android/library/widget/AbsHListView$k;->a(Lit/sephiroth/android/library/widget/AbsHListView$k;Lit/sephiroth/android/library/widget/AbsHListView$l;)Lit/sephiroth/android/library/widget/AbsHListView$l;

    return-void
.end method

.method public setScrollingCacheEnabled(Z)V
    .locals 1

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->L:Z

    if-eqz v0, :cond_0

    if-nez p1, :cond_0

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->F()V

    :cond_0
    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->L:Z

    return-void
.end method

.method public abstract setSelectionInt(I)V
.end method

.method public setSelector(I)V
    .locals 1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->setSelector(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method public setSelector(Landroid/graphics/drawable/Drawable;)V
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setCallback(Landroid/graphics/drawable/Drawable$Callback;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->unscheduleDrawable(Landroid/graphics/drawable/Drawable;)V

    :cond_0
    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    invoke-virtual {p1, v0}, Landroid/graphics/drawable/Drawable;->getPadding(Landroid/graphics/Rect;)Z

    iget v1, v0, Landroid/graphics/Rect;->left:I

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->q:I

    iget v1, v0, Landroid/graphics/Rect;->top:I

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->r:I

    iget v1, v0, Landroid/graphics/Rect;->right:I

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->s:I

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->t:I

    invoke-virtual {p1, p0}, Landroid/graphics/drawable/Drawable;->setCallback(Landroid/graphics/drawable/Drawable$Callback;)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->j()V

    return-void
.end method

.method public setSmoothScrollbarEnabled(Z)V
    .locals 0

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ax:Z

    return-void
.end method

.method public setStackFromRight(Z)V
    .locals 1

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->K:Z

    if-eq v0, p1, :cond_0

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->K:Z

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView;->c()V

    :cond_0
    return-void
.end method

.method public setTranscriptMode(I)V
    .locals 0

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aG:I

    return-void
.end method

.method public setVelocityScale(F)V
    .locals 0

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->aO:F

    return-void
.end method

.method public showContextMenuForChild(Landroid/view/View;)Z
    .locals 9

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Landroid/view/View;)I

    move-result v6

    const/4 v0, 0x0

    if-ltz v6, :cond_1

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v1, v6}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v7

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ai:Lit/sephiroth/android/library/widget/a$d;

    if-eqz v1, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->ai:Lit/sephiroth/android/library/widget/a$d;

    move-object v1, p0

    move-object v2, p1

    move v3, v6

    move-wide v4, v7

    invoke-interface/range {v0 .. v5}, Lit/sephiroth/android/library/widget/a$d;->a(Lit/sephiroth/android/library/widget/a;Landroid/view/View;IJ)Z

    move-result v0

    :cond_0
    if-nez v0, :cond_1

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int v0, v6, v0

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p0, v0, v6, v7, v8}, Lit/sephiroth/android/library/widget/AbsHListView;->b(Landroid/view/View;IJ)Landroid/view/ContextMenu$ContextMenuInfo;

    move-result-object v0

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->az:Landroid/view/ContextMenu$ContextMenuInfo;

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->showContextMenuForChild(Landroid/view/View;)Z

    move-result v0

    :cond_1
    return v0
.end method

.method public verifyDrawable(Landroid/graphics/drawable/Drawable;)Z
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView;->m:Landroid/graphics/drawable/Drawable;

    if-eq v0, p1, :cond_1

    invoke-super {p0, p1}, Lit/sephiroth/android/library/widget/a;->verifyDrawable(Landroid/graphics/drawable/Drawable;)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return p1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    return p1
.end method
