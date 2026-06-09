.class public Lchat/ola/vn/balloon/e;
.super Lchat/ola/vn/balloon/b;

# interfaces
.implements Lchat/ola/vn/balloon/c;
.implements Lchat/ola/vn/p/e;


# static fields
.field private static y:I

.field private static z:I


# instance fields
.field private A:Z

.field public s:Lchat/ola/vn/message/f;

.field t:Lchat/ola/vn/view/OlaCachedImageView;

.field public u:Lchat/ola/vn/balloon/f;

.field private v:Landroid/os/Handler;

.field private w:Ljava/lang/Runnable;

.field private x:Landroid/widget/TextView;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/balloon/b;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/balloon/e;->A:Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/balloon/b;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/balloon/e;->A:Z

    return-void
.end method

.method public constructor <init>(Lchat/ola/vn/balloon/OlaBalloonService;)V
    .locals 4
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, v0}, Lchat/ola/vn/balloon/b;-><init>(Lchat/ola/vn/balloon/OlaBalloonService;II)V

    iput-boolean v0, p0, Lchat/ola/vn/balloon/e;->A:Z

    sget v1, Lchat/ola/vn/balloon/e;->y:I

    if-nez v1, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/balloon/OlaBalloonService;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f08007b

    invoke-static {v1, v2}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    sput v2, Lchat/ola/vn/balloon/e;->y:I

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    sput v1, Lchat/ola/vn/balloon/e;->z:I

    :cond_0
    sget v1, Lchat/ola/vn/balloon/e;->y:I

    iput v1, p0, Lchat/ola/vn/balloon/e;->d:I

    sget v1, Lchat/ola/vn/balloon/e;->z:I

    iput v1, p0, Lchat/ola/vn/balloon/e;->e:I

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v2, p0, Lchat/ola/vn/balloon/e;->d:I

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v2, p0, Lchat/ola/vn/balloon/e;->e:I

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    new-instance v1, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-direct {v1, p1}, Lchat/ola/vn/view/OlaCachedImageView;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lchat/ola/vn/balloon/e;->t:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->t:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v2, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setBackgroundColor(I)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->t:Lchat/ola/vn/view/OlaCachedImageView;

    const v2, 0x3f59999a    # 0.85f

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setAlpha(F)V

    :cond_1
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    iget v2, p0, Lchat/ola/vn/balloon/e;->d:I

    iget v3, p0, Lchat/ola/vn/balloon/e;->e:I

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    iput v0, v1, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    iput v0, v1, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    const/16 v0, 0x11

    iput v0, v1, Landroid/widget/LinearLayout$LayoutParams;->gravity:I

    iget-object v2, p0, Lchat/ola/vn/balloon/e;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p0, v2, v1}, Lchat/ola/vn/balloon/e;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, p1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lchat/ola/vn/balloon/e;->x:Landroid/widget/TextView;

    invoke-virtual {p0}, Lchat/ola/vn/balloon/e;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f070170

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/balloon/e;->x:Landroid/widget/TextView;

    int-to-float v1, v1

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setTextSize(F)V

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->x:Landroid/widget/TextView;

    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->x:Landroid/widget/TextView;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->x:Landroid/widget/TextView;

    const v2, 0x7f080078

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setBackgroundResource(I)V

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->x:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setGravity(I)V

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->x:Landroid/widget/TextView;

    const v1, 0x7f10020b

    invoke-virtual {v0, p1, v1}, Landroid/widget/TextView;->setTextAppearance(Landroid/content/Context;I)V

    new-instance p1, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v0, -0x2

    invoke-direct {p1, v0, v0}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    const/16 v0, 0xa

    invoke-virtual {p1, v0}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    const/16 v0, 0xb

    invoke-virtual {p1, v0}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->x:Landroid/widget/TextView;

    invoke-virtual {p0, v0, p1}, Lchat/ola/vn/balloon/e;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0, p0}, Lchat/ola/vn/balloon/e;->setOlaBalloonListener(Lchat/ola/vn/p/e;)V

    invoke-virtual {p0, p0}, Lchat/ola/vn/balloon/e;->setOlaBalloonAnimationListener(Lchat/ola/vn/balloon/c;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/balloon/e;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/balloon/e;->g()V

    return-void
.end method

.method private f()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->v:Landroid/os/Handler;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/balloon/e;->getHandler()Landroid/os/Handler;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/balloon/e;->v:Landroid/os/Handler;

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->v:Landroid/os/Handler;

    if-nez v0, :cond_0

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/balloon/e;->v:Landroid/os/Handler;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/e;->w:Ljava/lang/Runnable;

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/balloon/e$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/balloon/e$1;-><init>(Lchat/ola/vn/balloon/e;)V

    iput-object v0, p0, Lchat/ola/vn/balloon/e;->w:Ljava/lang/Runnable;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/balloon/e;->v:Landroid/os/Handler;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->v:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->w:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->v:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->w:Ljava/lang/Runnable;

    const-wide/16 v2, 0xbb8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_2
    return-void
.end method

.method private g()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/e;->v:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->w:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/balloon/f;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    invoke-virtual {v0, v1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Landroid/view/View;)V

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_1
    return-void
.end method

.method private h()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {v0, v1}, Lchat/ola/vn/balloon/OlaBalloonService;->c(Lchat/ola/vn/message/f;)V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/balloon/e;->setNotify(I)V

    :cond_0
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/balloon/b;)V
    .locals 2

    :try_start_0
    iget-boolean p1, p0, Lchat/ola/vn/balloon/e;->A:Z

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    iput-boolean v0, p0, Lchat/ola/vn/balloon/e;->A:Z

    invoke-direct {p0}, Lchat/ola/vn/balloon/e;->h()V

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {p1, p0}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Landroid/view/View;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/balloon/e;->f()V

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    invoke-virtual {p1, v0}, Lchat/ola/vn/balloon/f;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    iget-object p1, p1, Lchat/ola/vn/balloon/f;->a:Landroid/view/WindowManager$LayoutParams;

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/e;->getBalloonWidth()I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    iget-object p1, p1, Lchat/ola/vn/balloon/f;->a:Landroid/view/WindowManager$LayoutParams;

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    iput v0, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    iget-object v1, v1, Lchat/ola/vn/balloon/f;->a:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/balloon/OlaBalloonService;->b(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/message/d;Z)V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/balloon/e;->getVisibility()I

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->z()I

    move-result v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/balloon/e;->setNotify(I)V

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/balloon/e;->setNotify(I)V

    :cond_1
    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/balloon/e;->g()V

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    if-nez v0, :cond_2

    if-eqz p2, :cond_3

    new-instance p2, Lchat/ola/vn/balloon/f;

    invoke-virtual {p0}, Lchat/ola/vn/balloon/e;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p2, v0, p0}, Lchat/ola/vn/balloon/f;-><init>(Landroid/content/Context;Lchat/ola/vn/balloon/e;)V

    iput-object p2, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    :goto_1
    iget-object p2, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    invoke-virtual {p2, p1}, Lchat/ola/vn/balloon/f;->setMessage(Lchat/ola/vn/message/d;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_2
    if-eqz p2, :cond_3

    goto :goto_1

    :catch_0
    :cond_3
    return-void
.end method

.method public b()V
    .locals 3

    iget-byte v0, p0, Lchat/ola/vn/balloon/e;->a:B

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/f;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/balloon/f;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    iget-object v0, v0, Lchat/ola/vn/balloon/f;->a:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/e;->getBalloonWidth()I

    move-result v2

    add-int/2addr v1, v2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    iget-object v0, v0, Lchat/ola/vn/balloon/f;->a:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    iget-object v2, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    iget-object v2, v2, Lchat/ola/vn/balloon/f;->a:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/balloon/e;->f()V

    :cond_1
    invoke-super {p0}, Lchat/ola/vn/balloon/b;->b()V

    return-void
.end method

.method public b(Lchat/ola/vn/balloon/b;)V
    .locals 7

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    if-eqz p1, :cond_1

    iget-byte p1, p0, Lchat/ola/vn/balloon/e;->a:B

    if-nez p1, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/balloon/e;->r:J

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz p1, :cond_1

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/balloon/e;->A:Z

    iput-byte p1, p0, Lchat/ola/vn/balloon/e;->a:B

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    iput p1, p0, Lchat/ola/vn/balloon/e;->n:I

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    iput p1, p0, Lchat/ola/vn/balloon/e;->o:I

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v2, p0, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    const/4 v3, 0x0

    const/4 v4, 0x0

    const-wide/16 v5, 0xc8

    move-object v1, p0

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/balloon/a;Landroid/view/WindowManager$LayoutParams;IIJ)V

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->a(I)V

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->A()V

    invoke-direct {p0}, Lchat/ola/vn/balloon/e;->g()V

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object p1, p1, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/balloon/e;

    invoke-virtual {v0, p0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v1, v0}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_1
    return-void
