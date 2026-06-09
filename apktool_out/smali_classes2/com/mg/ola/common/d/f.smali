.class public Lcom/mg/ola/common/d/f;
.super Ljava/lang/Object;


# direct methods
.method public static a(Landroid/graphics/BitmapFactory$Options;II)I
    .locals 3

    iget v0, p0, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    iget p0, p0, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    if-gt v0, p2, :cond_1

    if-le p0, p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x1

    return p0

    :cond_1
    :goto_0
    if-le p0, v0, :cond_2

    int-to-float v1, v0

    int-to-float v2, p2

    :goto_1
    div-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    goto :goto_2

    :cond_2
    int-to-float v1, p0

    int-to-float v2, p1

    goto :goto_1

    :goto_2
    mul-int p0, p0, v0

    int-to-float p0, p0

    mul-int p1, p1, p2

    mul-int/lit8 p1, p1, 0x2

    int-to-float p1, p1

    :goto_3
    mul-int p2, v1, v1

    int-to-float p2, p2

    div-float p2, p0, p2

    cmpl-float p2, p2, p1

    if-lez p2, :cond_3

    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    :cond_3
    move p0, v1

    return p0
.end method

.method public static a(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;
    .locals 7

    if-eqz p1, :cond_0

    if-eqz p0, :cond_0

    new-instance v5, Landroid/graphics/Matrix;

    invoke-direct {v5}, Landroid/graphics/Matrix;-><init>()V

    int-to-float p1, p1

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    int-to-float v2, v2

    div-float/2addr v2, v1

    invoke-virtual {v5, p1, v0, v2}, Landroid/graphics/Matrix;->setRotate(FFF)V

    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    const/4 v6, 0x1

    move-object v0, p0

    invoke-static/range {v0 .. v6}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_0
    return-object p0
.end method

.method public static a(Landroid/graphics/Matrix;Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;
    .locals 13

    move-object v0, p0

    move-object v7, p1

    move v8, p2

    move/from16 v9, p3

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    sub-int/2addr v1, v8

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    sub-int/2addr v2, v9

    const/4 v3, 0x0

    const/4 v10, 0x0

    if-nez p4, :cond_1

    if-ltz v1, :cond_0

    if-gez v2, :cond_1

    :cond_0
    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v8, v9, v0}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    new-instance v4, Landroid/graphics/Canvas;

    invoke-direct {v4, v0}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    div-int/lit8 v1, v1, 0x2

    invoke-static {v10, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    div-int/lit8 v2, v2, 0x2

    invoke-static {v10, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    new-instance v5, Landroid/graphics/Rect;

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    invoke-static {v8, v6}, Ljava/lang/Math;->min(II)I

    move-result v6

    add-int/2addr v6, v1

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v10

    invoke-static {v9, v10}, Ljava/lang/Math;->min(II)I

    move-result v10

    add-int/2addr v10, v2

    invoke-direct {v5, v1, v2, v6, v10}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-virtual {v5}, Landroid/graphics/Rect;->width()I

    move-result v1

    sub-int v1, v8, v1

    div-int/lit8 v1, v1, 0x2

    invoke-virtual {v5}, Landroid/graphics/Rect;->height()I

    move-result v2

    sub-int v2, v9, v2

    div-int/lit8 v2, v2, 0x2

    new-instance v6, Landroid/graphics/Rect;

    sub-int/2addr v8, v1

    sub-int/2addr v9, v2

    invoke-direct {v6, v1, v2, v8, v9}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-virtual {v4, v7, v5, v6, v3}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    return-object v0

    :cond_1
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    int-to-float v2, v2

    div-float v4, v1, v2

    int-to-float v5, v8

    int-to-float v6, v9

    div-float v11, v5, v6

    cmpl-float v4, v4, v11

    const/high16 v11, 0x3f800000    # 1.0f

    const v12, 0x3f666666    # 0.9f

    if-lez v4, :cond_4

    div-float/2addr v6, v2

    cmpg-float v1, v6, v12

    if-ltz v1, :cond_3

    cmpl-float v1, v6, v11

    if-lez v1, :cond_2

    goto :goto_0

    :cond_2
    move-object v0, v3

    goto :goto_2

    :cond_3
    :goto_0
    invoke-virtual {v0, v6, v6}, Landroid/graphics/Matrix;->setScale(FF)V

    goto :goto_2

    :cond_4
    div-float/2addr v5, v1

    cmpg-float v1, v5, v12

    if-ltz v1, :cond_6

    cmpl-float v1, v5, v11

    if-lez v1, :cond_5

    goto :goto_1

    :cond_5
    move-object v5, v3

    goto :goto_3

    :cond_6
    :goto_1
    invoke-virtual {v0, v5, v5}, Landroid/graphics/Matrix;->setScale(FF)V

    :goto_2
    move-object v5, v0

    :goto_3
    if-eqz v5, :cond_7

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    const/4 v6, 0x1

    move-object v0, v7

    invoke-static/range {v0 .. v6}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v0

    goto :goto_4

    :cond_7
    move-object v0, v7

    :goto_4
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    sub-int/2addr v1, v8

    invoke-static {v10, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    sub-int/2addr v2, v9

    invoke-static {v10, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    div-int/lit8 v1, v1, 0x2

    div-int/lit8 v2, v2, 0x2

    invoke-static {v0, v1, v2, v8, v9}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIII)Landroid/graphics/Bitmap;

    move-result-object v1

    if-eq v0, v7, :cond_8

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    :cond_8
    return-object v1
.end method

.method public static a(Ljava/lang/String;II)Landroid/graphics/Bitmap;
    .locals 2

    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    const/4 v1, 0x1

    iput-boolean v1, v0, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    invoke-static {p0, v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    invoke-static {v0, p1, p2}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/BitmapFactory$Options;II)I

    move-result p1

    iput p1, v0, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    const/4 p1, 0x0

    iput-boolean p1, v0, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    invoke-static {p0, v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/lang/String;)[I
    .locals 5

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    const/4 v0, 0x2

    :try_start_0
    new-instance v1, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v1}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    const/4 v2, 0x1

    iput-boolean v2, v1, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    invoke-static {p0, v1}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    new-array p0, v0, [I

    const/4 v3, 0x0

    iget v4, v1, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    aput v4, p0, v3

    iget v1, v1, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    aput v1, p0, v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    new-array p0, v0, [I

    fill-array-data p0, :array_0

    return-object p0

    :array_0
    .array-data 4
        0x0
        0x0
    .end array-data
.end method
