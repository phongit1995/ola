.class public Lchat/ola/vn/balloon/d;
.super Landroid/widget/RelativeLayout;

# interfaces
.implements Lchat/ola/vn/balloon/a;


# instance fields
.field a:Landroid/os/Handler;

.field public b:Landroid/view/WindowManager$LayoutParams;

.field c:Landroid/widget/RelativeLayout$LayoutParams;

.field protected d:Landroid/graphics/Rect;

.field e:Lchat/ola/vn/balloon/OlaBalloonService;

.field private f:I

.field private g:I

.field private h:Landroid/view/View;

.field private i:Landroid/widget/ImageView;


# direct methods
.method public constructor <init>(Lchat/ola/vn/balloon/OlaBalloonService;)V
    .locals 7

    invoke-direct {p0, p1}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/balloon/d;->e:Lchat/ola/vn/balloon/OlaBalloonService;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/balloon/d;->e:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->e()I

    move-result v0

    div-int/lit8 v0, v0, 0x6

    iput v0, p0, Lchat/ola/vn/balloon/d;->f:I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    :try_start_2
    sget v0, Lchat/ola/vn/e;->d:I

    div-int/lit8 v0, v0, 0x6

    iput v0, p0, Lchat/ola/vn/balloon/d;->f:I

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    iput v0, p0, Lchat/ola/vn/balloon/d;->g:I

    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getBalloonWidth()I

    move-result v2

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getBalloonHeight()I

    move-result v3

    const/16 v4, 0x7d3

    const/16 v5, 0x28

    const/4 v6, -0x3

    move-object v1, v0

    invoke-direct/range {v1 .. v6}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    iput-object v0, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x33

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    const/4 v1, -0x1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v2, p0, Lchat/ola/vn/balloon/d;->f:I

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    const/high16 v2, 0x1030000

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->windowAnimations:I

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/balloon/d;->setBackgroundColor(I)V

    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/balloon/d;->h:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->h:Landroid/view/View;

    const v2, 0x7f080077

    invoke-virtual {v0, v2}, Landroid/view/View;->setBackgroundResource(I)V

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->h:Landroid/view/View;

    new-instance v2, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v2, v1, v1}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v0, v2}, Lchat/ola/vn/balloon/d;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v0, Landroid/widget/ImageView;

    invoke-direct {v0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/balloon/d;->i:Landroid/widget/ImageView;

    iget-object p1, p0, Lchat/ola/vn/balloon/d;->i:Landroid/widget/ImageView;

    const v0, 0x7f08066e

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    new-instance p1, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v0, -0x2

    invoke-direct {p1, v0, v0}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    iput-object p1, p0, Lchat/ola/vn/balloon/d;->c:Landroid/widget/RelativeLayout$LayoutParams;

    iget-object p1, p0, Lchat/ola/vn/balloon/d;->c:Landroid/widget/RelativeLayout$LayoutParams;

    const/16 v0, 0xd

    invoke-virtual {p1, v0}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    iget-object p1, p0, Lchat/ola/vn/balloon/d;->i:Landroid/widget/ImageView;

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/balloon/d;)Landroid/widget/ImageView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/balloon/d;->i:Landroid/widget/ImageView;

    return-object p0
.end method