.end method

.method public e()Z
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0, p0}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/balloon/e;)V

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->a(Ljava/lang/Long;)V

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public getContact()Lchat/ola/vn/message/f;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    return-object v0
.end method

.method public getCurrentPositionX()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    return v0
.end method

.method public getCurrentPositionY()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    return v0
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ClickableViewAccessibility"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/balloon/e;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    invoke-super {p0, p1}, Lchat/ola/vn/balloon/b;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method public setContact(Lchat/ola/vn/message/f;)V
    .locals 4
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->o()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p0}, Lchat/ola/vn/balloon/e;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->t:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x3f59999a    # 0.85f

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setAlpha(F)V

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/balloon/e;->a()V

    return-void

    :cond_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->o()Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p0}, Lchat/ola/vn/balloon/e;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v2

    const/16 v3, 0xc8

    invoke-virtual {v0, p1, v1, v2, v3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/graphics/Bitmap;I)V

    return-void

    :cond_2
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/balloon/e;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p0}, Lchat/ola/vn/balloon/e;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/graphics/Bitmap;)V

    return-void
.end method

.method public setNotify(I)V
    .locals 2

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->x:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/e;->x:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/balloon/e;->x:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ""

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public setVisibility(I)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/balloon/b;->setVisibility(I)V

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->z()I

    move-result p1

    :goto_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/balloon/e;->setNotify(I)V

    return-void

    :cond_0
    const/4 p1, 0x0

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Lchat/ola/vn/balloon/f;->setVisibility(I)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/balloon/e;->u:Lchat/ola/vn/balloon/f;

    :cond_2
    return-void
.end method
