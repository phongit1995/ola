.class public Lchat/ola/vn/util/b/c;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/String;",
        "Ljava/lang/Long;",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field protected a:S

.field protected b:Z

.field private c:Lchat/ola/vn/util/b/a;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    const/4 v0, -0x1

    iput-short v0, p0, Lchat/ola/vn/util/b/c;->a:S

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/util/b/c;->b:Z

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/util/b/c;)Lchat/ola/vn/util/b/a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/util/b/c;->c:Lchat/ola/vn/util/b/a;

    return-object p0
.end method

.method private a(Lchat/ola/vn/entity/i;Z)V
    .locals 13

    const/4 v0, 0x0

    const/4 v1, 0x1

    :try_start_0
    new-instance v2, Ljava/net/URL;

    invoke-static {p1, p2}, Lchat/ola/vn/entity/i;->a(Lchat/ola/vn/entity/i;Z)Ljava/lang/String;

    move-result-object p2

    invoke-direct {v2, p2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object p2

    check-cast p2, Ljava/net/HttpURLConnection;
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_c
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_9
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    const/4 v2, 0x0

    :try_start_1
    invoke-virtual {p2, v2}, Ljava/net/HttpURLConnection;->setInstanceFollowRedirects(Z)V

    invoke-virtual {p2}, Ljava/net/HttpURLConnection;->connect()V

    invoke-virtual {p2}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v3

    const/16 v4, 0x12e

    if-eq v3, v4, :cond_3

    new-instance v3, Ljava/io/BufferedInputStream;

    invoke-virtual {p2}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->i()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v5

    packed-switch v5, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    const-string v4, "mp3"

    goto :goto_0

    :pswitch_1
    const-string v4, "mp4"

    goto :goto_0

    :pswitch_2
    const-string v4, "jpg"

    :cond_0
    :goto_0
    invoke-static {v0, v4}, Lchat/ola/vn/d;->b(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v12

    invoke-virtual {p2}, Ljava/net/HttpURLConnection;->getContentLength()I

    move-result v5

    invoke-static {v12}, Lcom/mg/ola/common/d/c;->h(Ljava/io/File;)J

    move-result-wide v6
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_8
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_4
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    int-to-long v9, v5

    cmp-long v8, v6, v9

    if-nez v8, :cond_1

    if-eqz v5, :cond_1

    :try_start_3
    iput-short v2, p0, Lchat/ola/vn/util/b/c;->a:S

    iget-object v2, p0, Lchat/ola/vn/util/b/c;->c:Lchat/ola/vn/util/b/a;

    invoke-virtual {v12}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v12}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v2, v5, v4, v6}, Lchat/ola/vn/util/b/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/io/FileNotFoundException; {:try_start_3 .. :try_end_3} :catch_8
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :catch_0
    :try_start_4
    invoke-virtual {v3}, Ljava/io/BufferedInputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/io/FileNotFoundException; {:try_start_4 .. :try_end_4} :catch_8
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :catch_1
    :try_start_5
    invoke-virtual {p2}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2
    .catch Ljava/io/FileNotFoundException; {:try_start_5 .. :try_end_5} :catch_8
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    :catch_2
    :cond_1
    const/16 v8, 0x400

    const/4 v11, 0x0

    move-object v5, p0

    move-object v6, v12

    move-object v7, v3

    :try_start_6
    invoke-direct/range {v5 .. v11}, Lchat/ola/vn/util/b/c;->a(Ljava/io/File;Ljava/io/InputStream;IJZ)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v2

    if-eq v2, v1, :cond_2

    const/4 v0, 0x3

    goto :goto_1

    :cond_2
    invoke-virtual {v12}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lchat/ola/vn/d;->c(Ljava/lang/String;Ljava/lang/String;)V

    :goto_1
    new-instance v0, Lchat/ola/vn/util/b/c$3;

    invoke-direct {v0, p0, v12, v4, p1}, Lchat/ola/vn/util/b/c$3;-><init>(Lchat/ola/vn/util/b/c;Ljava/io/File;Ljava/lang/String;Lchat/ola/vn/entity/i;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3
    .catch Ljava/io/FileNotFoundException; {:try_start_6 .. :try_end_6} :catch_8
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    :catch_3
    move-object v0, v3

    goto :goto_2

    :catchall_0
    move-exception p1

    goto :goto_7

    :catch_4
    move-exception p1

    goto :goto_3

    :cond_3
    :try_start_7
    new-instance p1, Lchat/ola/vn/util/b/c$2;

    invoke-direct {p1, p0}, Lchat/ola/vn/util/b/c$2;-><init>(Lchat/ola/vn/util/b/c;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_7
    .catch Ljava/io/FileNotFoundException; {:try_start_7 .. :try_end_7} :catch_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_6
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    :goto_2
    :try_start_8
    invoke-virtual {p2}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_5

    :catch_5
    :try_start_9
    invoke-virtual {v0}, Ljava/io/BufferedInputStream;->close()V
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_e

    return-void

    :catchall_1
    move-exception p1

    move-object v3, v0

    goto :goto_7

    :catch_6
    move-exception p1

    move-object v3, v0

    :goto_3
    move-object v0, p2

    goto :goto_4

    :catch_7
    move-object v3, v0

    :catch_8
    move-object v0, p2

    goto :goto_6

    :catchall_2
    move-exception p1

    move-object p2, v0

    move-object v3, p2

    goto :goto_7

    :catch_9
    move-exception p1

    move-object v3, v0

    :goto_4
    :try_start_a
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    :try_start_b
    iput-short v1, p0, Lchat/ola/vn/util/b/c;->a:S

    iget-object p1, p0, Lchat/ola/vn/util/b/c;->c:Lchat/ola/vn/util/b/a;

    invoke-interface {p1}, Lchat/ola/vn/util/b/a;->a()V
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_a
    .catchall {:try_start_b .. :try_end_b} :catchall_3

    goto :goto_5

    :catch_a
    move-exception p1

    :try_start_c
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_3

    :goto_5
    :try_start_d
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_d
    .catch Ljava/lang/Throwable; {:try_start_d .. :try_end_d} :catch_b

    :catch_b
    :try_start_e
    invoke-virtual {v3}, Ljava/io/BufferedInputStream;->close()V
    :try_end_e
    .catch Ljava/lang/Throwable; {:try_start_e .. :try_end_e} :catch_e

    return-void

    :catchall_3
    move-exception p1

    move-object p2, v0

    goto :goto_7

    :catch_c
    move-object v3, v0

    :goto_6
    :try_start_f
    iput-short v1, p0, Lchat/ola/vn/util/b/c;->a:S

    iget-object p1, p0, Lchat/ola/vn/util/b/c;->c:Lchat/ola/vn/util/b/a;

    invoke-interface {p1}, Lchat/ola/vn/util/b/a;->a()V
    :try_end_f
    .catch Ljava/lang/Throwable; {:try_start_f .. :try_end_f} :catch_d
    .catchall {:try_start_f .. :try_end_f} :catchall_3

    goto :goto_5

    :catch_d
    move-exception p1

    :try_start_10
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_3

    goto :goto_5

    :catch_e
    return-void

    :goto_7
    :try_start_11
    invoke-virtual {p2}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_11
    .catch Ljava/lang/Throwable; {:try_start_11 .. :try_end_11} :catch_f

    :catch_f
    :try_start_12
    invoke-virtual {v3}, Ljava/io/BufferedInputStream;->close()V
    :try_end_12
    .catch Ljava/lang/Throwable; {:try_start_12 .. :try_end_12} :catch_10

    :catch_10
    throw p1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private a(Ljava/io/File;Ljava/io/InputStream;IJZ)V
    .locals 16

    move-object/from16 v1, p0

    move-object/from16 v2, p2

    const/4 v4, 0x0

    move-object/from16 v5, p1

    move/from16 v6, p6

    :try_start_0
    invoke-virtual {v1, v5, v6}, Lchat/ola/vn/util/b/c;->a(Ljava/io/File;Z)Ljava/io/FileOutputStream;

    move-result-object v6
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move/from16 v7, p3

    :try_start_1
    new-array v4, v7, [B

    const-wide/16 v7, 0x0

    if-eqz v2, :cond_3

    :goto_0
    invoke-virtual {v2, v4}, Ljava/io/InputStream;->read([B)I

    move-result v9

    const/4 v10, 0x0

    if-lez v9, :cond_2

    iget-boolean v11, v1, Lchat/ola/vn/util/b/c;->b:Z

    const/4 v12, 0x2

    if-eqz v11, :cond_0

    invoke-static/range {p1 .. p1}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    invoke-static {v6}, Lcom/mg/ola/common/d/e;->a(Ljava/io/OutputStream;)V

    iput-short v12, v1, Lchat/ola/vn/util/b/c;->a:S
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    invoke-static {v6}, Lcom/mg/ola/common/d/e;->a(Ljava/io/OutputStream;)V

    return-void

    :cond_0
    :try_start_2
    iget-object v11, v1, Lchat/ola/vn/util/b/c;->c:Lchat/ola/vn/util/b/a;

    if-eqz v11, :cond_1

    int-to-long v13, v9

    move-object v15, v4

    add-long v3, v7, v13

    new-array v7, v12, [Ljava/lang/Long;

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v8

    aput-object v8, v7, v10

    invoke-static/range {p4 .. p5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v8

    const/4 v11, 0x1

    aput-object v8, v7, v11

    invoke-virtual {v1, v7}, Lchat/ola/vn/util/b/c;->publishProgress([Ljava/lang/Object;)V

    move-wide v7, v3

    move-object v3, v15

    goto :goto_1

    :cond_1
    move-object v3, v4

    :goto_1
    invoke-virtual {v6, v3, v10, v9}, Ljava/io/OutputStream;->write([BII)V

    move-object v4, v3

    goto :goto_0

    :cond_2
    invoke-static {v6}, Lcom/mg/ola/common/d/e;->a(Ljava/io/OutputStream;)V

    iput-short v10, v1, Lchat/ola/vn/util/b/c;->a:S
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :cond_3
    invoke-static {v6}, Lcom/mg/ola/common/d/e;->a(Ljava/io/OutputStream;)V

    return-void

    :catchall_0
    move-exception v0

    move-object v2, v0

    goto :goto_3

    :catch_0
    move-object v4, v6

    goto :goto_2

    :catchall_1
    move-exception v0

    move-object v2, v0

    move-object v6, v4

    goto :goto_3

    :catch_1
    :goto_2
    :try_start_3
    invoke-static/range {p1 .. p1}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    invoke-static {v4}, Lcom/mg/ola/common/d/e;->a(Ljava/io/OutputStream;)V

    const/4 v2, 0x1

    iput-short v2, v1, Lchat/ola/vn/util/b/c;->a:S
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    invoke-static {v4}, Lcom/mg/ola/common/d/e;->a(Ljava/io/OutputStream;)V

    return-void

    :goto_3
    invoke-static {v6}, Lcom/mg/ola/common/d/e;->a(Ljava/io/OutputStream;)V

    throw v2
.end method


# virtual methods
.method public a(Lchat/ola/vn/util/b/a;)Lchat/ola/vn/util/b/c;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/b/c;->c:Lchat/ola/vn/util/b/a;

    return-object p0
.end method

.method public a(Ljava/io/File;Z)Ljava/io/FileOutputStream;
    .locals 2

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance p2, Ljava/io/IOException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "File \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string p1, "\' exists but is a directory"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p2

    :cond_0
    invoke-virtual {p1}, Ljava/io/File;->canWrite()Z

    move-result v0

    if-nez v0, :cond_2

    new-instance p2, Ljava/io/IOException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "File \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string p1, "\' cannot be written to"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p2

    :cond_1
    invoke-virtual {p1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    move-result v1

    if-nez v1, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v1

    if-nez v1, :cond_2

    new-instance p1, Ljava/io/IOException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Directory \'"

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v0, "\' could not be created"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_2
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p1, p2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V

    return-object v0
.end method

.method protected varargs a([Ljava/lang/String;)Ljava/lang/Void;
    .locals 6

    const/4 v0, 0x0

    aget-object p1, p1, v0

    :try_start_0
    new-instance v1, Lchat/ola/vn/entity/i;

    invoke-direct {v1}, Lchat/ola/vn/entity/i;-><init>()V

    invoke-virtual {v1, p1}, Lchat/ola/vn/entity/i;->a(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/entity/i;->j()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Lchat/ola/vn/entity/i;->i()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-virtual {v1}, Lchat/ola/vn/entity/i;->f()S

    move-result v5

    packed-switch v5, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    const-string v4, "mp3"

    goto :goto_0

    :pswitch_1
    const-string v4, "mp4"

    goto :goto_0

    :pswitch_2
    const-string v4, "jpg"

    :cond_0
    :goto_0
    invoke-static {p1, v4}, Lchat/ola/vn/d;->b(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_1

    new-instance v0, Lchat/ola/vn/util/b/c$1;

    invoke-direct {v0, p0, p1, v4}, Lchat/ola/vn/util/b/c$1;-><init>(Lchat/ola/vn/util/b/c;Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    goto :goto_1

    :cond_1
    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-direct {p0, v1, v0}, Lchat/ola/vn/util/b/c;->a(Lchat/ola/vn/entity/i;Z)V

    goto :goto_1

    :cond_2
    const/4 p1, 0x1

    invoke-direct {p0, v1, p1}, Lchat/ola/vn/util/b/c;->a(Lchat/ola/vn/entity/i;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_1
    const/4 p1, 0x0

    return-object p1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/util/b/c;->b:Z

    return-void
.end method

.method protected final a(Ljava/lang/Void;)V
    .locals 0

    return-void
.end method

.method protected varargs a([Ljava/lang/Long;)V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/util/b/c;->c:Lchat/ola/vn/util/b/a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/util/b/c;->c:Lchat/ola/vn/util/b/a;

    const/4 v1, 0x0

    aget-object v1, p1, v1

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    const/4 v3, 0x1

    aget-object p1, p1, v3

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    invoke-interface {v0, v1, v2, v3, v4}, Lchat/ola/vn/util/b/a;->a(JJ)V

    :cond_0
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/util/b/c;->a([Ljava/lang/String;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/util/b/c;->a(Ljava/lang/Void;)V

    return-void
.end method

.method public onPreExecute()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/b/c;->c:Lchat/ola/vn/util/b/a;

    invoke-interface {v0}, Lchat/ola/vn/util/b/a;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected synthetic onProgressUpdate([Ljava/lang/Object;)V
    .locals 0

    check-cast p1, [Ljava/lang/Long;

    invoke-virtual {p0, p1}, Lchat/ola/vn/util/b/c;->a([Ljava/lang/Long;)V

    return-void
.end method
