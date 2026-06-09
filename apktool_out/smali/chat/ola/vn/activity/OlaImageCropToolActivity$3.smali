.class Lchat/ola/vn/activity/OlaImageCropToolActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaImageCropToolActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field a:Landroid/graphics/Matrix;

.field final synthetic b:Lchat/ola/vn/activity/OlaImageCropToolActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaImageCropToolActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a()V
    .locals 11

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->d(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Landroid/graphics/Bitmap;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/view/HighlightView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->e(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Lchat/ola/vn/view/CropImageView;

    move-result-object v1

    invoke-direct {v0, v1}, Lchat/ola/vn/view/HighlightView;-><init>(Landroid/view/View;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->d(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->d(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    new-instance v3, Landroid/graphics/Rect;

    const/4 v4, 0x0

    invoke-direct {v3, v4, v4, v1, v2}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v5

    mul-int/lit8 v5, v5, 0x4

    div-int/lit8 v5, v5, 0x5

    iget-object v6, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v6}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->f(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I

    move-result v6

    if-eqz v6, :cond_2

    iget-object v6, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v6}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->g(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I

    move-result v6

    if-eqz v6, :cond_2

    iget-object v6, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v6}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->f(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I

    move-result v6

    iget-object v7, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v7}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->g(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I

    move-result v7

    if-le v6, v7, :cond_1

    iget-object v6, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v6}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->g(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I

    move-result v6

    mul-int v6, v6, v5

    iget-object v7, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v7}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->f(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I

    move-result v7

    div-int/2addr v6, v7

    goto :goto_0

    :cond_1
    iget-object v6, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v6}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->f(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I

    move-result v6

    mul-int v6, v6, v5

    iget-object v7, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v7}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->g(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I

    move-result v7

    div-int/2addr v6, v7

    move v10, v6

    move v6, v5

    move v5, v10

    goto :goto_0

    :cond_2
    move v6, v5

    :goto_0
    sub-int/2addr v1, v5

    div-int/lit8 v1, v1, 0x2

    sub-int/2addr v2, v6

    div-int/lit8 v2, v2, 0x2

    new-instance v7, Landroid/graphics/RectF;

    int-to-float v8, v1

    int-to-float v9, v2

    add-int/2addr v1, v5

    int-to-float v1, v1

    add-int/2addr v2, v6

    int-to-float v2, v2

    invoke-direct {v7, v8, v9, v1, v2}, Landroid/graphics/RectF;-><init>(FFFF)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->a:Landroid/graphics/Matrix;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    iget-boolean v5, v1, Lchat/ola/vn/activity/OlaImageCropToolActivity;->f:Z

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->f(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->g(Lchat/ola/vn/activity/OlaImageCropToolActivity;)I

    move-result v1

    if-eqz v1, :cond_3

    const/4 v1, 0x1

    const/4 v6, 0x1

    goto :goto_1

    :cond_3
    const/4 v6, 0x0

    :goto_1
    move-object v1, v0

    move-object v4, v7

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/view/HighlightView;->a(Landroid/graphics/Matrix;Landroid/graphics/Rect;Landroid/graphics/RectF;ZZ)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->e(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Lchat/ola/vn/view/CropImageView;

    move-result-object v1

    iget-object v1, v1, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->e(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Lchat/ola/vn/view/CropImageView;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/CropImageView;->a(Lchat/ola/vn/view/HighlightView;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaImageCropToolActivity$3;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->a()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->e(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Lchat/ola/vn/view/CropImageView;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/view/CropImageView;->getImageMatrix()Landroid/graphics/Matrix;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->a:Landroid/graphics/Matrix;

    new-instance v0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaImageCropToolActivity$3$1;-><init>(Lchat/ola/vn/activity/OlaImageCropToolActivity$3;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method
