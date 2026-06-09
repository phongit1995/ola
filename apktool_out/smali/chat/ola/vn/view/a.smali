.class public Lchat/ola/vn/view/a;
.super Landroid/graphics/drawable/Drawable;


# instance fields
.field private a:Landroid/graphics/Bitmap;

.field private b:Landroid/graphics/Matrix;

.field private c:Landroid/graphics/Paint;

.field private d:I

.field private e:I


# direct methods
.method public constructor <init>(II)V
    .locals 1

    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    iput p1, p0, Lchat/ola/vn/view/a;->d:I

    iput p2, p0, Lchat/ola/vn/view/a;->e:I

    invoke-direct {p0}, Lchat/ola/vn/view/a;->a()V

    const/4 v0, 0x0

    invoke-virtual {p0, v0, v0, p1, p2}, Lchat/ola/vn/view/a;->setBounds(IIII)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/a;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/a;->d:I

    return p0
.end method

.method private a()V
    .locals 1

    new-instance v0, Landroid/graphics/Matrix;

    invoke-direct {v0}, Landroid/graphics/Matrix;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/a;->b:Landroid/graphics/Matrix;

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/a;->c:Landroid/graphics/Paint;

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/view/a;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/a;->e:I

    return p0
.end method


# virtual methods
.method public a(Landroid/graphics/Bitmap;)V
    .locals 7

    iput-object p1, p0, Lchat/ola/vn/view/a;->a:Landroid/graphics/Bitmap;

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p1

    iget v1, p0, Lchat/ola/vn/view/a;->d:I

    iget v2, p0, Lchat/ola/vn/view/a;->e:I

    mul-int v3, v0, v2

    mul-int v4, v1, p1

    const/4 v5, 0x0

    const/high16 v6, 0x3f000000    # 0.5f

    if-le v3, v4, :cond_0

    int-to-float v2, v2

    int-to-float p1, p1

    div-float/2addr v2, p1

    int-to-float p1, v1

    int-to-float v0, v0

    mul-float v0, v0, v2

    sub-float/2addr p1, v0

    mul-float p1, p1, v6

    move v0, v2

    goto :goto_0

    :cond_0
    int-to-float v1, v1

    int-to-float v0, v0

    div-float v0, v1, v0

    int-to-float v1, v2

    int-to-float p1, p1

    mul-float p1, p1, v0

    sub-float/2addr v1, p1

    mul-float p1, v1, v6

    move v5, p1

    const/4 p1, 0x0

    :goto_0
    iget-object v1, p0, Lchat/ola/vn/view/a;->b:Landroid/graphics/Matrix;

    invoke-virtual {v1, v0, v0}, Landroid/graphics/Matrix;->setScale(FF)V

    iget-object v0, p0, Lchat/ola/vn/view/a;->b:Landroid/graphics/Matrix;

    add-float/2addr p1, v6

    float-to-int p1, p1

    int-to-float p1, p1

    add-float/2addr v5, v6

    float-to-int v1, v5

    int-to-float v1, v1

    invoke-virtual {v0, p1, v1}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    invoke-virtual {p0}, Lchat/ola/vn/view/a;->invalidateSelf()V

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    const-string v0, "#\u001b"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "##"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    :cond_1
    invoke-static {p1}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result v0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->b()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f080717

    invoke-static {p1, v0}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object p1

    :goto_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/view/a;->a(Landroid/graphics/Bitmap;)V

    return-void

    :pswitch_1
    invoke-static {}, Lchat/ola/vn/OlaApplication;->b()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f08071a

    invoke-static {p1, v0}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object p1

    goto :goto_0

    :pswitch_2
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/view/a$1;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/view/a$1;-><init>(Lchat/ola/vn/view/a;Ljava/lang/String;)V

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/c/w;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public b(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    const-string v0, "file:\\"

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    const-string v0, "UTF-8"

    invoke-static {p1, v0}, Ljava/net/URLDecoder;->decode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    invoke-static {p1}, Lchat/ola/vn/util/o;->d(Ljava/lang/String;)S

    move-result v0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->b()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f080717

    goto :goto_0

    :pswitch_1
    invoke-static {}, Lchat/ola/vn/OlaApplication;->b()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f08071a

    :goto_0
    invoke-static {p1, v0}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/a;->a(Landroid/graphics/Bitmap;)V

    return-void

    :pswitch_2
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/view/a$2;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/view/a$2;-><init>(Lchat/ola/vn/view/a;Ljava/lang/String;)V

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/c/w;)V

    :catch_0
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public draw(Landroid/graphics/Canvas;)V
    .locals 4

    invoke-virtual {p1}, Landroid/graphics/Canvas;->getSaveCount()I

    move-result v0

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    iget v1, p0, Lchat/ola/vn/view/a;->d:I

    iget v2, p0, Lchat/ola/vn/view/a;->e:I

    const/4 v3, 0x0

    invoke-virtual {p1, v3, v3, v1, v2}, Landroid/graphics/Canvas;->clipRect(IIII)Z

    iget-object v1, p0, Lchat/ola/vn/view/a;->a:Landroid/graphics/Bitmap;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/view/a;->a:Landroid/graphics/Bitmap;

    iget-object v2, p0, Lchat/ola/vn/view/a;->b:Landroid/graphics/Matrix;

    iget-object v3, p0, Lchat/ola/vn/view/a;->c:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v3}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Matrix;Landroid/graphics/Paint;)V

    goto :goto_0

    :cond_0
    sget v1, Lchat/ola/vn/f;->v:I

    invoke-virtual {p1, v1}, Landroid/graphics/Canvas;->drawColor(I)V

    :goto_0
    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->restoreToCount(I)V

    return-void
.end method

.method public getIntrinsicHeight()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/view/a;->e:I

    return v0
.end method

.method public getIntrinsicWidth()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/view/a;->d:I

    return v0
.end method

.method public getOpacity()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public setAlpha(I)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/a;->c:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setAlpha(I)V

    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/a;->c:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    return-void
.end method
