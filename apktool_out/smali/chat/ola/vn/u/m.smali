.class Lchat/ola/vn/u/m;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/u/g;


# instance fields
.field a:Lchat/ola/vn/u/d;

.field b:Ljava/lang/String;

.field c:Ljava/lang/String;

.field d:Lchat/ola/vn/u/p;

.field e:Ljava/lang/String;

.field f:Ljava/lang/String;

.field g:I

.field h:I

.field i:I

.field j:Ljava/io/InputStream;

.field k:Z


# direct methods
.method constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/u/m;->a:Lchat/ola/vn/u/d;

    iput-object v0, p0, Lchat/ola/vn/u/m;->e:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/u/m;->f:Ljava/lang/String;

    const/16 v1, 0x5000

    iput v1, p0, Lchat/ola/vn/u/m;->g:I

    const/4 v1, 0x0

    iput v1, p0, Lchat/ola/vn/u/m;->h:I

    iput v1, p0, Lchat/ola/vn/u/m;->i:I

    iput-object v0, p0, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    iput-boolean v1, p0, Lchat/ola/vn/u/m;->k:Z

    return-void
.end method

.method private a(II)V
    .locals 1

    new-instance v0, Lchat/ola/vn/u/m$8;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/u/m$8;-><init>(Lchat/ola/vn/u/m;II)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private a(ILjava/lang/String;ILjava/lang/String;Ljava/lang/String;ZLjava/lang/String;)V
    .locals 17

    move-object/from16 v1, p0

    move-object/from16 v2, p2

    move-object/from16 v3, p4

    const/4 v4, 0x1

    const/16 v5, 0x780

    :try_start_0
    const-string v6, "png"

    invoke-static {v6, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_0

    const-string v6, "jpg"

    invoke-static {v6, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_8

    :cond_0
    new-instance v6, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v6}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    iput-boolean v4, v6, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    invoke-static {v2, v6}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    iget v7, v6, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    iget v8, v6, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    invoke-static/range {p2 .. p2}, Lcom/mg/ola/common/d/b;->a(Ljava/lang/String;)I

    move-result v9

    invoke-static {v8, v7}, Ljava/lang/Math;->max(II)I

    move-result v10

    if-le v10, v5, :cond_6

    if-le v8, v7, :cond_1

    mul-int/lit16 v7, v7, 0x780

    div-int/2addr v7, v8

    invoke-static {v6, v5, v7}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/BitmapFactory$Options;II)I

    move-result v7

    goto :goto_0

    :cond_1
    if-ne v8, v7, :cond_2

    invoke-static {v6, v5, v5}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/BitmapFactory$Options;II)I

    move-result v7

    goto :goto_0

    :cond_2
    mul-int/lit16 v8, v8, 0x780

    div-int/2addr v8, v7

    invoke-static {v6, v8, v5}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/BitmapFactory$Options;II)I

    move-result v7

    :goto_0
    rem-int/lit8 v8, v7, 0x2

    if-eqz v8, :cond_3

    add-int/lit8 v7, v7, 0x1

    :cond_3
    iput v7, v6, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    const/4 v7, 0x0

    iput-boolean v7, v6, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    invoke-static {v2, v6}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v6
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-lez v9, :cond_4

    :try_start_1
    new-instance v15, Landroid/graphics/Matrix;

    invoke-direct {v15}, Landroid/graphics/Matrix;-><init>()V

    int-to-float v7, v9

    invoke-virtual {v15, v7}, Landroid/graphics/Matrix;->postRotate(F)Z

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-virtual {v6}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v13

    invoke-virtual {v6}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v14

    const/16 v16, 0x1

    move-object v10, v6

    invoke-static/range {v10 .. v16}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v7
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v6, v7

    goto :goto_1

    :catch_0
    move-exception v0

    move-object v7, v0

    :try_start_2
    invoke-virtual {v7}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_4
    :goto_1
    new-instance v7, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->a()Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, ".temp."

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static/range {p2 .. p2}, Lcom/mg/ola/common/d/d;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v7, v8, v9}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v7}, Ljava/io/File;->exists()Z

    move-result v8

    if-nez v8, :cond_5

    invoke-virtual {v7}, Ljava/io/File;->createNewFile()Z

    :cond_5
    invoke-static {v6, v7}, Lcom/mg/ola/common/d/c;->a(Landroid/graphics/Bitmap;Ljava/io/File;)V

    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    iput-object v6, v1, Lchat/ola/vn/u/m;->f:Ljava/lang/String;

    invoke-static {v7}, Lcom/mg/ola/common/d/c;->h(Ljava/io/File;)J

    move-result-wide v6

    long-to-int v6, v6

    iput v6, v1, Lchat/ola/vn/u/m;->h:I

    :goto_2
    iget v6, v1, Lchat/ola/vn/u/m;->h:I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :try_start_3
    const-string v7, "jpg"
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    goto/16 :goto_4

    :cond_6
    if-lez v9, :cond_8

    :try_start_4
    invoke-static/range {p2 .. p2}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v10

    new-instance v15, Landroid/graphics/Matrix;

    invoke-direct {v15}, Landroid/graphics/Matrix;-><init>()V

    int-to-float v6, v9

    invoke-virtual {v15, v6}, Landroid/graphics/Matrix;->postRotate(F)Z

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-virtual {v10}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v13

    invoke-virtual {v10}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v14

    const/16 v16, 0x1

    invoke-static/range {v10 .. v16}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v6

    const-string v7, "OlaChat"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "ROTATE: "

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v7, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->a()Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, ".temp."

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static/range {p2 .. p2}, Lcom/mg/ola/common/d/d;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v7, v8, v9}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v7}, Ljava/io/File;->exists()Z

    move-result v8

    if-nez v8, :cond_7

    invoke-virtual {v7}, Ljava/io/File;->createNewFile()Z

    :cond_7
    invoke-static {v6, v7}, Lcom/mg/ola/common/d/c;->a(Landroid/graphics/Bitmap;Ljava/io/File;)V

    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    iput-object v6, v1, Lchat/ola/vn/u/m;->f:Ljava/lang/String;

    invoke-static {v7}, Lcom/mg/ola/common/d/c;->h(Ljava/io/File;)J

    move-result-wide v6

    long-to-int v6, v6

    iput v6, v1, Lchat/ola/vn/u/m;->h:I
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_2

    :cond_8
    move/from16 v6, p1

    goto :goto_3

    :catch_1
    move/from16 v6, p1

    :catch_2
    const/4 v7, 0x0

    :try_start_5
    iput-object v7, v1, Lchat/ola/vn/u/m;->f:Ljava/lang/String;

    :goto_3
    move-object v7, v3

    :goto_4
    new-instance v3, Lchat/ola/vn/u/e;

    invoke-direct {v3, v4}, Lchat/ola/vn/u/e;-><init>(S)V

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_9

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v4

    :goto_5
    iput-object v4, v3, Lchat/ola/vn/u/e;->e:Ljava/lang/String;

    goto :goto_6

    :cond_9
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/e;->j()Ljava/lang/String;

    move-result-object v4

    goto :goto_5

    :goto_6
    iput v6, v3, Lchat/ola/vn/u/e;->g:I

    move/from16 v4, p3

    iput v4, v3, Lchat/ola/vn/u/e;->h:I

    invoke-static {v7}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_a

    iput-object v7, v3, Lchat/ola/vn/u/e;->a:Ljava/lang/String;

    :cond_a
    invoke-static/range {p5 .. p5}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_b

    move-object/from16 v4, p5

    iput-object v4, v3, Lchat/ola/vn/u/e;->b:Ljava/lang/String;

    :cond_b
    invoke-static/range {p2 .. p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_c

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "."

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v3, Lchat/ola/vn/u/e;->d:Ljava/lang/String;

    :cond_c
    if-eqz p6, :cond_d

    const/16 v2, 0x32

    iput-byte v2, v3, Lchat/ola/vn/u/e;->k:B

    goto :goto_7

    :cond_d
    const/16 v2, 0x30

    iput-byte v2, v3, Lchat/ola/vn/u/e;->k:B

    :goto_7
    move-object/from16 v2, p7

    iput-object v2, v3, Lchat/ola/vn/u/e;->f:Ljava/lang/String;

    iget-object v2, v1, Lchat/ola/vn/u/m;->a:Lchat/ola/vn/u/d;

    invoke-virtual {v2, v3}, Lchat/ola/vn/u/d;->b(Lchat/ola/vn/u/e;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    return-void

    :catch_3
    invoke-virtual {v1, v5}, Lchat/ola/vn/u/m;->a(I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/u/m;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/u/m;->f()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/u/m;ILjava/lang/String;ILjava/lang/String;Ljava/lang/String;ZLjava/lang/String;)V
    .locals 0

    invoke-direct/range {p0 .. p7}, Lchat/ola/vn/u/m;->a(ILjava/lang/String;ILjava/lang/String;Ljava/lang/String;ZLjava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/u/m;Ljava/lang/String;I[B)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/u/m;->a(Ljava/lang/String;I[B)V

    return-void
.end method

.method private a(Ljava/lang/String;I[B)V
    .locals 2

    new-instance v0, Lchat/ola/vn/u/e;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Lchat/ola/vn/u/e;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/u/e;->c:Ljava/lang/String;

    iput p2, v0, Lchat/ola/vn/u/e;->i:I

    iput-object p3, v0, Lchat/ola/vn/u/e;->l:[B

    iget-object p1, p0, Lchat/ola/vn/u/m;->a:Lchat/ola/vn/u/d;

    invoke-virtual {p1, v0}, Lchat/ola/vn/u/d;->a(Lchat/ola/vn/u/e;)V

    return-void
.end method

.method private a(Ljava/util/List;Ljava/lang/Integer;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;",
            "Ljava/lang/Integer;",
            ")V"
        }
    .end annotation

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->e()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/u/m$6;

    invoke-direct {v1, p0, p1, p2}, Lchat/ola/vn/u/m$6;-><init>(Lchat/ola/vn/u/m;Ljava/util/List;Ljava/lang/Integer;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/u/m;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/u/m;->e()V

    return-void
.end method

.method private b(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/u/m$10;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/u/m$10;-><init>(Lchat/ola/vn/u/m;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private d()V
    .locals 2

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->e()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/u/m$5;

    invoke-direct {v1, p0}, Lchat/ola/vn/u/m$5;-><init>(Lchat/ola/vn/u/m;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private e()V
    .locals 1

    new-instance v0, Lchat/ola/vn/u/m$7;

    invoke-direct {v0, p0}, Lchat/ola/vn/u/m$7;-><init>(Lchat/ola/vn/u/m;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private f()V
    .locals 1

    new-instance v0, Lchat/ola/vn/u/m$9;

    invoke-direct {v0, p0}, Lchat/ola/vn/u/m$9;-><init>(Lchat/ola/vn/u/m;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private g()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/u/m;->a:Lchat/ola/vn/u/d;

    iget-object v1, p0, Lchat/ola/vn/u/m;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/u/d;->a(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/u/m;->f()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-direct {p0}, Lchat/ola/vn/u/m;->g()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public a(I)V
    .locals 1

    :try_start_0
    new-instance v0, Lchat/ola/vn/u/m$3;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/u/m$3;-><init>(Lchat/ola/vn/u/m;I)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-direct {p0}, Lchat/ola/vn/u/m;->g()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public a(Lchat/ola/vn/u/p;)V
    .locals 2

    iput-object p1, p0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    iput-object p0, p1, Lchat/ola/vn/u/p;->a:Lchat/ola/vn/u/m;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, ""

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/u/m;->c:Ljava/lang/String;

    sget-boolean p1, Lchat/ola/vn/h;->I:Z

    if-eqz p1, :cond_0

    const/16 p1, 0x5000

    :goto_0
    iput p1, p0, Lchat/ola/vn/u/m;->g:I

    goto :goto_1

    :cond_0
    sget-boolean p1, Lchat/ola/vn/h;->J:Z

    if-eqz p1, :cond_1

    const/16 p1, 0x2800

    goto :goto_0

    :cond_1
    const/16 p1, 0xc00

    goto :goto_0

    :goto_1
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/u/m;->e:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v0}, Lchat/ola/vn/u/p;->a()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v0}, Lchat/ola/vn/u/p;->a()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/u/m;->e:Ljava/lang/String;

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/u/m;->e:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/mg/ola/common/d/c;->h(Ljava/io/File;)J

    move-result-wide v0

    long-to-int v0, v0

    iput v0, p0, Lchat/ola/vn/u/m;->h:I

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v0}, Lchat/ola/vn/u/p;->b()[B

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v0}, Lchat/ola/vn/u/p;->b()[B

    move-result-object v0

    array-length v0, v0

    iput v0, p0, Lchat/ola/vn/u/m;->h:I

    iput-object p1, p0, Lchat/ola/vn/u/m;->e:Ljava/lang/String;

    :cond_3
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v0}, Lchat/ola/vn/u/p;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-direct {p0, p1}, Lchat/ola/vn/u/m;->b(Ljava/lang/String;)V

    return-void

    :cond_4
    const/4 p1, 0x0

    iget v0, p0, Lchat/ola/vn/u/m;->h:I

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/u/m;->a(II)V

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->e()Ljava/util/concurrent/ExecutorService;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/u/m$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/u/m$1;-><init>(Lchat/ola/vn/u/m;)V

    invoke-interface {p1, v0}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    invoke-direct {p0}, Lchat/ola/vn/u/m;->f()V

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/u/m;->b:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    :try_start_0
    iget p1, p0, Lchat/ola/vn/u/m;->i:I

    iget v0, p0, Lchat/ola/vn/u/m;->g:I

    add-int/2addr p1, v0

    iput p1, p0, Lchat/ola/vn/u/m;->i:I

    iget p1, p0, Lchat/ola/vn/u/m;->i:I

    iget v0, p0, Lchat/ola/vn/u/m;->h:I

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/u/m;->a(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;ILjava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/m;->c:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p1, :cond_0

    :try_start_1
    new-instance p1, Lchat/ola/vn/u/m$4;

    invoke-direct {p1, p0, p2, p3}, Lchat/ola/vn/u/m$4;-><init>(Lchat/ola/vn/u/m;ILjava/lang/String;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    invoke-direct {p0}, Lchat/ola/vn/u/m;->g()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/m;->b:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    new-instance p1, Lchat/ola/vn/entity/i;

    invoke-direct {p1}, Lchat/ola/vn/entity/i;-><init>()V

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/i;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/u/m;->e:Ljava/lang/String;

    invoke-static {p2, v0}, Lchat/ola/vn/d;->c(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {p2}, Lchat/ola/vn/u/p;->c()Lchat/ola/vn/u/o;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/u/p;->a([B)V

    iput-object v1, p0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    new-instance v0, Lchat/ola/vn/u/m$11;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/u/m$11;-><init>(Lchat/ola/vn/u/m;Lchat/ola/vn/u/o;Lchat/ola/vn/entity/i;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    invoke-direct {p0}, Lchat/ola/vn/u/m;->g()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;IILjava/util/List;Ljava/lang/Integer;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "II",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;",
            "Ljava/lang/Integer;",
            ")V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/u/m;->c:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iput-object p2, p0, Lchat/ola/vn/u/m;->b:Ljava/lang/String;

    iput p3, p0, Lchat/ola/vn/u/m;->g:I

    mul-int p3, p3, p4

    iput p3, p0, Lchat/ola/vn/u/m;->i:I

    iget p1, p0, Lchat/ola/vn/u/m;->i:I

    iget p2, p0, Lchat/ola/vn/u/m;->h:I

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/u/m;->a(II)V

    invoke-direct {p0, p5, p6}, Lchat/ola/vn/u/m;->a(Ljava/util/List;Ljava/lang/Integer;)V

    :cond_0
    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/u/m;->k:Z

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/u/m;->i:I

    :cond_0
    return-void
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/u/m;->c:Ljava/lang/String;

    return-object v0
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/u/m;->c:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iput-object p2, p0, Lchat/ola/vn/u/m;->b:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/u/m;->d()V

    :cond_0
    return-void
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/u/m;->b:Ljava/lang/String;

    return-object v0
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/m;->b:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p1, :cond_0

    :try_start_1
    new-instance p1, Lchat/ola/vn/u/m$12;

    invoke-direct {p1, p0, p2}, Lchat/ola/vn/u/m$12;-><init>(Lchat/ola/vn/u/m;Ljava/lang/String;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    invoke-direct {p0}, Lchat/ola/vn/u/m;->g()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_0
    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/m;->c:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0, p2}, Lchat/ola/vn/u/m;->b(Ljava/lang/String;)V

    invoke-direct {p0}, Lchat/ola/vn/u/m;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/m;->c:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p1, :cond_0

    :try_start_1
    new-instance p1, Lchat/ola/vn/u/m$2;

    invoke-direct {p1, p0, p2}, Lchat/ola/vn/u/m$2;-><init>(Lchat/ola/vn/u/m;Ljava/lang/String;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    invoke-direct {p0}, Lchat/ola/vn/u/m;->g()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_0
    return-void
.end method
