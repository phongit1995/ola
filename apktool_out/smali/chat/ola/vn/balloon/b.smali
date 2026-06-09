.class public abstract Lchat/ola/vn/balloon/b;
.super Landroid/widget/RelativeLayout;

# interfaces
.implements Lchat/ola/vn/balloon/a;


# instance fields
.field protected a:B

.field public b:Landroid/view/WindowManager$LayoutParams;

.field protected c:Lchat/ola/vn/p/e;

.field protected d:I

.field protected e:I

.field protected f:F

.field protected g:F

.field h:Z

.field i:Z

.field protected j:Landroid/support/v4/view/GestureDetectorCompat;

.field protected k:I

.field protected l:Lchat/ola/vn/balloon/d;

.field protected m:Landroid/graphics/Rect;

.field protected n:I

.field protected o:I

.field protected p:Lchat/ola/vn/balloon/c;

.field protected q:Lchat/ola/vn/balloon/OlaBalloonService;

.field protected r:J


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput-byte p1, p0, Lchat/ola/vn/balloon/b;->a:B

    const/4 p2, 0x0

    iput p2, p0, Lchat/ola/vn/balloon/b;->f:F

    iput p2, p0, Lchat/ola/vn/balloon/b;->g:F

    iput-boolean p1, p0, Lchat/ola/vn/balloon/b;->h:Z

    iput-boolean p1, p0, Lchat/ola/vn/balloon/b;->i:Z

    const/4 p1, -0x1

    iput p1, p0, Lchat/ola/vn/balloon/b;->n:I

    iput p1, p0, Lchat/ola/vn/balloon/b;->o:I

    const-wide/16 p1, 0x0

    iput-wide p1, p0, Lchat/ola/vn/balloon/b;->r:J

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput-byte p1, p0, Lchat/ola/vn/balloon/b;->a:B

    const/4 p2, 0x0

    iput p2, p0, Lchat/ola/vn/balloon/b;->f:F

    iput p2, p0, Lchat/ola/vn/balloon/b;->g:F

    iput-boolean p1, p0, Lchat/ola/vn/balloon/b;->h:Z

    iput-boolean p1, p0, Lchat/ola/vn/balloon/b;->i:Z

    const/4 p1, -0x1

    iput p1, p0, Lchat/ola/vn/balloon/b;->n:I

    iput p1, p0, Lchat/ola/vn/balloon/b;->o:I

    const-wide/16 p1, 0x0

    iput-wide p1, p0, Lchat/ola/vn/balloon/b;->r:J

    return-void
.end method

.method public constructor <init>(Lchat/ola/vn/balloon/OlaBalloonService;II)V
    .locals 7

    invoke-direct {p0, p1}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    iput-byte v0, p0, Lchat/ola/vn/balloon/b;->a:B

    const/4 v1, 0x0

    iput v1, p0, Lchat/ola/vn/balloon/b;->f:F

    iput v1, p0, Lchat/ola/vn/balloon/b;->g:F

    iput-boolean v0, p0, Lchat/ola/vn/balloon/b;->h:Z

    iput-boolean v0, p0, Lchat/ola/vn/balloon/b;->i:Z

    const/4 v1, -0x1

    iput v1, p0, Lchat/ola/vn/balloon/b;->n:I

    iput v1, p0, Lchat/ola/vn/balloon/b;->o:I

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lchat/ola/vn/balloon/b;->r:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, p0, Lchat/ola/vn/balloon/b;->r:J

    iput-object p1, p0, Lchat/ola/vn/balloon/b;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    iput p2, p0, Lchat/ola/vn/balloon/b;->d:I

    iput p3, p0, Lchat/ola/vn/balloon/b;->e:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object p2

    iget p2, p2, Landroid/content/res/Configuration;->orientation:I

    iput p2, p0, Lchat/ola/vn/balloon/b;->k:I

    new-instance p2, Landroid/view/WindowManager$LayoutParams;

    iget v2, p0, Lchat/ola/vn/balloon/b;->d:I

    iget v3, p0, Lchat/ola/vn/balloon/b;->e:I

    const/16 v4, 0x7d2

    const/16 v5, 0x28

    const/4 v6, -0x3

    move-object v1, p2

    invoke-direct/range {v1 .. v6}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    iput-object p2, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget-object p2, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    const/16 p3, 0x33

    iput p3, p2, Landroid/view/WindowManager$LayoutParams;->gravity:I

    iget-object p2, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    const/high16 p3, 0x1030000

    iput p3, p2, Landroid/view/WindowManager$LayoutParams;->windowAnimations:I

    invoke-virtual {p0, v0}, Lchat/ola/vn/balloon/b;->setBackgroundColor(I)V

    new-instance p2, Landroid/support/v4/view/GestureDetectorCompat;

    new-instance p3, Lchat/ola/vn/balloon/b$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/balloon/b$1;-><init>(Lchat/ola/vn/balloon/b;)V

    invoke-direct {p2, p1, p3}, Landroid/support/v4/view/GestureDetectorCompat;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;)V

    iput-object p2, p0, Lchat/ola/vn/balloon/b;->j:Landroid/support/v4/view/GestureDetectorCompat;

    return-void
