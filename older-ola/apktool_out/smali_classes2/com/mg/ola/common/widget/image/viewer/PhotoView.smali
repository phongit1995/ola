.class public Lcom/mg/ola/common/widget/image/viewer/PhotoView;
.super Landroid/widget/ImageView;


# instance fields
.field private a:Lcom/mg/ola/common/widget/image/viewer/b;

.field private b:Landroid/widget/ImageView$ScaleType;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c:Ljava/lang/String;

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c()V

    return-void
.end method

.method private c()V
    .locals 1

    sget-object v0, Landroid/widget/ImageView$ScaleType;->MATRIX:Landroid/widget/ImageView$ScaleType;

    invoke-super {p0, v0}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    new-instance v0, Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-direct {v0, p0}, Lcom/mg/ola/common/widget/image/viewer/b;-><init>(Landroid/widget/ImageView;)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->b:Landroid/widget/ImageView$ScaleType;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->b:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->b:Landroid/widget/ImageView$ScaleType;

    :cond_0
    return-void
.end method


# virtual methods
.method public a(F)V
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->getWidth()I

    move-result v1

    div-int/lit8 v1, v1, 0x2

    int-to-float v1, v1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->getHeight()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    int-to-float v2, v2

    invoke-virtual {v0, p1, v1, v2}, Lcom/mg/ola/common/widget/image/viewer/b;->a(FFF)V

    return-void
.end method

.method public a(Landroid/graphics/Bitmap;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c:Ljava/lang/String;

    if-eqz v0, :cond_0

    if-eqz p2, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iput-object p2, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c:Ljava/lang/String;

    return-void
.end method

.method public a()Z
    .locals 1

    :try_start_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->k()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public a(Ljava/lang/String;)Z
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c:Ljava/lang/String;

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public b()V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->a()V

    return-void
.end method

.method public getCachingId()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c:Ljava/lang/String;

    return-object v0
.end method

.method public getDisplayRect()Landroid/graphics/RectF;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->b()Landroid/graphics/RectF;

    move-result-object v0

    return-object v0
.end method

.method public getLoadingUrl()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->d:Ljava/lang/String;

    return-object v0
.end method

.method public getMaxScale()F
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->f()F

    move-result v0

    return v0
.end method

.method public getMidScale()F
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->e()F

    move-result v0

    return v0
.end method

.method public getMinScale()F
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->d()F

    move-result v0

    return v0
.end method

.method public getScale()F
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->g()F

    move-result v0

    return v0
.end method

.method public getScaleType()Landroid/widget/ImageView$ScaleType;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->h()Landroid/widget/ImageView$ScaleType;

    move-result-object v0

    return-object v0
.end method

.method protected onDetachedFromWindow()V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->a()V

    invoke-super {p0}, Landroid/widget/ImageView;->onDetachedFromWindow()V

    return-void
.end method

.method public setAllowParentInterceptOnEdge(Z)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Z)V

    return-void
.end method

.method public setImageBitmap(Landroid/graphics/Bitmap;)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    return-void
.end method

.method public setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->i()V

    :cond_0
    return-void
.end method

.method public setImageResource(I)V
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->c:Ljava/lang/String;

    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->i()V

    :cond_1
    return-void
.end method

.method public setImageURI(Landroid/net/Uri;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageURI(Landroid/net/Uri;)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->i()V

    :cond_0
    return-void
.end method

.method public setLoadingUrl(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->d:Ljava/lang/String;

    return-void
.end method

.method public setMaxScale(F)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->c(F)V

    return-void
.end method

.method public setMidScale(F)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->b(F)V

    return-void
.end method

.method public setMinScale(F)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(F)V

    return-void
.end method

.method public setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/view/View$OnLongClickListener;)V

    return-void
.end method

.method public setOnMatrixChangeListener(Lcom/mg/ola/common/widget/image/viewer/b$e;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Lcom/mg/ola/common/widget/image/viewer/b$e;)V

    return-void
.end method

.method public setOnPhotoTapListener(Lcom/mg/ola/common/widget/image/viewer/b$f;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Lcom/mg/ola/common/widget/image/viewer/b$f;)V

    return-void
.end method

.method public setOnViewTapListener(Lcom/mg/ola/common/widget/image/viewer/b$g;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Lcom/mg/ola/common/widget/image/viewer/b$g;)V

    return-void
.end method

.method public setScaleEnable(Z)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->c(Z)V

    return-void
.end method

.method public setScaleType(Landroid/widget/ImageView$ScaleType;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_0
    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->b:Landroid/widget/ImageView$ScaleType;

    return-void
.end method

.method public setZoomable(Z)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Z)V

    return-void
.end method
