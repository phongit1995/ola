.class public Lchat/ola/vn/activity/OlaImageCropToolActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field e:Z

.field f:Z

.field g:Ljava/lang/Runnable;

.field private h:Lchat/ola/vn/view/CropImageView;

.field private i:Landroid/graphics/Bitmap;

.field private j:Lchat/ola/vn/view/HighlightView;

.field private k:Ljava/lang/String;

.field private l:I

.field private m:I

.field private n:I

.field private o:I

.field private p:Landroid/net/Uri;

.field private q:Ljava/lang/Runnable;

.field private r:Landroid/app/ProgressDialog;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->k:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->f:Z

    iput v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->l:I

    iput v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->m:I

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->n:I

    iput v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->o:I

    new-instance v0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;-><init>(Lchat/ola/vn/activity/OlaImageCropToolActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->g:Ljava/lang/Runnable;

    return-void
.end method

.method private B()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->l:I

    if-eqz v0, :cond_1

    iget v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->m:I

    if-eqz v0, :cond_1

    new-instance v0, Lchat/ola/vn/view/HighlightView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->h:Lchat/ola/vn/view/CropImageView;

    invoke-direct {v0, v1}, Lchat/ola/vn/view/HighlightView;-><init>(Landroid/view/View;)V

    new-instance v3, Landroid/graphics/Rect;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    const/4 v4, 0x0

    invoke-direct {v3, v4, v4, v1, v2}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v4, Landroid/graphics/RectF;

    invoke-direct {v4}, Landroid/graphics/RectF;-><init>()V

    invoke-virtual {v3}, Landroid/graphics/Rect;->width()I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    sub-int/2addr v1, v2

    div-int/lit8 v1, v1, 0x2

    invoke-virtual {v3}, Landroid/graphics/Rect;->height()I

    move-result v2

    iget-object v5, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    sub-int/2addr v2, v5

    div-int/lit8 v2, v2, 0x2

    int-to-float v1, v1

    iput v1, v4, Landroid/graphics/RectF;->left:F

    int-to-float v1, v2

    iput v1, v4, Landroid/graphics/RectF;->top:F

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    add-int/2addr v1, v2

    int-to-float v1, v1

    iput v1, v4, Landroid/graphics/RectF;->right:F

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    add-int/2addr v2, v1

    int-to-float v1, v2

    iput v1, v4, Landroid/graphics/RectF;->bottom:F

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->h:Lchat/ola/vn/view/CropImageView;

    invoke-virtual {v1}, Lchat/ola/vn/view/CropImageView;->getImageMatrix()Landroid/graphics/Matrix;

    move-result-object v2

    const/4 v5, 0x1

    const/4 v6, 0x1

    move-object v1, v0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/view/HighlightView;->a(Landroid/graphics/Matrix;Landroid/graphics/Rect;Landroid/graphics/RectF;ZZ)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->h:Lchat/ola/vn/view/CropImageView;

    iget-object v1, v1, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->h:Lchat/ola/vn/view/CropImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/CropImageView;->a(Lchat/ola/vn/view/HighlightView;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->h:Lchat/ola/vn/view/CropImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/CropImageView;->invalidate()V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->g:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    return-void
.end method

.method private C()Landroid/graphics/Bitmap;
    .locals 10
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->j:Lchat/ola/vn/view/HighlightView;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->e:Z

    if-eqz v0, :cond_1

    return-object v1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    if-nez v0, :cond_2

    return-object v1

    :cond_2
    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->e:Z

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->j:Lchat/ola/vn/view/HighlightView;

    invoke-virtual {v2}, Lchat/ola/vn/view/HighlightView;->b()Landroid/graphics/Rect;

    move-result-object v2

    invoke-virtual {v2}, Landroid/graphics/Rect;->width()I

    move-result v3

    invoke-virtual {v2}, Landroid/graphics/Rect;->height()I

    move-result v4

    iget-boolean v5, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->f:Z

    if-eqz v5, :cond_3

    sget-object v5, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    goto :goto_0

    :cond_3
    sget-object v5, Landroid/graphics/Bitmap$Config;->RGB_565:Landroid/graphics/Bitmap$Config;

    :goto_0
    invoke-static {v3, v4, v5}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v5

    new-instance v6, Landroid/graphics/Canvas;

    invoke-direct {v6, v5}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    new-instance v7, Landroid/graphics/Rect;

    const/4 v8, 0x0

    invoke-direct {v7, v8, v8, v3, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    iget-object v9, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    invoke-virtual {v6, v9, v2, v7, v1}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    iget-boolean v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->f:Z

    if-eqz v1, :cond_6

    new-instance v1, Landroid/graphics/Canvas;

    invoke-direct {v1, v5}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    new-instance v2, Landroid/graphics/Path;

    invoke-direct {v2}, Landroid/graphics/Path;-><init>()V

    int-to-float v6, v3

    const/high16 v7, 0x40000000    # 2.0f

    div-float/2addr v6, v7

    int-to-float v9, v4

    div-float/2addr v9, v7

    sget-object v7, Landroid/graphics/Path$Direction;->CW:Landroid/graphics/Path$Direction;

    invoke-virtual {v2, v6, v9, v6, v7}, Landroid/graphics/Path;->addCircle(FFFLandroid/graphics/Path$Direction;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-virtual {v1}, Landroid/graphics/Canvas;->isHardwareAccelerated()Z

    move-result v6

    if-nez v6, :cond_5

    :cond_4
    sget-object v6, Landroid/graphics/Region$Op;->DIFFERENCE:Landroid/graphics/Region$Op;

    invoke-virtual {v1, v2, v6}, Landroid/graphics/Canvas;->clipPath(Landroid/graphics/Path;Landroid/graphics/Region$Op;)Z

    :cond_5
    sget-object v2, Landroid/graphics/PorterDuff$Mode;->CLEAR:Landroid/graphics/PorterDuff$Mode;

    invoke-virtual {v1, v8, v2}, Landroid/graphics/Canvas;->drawColor(ILandroid/graphics/PorterDuff$Mode;)V

    :cond_6
    :try_start_0
    iget v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->l:I

    if-ne v3, v1, :cond_8

    iget v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->m:I

    if-eq v4, v1, :cond_7

    goto :goto_1

    :catch_0
    :cond_7
    move-object v0, v5

    goto :goto_2

    :cond_8
    :goto_1
    new-instance v1, Landroid/graphics/Matrix;

    invoke-direct {v1}, Landroid/graphics/Matrix;-><init>()V

    iget v2, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->l:I

    iget v3, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->m:I

    invoke-static {v1, v5, v2, v3, v0}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/Matrix;Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eq v5, v0, :cond_9

    :try_start_1
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_9
    :goto_2
    iput-boolean v8, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->e:Z

    return-object v0
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Landroid/graphics/Bitmap;
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->C()Landroid/graphics/Bitmap;

    move-result-object p0

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaImageCropToolActivity;Lchat/ola/vn/view/HighlightView;)Lchat/ola/vn/view/HighlightView;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->j:Lchat/ola/vn/view/HighlightView;

    return-object p1
.end method

.method private a(Landroid/content/Intent;)V
    .locals 3

    :try_start_0
    invoke-virtual {p1}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->p:Landroid/net/Uri;

    const-string v0, "outputX"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->l:I

    const-string v0, "outputY"

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->m:I

    const-string v0, "aspectX"

    const/4 v1, 0x1

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->n:I

    const-string v0, "aspectY"

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->o:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->p:Landroid/net/Uri;

    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object p1

    iget v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->l:I

    const/16 v2, 0x2d0

    if-nez v0, :cond_0

    iput v2, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->l:I

    :cond_0
    iget v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->m:I

    if-nez v0, :cond_1

    iput v2, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->m:I

    :cond_1
    iget v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->l:I

    iget v2, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->m:I

    invoke-static {p1, v0, v2}, Lcom/mg/ola/common/d/f;->a(Ljava/lang/String;II)Landroid/graphics/Bitmap;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    iget p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->l:I

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result p1

    iput p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->l:I

    :cond_2
    iget p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->m:I

    if-nez p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p1

    iput p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->m:I

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->h:Lchat/ola/vn/view/CropImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/view/CropImageView;->a(Landroid/graphics/Bitmap;Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->finish()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaImageCropToolActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->c(Z)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Landroid/net/Uri;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->p:Landroid/net/Uri;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->k:Ljava/lang/String;

    return-object p0
.end method

.method private c(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->q:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/OlaImageCropToolActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity$2;-><init>(Lchat/ola/vn/activity/OlaImageCropToolActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->q:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->q:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->q:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7530

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->r:Landroid/app/ProgressDialog;

    if-nez p1, :cond_1

    const p1, 0x7f0f05ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    const v0, 0x7f0f0210

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->r:Landroid/app/ProgressDialog;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->r:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->show()V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->r:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Landroid/graphics/Bitmap;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Lchat/ola/vn/view/CropImageView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->h:Lchat/ola/vn/view/CropImageView;

    return-object p0
.end method

.method static synthetic f(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->n:I

    return p0
.end method

.method static synthetic g(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->o:I

    return p0
.end method

.method static synthetic h(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Lchat/ola/vn/view/HighlightView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->j:Lchat/ola/vn/view/HighlightView;

    return-object p0
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public onBackPressed()V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->finish()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090099

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eq p1, v0, :cond_2

    const v0, 0x7f0900a9

    if-eq p1, v0, :cond_1

    const v0, 0x7f090119

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    const/16 v0, 0x5a

    invoke-static {p1, v0}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    new-instance p1, Lcom/mg/ola/common/a/a;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->i:Landroid/graphics/Bitmap;

    invoke-direct {p1, v0}, Lcom/mg/ola/common/a/a;-><init>(Landroid/graphics/Bitmap;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->h:Lchat/ola/vn/view/CropImageView;

    invoke-virtual {v0, p1, v2}, Lchat/ola/vn/view/CropImageView;->a(Lcom/mg/ola/common/a/a;Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->g:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    return-void

    :cond_1
    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    invoke-virtual {p0, v1, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->finish()V

    return-void

    :cond_2
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->c(Z)V

    new-instance p1, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;-><init>(Lchat/ola/vn/activity/OlaImageCropToolActivity;)V

    new-array v0, v1, [Ljava/lang/Void;

    invoke-virtual {p1, v0}, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    new-instance v0, Landroid/graphics/drawable/ColorDrawable;

    const/high16 v1, -0x1000000

    invoke-direct {v0, v1}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {p1, v0}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    const p1, 0x7f0b009d

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->setContentView(I)V

    const p1, 0x7f0901f1

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/CropImageView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity;->h:Lchat/ola/vn/view/CropImageView;

    const p1, 0x7f090119

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0900a9

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090099

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->a(Landroid/content/Intent;)V

    :cond_0
    return-void
.end method