.end method

.method public static a(Landroid/content/Context;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 1

    const/4 v0, 0x1

    invoke-static {p0, p1, v0, v0}, Lchat/ola/vn/balloon/b;->a(Landroid/content/Context;Landroid/graphics/Bitmap;ZZ)Landroid/graphics/Bitmap;

    move-result-object p0

    return-object p0
.end method

.method public static a(Landroid/content/Context;Landroid/graphics/Bitmap;ZZ)Landroid/graphics/Bitmap;
    .locals 12

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f08007b

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-static {p0, v1}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object p0

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->getPadding(Landroid/graphics/Rect;)Z

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    iget v3, v1, Landroid/graphics/Rect;->right:I

    sub-int v3, v0, v3

    iput v3, v1, Landroid/graphics/Rect;->right:I

    iget v3, v1, Landroid/graphics/Rect;->bottom:I

    sub-int v3, v2, v3

    iput v3, v1, Landroid/graphics/Rect;->bottom:I

    invoke-virtual {v1}, Landroid/graphics/Rect;->width()I

    move-result v1

    sub-int v1, v0, v1

    sget-object v3, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v2, v3}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v3

    new-instance v4, Landroid/graphics/Canvas;

    invoke-direct {v4, v3}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    new-instance v5, Landroid/graphics/Paint;

    invoke-direct {v5}, Landroid/graphics/Paint;-><init>()V

    const/4 v6, 0x1

    invoke-virtual {v5, v6}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    const/4 v6, 0x0

    invoke-virtual {v4, v6, v6, v6, v6}, Landroid/graphics/Canvas;->drawARGB(IIII)V

    const v7, -0xbdbdbe

    invoke-virtual {v5, v7}, Landroid/graphics/Paint;->setColor(I)V

    int-to-float v7, v0

    const/high16 v8, 0x40000000    # 2.0f

    div-float/2addr v7, v8

    sub-int v8, v0, v1

    div-int/lit8 v8, v8, 0x2

    int-to-float v8, v8

    invoke-virtual {v4, v7, v7, v8, v5}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    new-instance v7, Landroid/graphics/PorterDuffXfermode;

    sget-object v8, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v7, v8}, Landroid/graphics/PorterDuffXfermode;-><init>(Landroid/graphics/PorterDuff$Mode;)V

    invoke-virtual {v5, v7}, Landroid/graphics/Paint;->setXfermode(Landroid/graphics/Xfermode;)Landroid/graphics/Xfermode;

    const/4 v7, 0x0

    if-eqz p2, :cond_1

    new-instance p2, Landroid/graphics/Rect;

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v8

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v9

    invoke-direct {p2, v6, v6, v8, v9}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v8, Landroid/graphics/Rect;

    div-int/lit8 v1, v1, 0x2

    sub-int v9, v0, v1

    invoke-direct {v8, v1, v1, v9, v9}, Landroid/graphics/Rect;-><init>(IIII)V

    if-eqz p3, :cond_0

    goto :goto_0

    :cond_0
    move-object v5, v7

    :goto_0
    invoke-virtual {v4, p1, p2, v8, v5}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    goto :goto_2

    :cond_1
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result p2

    sub-int p2, v0, p2

    div-int/lit8 p2, p2, 0x2

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    sub-int v1, v2, v1

    div-int/lit8 v1, v1, 0x2

    new-instance v8, Landroid/graphics/Rect;

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v9

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v10

    invoke-direct {v8, v6, v6, v9, v10}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v9, Landroid/graphics/Rect;

    sub-int v10, v0, p2

    sub-int v11, v0, v1

    invoke-direct {v9, p2, v1, v10, v11}, Landroid/graphics/Rect;-><init>(IIII)V

    if-eqz p3, :cond_2

    goto :goto_1

    :cond_2
    move-object v5, v7

    :goto_1
    invoke-virtual {v4, p1, v8, v9, v5}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    :goto_2
    new-instance p1, Landroid/graphics/Rect;

    invoke-direct {p1, v6, v6, v0, v2}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-virtual {v4, p0, p1, p1, v7}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    return-object v3
