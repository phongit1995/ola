.class public Lchat/ola/vn/view/OlaAttachmentVoiceButton;
.super Landroid/widget/FrameLayout;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "NewApi"
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;
    }
.end annotation


# instance fields
.field a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;

.field private b:I

.field private c:I

.field private d:I

.field private e:Landroid/graphics/Rect;

.field private f:Z

.field private g:Lcom/mg/ola/a/a/b/n;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->e:Landroid/graphics/Rect;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->f:Z

    invoke-direct {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->e:Landroid/graphics/Rect;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->f:Z

    invoke-direct {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->e:Landroid/graphics/Rect;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->f:Z

    invoke-direct {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/OlaAttachmentVoiceButton;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->b:I

    return p0
.end method

.method private a()V
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f070120

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->b:I

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f07013f

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->c:I

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f07012f

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->d:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private b()V
    .locals 7

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getHeight()I

    move-result v1

    iget v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->c:I

    iget v3, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->d:I

    sub-int/2addr v2, v3

    int-to-float v2, v2

    int-to-float v3, v1

    div-float/2addr v2, v3

    iget v4, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->c:I

    iget v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->d:I

    const/4 v6, 0x2

    div-int/2addr v5, v6

    sub-int/2addr v4, v5

    int-to-float v4, v4

    div-float/2addr v4, v3

    iget v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->b:I

    int-to-float v5, v5

    div-float/2addr v3, v5

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getScaleX()F

    move-result v3

    :cond_0
    iget-object v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    if-eqz v5, :cond_1

    iget-object v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    invoke-virtual {v5}, Lcom/mg/ola/a/a/b/n;->c()V

    :cond_1
    new-array v5, v6, [F

    const/4 v6, 0x0

    aput v3, v5, v6

    const/4 v3, 0x1

    aput v2, v5, v3

    invoke-static {v5}, Lcom/mg/ola/a/a/b/n;->b([F)Lcom/mg/ola/a/a/b/n;

    move-result-object v2

    const-wide/16 v5, 0x96

    invoke-virtual {v2, v5, v6}, Lcom/mg/ola/a/a/b/n;->c(J)Lcom/mg/ola/a/a/b/n;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    iget-object v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    new-instance v3, Lchat/ola/vn/view/OlaAttachmentVoiceButton$1;

    invoke-direct {v3, p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton$1;-><init>(Lchat/ola/vn/view/OlaAttachmentVoiceButton;)V

    invoke-virtual {v2, v3}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/a$a;)V

    iget-object v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    new-instance v3, Lchat/ola/vn/view/OlaAttachmentVoiceButton$2;

    invoke-direct {v3, p0, v4, v0, v1}, Lchat/ola/vn/view/OlaAttachmentVoiceButton$2;-><init>(Lchat/ola/vn/view/OlaAttachmentVoiceButton;FLandroid/view/ViewGroup$LayoutParams;I)V

    invoke-virtual {v2, v3}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/n$b;)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/n;->a()V

    return-void
.end method

.method private c()V
    .locals 7
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getHeight()I

    move-result v1

    iget v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->b:I

    iget v3, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->d:I

    add-int/2addr v2, v3

    int-to-float v2, v2

    int-to-float v3, v1

    div-float/2addr v2, v3

    iget v4, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->b:I

    iget v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->d:I

    const/4 v6, 0x2

    div-int/2addr v5, v6

    add-int/2addr v4, v5

    int-to-float v4, v4

    div-float/2addr v4, v3

    iget v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->b:I

    int-to-float v5, v5

    div-float/2addr v3, v5

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getScaleX()F

    move-result v3

    :cond_0
    iget-object v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    if-eqz v5, :cond_1

    iget-object v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    invoke-virtual {v5}, Lcom/mg/ola/a/a/b/n;->c()V

    :cond_1
    new-array v5, v6, [F

    const/4 v6, 0x0

    aput v3, v5, v6

    const/4 v3, 0x1

    aput v2, v5, v3

    invoke-static {v5}, Lcom/mg/ola/a/a/b/n;->b([F)Lcom/mg/ola/a/a/b/n;

    move-result-object v2

    const-wide/16 v5, 0x96

    invoke-virtual {v2, v5, v6}, Lcom/mg/ola/a/a/b/n;->c(J)Lcom/mg/ola/a/a/b/n;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    iget-object v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    new-instance v3, Lchat/ola/vn/view/OlaAttachmentVoiceButton$3;

    invoke-direct {v3, p0, v0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton$3;-><init>(Lchat/ola/vn/view/OlaAttachmentVoiceButton;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v2, v3}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/a$a;)V

    iget-object v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    new-instance v3, Lchat/ola/vn/view/OlaAttachmentVoiceButton$4;

    invoke-direct {v3, p0, v4, v0, v1}, Lchat/ola/vn/view/OlaAttachmentVoiceButton$4;-><init>(Lchat/ola/vn/view/OlaAttachmentVoiceButton;FLandroid/view/ViewGroup$LayoutParams;I)V

    invoke-virtual {v2, v3}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/n$b;)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/n;->a()V

    return-void
.end method

.method private d()V
    .locals 7

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getHeight()I

    move-result v1

    iget v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->b:I

    iget v3, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->d:I

    add-int/2addr v2, v3

    int-to-float v2, v2

    int-to-float v3, v1

    div-float/2addr v2, v3

    iget v4, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->b:I

    iget v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->d:I

    const/4 v6, 0x2

    div-int/2addr v5, v6

    add-int/2addr v4, v5

    int-to-float v4, v4

    div-float/2addr v4, v3

    iget v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->b:I

    int-to-float v5, v5

    div-float/2addr v3, v5

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getScaleX()F

    move-result v3

    :cond_0
    iget-object v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    if-eqz v5, :cond_1

    iget-object v5, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    invoke-virtual {v5}, Lcom/mg/ola/a/a/b/n;->c()V

    :cond_1
    new-array v5, v6, [F

    const/4 v6, 0x0

    aput v3, v5, v6

    const/4 v3, 0x1

    aput v2, v5, v3

    invoke-static {v5}, Lcom/mg/ola/a/a/b/n;->b([F)Lcom/mg/ola/a/a/b/n;

    move-result-object v2

    const-wide/16 v5, 0x96

    invoke-virtual {v2, v5, v6}, Lcom/mg/ola/a/a/b/n;->c(J)Lcom/mg/ola/a/a/b/n;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    iget-object v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    new-instance v3, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;

    invoke-direct {v3, p0, v0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;-><init>(Lchat/ola/vn/view/OlaAttachmentVoiceButton;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v2, v3}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/a$a;)V

    iget-object v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    new-instance v3, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;

    invoke-direct {v3, p0, v4, v0, v1}, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;-><init>(Lchat/ola/vn/view/OlaAttachmentVoiceButton;FLandroid/view/ViewGroup$LayoutParams;I)V

    invoke-virtual {v2, v3}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/n$b;)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->g:Lcom/mg/ola/a/a/b/n;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/n;->a()V

    return-void
.end method


# virtual methods
.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ClickableViewAccessibility"
        }
    .end annotation

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1

    :pswitch_1
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->e:Landroid/graphics/Rect;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->e:Landroid/graphics/Rect;

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getLeft()I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v4

    add-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getTop()I

    move-result v4

    int-to-float v4, v4

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    add-float/2addr v4, p1

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result p1

    invoke-virtual {v0, v3, p1}, Landroid/graphics/Rect;->contains(II)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-boolean p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->f:Z

    if-nez p1, :cond_1

    iput-boolean v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->f:Z

    invoke-direct {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->b()V

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p1, :cond_1

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;

    invoke-interface {p1}, Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;->c()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    return v2

    :cond_0
    :try_start_2
    iget-boolean p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->f:Z

    if-eqz p1, :cond_1

    iput-boolean v1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->f:Z

    invoke-direct {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->d()V

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    if-eqz p1, :cond_1

    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;

    invoke-interface {p1}, Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;->d()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    :catch_0
    :cond_1
    return v2

    :pswitch_2
    :try_start_4
    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->e:Landroid/graphics/Rect;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->e:Landroid/graphics/Rect;

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getLeft()I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v4

    add-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getTop()I

    move-result v4

    int-to-float v4, v4

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    add-float/2addr v4, p1

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result p1

    invoke-virtual {v0, v3, p1}, Landroid/graphics/Rect;->contains(II)Z

    move-result p1

    const/4 v0, 0x0

    if-eqz p1, :cond_2

    iput-boolean v1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->f:Z

    invoke-direct {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->c()V

    iput-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->e:Landroid/graphics/Rect;

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;

    invoke-interface {p1}, Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;->b()V

    return v2

    :cond_2
    iput-boolean v1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->f:Z

    invoke-direct {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->c()V

    iput-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->e:Landroid/graphics/Rect;

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;

    invoke-interface {p1}, Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;->e()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    :catch_1
    :cond_3
    return v2

    :pswitch_3
    :try_start_5
    invoke-direct {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->b()V

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_3

    if-eqz p1, :cond_4

    :try_start_6
    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;

    invoke-interface {p1}, Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;->n_()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_2
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_3

    :catch_2
    :cond_4
    :try_start_7
    new-instance p1, Landroid/graphics/Rect;

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getLeft()I

    move-result v0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getTop()I

    move-result v1

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getRight()I

    move-result v3

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->getBottom()I

    move-result v4

    invoke-direct {p1, v0, v1, v3, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->e:Landroid/graphics/Rect;

    iput-boolean v2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->f:Z
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3

    :catch_3
    return v2

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method
