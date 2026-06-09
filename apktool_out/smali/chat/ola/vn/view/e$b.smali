.class Lchat/ola/vn/view/e$b;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/e;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "[B",
        "Ljava/lang/Void;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/e;


# direct methods
.method private constructor <init>(Lchat/ola/vn/view/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/view/e;Lchat/ola/vn/view/e$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/e$b;-><init>(Lchat/ola/vn/view/e;)V

    return-void
.end method


# virtual methods
.method protected varargs a([[B)Ljava/lang/String;
    .locals 18

    move-object/from16 v1, p0

    const/4 v2, 0x0

    const/4 v3, 0x1

    :try_start_0
    aget-object v4, p1, v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_5

    :try_start_1
    array-length v5, v4

    int-to-long v5, v5

    invoke-static {v5, v6}, Lchat/ola/vn/d;->a(J)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    :cond_0
    invoke-static {v6, v4}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;[B)V

    invoke-static {v5}, Lcom/mg/ola/common/d/b;->a(Ljava/lang/String;)I

    move-result v5
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :try_start_2
    invoke-virtual {v6}, Ljava/io/File;->delete()Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_0
    const/4 v5, 0x0

    :catch_1
    :goto_0
    :try_start_3
    array-length v6, v4

    invoke-static {v4, v2, v6}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v4

    iget-object v6, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v6}, Lchat/ola/vn/view/e;->h(Lchat/ola/vn/view/e;)I

    move-result v6

    int-to-float v6, v6

    iget-object v7, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v7}, Lchat/ola/vn/view/e;->i(Lchat/ola/vn/view/e;)I

    move-result v7

    int-to-float v7, v7

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v8

    int-to-float v8, v8

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v9

    int-to-float v9, v9

    iget-object v10, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v10}, Lchat/ola/vn/view/e;->j(Lchat/ola/vn/view/e;)I

    move-result v10

    iget-object v11, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v11}, Lchat/ola/vn/view/e;->k(Lchat/ola/vn/view/e;)I

    move-result v11

    div-int/2addr v10, v11

    if-gt v10, v3, :cond_1

    const/4 v10, 0x1

    goto :goto_1

    :cond_1
    const/4 v10, 0x0

    :goto_1
    if-eqz v10, :cond_2

    cmpl-float v10, v8, v9

    if-lez v10, :cond_3

    iget-object v6, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v6}, Lchat/ola/vn/view/e;->i(Lchat/ola/vn/view/e;)I

    move-result v6

    int-to-float v6, v6

    iget-object v7, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    :goto_2
    invoke-static {v7}, Lchat/ola/vn/view/e;->h(Lchat/ola/vn/view/e;)I

    move-result v7

    int-to-float v7, v7

    goto :goto_3

    :cond_2
    cmpg-float v10, v8, v9

    if-gez v10, :cond_3

    iget-object v6, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v6}, Lchat/ola/vn/view/e;->i(Lchat/ola/vn/view/e;)I

    move-result v6

    int-to-float v6, v6

    iget-object v7, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    goto :goto_2

    :cond_3
    :goto_3
    div-float v10, v8, v9

    div-float v11, v6, v7

    cmpl-float v10, v10, v11

    if-ltz v10, :cond_4

    div-float v10, v9, v7

    goto :goto_4

    :cond_4
    div-float v10, v8, v6

    :goto_4
    mul-float v6, v6, v10

    float-to-int v6, v6

    mul-float v7, v7, v10

    float-to-int v7, v7

    int-to-float v10, v6

    sub-float/2addr v8, v10

    const/high16 v10, 0x40000000    # 2.0f

    div-float/2addr v8, v10

    float-to-int v8, v8

    int-to-float v11, v7

    sub-float/2addr v9, v11

    div-float/2addr v9, v10

    float-to-int v9, v9

    invoke-static {v4, v8, v9, v6, v7}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIII)Landroid/graphics/Bitmap;

    move-result-object v4
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_5

    if-nez v5, :cond_a

    :try_start_4
    iget-object v5, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v5}, Lchat/ola/vn/view/e;->h(Lchat/ola/vn/view/e;)I

    move-result v5

    int-to-float v5, v5

    iget-object v6, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v6}, Lchat/ola/vn/view/e;->i(Lchat/ola/vn/view/e;)I

    move-result v6

    int-to-float v6, v6

    div-float/2addr v5, v6

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    int-to-float v6, v6

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v7

    int-to-float v7, v7

    div-float/2addr v6, v7

    const/high16 v7, 0x3f800000    # 1.0f

    cmpl-float v8, v5, v7

    if-lez v8, :cond_5

    cmpg-float v8, v6, v7

    if-ltz v8, :cond_6

    :cond_5
    cmpg-float v5, v5, v7

    if-gez v5, :cond_a

    cmpl-float v5, v6, v7

    if-lez v5, :cond_a

    :cond_6
    new-instance v15, Landroid/graphics/Matrix;

    invoke-direct {v15}, Landroid/graphics/Matrix;-><init>()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :try_start_5
    invoke-static {}, Landroid/hardware/Camera;->getNumberOfCameras()I

    move-result v5

    if-ne v5, v3, :cond_7

    :goto_5
    const/4 v5, 0x1

    goto :goto_6

    :cond_7
    iget-object v5, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v5}, Lchat/ola/vn/view/e;->l(Lchat/ola/vn/view/e;)I

    move-result v5
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    if-ne v5, v3, :cond_8

    goto :goto_5

    :catch_2
    :cond_8
    const/4 v5, 0x0

    :goto_6
    if-eqz v5, :cond_9

    const/high16 v5, -0x3d4c0000    # -90.0f

    :try_start_6
    invoke-virtual {v15, v5}, Landroid/graphics/Matrix;->postRotate(F)Z

    goto :goto_7

    :cond_9
    const/high16 v5, 0x42b40000    # 90.0f

    invoke-virtual {v15, v5}, Landroid/graphics/Matrix;->postRotate(F)Z

    :goto_7
    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v13

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v14

    const/16 v16, 0x1

    move-object v10, v4

    invoke-static/range {v10 .. v16}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v5
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    move-object v4, v5

    :catch_3
    :cond_a
    :try_start_7
    new-instance v5, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v5}, Ljava/io/ByteArrayOutputStream;-><init>()V

    sget-object v6, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v7, 0x64

    invoke-virtual {v4, v6, v7, v5}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    invoke-virtual {v5}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    array-length v5, v4

    int-to-long v5, v5

    invoke-static {v5, v6}, Lchat/ola/vn/d;->a(J)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v7

    if-eqz v7, :cond_b

    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    :cond_b
    invoke-static {v6, v4}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;[B)V

    iget-object v4, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v4}, Lchat/ola/vn/view/e;->e(Lchat/ola/vn/view/e;)Ljava/lang/Short;

    move-result-object v4

    if-eqz v4, :cond_11

    const/16 v4, 0x400

    new-instance v7, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v7}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    iput-boolean v3, v7, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    invoke-static {v5, v7}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    iget v8, v7, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    iget v9, v7, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    invoke-static {v9, v8}, Ljava/lang/Math;->max(II)I

    move-result v10

    if-le v10, v4, :cond_11

    invoke-static {v5}, Lcom/mg/ola/common/d/b;->a(Ljava/lang/String;)I

    move-result v10

    if-le v9, v8, :cond_c

    mul-int/lit16 v8, v8, 0x400

    div-int/2addr v8, v9

    invoke-static {v7, v4, v8}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/BitmapFactory$Options;II)I

    move-result v4

    goto :goto_8

    :cond_c
    if-ne v9, v8, :cond_d

    invoke-static {v7, v4, v4}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/BitmapFactory$Options;II)I

    move-result v4

    goto :goto_8

    :cond_d
    mul-int/lit16 v9, v9, 0x400

    div-int/2addr v9, v8

    invoke-static {v7, v9, v4}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/BitmapFactory$Options;II)I

    move-result v4

    :goto_8
    rem-int/lit8 v8, v4, 0x2

    if-eqz v8, :cond_e

    add-int/lit8 v4, v4, 0x1

    :cond_e
    iput v4, v7, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    iput-boolean v2, v7, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    invoke-static {v5, v7}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v2
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_5

    if-lez v10, :cond_f

    :try_start_8
    new-instance v4, Landroid/graphics/Matrix;

    invoke-direct {v4}, Landroid/graphics/Matrix;-><init>()V

    int-to-float v7, v10

    invoke-virtual {v4, v7}, Landroid/graphics/Matrix;->postRotate(F)Z

    const/4 v12, 0x0

    const/4 v13, 0x0

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v14

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v15

    const/16 v17, 0x1

    move-object v11, v2

    move-object/from16 v16, v4

    invoke-static/range {v11 .. v17}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v4
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_4

    move-object v2, v4

    goto :goto_9

    :catch_4
    move-exception v0

    move-object v4, v0

    :try_start_9
    invoke-virtual {v4}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_f
    :goto_9
    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_10

    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    :cond_10
    invoke-static {v2, v6}, Lcom/mg/ola/common/d/c;->a(Landroid/graphics/Bitmap;Ljava/io/File;)V

    :cond_11
    iget-object v2, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v2, v3}, Lchat/ola/vn/view/e;->a(Lchat/ola/vn/view/e;Z)Z
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_5

    return-object v5

    :catch_5
    move-exception v0

    move-object v2, v0

    invoke-virtual {v2}, Ljava/lang/Throwable;->printStackTrace()V

    iget-object v2, v1, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v2, v3}, Lchat/ola/vn/view/e;->a(Lchat/ola/vn/view/e;Z)Z

    const/4 v2, 0x0

    return-object v2
.end method

.method protected a(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v0}, Lchat/ola/vn/view/e;->e(Lchat/ola/vn/view/e;)Ljava/lang/Short;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v0}, Lchat/ola/vn/view/e;->m(Lchat/ola/vn/view/e;)Lchat/ola/vn/view/e$a;

    move-result-object v0

    invoke-interface {v0, p1}, Lchat/ola/vn/view/e$a;->a_(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v0}, Lchat/ola/vn/view/e;->m(Lchat/ola/vn/view/e;)Lchat/ola/vn/view/e$a;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/e$b;->a:Lchat/ola/vn/view/e;

    invoke-static {v1}, Lchat/ola/vn/view/e;->e(Lchat/ola/vn/view/e;)Ljava/lang/Short;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Short;->shortValue()S

    move-result v1

    invoke-interface {v0, p1, v1}, Lchat/ola/vn/view/e$a;->h(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    :try_start_1
    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/util/c/a;->x:Landroid/net/Uri;

    invoke-static {p1, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    :cond_1
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [[B

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/e$b;->a([[B)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/e$b;->a(Ljava/lang/String;)V

    return-void
.end method