.end method

.method private a(II)V
    .locals 8

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz v0, :cond_0

    sget-object v1, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v3, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    const-wide/16 v6, 0x320

    move-object v2, p0

    move v4, p1

    move v5, p2

    invoke-virtual/range {v1 .. v7}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/balloon/a;Landroid/view/WindowManager$LayoutParams;IIJ)V

    :cond_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/balloon/b;II)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/balloon/b;->a(II)V

    return-void
.end method

.method public static a(Lchat/ola/vn/balloon/a;II)[I
    .locals 8

    invoke-interface {p0}, Lchat/ola/vn/balloon/a;->getWindowWidth()I

    move-result v0

    invoke-interface {p0}, Lchat/ola/vn/balloon/a;->getBalloonWidth()I

    move-result v1

    sub-int/2addr v0, v1

    invoke-interface {p0}, Lchat/ola/vn/balloon/a;->getWindowHeight()I

    move-result v1

    invoke-interface {p0}, Lchat/ola/vn/balloon/a;->getBalloonHeight()I

    move-result v2

    sub-int/2addr v1, v2

    invoke-interface {p0}, Lchat/ola/vn/balloon/a;->getCurrentPositionX()I

    move-result v2

    invoke-interface {p0}, Lchat/ola/vn/balloon/a;->getCurrentPositionY()I

    move-result p0

    const/4 v3, 0x1

    const/4 v4, 0x2

    const/4 v5, 0x0

    if-gez p1, :cond_2

    int-to-float v0, v2

    sub-int v6, v2, p1

    int-to-float v6, v6

    div-float/2addr v0, v6

    sub-int v6, p2, p0

    int-to-float v6, v6

    mul-float v0, v0, v6

    float-to-int v0, v0

    add-int/2addr v0, p0

    if-gez v0, :cond_0

    int-to-float v0, p0

    sub-int/2addr p0, p2

    int-to-float p0, p0

    div-float/2addr v0, p0

    sub-int/2addr p1, v2

    int-to-float p0, p1

    mul-float v0, v0, p0

    float-to-int p0, v0

    add-int/2addr v2, p0

    new-array p0, v4, [I

    aput v2, p0, v5

    aput v5, p0, v3

    return-object p0

    :cond_0
    if-le v0, v1, :cond_1

    sub-int p0, v1, p0

    int-to-float p0, p0

    div-float/2addr p0, v6

    sub-int/2addr p1, v2

    int-to-float p1, p1

    mul-float p0, p0, p1

    float-to-int p0, p0

    add-int/2addr v2, p0

    new-array p0, v4, [I

    aput v2, p0, v5

    aput v1, p0, v3

    return-object p0

    :cond_1
    new-array p0, v4, [I

    aput v5, p0, v5

    aput v0, p0, v3

    return-object p0

    :cond_2
    if-le p1, v0, :cond_5

    sub-int v6, v0, v2

    int-to-float v6, v6

    sub-int/2addr p1, v2

    int-to-float p1, p1

    div-float/2addr v6, p1

    sub-int v7, p2, p0

    int-to-float v7, v7

    mul-float v6, v6, v7

    float-to-int v6, v6

    add-int/2addr v6, p0

    if-gez v6, :cond_3

    int-to-float v0, p0

    sub-int/2addr p0, p2

    int-to-float p0, p0

    div-float/2addr v0, p0

    mul-float v0, v0, p1

    float-to-int p0, v0

    add-int/2addr v2, p0

    new-array p0, v4, [I

    aput v2, p0, v5

    aput v5, p0, v3

    return-object p0

    :cond_3
    if-le v6, v1, :cond_4

    sub-int p0, v1, p0

    int-to-float p0, p0

    div-float/2addr p0, v7

    mul-float p0, p0, p1

    float-to-int p0, p0

    add-int/2addr v2, p0

    new-array p0, v4, [I

    aput v2, p0, v5

    aput v1, p0, v3

    return-object p0

    :cond_4
    new-array p0, v4, [I

    aput v0, p0, v5

    aput v6, p0, v3

    return-object p0

    :cond_5
    if-gez p2, :cond_8

    int-to-float v1, p0

    sub-int v6, p0, p2

    int-to-float v6, v6

    div-float/2addr v1, v6

    sub-int v6, p1, v2

    int-to-float v6, v6

    mul-float v1, v1, v6

    float-to-int v1, v1

    add-int/2addr v1, v2

    if-gez v1, :cond_6

    int-to-float v0, v2

    sub-int/2addr v2, p1

    int-to-float p1, v2

    div-float/2addr v0, p1

    sub-int/2addr p2, p0

    int-to-float p1, p2

    mul-float v0, v0, p1

    float-to-int p1, v0

    add-int/2addr p0, p1

    new-array p1, v4, [I

    aput v5, p1, v5

    aput p0, p1, v3

    return-object p1

    :cond_6
    if-le v1, v0, :cond_7

    sub-int p1, v0, v2

    int-to-float p1, p1

    div-float/2addr p1, v6

    sub-int/2addr p2, p0

    int-to-float p2, p2

    mul-float p1, p1, p2

    float-to-int p1, p1

    add-int/2addr p0, p1

    new-array p1, v4, [I

    aput v0, p1, v5

    aput p0, p1, v3

    return-object p1

    :cond_7
    new-array p0, v4, [I

    aput v1, p0, v5

    aput v5, p0, v3

    return-object p0

    :cond_8
    if-le p2, v1, :cond_b

    sub-int v6, v1, p0

    int-to-float v6, v6

    sub-int/2addr p2, p0

    int-to-float p2, p2

    div-float/2addr v6, p2

    sub-int v7, p1, v2

    int-to-float v7, v7

    mul-float v6, v6, v7

    float-to-int v6, v6

    add-int/2addr v6, v2

    if-gez v6, :cond_9

    int-to-float v0, v2

    sub-int/2addr v2, p1

    int-to-float p1, v2

    div-float/2addr v0, p1

    mul-float v0, v0, p2

    float-to-int p1, v0

    add-int/2addr p0, p1

    new-array p1, v4, [I

    aput v5, p1, v5

    aput p0, p1, v3

    return-object p1

    :cond_9
    if-le v6, v0, :cond_a

    sub-int p1, v0, v2

    int-to-float p1, p1

    div-float/2addr p1, v7

    mul-float p1, p1, p2

    float-to-int p1, p1

    add-int/2addr p0, p1

    new-array p1, v4, [I

    aput v0, p1, v5

    aput p0, p1, v3

    return-object p1

    :cond_a
    new-array p0, v4, [I

    aput v6, p0, v5

    aput v1, p0, v3

    return-object p0

    :cond_b
    const/4 p0, 0x0

    return-object p0
.end method

.method private b(II)V
    .locals 2

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v1, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {v0, p0, v1, p1, p2}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/balloon/a;Landroid/view/WindowManager$LayoutParams;II)V

    :cond_0
    return-void
.end method

.method private f()V
    .locals 10

    const/4 v0, 0x4

    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    if-eqz v2, :cond_0

    new-instance v2, Landroid/graphics/Rect;

    iget-object v3, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v4, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v5, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v5, v5, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v6, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v6, v6, Landroid/view/WindowManager$LayoutParams;->width:I

    add-int/2addr v5, v6

    iget-object v6, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v6, v6, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v7, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v7, v7, Landroid/view/WindowManager$LayoutParams;->height:I

    add-int/2addr v6, v7

    invoke-direct {v2, v3, v4, v5, v6}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v3, Landroid/graphics/Rect;

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowHeight()I

    move-result v4

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowHeight()I

    move-result v5

    div-int/lit8 v5, v5, 0x6

    sub-int/2addr v4, v5

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowWidth()I

    move-result v5

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowHeight()I

    move-result v6

    invoke-direct {v3, v1, v4, v5, v6}, Landroid/graphics/Rect;-><init>(IIII)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance v4, Landroid/graphics/Rect;

    iget-object v5, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    iget-object v5, v5, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v5, v5, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v6, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    iget-object v6, v6, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v6, v6, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v7, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    iget-object v7, v7, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v7, v7, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v8, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    invoke-virtual {v8}, Lchat/ola/vn/balloon/d;->getBalloonWidth()I

    move-result v8

    add-int/2addr v7, v8

    iget-object v8, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    iget-object v8, v8, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    iget v8, v8, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v9, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    invoke-virtual {v9}, Lchat/ola/vn/balloon/d;->getBalloonHeight()I

    move-result v9

    add-int/2addr v8, v9

    invoke-direct {v4, v5, v6, v7, v8}, Landroid/graphics/Rect;-><init>(IIII)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v3, v4

    :catch_0
    :try_start_2
    invoke-virtual {v3, v2}, Landroid/graphics/Rect;->intersect(Landroid/graphics/Rect;)Z

    move-result v2

    if-eqz v2, :cond_0

    iput-byte v0, p0, Lchat/ola/vn/balloon/b;->a:B

    iget-object v2, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowHeight()I

    move-result v3

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonHeight()I

    move-result v4

    sub-int/2addr v3, v4

    invoke-direct {p0, v2, v3}, Lchat/ola/vn/balloon/b;->b(II)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    :try_start_3
    iput-byte v0, p0, Lchat/ola/vn/balloon/b;->a:B

    iget-object v0, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowHeight()I

    move-result v2

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonHeight()I

    move-result v3

    sub-int/2addr v2, v3

    invoke-direct {p0, v0, v2}, Lchat/ola/vn/balloon/b;->b(II)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    return-void

    :catch_2
    :try_start_4
    iget-object v0, p0, Lchat/ola/vn/balloon/b;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0, p0}, Lchat/ola/vn/balloon/OlaBalloonService;->b(Landroid/view/View;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonWidth()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    add-int/2addr v0, v2

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowWidth()I

    move-result v2

    sub-int/2addr v2, v0

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v3

    iget-object v4, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v5, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v5, v5, Landroid/view/WindowManager$LayoutParams;->y:I

    if-gtz v4, :cond_1

    iput-byte v1, p0, Lchat/ola/vn/balloon/b;->a:B

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowWidth()I

    move-result v6

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonWidth()I

    move-result v7

    sub-int/2addr v6, v7

    if-lt v4, v6, :cond_2

    iput-byte v1, p0, Lchat/ola/vn/balloon/b;->a:B

    return-void

    :cond_2
    if-ne v3, v0, :cond_3

    goto :goto_0

    :cond_3
    if-ne v3, v2, :cond_4

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowWidth()I

    move-result v0

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonWidth()I

    move-result v1

    sub-int v1, v0, v1

    goto :goto_0

    :cond_4
    move v1, v4

    :goto_0
    const/4 v0, 0x1

    iput-byte v0, p0, Lchat/ola/vn/balloon/b;->a:B

    invoke-direct {p0, v1, v5}, Lchat/ola/vn/balloon/b;->b(II)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :catch_3
    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v1, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {v0, p0, v1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    :cond_0
    return-void
.end method

.method public b()V
    .locals 3

    iget-byte v0, p0, Lchat/ola/vn/balloon/b;->a:B

    const/4 v1, 0x4

    const/4 v2, 0x0

    if-eq v0, v1, :cond_0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-direct {p0}, Lchat/ola/vn/balloon/b;->f()V

    return-void

    :pswitch_1
    iput-byte v2, p0, Lchat/ola/vn/balloon/b;->a:B

    iget-object v0, p0, Lchat/ola/vn/balloon/b;->p:Lchat/ola/vn/balloon/c;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/balloon/b;->p:Lchat/ola/vn/balloon/c;

    invoke-interface {v0, p0}, Lchat/ola/vn/balloon/c;->a(Lchat/ola/vn/balloon/b;)V

    return-void

    :cond_0
    iput-byte v2, p0, Lchat/ola/vn/balloon/b;->a:B

    const/16 v0, 0x8

    invoke-virtual {p0, v0}, Lchat/ola/vn/balloon/b;->setVisibility(I)V

    :cond_1
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public c()Z
    .locals 3

    iget-byte v0, p0, Lchat/ola/vn/balloon/b;->a:B

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget-byte v0, p0, Lchat/ola/vn/balloon/b;->a:B

    const/4 v2, 0x2

    if-eq v0, v2, :cond_1

    iget-byte v0, p0, Lchat/ola/vn/balloon/b;->a:B

    const/4 v2, 0x4

    if-ne v0, v2, :cond_0

    return v1

    :cond_0
    const/4 v1, 0x0

    :cond_1
    return v1
.end method

.method public d()Z
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v2, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    add-int/2addr v1, v2

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowHeight()I

    move-result v2

    if-lt v1, v2, :cond_1

    iput-byte v0, p0, Lchat/ola/vn/balloon/b;->a:B

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->e()Z

    move-result v1

    if-nez v1, :cond_0

    const/16 v1, 0x8

    invoke-virtual {p0, v1}, Lchat/ola/vn/balloon/b;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/balloon/b;->q:Lchat/ola/vn/balloon/OlaBalloonService;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v1, :cond_0

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/balloon/b;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0, p0}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Landroid/view/View;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_0
    const/4 v0, 0x1

    :catch_1
    :cond_1
    return v0
.end method

.method public e()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public getBackupX()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/balloon/b;->n:I

    return v0
.end method

.method public getBackupY()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/balloon/b;->o:I

    return v0
.end method

.method public getBalloonBound()Landroid/graphics/Rect;
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/balloon/b;->m:Landroid/graphics/Rect;

    if-nez v0, :cond_0

    new-instance v0, Landroid/graphics/Rect;

    iget-object v1, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v2, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v3, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonWidth()I

    move-result v4

    add-int/2addr v3, v4

    iget-object v4, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonHeight()I

    move-result v5

    add-int/2addr v4, v5

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object v0, p0, Lchat/ola/vn/balloon/b;->m:Landroid/graphics/Rect;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/b;->m:Landroid/graphics/Rect;

    iget-object v1, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v2, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v3, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonWidth()I

    move-result v4

    add-int/2addr v3, v4

    iget-object v4, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonHeight()I

    move-result v5

    add-int/2addr v4, v5

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/graphics/Rect;->set(IIII)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/balloon/b;->m:Landroid/graphics/Rect;

    return-object v0
.end method

.method public getBalloonHandler()Landroid/os/Handler;
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getHandler()Landroid/os/Handler;

    move-result-object v0

    return-object v0
.end method

.method public getBalloonHeight()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/balloon/b;->e:I

    return v0
.end method

.method public getBalloonLayoutParameter()Landroid/view/WindowManager$LayoutParams;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    return-object v0
.end method

.method public getBalloonTerminator()Lchat/ola/vn/balloon/d;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    return-object v0
.end method

.method public getBalloonWidth()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/balloon/b;->d:I

    return v0
.end method

.method public getLastAccess()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/balloon/b;->r:J

    return-wide v0
.end method

.method public getOlaBalloonAnimationListener()Lchat/ola/vn/balloon/c;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/balloon/b;->p:Lchat/ola/vn/balloon/c;

    return-object v0
.end method

.method public getOlaBalloonListener()Lchat/ola/vn/p/e;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/balloon/b;->c:Lchat/ola/vn/p/e;

    return-object v0
.end method

.method public getWindowHeight()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/b;->q:Lchat/ola/vn/balloon/OlaBalloonService;

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
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/b;->q:Lchat/ola/vn/balloon/OlaBalloonService;

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

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object p1

    iget p1, p1, Landroid/content/res/Configuration;->orientation:I

    iput p1, p0, Lchat/ola/vn/balloon/b;->k:I

    invoke-direct {p0}, Lchat/ola/vn/balloon/b;->f()V

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 8

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/balloon/b;->j:Landroid/support/v4/view/GestureDetectorCompat;

    invoke-virtual {v1, p1}, Landroid/support/v4/view/GestureDetectorCompat;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v1

    const/4 v2, 0x1

    if-nez v1, :cond_d

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v1

    const/4 v3, 0x3

    packed-switch v1, :pswitch_data_0

    return v0

    :pswitch_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result p1

    iget v3, p0, Lchat/ola/vn/balloon/b;->f:F

    sub-float v3, v1, v3

    iget v4, p0, Lchat/ola/vn/balloon/b;->g:F

    sub-float v4, p1, v4

    const/4 v5, 0x0

    cmpl-float v6, v3, v5

    if-ltz v6, :cond_0

    iput-boolean v2, p0, Lchat/ola/vn/balloon/b;->h:Z

    goto :goto_0

    :cond_0
    iput-boolean v0, p0, Lchat/ola/vn/balloon/b;->h:Z

    :goto_0
    cmpl-float v5, v4, v5

    if-ltz v5, :cond_1

    iput-boolean v2, p0, Lchat/ola/vn/balloon/b;->i:Z

    goto :goto_1

    :cond_1
    iput-boolean v0, p0, Lchat/ola/vn/balloon/b;->i:Z

    :goto_1
    iget-byte v5, p0, Lchat/ola/vn/balloon/b;->a:B

    if-eq v5, v2, :cond_2

    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v5

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v6

    invoke-static {v5, v6}, Ljava/lang/Math;->max(FF)F

    move-result v5

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowWidth()I

    move-result v6

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowHeight()I

    move-result v7

    invoke-static {v6, v7}, Ljava/lang/Math;->max(II)I

    move-result v6

    div-int/lit8 v6, v6, 0x64

    int-to-float v6, v6

    cmpg-float v5, v5, v6

    if-gez v5, :cond_2

    return v0

    :cond_2
    iget-object v5, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    if-eqz v5, :cond_3

    iget-object v5, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    invoke-virtual {v5}, Lchat/ola/vn/balloon/d;->e()V

    :cond_3
    iput-byte v2, p0, Lchat/ola/vn/balloon/b;->a:B

    iput v1, p0, Lchat/ola/vn/balloon/b;->f:F

    iput p1, p0, Lchat/ola/vn/balloon/b;->g:F

    iget-object v5, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v5, v5, Landroid/view/WindowManager$LayoutParams;->x:I

    int-to-float v5, v5

    add-float/2addr v5, v3

    float-to-int v5, v5

    iget-object v6, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget v6, v6, Landroid/view/WindowManager$LayoutParams;->y:I

    int-to-float v6, v6

    add-float/2addr v6, v4

    float-to-int v6, v6

    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v3

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v4

    invoke-static {v3, v4}, Ljava/lang/Math;->max(FF)F

    move-result v3

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowWidth()I

    move-result v4

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowHeight()I

    move-result v7

    invoke-static {v4, v7}, Ljava/lang/Math;->max(II)I

    move-result v4

    div-int/lit8 v4, v4, 0x64

    int-to-float v4, v4

    cmpl-float v3, v3, v4

    if-lez v3, :cond_4

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonWidth()I

    move-result v3

    div-int/lit8 v3, v3, 0x2

    int-to-float v3, v3

    sub-float/2addr v1, v3

    float-to-int v1, v1

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonHeight()I

    move-result v3

    div-int/lit8 v3, v3, 0x2

    int-to-float v3, v3

    sub-float/2addr p1, v3

    float-to-int p1, p1

    goto :goto_2

    :cond_4
    move v1, v5

    move p1, v6

    :goto_2
    if-gez v1, :cond_5

    const/4 v1, 0x0

    goto :goto_3

    :cond_5
    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowWidth()I

    move-result v3

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonWidth()I

    move-result v4

    sub-int/2addr v3, v4

    if-le v1, v3, :cond_6

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowWidth()I

    move-result v1

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonWidth()I

    move-result v3

    sub-int/2addr v1, v3

    :cond_6
    :goto_3
    if-gez p1, :cond_7

    const/4 p1, 0x0

    goto :goto_4

    :cond_7
    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowHeight()I

    move-result v3

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonHeight()I

    move-result v4

    sub-int/2addr v3, v4

    if-le p1, v3, :cond_8

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getWindowHeight()I

    move-result p1

    invoke-virtual {p0}, Lchat/ola/vn/balloon/b;->getBalloonHeight()I

    move-result v3

    sub-int/2addr p1, v3

    :cond_8
    :goto_4
    iget-object v3, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iput v1, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v1, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iput p1, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    sget-object p1, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz p1, :cond_9

    sget-object p1, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v1, p0, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p1, p0, v1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    :cond_9
    return v2

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    if-eqz p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    invoke-virtual {p1}, Lchat/ola/vn/balloon/d;->f()V

    :cond_a
    iget-byte p1, p0, Lchat/ola/vn/balloon/b;->a:B

    if-ne p1, v2, :cond_b

    invoke-direct {p0}, Lchat/ola/vn/balloon/b;->f()V

    return v2

    :cond_b
    iget-byte p1, p0, Lchat/ola/vn/balloon/b;->a:B

    if-ne p1, v3, :cond_c

    iput-byte v0, p0, Lchat/ola/vn/balloon/b;->a:B

    iget-object p1, p0, Lchat/ola/vn/balloon/b;->c:Lchat/ola/vn/p/e;

    if-eqz p1, :cond_c

    iget-object p1, p0, Lchat/ola/vn/balloon/b;->c:Lchat/ola/vn/p/e;

    invoke-interface {p1, p0}, Lchat/ola/vn/p/e;->b(Lchat/ola/vn/balloon/b;)V

    :cond_c
    return v0

    :pswitch_2
    iput-byte v3, p0, Lchat/ola/vn/balloon/b;->a:B

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v1

    iput v1, p0, Lchat/ola/vn/balloon/b;->f:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result p1

    iput p1, p0, Lchat/ola/vn/balloon/b;->g:F

    return v2

    :cond_d
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    if-eq p1, v2, :cond_e

    return v0

    :cond_e
    iget-object p1, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    if-eqz p1, :cond_f

    iget-object p1, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    invoke-virtual {p1}, Lchat/ola/vn/balloon/d;->f()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_f
    return v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public setBackupX(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/balloon/b;->n:I

    return-void
.end method

.method public setBackupY(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/balloon/b;->o:I

    return-void
.end method

.method public setBalloonTerminator(Lchat/ola/vn/balloon/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/balloon/b;->l:Lchat/ola/vn/balloon/d;

    return-void
.end method

.method public setLastAccess(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/balloon/b;->r:J

    return-void
.end method

.method public setOlaBalloonAnimationListener(Lchat/ola/vn/balloon/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/balloon/b;->p:Lchat/ola/vn/balloon/c;

    return-void
.end method

.method public setOlaBalloonListener(Lchat/ola/vn/p/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/balloon/b;->c:Lchat/ola/vn/p/e;

    return-void
.end method
