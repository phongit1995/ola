.class public Lcom/mg/ola/common/widget/SoftKeyLinearLayout;
.super Landroid/widget/LinearLayout;


# instance fields
.field private a:Landroid/view/WindowManager;

.field private b:Lcom/mg/ola/common/widget/a/a;

.field private c:Z

.field private d:Landroid/graphics/Rect;

.field private e:I

.field private f:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->f:I

    invoke-direct {p0}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->b()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->f:I

    invoke-direct {p0}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->b()V

    return-void
.end method

.method private b()V
    .locals 2

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a:Landroid/view/WindowManager;

    return-void
.end method

.method private getDisplayHeight()I
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xd
    .end annotation

    iget-object v0, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a:Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-static {}, Lcom/mg/ola/common/d/g;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Landroid/graphics/Point;

    invoke-direct {v1}, Landroid/graphics/Point;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    iget v0, v1, Landroid/graphics/Point;->y:I

    return v0

    :cond_0
    invoke-virtual {v0}, Landroid/view/Display;->getHeight()I

    move-result v0

    return v0
.end method

.method private getStatusBarHeight()I
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "status_bar_height"

    const-string v2, "dimen"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    if-lez v1, :cond_0

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    return v0

    :cond_0
    const/high16 v1, 0x41c80000    # 25.0f

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float v0, v0, v1

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    double-to-int v0, v0

    return v0

    :catch_0
    const/16 v0, 0x4b

    return v0
.end method


# virtual methods
.method public a()Z
    .locals 1

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->c:Z

    return v0
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->d:Landroid/graphics/Rect;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->d:Landroid/graphics/Rect;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    float-to-int v1, v1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    float-to-int v2, v2

    invoke-virtual {v0, v1, v2}, Landroid/graphics/Rect;->contains(II)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    invoke-super {p0, p1}, Landroid/widget/LinearLayout;->onInterceptTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method protected onLayout(ZIIII)V
    .locals 0

    invoke-super/range {p0 .. p5}, Landroid/widget/LinearLayout;->onLayout(ZIIII)V

    return-void
.end method

.method protected onMeasure(II)V
    .locals 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ParserError"
        }
    .end annotation

    :try_start_0
    iget v0, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->f:I

    if-nez v0, :cond_0

    invoke-direct {p0}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->getStatusBarHeight()I

    move-result v0

    iput v0, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->f:I

    :cond_0
    invoke-direct {p0}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->getDisplayHeight()I

    move-result v0

    iget v1, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->f:I

    sub-int/2addr v0, v1

    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v1

    iget v2, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->e:I

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eq v1, v2, :cond_2

    if-ge v1, v0, :cond_1

    const/4 v4, 0x1

    :cond_1
    iput-boolean v4, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->c:Z

    goto :goto_0

    :cond_2
    const/4 v3, 0x0

    :goto_0
    iput v1, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->e:I

    iget-object v0, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->b:Lcom/mg/ola/common/widget/a/a;

    if-eqz v0, :cond_3

    if-eqz v3, :cond_3

    iget-object v0, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->b:Lcom/mg/ola/common/widget/a/a;

    iget-boolean v2, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->c:Z

    invoke-interface {v0, v2, v1}, Lcom/mg/ola/common/widget/a/a;->a(ZI)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    :try_start_1
    invoke-super {p0, p1, p2}, Landroid/widget/LinearLayout;->onMeasure(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public setInterceptMargin(Landroid/graphics/Rect;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->d:Landroid/graphics/Rect;

    return-void
.end method

.method public setOnSoftKeyboardListener(Lcom/mg/ola/common/widget/a/a;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->b:Lcom/mg/ola/common/widget/a/a;

    return-void
.end method
