.class public final Lcom/facebook/accountkit/ui/AspectFrameLayout;
.super Landroid/widget/FrameLayout;


# instance fields
.field private aspectHeight:I

.field private aspectWidth:I

.field private displaySize:Landroid/graphics/Point;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/ui/AspectFrameLayout;->init(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/ui/AspectFrameLayout;->init(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V
    .locals 0
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/annotation/TargetApi;
        value = 0x15
    .end annotation

    invoke-direct {p0, p1, p2, p3, p4}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/ui/AspectFrameLayout;->init(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method private init(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    sget-object v0, Lcom/facebook/accountkit/R$styleable;->AspectFrameLayout:[I

    invoke-virtual {p1, p2, v0}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object p1

    :try_start_0
    sget p2, Lcom/facebook/accountkit/R$styleable;->AspectFrameLayout_com_accountkit_aspect_width:I

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Landroid/content/res/TypedArray;->getDimensionPixelSize(II)I

    move-result p2

    iput p2, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectWidth:I

    sget p2, Lcom/facebook/accountkit/R$styleable;->AspectFrameLayout_com_accountkit_aspect_height:I

    invoke-virtual {p1, p2, v0}, Landroid/content/res/TypedArray;->getDimensionPixelSize(II)I

    move-result p2

    iput p2, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectHeight:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    return-void

    :catchall_0
    move-exception p2

    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    throw p2
.end method


# virtual methods
.method public getAspectHeight()F
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectHeight:I

    int-to-float v0, v0

    return v0
.end method

.method public getAspectWidth()F
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectWidth:I

    int-to-float v0, v0

    return v0
.end method

.method protected onAttachedToWindow()V
    .locals 3

    invoke-super {p0}, Landroid/widget/FrameLayout;->onAttachedToWindow()V

    new-instance v0, Landroid/graphics/Point;

    invoke-direct {v0}, Landroid/graphics/Point;-><init>()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AspectFrameLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "window"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager;

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->displaySize:Landroid/graphics/Point;

    return-void
.end method

.method protected onMeasure(II)V
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectWidth:I

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectHeight:I

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->displaySize:Landroid/graphics/Point;

    if-nez v0, :cond_0

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->displaySize:Landroid/graphics/Point;

    iget p1, p1, Landroid/graphics/Point;->x:I

    iget p2, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectHeight:I

    mul-int p1, p1, p2

    iget p2, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectWidth:I

    div-int/2addr p1, p2

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->displaySize:Landroid/graphics/Point;

    iget p2, p2, Landroid/graphics/Point;->y:I

    if-le p1, p2, :cond_1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->displaySize:Landroid/graphics/Point;

    iget p2, p2, Landroid/graphics/Point;->x:I

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->displaySize:Landroid/graphics/Point;

    iget p1, p1, Landroid/graphics/Point;->y:I

    iget p2, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectWidth:I

    mul-int p1, p1, p2

    iget p2, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectHeight:I

    div-int p2, p1, p2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->displaySize:Landroid/graphics/Point;

    iget p1, p1, Landroid/graphics/Point;->y:I

    :goto_0
    const/high16 v0, 0x40000000    # 2.0f

    invoke-static {p2, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p2

    invoke-static {p1, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p1

    invoke-super {p0, p2, p1}, Landroid/widget/FrameLayout;->onMeasure(II)V

    return-void

    :cond_2
    :goto_1
    invoke-super {p0, p1, p2}, Landroid/widget/FrameLayout;->onMeasure(II)V

    return-void
.end method

.method public setAspectHeight(I)V
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectHeight:I

    if-ne v0, p1, :cond_0

    return-void

    :cond_0
    iput p1, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectHeight:I

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AspectFrameLayout;->requestLayout()V

    return-void
.end method

.method public setAspectWidth(I)V
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectWidth:I

    if-ne v0, p1, :cond_0

    return-void

    :cond_0
    iput p1, p0, Lcom/facebook/accountkit/ui/AspectFrameLayout;->aspectWidth:I

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AspectFrameLayout;->requestLayout()V

    return-void
.end method
