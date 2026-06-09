.class final Lcom/facebook/accountkit/ui/KeyboardObserver;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/KeyboardObserver$OnVisibleFrameChangedListener;
    }
.end annotation


# static fields
.field private static final MINIMUM_KEYBOARD_HEIGHT_DP:I


# instance fields
.field private didCalculateVisibleFrame:Z

.field private final lastRootViewVisibleFrame:Landroid/graphics/Rect;

.field private final lastViewVisibleFrame:Landroid/graphics/Rect;

.field private onVisibleFrameChangedListener:Lcom/facebook/accountkit/ui/KeyboardObserver$OnVisibleFrameChangedListener;

.field private final rootViewVisibleFrame:Landroid/graphics/Rect;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x15

    if-lt v0, v1, :cond_0

    const/16 v0, 0x30

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    add-int/lit8 v0, v0, 0x64

    sput v0, Lcom/facebook/accountkit/ui/KeyboardObserver;->MINIMUM_KEYBOARD_HEIGHT_DP:I

    return-void
.end method

.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->didCalculateVisibleFrame:Z

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->lastViewVisibleFrame:Landroid/graphics/Rect;

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->lastRootViewVisibleFrame:Landroid/graphics/Rect;

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->rootViewVisibleFrame:Landroid/graphics/Rect;

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/KeyboardObserver;->configureGlobalObserver(Landroid/view/View;)V

    return-void
.end method

.method static synthetic access$000(Lcom/facebook/accountkit/ui/KeyboardObserver;Landroid/view/View;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/ui/KeyboardObserver;->checkVisibleFrame(Landroid/view/View;Landroid/view/View;)V

    return-void
.end method

.method private checkVisibleFrame(Landroid/view/View;Landroid/view/View;)V
    .locals 3

    invoke-virtual {p2}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    sget v1, Lcom/facebook/accountkit/ui/KeyboardObserver;->MINIMUM_KEYBOARD_HEIGHT_DP:I

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/ViewUtility;->getDimensionPixelSize(Landroid/content/Context;I)I

    move-result v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->rootViewVisibleFrame:Landroid/graphics/Rect;

    invoke-virtual {p2, v1}, Landroid/view/View;->getWindowVisibleDisplayFrame(Landroid/graphics/Rect;)V

    invoke-virtual {p2}, Landroid/view/View;->getHeight()I

    move-result p2

    iget-object v1, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->rootViewVisibleFrame:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->bottom:I

    iget-object v2, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->rootViewVisibleFrame:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->top:I

    sub-int/2addr v1, v2

    sub-int/2addr p2, v1

    const/4 v1, 0x1

    if-lt p2, v0, :cond_0

    const/4 p2, 0x1

    goto :goto_0

    :cond_0
    const/4 p2, 0x0

    :goto_0
    if-eqz p2, :cond_1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->rootViewVisibleFrame:Landroid/graphics/Rect;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->lastRootViewVisibleFrame:Landroid/graphics/Rect;

    invoke-virtual {p2, v0}, Landroid/graphics/Rect;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->lastRootViewVisibleFrame:Landroid/graphics/Rect;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->rootViewVisibleFrame:Landroid/graphics/Rect;

    invoke-virtual {p2, v0}, Landroid/graphics/Rect;->set(Landroid/graphics/Rect;)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->lastViewVisibleFrame:Landroid/graphics/Rect;

    invoke-virtual {p1, p2}, Landroid/view/View;->getGlobalVisibleRect(Landroid/graphics/Rect;)Z

    iput-boolean v1, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->didCalculateVisibleFrame:Z

    iget-object p1, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->onVisibleFrameChangedListener:Lcom/facebook/accountkit/ui/KeyboardObserver$OnVisibleFrameChangedListener;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->onVisibleFrameChangedListener:Lcom/facebook/accountkit/ui/KeyboardObserver$OnVisibleFrameChangedListener;

    iget-object p2, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->lastViewVisibleFrame:Landroid/graphics/Rect;

    invoke-interface {p1, p2}, Lcom/facebook/accountkit/ui/KeyboardObserver$OnVisibleFrameChangedListener;->onVisibleFrameChanged(Landroid/graphics/Rect;)V

    :cond_1
    return-void
.end method

.method private configureGlobalObserver(Landroid/view/View;)V
    .locals 3

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getRootView()Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    new-instance v1, Lcom/facebook/accountkit/ui/KeyboardObserver$1;

    invoke-direct {v1, p0, p1, v0}, Lcom/facebook/accountkit/ui/KeyboardObserver$1;-><init>(Lcom/facebook/accountkit/ui/KeyboardObserver;Landroid/view/View;Landroid/view/View;)V

    invoke-virtual {v0}, Landroid/view/View;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/view/ViewTreeObserver;->addOnGlobalLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    invoke-direct {p0, p1, v0}, Lcom/facebook/accountkit/ui/KeyboardObserver;->checkVisibleFrame(Landroid/view/View;Landroid/view/View;)V

    return-void
.end method


# virtual methods
.method public setOnVisibleFrameChangedListener(Lcom/facebook/accountkit/ui/KeyboardObserver$OnVisibleFrameChangedListener;)V
    .locals 1
    .param p1    # Lcom/facebook/accountkit/ui/KeyboardObserver$OnVisibleFrameChangedListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->onVisibleFrameChangedListener:Lcom/facebook/accountkit/ui/KeyboardObserver$OnVisibleFrameChangedListener;

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->didCalculateVisibleFrame:Z

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/KeyboardObserver;->lastViewVisibleFrame:Landroid/graphics/Rect;

    invoke-interface {p1, v0}, Lcom/facebook/accountkit/ui/KeyboardObserver$OnVisibleFrameChangedListener;->onVisibleFrameChanged(Landroid/graphics/Rect;)V

    :cond_0
    return-void
.end method
