.class public Lchat/ola/vn/w/ck;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 1

    iget-object p3, p1, Lchat/ola/vn/w/bk;->w:Ljava/lang/String;

    const/16 v0, 0x81

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p1, p1, Lchat/ola/vn/w/bk;->ap:[B

    const/16 p3, 0xd1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(S[B)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 11

    const/4 p3, 0x7

    :try_start_0
    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/16 p3, 0x81

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 p3, 0xd1

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object p3

    const/4 v0, 0x0

    aget-byte v3, p3, v0

    const/16 v4, 0x2d

    const/4 v5, 0x3

    const/4 v6, 0x2

    const/4 v7, 0x1

    packed-switch v3, :pswitch_data_0

    return-void

    :pswitch_0
    aget-byte v3, p3, v7
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    if-nez v3, :cond_0

    const/4 v3, 0x0

    :try_start_1
    aget-byte v8, p3, v6

    aget-byte v5, p3, v5

    invoke-static {v8, v5}, Lchat/ola/vn/util/e;->a(BB)I

    move-result v5

    int-to-short v5, v5

    array-length v8, p3

    const/4 v9, 0x4

    sub-int/2addr v8, v9

    new-array v8, v8, [B

    array-length v10, v8

    invoke-static {p3, v9, v8, v0, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-virtual {p1, v4, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result p3

    invoke-virtual {p1, p3, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short p1, p1

    new-instance p3, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->m()Ljava/io/File;

    move-result-object v0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, ".snap.group."

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v9, "."

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v9, "."

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    invoke-virtual {v4, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v9, ".tmp"

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p3, v0, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    invoke-virtual {v0, v8}, Ljava/io/FileOutputStream;->write([B)V

    invoke-static {v1, v2, v6, p1, v7}, Lchat/ola/vn/message/e;->a(Ljava/lang/String;Ljava/lang/String;SSB)Lchat/ola/vn/message/t;

    move-result-object p1

    invoke-virtual {p1, v6}, Lchat/ola/vn/message/t;->a(B)V

    invoke-virtual {p3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1, p3, v5}, Lchat/ola/vn/message/t;->a(Ljava/lang/String;S)V

    invoke-interface {p2, p1}, Lchat/ola/vn/p/g;->b(Lchat/ola/vn/message/t;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    return-void

    :catchall_0
    move-exception p1

    move-object v3, v0

    goto :goto_0

    :catch_0
    move-object v3, v0

    goto :goto_1

    :catchall_1
    move-exception p1

    :goto_0
    :try_start_4
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    :catch_1
    :try_start_5
    throw p1

    :catch_2
    :goto_1
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V

    return-void

    :pswitch_1
    array-length v3, p3

    sub-int/2addr v3, v7

    new-array v3, v3, [B

    array-length v5, v3

    invoke-static {p3, v7, v3, v0, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-static {v3}, Lchat/ola/vn/util/m;->a([B)Ljava/lang/String;

    move-result-object p3

    const-string v3, "x"

    invoke-virtual {p3, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1, v4, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    invoke-virtual {p1, v3, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short v3, p1

    aget-object v4, p3, v0

    aget-object v5, p3, v7

    move-object v0, p2

    invoke-interface/range {v0 .. v5}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;Ljava/lang/String;)V

    return-void

    :pswitch_2
    aget-byte v3, p3, v7

    int-to-short v7, v3

    aget-byte v3, p3, v6

    int-to-short v6, v3

    array-length v3, p3

    sub-int/2addr v3, v5

    new-array v3, v3, [B

    array-length v8, v3

    invoke-static {p3, v5, v3, v0, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-virtual {p1, v4, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result p3

    invoke-virtual {p1, p3, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short p1, p1

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, ".voice.group."

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "."

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {p3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    const-string v0, ".tmp"

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v4

    invoke-static {p3, v0, v4}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;

    move-result-object p3

    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-virtual {v0, v3}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V

    invoke-virtual {p3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    move-object v0, p2

    move v3, p1

    move v5, v6

    move v6, v7

    invoke-interface/range {v0 .. v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;SS)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    :catch_3
    :cond_0
    :pswitch_3
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_2
        :pswitch_1
        :pswitch_3
        :pswitch_3
        :pswitch_0
    .end packed-switch
.end method
