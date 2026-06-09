.class Lchat/ola/vn/c/d;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Lchat/ola/vn/c/f;",
        "Ljava/lang/Integer;",
        "[",
        "Lchat/ola/vn/c/f;",
        ">;"
    }
.end annotation


# static fields
.field public static a:Ljava/lang/Integer;

.field private static b:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lchat/ola/vn/c/f;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/c/d;->a:Ljava/lang/Integer;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lchat/ola/vn/c/d;->b:Ljava/util/Map;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Integer;)V
    .locals 0

    return-void
.end method

.method protected varargs a([Lchat/ola/vn/c/f;)[Lchat/ola/vn/c/f;
    .locals 17
    .annotation build Landroid/annotation/TargetApi;
        value = 0xa
    .end annotation

    move-object/from16 v1, p1

    :try_start_0
    sget-object v2, Lchat/ola/vn/c/d;->a:Ljava/lang/Integer;

    monitor-enter v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2d

    :try_start_1
    sget-object v3, Lchat/ola/vn/c/d;->a:Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    const/4 v4, 0x1

    add-int/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    sput-object v3, Lchat/ola/vn/c/d;->a:Ljava/lang/Integer;

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_15

    const/4 v2, 0x0

    if-eqz v1, :cond_32

    :try_start_2
    array-length v3, v1

    if-nez v3, :cond_0

    return-object v2

    :cond_0
    const/4 v3, 0x0

    const/4 v5, 0x0

    :goto_0
    array-length v6, v1

    if-ge v5, v6, :cond_33

    aget-object v6, v1, v5

    if-nez v6, :cond_1

    goto/16 :goto_21

    :cond_1
    iget-object v7, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;

    if-eqz v7, :cond_2

    goto/16 :goto_21

    :cond_2
    sget-object v7, Lchat/ola/vn/c/d;->b:Ljava/util/Map;

    monitor-enter v7
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2d

    :try_start_3
    invoke-virtual {v6}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v8

    if-eqz v8, :cond_b

    sget-object v9, Lchat/ola/vn/c/d;->b:Ljava/util/Map;

    invoke-interface {v9, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lchat/ola/vn/c/f;

    if-eqz v9, :cond_a

    iget v10, v6, Lchat/ola/vn/c/f;->e:I

    if-eq v10, v4, :cond_7

    iget v10, v6, Lchat/ola/vn/c/f;->e:I

    const/16 v11, 0x9

    if-ne v10, v11, :cond_3

    goto :goto_2

    :cond_3
    invoke-virtual {v9}, Lchat/ola/vn/c/f;->d()I

    move-result v10

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->d()I

    move-result v11

    if-lt v10, v11, :cond_5

    iget-object v10, v9, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    if-nez v10, :cond_4

    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    iput-object v10, v9, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    :cond_4
    iget-object v10, v6, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    if-eqz v10, :cond_a

    iget-object v8, v9, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    iget-object v9, v6, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    invoke-interface {v8, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iput-object v2, v6, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    iput-boolean v4, v6, Lchat/ola/vn/c/f;->t:Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :goto_1
    :try_start_4
    monitor-exit v7
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto/16 :goto_21

    :cond_5
    :try_start_5
    iget-object v10, v6, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    if-nez v10, :cond_6

    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    iput-object v10, v6, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    :cond_6
    iget-object v10, v9, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    if-eqz v10, :cond_a

    iget-object v10, v6, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    iget-object v11, v9, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    invoke-interface {v10, v11}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iput-object v2, v9, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    goto :goto_3

    :cond_7
    :goto_2
    iget-object v8, v9, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    if-nez v8, :cond_8

    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    iput-object v8, v9, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    :cond_8
    iget-object v8, v6, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    if-eqz v8, :cond_9

    iget-object v8, v9, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    iget-object v9, v6, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    invoke-interface {v8, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iput-object v2, v6, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    :cond_9
    iput-boolean v4, v6, Lchat/ola/vn/c/f;->t:Z

    goto :goto_1

    :cond_a
    :goto_3
    sget-object v9, Lchat/ola/vn/c/d;->b:Ljava/util/Map;

    invoke-interface {v9, v8, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_4

    :catchall_0
    move-exception v0

    move-object v2, v0

    goto/16 :goto_22

    :catch_0
    :cond_b
    :goto_4
    :try_start_6
    monitor-exit v7
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    :try_start_7
    invoke-virtual {v6}, Lchat/ola/vn/c/f;->b()Ljava/lang/String;

    move-result-object v7

    iget v8, v6, Lchat/ola/vn/c/f;->e:I
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_2d

    const/16 v9, 0x3a98

    const/16 v10, 0x1388

    packed-switch v8, :pswitch_data_0

    goto/16 :goto_21

    :pswitch_0
    :try_start_8
    new-instance v8, Ljava/net/URL;

    invoke-direct {v8, v7}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    invoke-virtual {v8}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v7

    check-cast v7, Ljava/net/HttpURLConnection;
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_6
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    :try_start_9
    invoke-virtual {v7, v10}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    invoke-virtual {v7, v9}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->connect()V

    new-instance v8, Ljava/io/BufferedInputStream;

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_3
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    :try_start_a
    invoke-static {v8}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v9

    if-nez v9, :cond_c

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10

    invoke-virtual {v10}, Lchat/ola/vn/c/t;->b()V

    :cond_c
    iput-object v9, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    const/4 v6, 0x0

    sub-long v13, v9, v11

    sget v6, Lchat/ola/vn/c/f;->c:I

    add-int/2addr v6, v4

    sput v6, Lchat/ola/vn/c/f;->c:I

    sget-wide v9, Lchat/ola/vn/c/f;->b:J

    const/4 v6, 0x0

    add-long v11, v9, v13

    sput-wide v11, Lchat/ola/vn/c/f;->b:J

    sget-wide v9, Lchat/ola/vn/c/f;->a:J

    cmp-long v6, v13, v9

    if-lez v6, :cond_d

    sput-wide v13, Lchat/ola/vn/c/f;->a:J
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_1
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    :catch_1
    :cond_d
    :goto_5
    :try_start_b
    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_2

    :catch_2
    :try_start_c
    invoke-virtual {v8}, Ljava/io/BufferedInputStream;->close()V
    :try_end_c
    .catch Ljava/lang/Throwable; {:try_start_c .. :try_end_c} :catch_2c

    goto/16 :goto_21

    :catchall_1
    move-exception v0

    goto :goto_6

    :catchall_2
    move-exception v0

    move-object v8, v2

    goto :goto_6

    :catch_3
    move-object v8, v2

    goto :goto_5

    :catchall_3
    move-exception v0

    move-object v7, v2

    move-object v8, v7

    :goto_6
    move-object v2, v0

    :try_start_d
    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_d
    .catch Ljava/lang/Throwable; {:try_start_d .. :try_end_d} :catch_4

    :catch_4
    :try_start_e
    invoke-virtual {v8}, Ljava/io/BufferedInputStream;->close()V
    :try_end_e
    .catch Ljava/lang/Throwable; {:try_start_e .. :try_end_e} :catch_5

    :catch_5
    :try_start_f
    throw v2
    :try_end_f
    .catch Ljava/lang/Throwable; {:try_start_f .. :try_end_f} :catch_2d

    :catch_6
    move-object v7, v2

    move-object v8, v7

    goto :goto_5

    :pswitch_1
    :try_start_10
    new-instance v8, Ljava/net/URL;

    invoke-direct {v8, v7}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    invoke-virtual {v8}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v7

    check-cast v7, Ljava/net/HttpURLConnection;
    :try_end_10
    .catch Ljava/lang/Throwable; {:try_start_10 .. :try_end_10} :catch_a
    .catchall {:try_start_10 .. :try_end_10} :catchall_6

    :try_start_11
    invoke-virtual {v7, v10}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    invoke-virtual {v7, v9}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->connect()V

    new-instance v8, Ljava/io/BufferedInputStream;

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_11
    .catch Ljava/lang/Throwable; {:try_start_11 .. :try_end_11} :catch_7
    .catchall {:try_start_11 .. :try_end_11} :catchall_5

    :try_start_12
    invoke-static {v8}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v9

    if-nez v9, :cond_e

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10

    invoke-virtual {v10}, Lchat/ola/vn/c/t;->c()V

    :cond_e
    iput-object v9, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    const/4 v6, 0x0

    sub-long v13, v9, v11

    sget v6, Lchat/ola/vn/c/f;->c:I

    add-int/2addr v6, v4

    sput v6, Lchat/ola/vn/c/f;->c:I

    sget-wide v9, Lchat/ola/vn/c/f;->b:J

    const/4 v6, 0x0

    add-long v11, v9, v13

    sput-wide v11, Lchat/ola/vn/c/f;->b:J

    sget-wide v9, Lchat/ola/vn/c/f;->a:J

    cmp-long v6, v13, v9

    if-lez v6, :cond_d

    sput-wide v13, Lchat/ola/vn/c/f;->a:J
    :try_end_12
    .catch Ljava/lang/Throwable; {:try_start_12 .. :try_end_12} :catch_1
    .catchall {:try_start_12 .. :try_end_12} :catchall_4

    goto :goto_5

    :catchall_4
    move-exception v0

    goto :goto_7

    :catchall_5
    move-exception v0

    move-object v8, v2

    goto :goto_7

    :catch_7
    move-object v8, v2

    goto :goto_5

    :catchall_6
    move-exception v0

    move-object v7, v2

    move-object v8, v7

    :goto_7
    move-object v2, v0

    :try_start_13
    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_13
    .catch Ljava/lang/Throwable; {:try_start_13 .. :try_end_13} :catch_8

    :catch_8
    :try_start_14
    invoke-virtual {v8}, Ljava/io/BufferedInputStream;->close()V
    :try_end_14
    .catch Ljava/lang/Throwable; {:try_start_14 .. :try_end_14} :catch_9

    :catch_9
    :try_start_15
    throw v2

    :catch_a
    move-object v7, v2

    move-object v8, v7

    goto :goto_5

    :pswitch_2
    iget-boolean v7, v6, Lchat/ola/vn/c/f;->n:Z

    if-eqz v7, :cond_f

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v7

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v7

    goto :goto_8

    :cond_f
    move-object v7, v2

    :goto_8
    if-eqz v7, :cond_11

    :cond_10
    :goto_9
    iput-object v7, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;

    goto/16 :goto_21

    :cond_11
    iget-object v7, v6, Lchat/ola/vn/c/f;->k:Ljava/lang/String;

    invoke-static {v7}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_31

    iget-object v7, v6, Lchat/ola/vn/c/f;->l:Ljava/lang/String;

    invoke-static {v7}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7
    :try_end_15
    .catch Ljava/lang/Throwable; {:try_start_15 .. :try_end_15} :catch_2d

    if-nez v7, :cond_31

    :try_start_16
    invoke-virtual {v6}, Lchat/ola/vn/c/f;->d()I

    move-result v7

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->d()I

    move-result v8

    iget-object v11, v6, Lchat/ola/vn/c/f;->l:Ljava/lang/String;

    iget-object v12, v6, Lchat/ola/vn/c/f;->k:Ljava/lang/String;

    iget v13, v6, Lchat/ola/vn/c/f;->m:I

    invoke-static {v7, v8, v11, v12, v13}, Lchat/ola/vn/n/b;->a(IILjava/lang/String;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Ljava/net/URL;

    invoke-direct {v8, v7}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v7

    check-cast v7, Ljava/net/HttpURLConnection;
    :try_end_16
    .catch Ljava/lang/Throwable; {:try_start_16 .. :try_end_16} :catch_c

    :try_start_17
    invoke-virtual {v7, v10}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    invoke-virtual {v7, v9}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->connect()V

    new-instance v8, Ljava/io/BufferedInputStream;

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_17
    .catch Ljava/lang/Throwable; {:try_start_17 .. :try_end_17} :catch_b

    :try_start_18
    invoke-static {v8}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v9

    if-nez v9, :cond_12

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10

    invoke-virtual {v10}, Lchat/ola/vn/c/t;->b()V

    :cond_12
    iput-object v9, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;
    :try_end_18
    .catch Ljava/lang/Throwable; {:try_start_18 .. :try_end_18} :catch_1

    goto/16 :goto_21

    :catch_b
    move-object v8, v2

    goto/16 :goto_5

    :catch_c
    move-object v7, v2

    move-object v8, v7

    goto/16 :goto_5

    :pswitch_3
    :try_start_19
    iget-boolean v7, v6, Lchat/ola/vn/c/f;->n:Z

    if-eqz v7, :cond_13

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v7

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v7

    goto :goto_a

    :cond_13
    move-object v7, v2

    :goto_a
    if-eqz v7, :cond_14

    goto :goto_9

    :cond_14
    iget-object v8, v6, Lchat/ola/vn/c/f;->j:Ljava/lang/String;

    invoke-static {v8}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v8
    :try_end_19
    .catch Ljava/lang/Throwable; {:try_start_19 .. :try_end_19} :catch_2d

    if-nez v8, :cond_31

    :try_start_1a
    new-instance v8, Ljava/net/URL;

    iget-object v11, v6, Lchat/ola/vn/c/f;->j:Ljava/lang/String;

    invoke-direct {v8, v11}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v8

    check-cast v8, Ljava/net/HttpURLConnection;
    :try_end_1a
    .catch Ljava/lang/Throwable; {:try_start_1a .. :try_end_1a} :catch_11

    :try_start_1b
    invoke-virtual {v8, v10}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    invoke-virtual {v8, v9}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    invoke-virtual {v8}, Ljava/net/HttpURLConnection;->connect()V

    new-instance v9, Ljava/io/BufferedInputStream;

    invoke-virtual {v8}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v10

    invoke-direct {v9, v10}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_1b
    .catch Ljava/lang/Throwable; {:try_start_1b .. :try_end_1b} :catch_10

    :try_start_1c
    iget-boolean v10, v6, Lchat/ola/vn/c/f;->o:Z

    if-eqz v10, :cond_16

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->d()I

    move-result v10

    const/16 v11, 0x500

    if-ne v10, v11, :cond_16

    invoke-static {v9}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v7

    if-nez v7, :cond_15

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10

    :goto_b
    invoke-virtual {v10}, Lchat/ola/vn/c/t;->b()V

    :cond_15
    :goto_c
    iput-object v7, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;

    goto/16 :goto_21

    :cond_16
    invoke-virtual {v6}, Lchat/ola/vn/c/f;->d()I

    move-result v10

    if-lez v10, :cond_20

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->a()Z

    move-result v10
    :try_end_1c
    .catch Ljava/lang/Throwable; {:try_start_1c .. :try_end_1c} :catch_e

    if-eqz v10, :cond_1c

    :try_start_1d
    new-instance v7, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v7}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    iput-boolean v4, v7, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    invoke-virtual {v9, v3}, Ljava/io/BufferedInputStream;->mark(I)V

    invoke-static {v9, v2, v7}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    invoke-virtual {v9}, Ljava/io/BufferedInputStream;->reset()V

    iget v10, v7, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    iget v11, v7, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->d()I

    move-result v12

    if-le v10, v12, :cond_1b

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->d()I

    move-result v12

    if-le v10, v11, :cond_17

    mul-int v11, v11, v12

    div-int/2addr v11, v10

    invoke-static {v7, v12, v11}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/BitmapFactory$Options;II)I

    move-result v10

    goto :goto_d

    :cond_17
    if-ne v10, v11, :cond_18

    invoke-static {v7, v12, v12}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/BitmapFactory$Options;II)I

    move-result v10

    goto :goto_d

    :cond_18
    mul-int v10, v10, v12

    div-int/2addr v10, v11

    invoke-static {v7, v10, v12}, Lcom/mg/ola/common/d/f;->a(Landroid/graphics/BitmapFactory$Options;II)I

    move-result v10

    :goto_d
    rem-int/lit8 v11, v10, 0x2

    if-eqz v11, :cond_19

    add-int/lit8 v10, v10, 0x1

    :cond_19
    iput v10, v7, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    iput-boolean v3, v7, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    invoke-static {v9, v2, v7}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v7

    if-nez v7, :cond_1a

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10

    :goto_e
    invoke-virtual {v10}, Lchat/ola/vn/c/t;->b()V

    :cond_1a
    iput-object v7, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;

    goto/16 :goto_21

    :cond_1b
    invoke-static {v9}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v7

    if-nez v7, :cond_1a

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10
    :try_end_1d
    .catch Ljava/lang/Throwable; {:try_start_1d .. :try_end_1d} :catch_d

    goto :goto_e

    :catch_d
    :try_start_1e
    invoke-static {v9}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v7

    if-nez v7, :cond_15

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10

    goto :goto_b

    :cond_1c
    iget-boolean v10, v6, Lchat/ola/vn/c/f;->n:Z

    if-eqz v10, :cond_1d

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v7

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v7, v10}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v7

    :cond_1d
    if-eqz v7, :cond_1e

    goto/16 :goto_c

    :cond_1e
    iget-object v7, v6, Lchat/ola/vn/c/f;->j:Ljava/lang/String;

    invoke-static {v7}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_31

    invoke-static {v9}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v7

    if-nez v7, :cond_1f

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10

    invoke-virtual {v10}, Lchat/ola/vn/c/t;->b()V

    :cond_1f
    iput-object v7, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;
    :try_end_1e
    .catch Ljava/lang/Throwable; {:try_start_1e .. :try_end_1e} :catch_e

    goto/16 :goto_21

    :catch_e
    :goto_f
    :try_start_1f
    invoke-virtual {v8}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_1f
    .catch Ljava/lang/Throwable; {:try_start_1f .. :try_end_1f} :catch_f

    :catch_f
    :try_start_20
    invoke-virtual {v9}, Ljava/io/BufferedInputStream;->close()V
    :try_end_20
    .catch Ljava/lang/Throwable; {:try_start_20 .. :try_end_20} :catch_2c

    goto/16 :goto_21

    :cond_20
    :try_start_21
    invoke-static {v9}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v7

    if-nez v7, :cond_15

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10
    :try_end_21
    .catch Ljava/lang/Throwable; {:try_start_21 .. :try_end_21} :catch_e

    goto/16 :goto_b

    :catch_10
    move-object v9, v2

    goto :goto_f

    :catch_11
    move-object v8, v2

    move-object v9, v8

    goto :goto_f

    :pswitch_4
    :try_start_22
    invoke-static {}, Lcom/mg/ola/common/d/g;->b()Z

    move-result v7

    if-eqz v7, :cond_31

    iget-object v7, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    if-eqz v7, :cond_31

    iget-object v7, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-static {v7, v4}, Landroid/media/ThumbnailUtils;->createVideoThumbnail(Ljava/lang/String;I)Landroid/graphics/Bitmap;

    move-result-object v7

    if-nez v7, :cond_10

    new-instance v7, Ljava/io/File;

    iget-object v8, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-direct {v7, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v8, Landroid/media/MediaMetadataRetriever;

    invoke-direct {v8}, Landroid/media/MediaMetadataRetriever;-><init>()V

    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v8, v7}, Landroid/media/MediaMetadataRetriever;->setDataSource(Ljava/lang/String;)V

    const-wide/16 v9, 0x3e8

    invoke-virtual {v8, v9, v10}, Landroid/media/MediaMetadataRetriever;->getFrameAtTime(J)Landroid/graphics/Bitmap;

    move-result-object v7

    goto/16 :goto_9

    :pswitch_5
    iget-object v7, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-static {v7}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_31

    iget-object v7, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-static {v7}, Lcom/mg/ola/common/d/c;->a(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_31

    new-instance v7, Landroid/media/ExifInterface;

    iget-object v8, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-direct {v7, v8}, Landroid/media/ExifInterface;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7}, Landroid/media/ExifInterface;->hasThumbnail()Z

    move-result v8

    if-eqz v8, :cond_22

    invoke-virtual {v7}, Landroid/media/ExifInterface;->getThumbnail()[B

    move-result-object v7

    array-length v8, v7

    invoke-static {v7, v3, v8}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v7
    :try_end_22
    .catch Ljava/lang/Throwable; {:try_start_22 .. :try_end_22} :catch_2d

    :try_start_23
    iget-object v8, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-static {v8}, Lcom/mg/ola/common/d/b;->a(Ljava/lang/String;)I

    move-result v8

    if-lez v8, :cond_21

    new-instance v14, Landroid/graphics/Matrix;

    invoke-direct {v14}, Landroid/graphics/Matrix;-><init>()V

    int-to-float v8, v8

    invoke-virtual {v14, v8}, Landroid/graphics/Matrix;->postRotate(F)Z

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v12

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v13

    const/4 v15, 0x1

    move-object v9, v7

    invoke-static/range {v9 .. v15}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v8
    :try_end_23
    .catch Ljava/lang/Throwable; {:try_start_23 .. :try_end_23} :catch_12

    move-object v7, v8

    :catch_12
    :cond_21
    if-nez v7, :cond_10

    :try_start_24
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v8

    :goto_10
    invoke-virtual {v8}, Lchat/ola/vn/c/t;->b()V

    goto/16 :goto_9

    :cond_22
    iget-object v7, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    sget v8, Lchat/ola/vn/e;->c:I

    div-int/lit8 v8, v8, 0x3

    sget v9, Lchat/ola/vn/e;->c:I

    div-int/lit8 v9, v9, 0x3

    invoke-static {v7, v8, v9}, Lcom/mg/ola/common/d/f;->a(Ljava/lang/String;II)Landroid/graphics/Bitmap;

    move-result-object v7

    if-nez v7, :cond_10

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v8
    :try_end_24
    .catch Ljava/lang/Throwable; {:try_start_24 .. :try_end_24} :catch_2d

    goto :goto_10

    :pswitch_6
    :try_start_25
    new-instance v8, Ljava/net/URL;

    invoke-direct {v8, v7}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    invoke-virtual {v8}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v7

    check-cast v7, Ljava/net/HttpURLConnection;
    :try_end_25
    .catch Ljava/lang/Throwable; {:try_start_25 .. :try_end_25} :catch_15
    .catchall {:try_start_25 .. :try_end_25} :catchall_8

    :try_start_26
    invoke-virtual {v7, v10}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    invoke-virtual {v7, v9}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->connect()V

    new-instance v8, Ljava/io/BufferedInputStream;

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_26
    .catch Ljava/lang/Throwable; {:try_start_26 .. :try_end_26} :catch_14
    .catchall {:try_start_26 .. :try_end_26} :catchall_7

    :try_start_27
    invoke-static {v8}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v9

    if-nez v9, :cond_23

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10

    invoke-virtual {v10}, Lchat/ola/vn/c/t;->b()V

    :cond_23
    iput-object v9, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    const/4 v6, 0x0

    sub-long v13, v9, v11

    sget v6, Lchat/ola/vn/c/f;->c:I

    add-int/2addr v6, v4

    sput v6, Lchat/ola/vn/c/f;->c:I

    sget-wide v9, Lchat/ola/vn/c/f;->b:J

    const/4 v6, 0x0

    add-long v11, v9, v13

    sput-wide v11, Lchat/ola/vn/c/f;->b:J

    sget-wide v9, Lchat/ola/vn/c/f;->a:J

    cmp-long v6, v13, v9

    if-lez v6, :cond_d

    sput-wide v13, Lchat/ola/vn/c/f;->a:J
    :try_end_27
    .catch Ljava/lang/Throwable; {:try_start_27 .. :try_end_27} :catch_13
    .catchall {:try_start_27 .. :try_end_27} :catchall_9

    goto/16 :goto_5

    :catch_13
    move-exception v0

    move-object v6, v0

    goto :goto_12

    :catchall_7
    move-exception v0

    move-object v8, v2

    goto :goto_11

    :catch_14
    move-exception v0

    move-object v6, v0

    move-object v8, v2

    goto :goto_12

    :catchall_8
    move-exception v0

    move-object v7, v2

    move-object v8, v7

    :goto_11
    move-object v2, v0

    goto :goto_13

    :catch_15
    move-exception v0

    move-object v6, v0

    move-object v7, v2

    move-object v8, v7

    :goto_12
    :try_start_28
    invoke-virtual {v6}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_28
    .catchall {:try_start_28 .. :try_end_28} :catchall_9

    goto/16 :goto_5

    :catchall_9
    move-exception v0

    goto :goto_11

    :goto_13
    :try_start_29
    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_29
    .catch Ljava/lang/Throwable; {:try_start_29 .. :try_end_29} :catch_16

    :catch_16
    :try_start_2a
    invoke-virtual {v8}, Ljava/io/BufferedInputStream;->close()V
    :try_end_2a
    .catch Ljava/lang/Throwable; {:try_start_2a .. :try_end_2a} :catch_17

    :catch_17
    :try_start_2b
    throw v2
    :try_end_2b
    .catch Ljava/lang/Throwable; {:try_start_2b .. :try_end_2b} :catch_2d

    :pswitch_7
    :try_start_2c
    iget-object v7, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-static {v7}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_24

    iget-object v7, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-static {v7}, Lcom/mg/ola/common/d/c;->a(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_24

    iget-object v7, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->d()I

    move-result v8

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->d()I

    move-result v9

    invoke-static {v7, v8, v9}, Lcom/mg/ola/common/d/f;->a(Ljava/lang/String;II)Landroid/graphics/Bitmap;

    move-result-object v7
    :try_end_2c
    .catch Ljava/lang/Throwable; {:try_start_2c .. :try_end_2c} :catch_18

    :try_start_2d
    iget-object v8, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-static {v8}, Lcom/mg/ola/common/d/b;->a(Ljava/lang/String;)I

    move-result v8

    if-lez v8, :cond_25

    new-instance v15, Landroid/graphics/Matrix;

    invoke-direct {v15}, Landroid/graphics/Matrix;-><init>()V

    int-to-float v8, v8

    invoke-virtual {v15, v8}, Landroid/graphics/Matrix;->postRotate(F)Z

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v13

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v14

    const/16 v16, 0x1

    move-object v10, v7

    invoke-static/range {v10 .. v16}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v8
    :try_end_2d
    .catch Ljava/lang/Throwable; {:try_start_2d .. :try_end_2d} :catch_19

    move-object v7, v8

    goto :goto_14

    :catch_18
    :cond_24
    move-object v7, v2

    :catch_19
    :cond_25
    :goto_14
    if-nez v7, :cond_26

    :try_start_2e
    iget-object v8, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-static {v8}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_26

    iget-object v8, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-static {v8}, Lcom/mg/ola/common/d/c;->a(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_26

    new-instance v8, Landroid/media/ExifInterface;

    iget-object v9, v6, Lchat/ola/vn/c/f;->i:Ljava/lang/String;

    invoke-direct {v8, v9}, Landroid/media/ExifInterface;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8}, Landroid/media/ExifInterface;->hasThumbnail()Z

    move-result v9

    if-eqz v9, :cond_26

    invoke-virtual {v8}, Landroid/media/ExifInterface;->getThumbnail()[B

    move-result-object v7

    array-length v8, v7

    invoke-static {v7, v3, v8}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v7

    :cond_26
    if-nez v7, :cond_10

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v8
    :try_end_2e
    .catch Ljava/lang/Throwable; {:try_start_2e .. :try_end_2e} :catch_2d

    goto/16 :goto_10

    :pswitch_8
    :try_start_2f
    new-instance v8, Ljava/net/URL;

    invoke-direct {v8, v7}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    invoke-virtual {v8}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v7

    check-cast v7, Ljava/net/HttpURLConnection;
    :try_end_2f
    .catch Ljava/lang/Throwable; {:try_start_2f .. :try_end_2f} :catch_1d
    .catchall {:try_start_2f .. :try_end_2f} :catchall_c

    :try_start_30
    invoke-virtual {v7, v10}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    invoke-virtual {v7, v9}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->connect()V

    new-instance v8, Ljava/io/BufferedInputStream;

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_30
    .catch Ljava/lang/Throwable; {:try_start_30 .. :try_end_30} :catch_1a
    .catchall {:try_start_30 .. :try_end_30} :catchall_b

    :try_start_31
    invoke-static {v8}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v9

    if-nez v9, :cond_27

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10

    invoke-virtual {v10}, Lchat/ola/vn/c/t;->c()V

    :cond_27
    iput-object v9, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    const/4 v6, 0x0

    sub-long v13, v9, v11

    sget v6, Lchat/ola/vn/c/f;->c:I

    add-int/2addr v6, v4

    sput v6, Lchat/ola/vn/c/f;->c:I

    sget-wide v9, Lchat/ola/vn/c/f;->b:J

    const/4 v6, 0x0

    add-long v11, v9, v13

    sput-wide v11, Lchat/ola/vn/c/f;->b:J

    sget-wide v9, Lchat/ola/vn/c/f;->a:J

    cmp-long v6, v13, v9

    if-lez v6, :cond_d

    sput-wide v13, Lchat/ola/vn/c/f;->a:J
    :try_end_31
    .catch Ljava/lang/Throwable; {:try_start_31 .. :try_end_31} :catch_1
    .catchall {:try_start_31 .. :try_end_31} :catchall_a

    goto/16 :goto_5

    :catchall_a
    move-exception v0

    goto :goto_15

    :catchall_b
    move-exception v0

    move-object v8, v2

    goto :goto_15

    :catch_1a
    move-object v8, v2

    goto/16 :goto_5

    :catchall_c
    move-exception v0

    move-object v7, v2

    move-object v8, v7

    :goto_15
    move-object v2, v0

    :try_start_32
    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_32
    .catch Ljava/lang/Throwable; {:try_start_32 .. :try_end_32} :catch_1b

    :catch_1b
    :try_start_33
    invoke-virtual {v8}, Ljava/io/BufferedInputStream;->close()V
    :try_end_33
    .catch Ljava/lang/Throwable; {:try_start_33 .. :try_end_33} :catch_1c

    :catch_1c
    :try_start_34
    throw v2

    :catch_1d
    move-object v7, v2

    move-object v8, v7

    goto/16 :goto_5

    :pswitch_9
    iget-boolean v8, v6, Lchat/ola/vn/c/f;->n:Z

    if-eqz v8, :cond_28

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v8

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v8, v11}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v8

    goto :goto_16

    :cond_28
    move-object v8, v2

    :goto_16
    invoke-virtual {v6}, Lchat/ola/vn/c/f;->d()I

    move-result v11

    if-lez v11, :cond_2a

    if-eqz v8, :cond_2a

    invoke-virtual {v8}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v12

    invoke-virtual {v8}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v13

    invoke-static {v12, v13}, Ljava/lang/Math;->max(II)I

    move-result v12

    if-lt v12, v11, :cond_2a

    invoke-virtual {v8}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v7

    invoke-virtual {v8}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v9

    invoke-static {v7, v9}, Ljava/lang/Math;->max(II)I

    move-result v7

    sget v9, Lchat/ola/vn/e;->c:I

    sget v10, Lchat/ola/vn/e;->d:I

    invoke-static {v9, v10}, Ljava/lang/Math;->max(II)I

    move-result v9

    if-lt v7, v9, :cond_29

    iput-boolean v4, v6, Lchat/ola/vn/c/f;->o:Z

    :cond_29
    iput-object v8, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;
    :try_end_34
    .catch Ljava/lang/Throwable; {:try_start_34 .. :try_end_34} :catch_2d

    goto/16 :goto_21

    :cond_2a
    :try_start_35
    new-instance v8, Ljava/net/URL;

    invoke-direct {v8, v7}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    invoke-virtual {v8}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v7

    check-cast v7, Ljava/net/HttpURLConnection;
    :try_end_35
    .catch Ljava/lang/Throwable; {:try_start_35 .. :try_end_35} :catch_29
    .catchall {:try_start_35 .. :try_end_35} :catchall_13

    :try_start_36
    invoke-virtual {v7, v10}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    invoke-virtual {v7, v9}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    invoke-virtual {v7, v3}, Ljava/net/HttpURLConnection;->setInstanceFollowRedirects(Z)V

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->connect()V

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v8

    const/16 v9, 0x12e

    if-eq v8, v9, :cond_2e

    new-instance v8, Ljava/io/BufferedInputStream;

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_36
    .catch Ljava/lang/Throwable; {:try_start_36 .. :try_end_36} :catch_28
    .catchall {:try_start_36 .. :try_end_36} :catchall_12

    :try_start_37
    invoke-static {v8}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v9

    if-eqz v9, :cond_2c

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v13

    const/4 v10, 0x0

    sub-long v15, v13, v11

    sget v10, Lchat/ola/vn/c/f;->c:I

    add-int/2addr v10, v4

    sput v10, Lchat/ola/vn/c/f;->c:I

    sget-wide v10, Lchat/ola/vn/c/f;->b:J

    const/4 v12, 0x0

    add-long v12, v10, v15

    sput-wide v12, Lchat/ola/vn/c/f;->b:J

    sget-wide v10, Lchat/ola/vn/c/f;->a:J

    cmp-long v12, v15, v10

    if-lez v12, :cond_2b

    sput-wide v15, Lchat/ola/vn/c/f;->a:J

    :cond_2b
    invoke-virtual {v9}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v10

    invoke-virtual {v9}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v11

    invoke-static {v10, v11}, Ljava/lang/Math;->max(II)I

    move-result v10

    sget v11, Lchat/ola/vn/e;->c:I

    sget v12, Lchat/ola/vn/e;->d:I

    invoke-static {v11, v12}, Ljava/lang/Math;->max(II)I

    move-result v11

    if-lt v10, v11, :cond_2d

    iput-boolean v4, v6, Lchat/ola/vn/c/f;->o:Z

    goto :goto_17

    :cond_2c
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v10

    invoke-virtual {v10}, Lchat/ola/vn/c/t;->b()V

    :cond_2d
    :goto_17
    iput-object v9, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;
    :try_end_37
    .catch Ljava/lang/Throwable; {:try_start_37 .. :try_end_37} :catch_1e
    .catchall {:try_start_37 .. :try_end_37} :catchall_14

    goto/16 :goto_5

    :catch_1e
    move-exception v0

    move-object v6, v0

    goto/16 :goto_1f

    :cond_2e
    :try_start_38
    const-string v8, "Location"

    invoke-virtual {v7, v8}, Ljava/net/HttpURLConnection;->getHeaderField(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v9

    invoke-virtual {v9, v8, v3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Z)Landroid/graphics/Bitmap;

    move-result-object v9

    if-nez v9, :cond_30

    new-instance v9, Ljava/net/URL;

    invoke-direct {v9, v8}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v9}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v9

    check-cast v9, Ljava/net/HttpURLConnection;
    :try_end_38
    .catch Ljava/lang/Throwable; {:try_start_38 .. :try_end_38} :catch_25
    .catchall {:try_start_38 .. :try_end_38} :catchall_10

    :try_start_39
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->connect()V

    new-instance v10, Ljava/io/BufferedInputStream;

    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v11

    invoke-direct {v10, v11}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_39
    .catch Ljava/lang/Throwable; {:try_start_39 .. :try_end_39} :catch_1f
    .catchall {:try_start_39 .. :try_end_39} :catchall_e

    :try_start_3a
    invoke-static {v10}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v11

    if-eqz v11, :cond_2f

    iput-boolean v4, v6, Lchat/ola/vn/c/f;->o:Z

    goto :goto_18

    :cond_2f
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v12

    invoke-virtual {v12}, Lchat/ola/vn/c/t;->b()V

    :goto_18
    invoke-static {v8, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v8

    iput-object v8, v6, Lchat/ola/vn/c/f;->h:Ljava/lang/String;
    :try_end_3a
    .catch Ljava/lang/Throwable; {:try_start_3a .. :try_end_3a} :catch_26
    .catchall {:try_start_3a .. :try_end_3a} :catchall_d

    move-object v8, v9

    move-object v9, v11

    goto :goto_19

    :catchall_d
    move-exception v0

    move-object v6, v0

    goto :goto_1b

    :catchall_e
    move-exception v0

    move-object v6, v0

    move-object v10, v2

    goto :goto_1b

    :catch_1f
    move-object v10, v2

    goto :goto_1c

    :cond_30
    move-object v8, v2

    move-object v10, v8

    :goto_19
    :try_start_3b
    iput-object v9, v6, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;
    :try_end_3b
    .catch Ljava/lang/Throwable; {:try_start_3b .. :try_end_3b} :catch_21
    .catchall {:try_start_3b .. :try_end_3b} :catchall_f

    :try_start_3c
    invoke-virtual {v8}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_3c
    .catch Ljava/lang/Throwable; {:try_start_3c .. :try_end_3c} :catch_20
    .catchall {:try_start_3c .. :try_end_3c} :catchall_11

    :catch_20
    :goto_1a
    :try_start_3d
    invoke-virtual {v10}, Ljava/io/BufferedInputStream;->close()V
    :try_end_3d
    .catch Ljava/lang/Throwable; {:try_start_3d .. :try_end_3d} :catch_27
    .catchall {:try_start_3d .. :try_end_3d} :catchall_11

    goto :goto_1d

    :catchall_f
    move-exception v0

    move-object v6, v0

    move-object v9, v8

    goto :goto_1b

    :catch_21
    move-object v9, v8

    goto :goto_1c

    :catchall_10
    move-exception v0

    move-object v6, v0

    move-object v9, v2

    move-object v10, v9

    :goto_1b
    :try_start_3e
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_3e
    .catch Ljava/lang/Throwable; {:try_start_3e .. :try_end_3e} :catch_22
    .catchall {:try_start_3e .. :try_end_3e} :catchall_11

    :catch_22
    :try_start_3f
    invoke-virtual {v10}, Ljava/io/BufferedInputStream;->close()V
    :try_end_3f
    .catch Ljava/lang/Throwable; {:try_start_3f .. :try_end_3f} :catch_23
    .catchall {:try_start_3f .. :try_end_3f} :catchall_11

    :catch_23
    :try_start_40
    throw v6
    :try_end_40
    .catch Ljava/lang/Throwable; {:try_start_40 .. :try_end_40} :catch_24
    .catchall {:try_start_40 .. :try_end_40} :catchall_11

    :catch_24
    move-exception v0

    move-object v6, v0

    move-object v8, v10

    goto :goto_1f

    :catch_25
    move-object v9, v2

    move-object v10, v9

    :catch_26
    :goto_1c
    :try_start_41
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_41
    .catch Ljava/lang/Throwable; {:try_start_41 .. :try_end_41} :catch_20
    .catchall {:try_start_41 .. :try_end_41} :catchall_11

    goto :goto_1a

    :catchall_11
    move-exception v0

    move-object v2, v0

    move-object v8, v10

    goto :goto_20

    :catch_27
    :goto_1d
    move-object v8, v10

    goto/16 :goto_5

    :catchall_12
    move-exception v0

    move-object v8, v2

    goto :goto_1e

    :catch_28
    move-exception v0

    move-object v6, v0

    move-object v8, v2

    goto :goto_1f

    :catchall_13
    move-exception v0

    move-object v7, v2

    move-object v8, v7

    :goto_1e
    move-object v2, v0

    goto :goto_20

    :catch_29
    move-exception v0

    move-object v6, v0

    move-object v7, v2

    move-object v8, v7

    :goto_1f
    :try_start_42
    invoke-virtual {v6}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_42
    .catchall {:try_start_42 .. :try_end_42} :catchall_14

    goto/16 :goto_5

    :catchall_14
    move-exception v0

    goto :goto_1e

    :goto_20
    :try_start_43
    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_43
    .catch Ljava/lang/Throwable; {:try_start_43 .. :try_end_43} :catch_2a

    :catch_2a
    :try_start_44
    invoke-virtual {v8}, Ljava/io/BufferedInputStream;->close()V
    :try_end_44
    .catch Ljava/lang/Throwable; {:try_start_44 .. :try_end_44} :catch_2b

    :catch_2b
    :try_start_45
    throw v2
    :try_end_45
    .catch Ljava/lang/Throwable; {:try_start_45 .. :try_end_45} :catch_2d

    :catch_2c
    :cond_31
    :goto_21
    :pswitch_a
    add-int/lit8 v5, v5, 0x1

    goto/16 :goto_0

    :goto_22
    :try_start_46
    monitor-exit v7
    :try_end_46
    .catchall {:try_start_46 .. :try_end_46} :catchall_0

    :try_start_47
    throw v2
    :try_end_47
    .catch Ljava/lang/Throwable; {:try_start_47 .. :try_end_47} :catch_2d

    :cond_32
    return-object v2

    :catchall_15
    move-exception v0

    move-object v3, v0

    :try_start_48
    monitor-exit v2
    :try_end_48
    .catchall {:try_start_48 .. :try_end_48} :catchall_15

    :try_start_49
    throw v3
    :try_end_49
    .catch Ljava/lang/Throwable; {:try_start_49 .. :try_end_49} :catch_2d

    :catch_2d
    :cond_33
    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_a
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected b([Lchat/ola/vn/c/f;)V
    .locals 10

    sget-object v0, Lchat/ola/vn/c/d;->a:Ljava/lang/Integer;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lchat/ola/vn/c/d;->a:Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    sput-object v1, Lchat/ola/vn/c/d;->a:Ljava/lang/Integer;

    sget-object v1, Lchat/ola/vn/c/d;->a:Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const/4 v3, 0x0

    if-gez v1, :cond_0

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    sput-object v1, Lchat/ola/vn/c/d;->a:Ljava/lang/Integer;

    :cond_0
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez p1, :cond_1

    return-void

    :cond_1
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_d

    aget-object v4, p1, v1

    if-nez v4, :cond_2

    goto/16 :goto_6

    :cond_2
    invoke-virtual {v4}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v5

    :try_start_1
    sget-object v6, Lchat/ola/vn/c/d;->b:Ljava/util/Map;

    if-eqz v6, :cond_4

    if-eqz v5, :cond_4

    sget-object v6, Lchat/ola/vn/c/d;->b:Ljava/util/Map;

    monitor-enter v6
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :try_start_2
    iget-boolean v7, v4, Lchat/ola/vn/c/f;->t:Z

    if-nez v7, :cond_3

    sget-object v7, Lchat/ola/vn/c/d;->b:Ljava/util/Map;

    invoke-interface {v7, v5}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    iput-boolean v3, v4, Lchat/ola/vn/c/f;->t:Z

    monitor-exit v6

    goto :goto_1

    :catchall_0
    move-exception v7

    monitor-exit v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    throw v7
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    :catch_0
    :cond_4
    :goto_1
    iget-object v6, v4, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;

    const/4 v7, 0x0

    if-eqz v6, :cond_9

    iget-boolean v6, v4, Lchat/ola/vn/c/f;->n:Z

    if-eqz v6, :cond_7

    if-eqz v5, :cond_7

    iget v6, v4, Lchat/ola/vn/c/f;->e:I

    if-eq v6, v2, :cond_6

    iget v6, v4, Lchat/ola/vn/c/f;->e:I

    const/16 v8, 0x9

    if-ne v6, v8, :cond_5

    goto :goto_2

    :cond_5
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v6

    iget-object v8, v4, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;

    iget-boolean v9, v4, Lchat/ola/vn/c/f;->o:Z

    invoke-virtual {v6, v5, v8, v9}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Landroid/graphics/Bitmap;Z)Lchat/ola/vn/c/a;

    goto :goto_3

    :cond_6
    :goto_2
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v6

    iget-object v8, v4, Lchat/ola/vn/c/f;->q:Landroid/graphics/Bitmap;

    invoke-virtual {v6, v5, v8}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Landroid/graphics/Bitmap;)Lchat/ola/vn/c/a;

    :cond_7
    :goto_3
    iget-object v5, v4, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    if-eqz v5, :cond_8

    iget-object v5, v4, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    invoke-interface {v5, v4}, Lchat/ola/vn/c/g;->a(Lchat/ola/vn/c/f;)V

    :cond_8
    iget-object v5, v4, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    if-eqz v5, :cond_c

    iget-object v5, v4, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_4
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_b

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lchat/ola/vn/c/g;

    invoke-interface {v6, v4}, Lchat/ola/vn/c/g;->a(Lchat/ola/vn/c/f;)V

    goto :goto_4

    :cond_9
    iget-object v5, v4, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    if-eqz v5, :cond_a

    iget-object v5, v4, Lchat/ola/vn/c/f;->r:Lchat/ola/vn/c/g;

    invoke-interface {v5, v4}, Lchat/ola/vn/c/g;->b(Lchat/ola/vn/c/f;)V

    :cond_a
    iget-object v5, v4, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    if-eqz v5, :cond_c

    iget-object v5, v4, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_5
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_b

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lchat/ola/vn/c/g;

    invoke-interface {v6, v4}, Lchat/ola/vn/c/g;->b(Lchat/ola/vn/c/f;)V

    goto :goto_5

    :cond_b
    iget-object v5, v4, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->clear()V

    iput-object v7, v4, Lchat/ola/vn/c/f;->s:Ljava/util/List;

    :cond_c
    :goto_6
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_0

    :cond_d
    return-void

    :catchall_1
    move-exception p1

    :try_start_4
    monitor-exit v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    throw p1
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation build Landroid/annotation/TargetApi;
        value = 0xa
    .end annotation

    check-cast p1, [Lchat/ola/vn/c/f;

    invoke-virtual {p0, p1}, Lchat/ola/vn/c/d;->a([Lchat/ola/vn/c/f;)[Lchat/ola/vn/c/f;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, [Lchat/ola/vn/c/f;

    invoke-virtual {p0, p1}, Lchat/ola/vn/c/d;->b([Lchat/ola/vn/c/f;)V

    return-void
.end method

.method protected synthetic onProgressUpdate([Ljava/lang/Object;)V
    .locals 0

    check-cast p1, [Ljava/lang/Integer;

    invoke-virtual {p0, p1}, Lchat/ola/vn/c/d;->a([Ljava/lang/Integer;)V

    return-void
.end method