# virtual methods
.method public a()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/d;->e:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->e:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v1, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {v0, p0, v1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b()V
    .locals 0

    return-void
.end method

.method public c()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public d()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public e()V
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    iput v0, p0, Lchat/ola/vn/balloon/d;->g:I

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getWindowHeight()I

    move-result v1

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getBalloonHeight()I

    move-result v2

    sub-int/2addr v1, v2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->a()V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/balloon/d;->setVisibility(I)V

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getContext()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f01004b

    invoke-static {v0, v1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/balloon/d$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/balloon/d$1;-><init>(Lchat/ola/vn/balloon/d;)V

    invoke-virtual {v0, v1}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    iget-object v1, p0, Lchat/ola/vn/balloon/d;->h:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public f()V
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getContext()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f01004f

    invoke-static {v0, v1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    new-instance v2, Lchat/ola/vn/balloon/d$2;

    invoke-direct {v2, p0}, Lchat/ola/vn/balloon/d$2;-><init>(Lchat/ola/vn/balloon/d;)V

    invoke-virtual {v0, v2}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    iget-object v2, p0, Lchat/ola/vn/balloon/d;->i:Landroid/widget/ImageView;

    invoke-virtual {v2, v0}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, v1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/balloon/d$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/balloon/d$3;-><init>(Lchat/ola/vn/balloon/d;)V

    invoke-virtual {v0, v1}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    iget-object v1, p0, Lchat/ola/vn/balloon/d;->h:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public getBalloonBound()Landroid/graphics/Rect;
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/d;->d:Landroid/graphics/Rect;

    if-nez v0, :cond_0

    new-instance v0, Landroid/graphics/Rect;

    iget-object v1, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v2, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v3, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getBalloonWidth()I

    move-result v4

    add-int/2addr v3, v4

    iget-object v4, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getBalloonHeight()I

    move-result v5

    add-int/2addr v4, v5

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object v0, p0, Lchat/ola/vn/balloon/d;->d:Landroid/graphics/Rect;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/d;->d:Landroid/graphics/Rect;

    iget-object v1, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v2, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v3, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getBalloonWidth()I

    move-result v4

    add-int/2addr v3, v4

    iget-object v4, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getBalloonHeight()I

    move-result v5

    add-int/2addr v4, v5

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/graphics/Rect;->set(IIII)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    new-instance v0, Landroid/graphics/Rect;

    const/4 v1, 0x0

    invoke-direct {v0, v1, v1, v1, v1}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object v0, p0, Lchat/ola/vn/balloon/d;->d:Landroid/graphics/Rect;

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/balloon/d;->d:Landroid/graphics/Rect;

    return-object v0
.end method

.method public getBalloonHandler()Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->a:Landroid/os/Handler;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getHandler()Landroid/os/Handler;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/balloon/d;->a:Landroid/os/Handler;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/d;->a:Landroid/os/Handler;

    return-object v0
.end method

.method public getBalloonHeight()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/balloon/d;->f:I

    return v0
.end method

.method public getBalloonLayoutParameter()Landroid/view/WindowManager$LayoutParams;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    return-object v0
.end method

.method public getBalloonWidth()I
    .locals 2

    :try_start_0
    iget v0, p0, Lchat/ola/vn/balloon/d;->g:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->e:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->e()I

    move-result v0

    sget v1, Lchat/ola/vn/e;->e:I

    add-int/2addr v0, v1

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/d;->e:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->d()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    sget v0, Lchat/ola/vn/e;->c:I

    return v0
.end method

.method public getCurrentPositionX()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->x:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public getCurrentPositionY()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->y:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public getWindowHeight()I
    .locals 2

    :try_start_0
    iget v0, p0, Lchat/ola/vn/balloon/d;->g:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->e:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->d()I

    move-result v0

    sget v1, Lchat/ola/vn/e;->e:I

    sub-int/2addr v0, v1

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/d;->e:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->e()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    sget v0, Lchat/ola/vn/e;->d:I

    return v0
.end method

.method public getWindowWidth()I
    .locals 2

    :try_start_0
    iget v0, p0, Lchat/ola/vn/balloon/d;->g:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/d;->e:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->e()I

    move-result v0

    sget v1, Lchat/ola/vn/e;->e:I

    add-int/2addr v0, v1

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/d;->e:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->d()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    sget v0, Lchat/ola/vn/e;->c:I

    return v0
.end method

.method protected onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/RelativeLayout;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    invoke-virtual {p0}, Lchat/ola/vn/balloon/d;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object p1

    iget p1, p1, Landroid/content/res/Configuration;->orientation:I

    iput p1, p0, Lchat/ola/vn/balloon/d;->g:I

    return-void
.end method
