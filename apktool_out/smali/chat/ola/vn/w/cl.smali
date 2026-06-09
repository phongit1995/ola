.class public Lchat/ola/vn/w/cl;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private b(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 10

    const/4 p3, 0x7

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0xd1

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object p1

    const/4 v1, 0x0

    aget-byte v2, p1, v1

    invoke-static {v2}, Lchat/ola/vn/util/e;->a(B)I

    move-result v2

    const/4 v3, 0x1

    aget-byte v4, p1, v3

    invoke-static {v4}, Lchat/ola/vn/util/e;->a(B)I

    move-result v4

    const/4 v5, 0x2

    new-array v6, v5, [I

    const/4 v6, 0x5

    const/4 v7, 0x4

    const/4 v8, 0x3

    packed-switch v4, :pswitch_data_0

    return-void

    :pswitch_0
    new-array p3, v5, [I

    aget-byte v4, p1, v5

    aget-byte v5, p1, v8

    invoke-static {v4, v5}, Lchat/ola/vn/util/e;->a(BB)I

    move-result v4

    aput v4, p3, v1

    aget-byte v1, p1, v7

    aget-byte p1, p1, v6

    invoke-static {v1, p1}, Lchat/ola/vn/util/e;->a(BB)I

    move-result p1

    aput p1, p3, v3

    const/4 p1, 0x0

    invoke-interface {p2, v0, v2, p1, p3}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;I[I[I)V

    return-void

    :pswitch_1
    new-array v4, v5, [I

    new-array v9, v5, [I

    aget-byte v5, p1, v5

    aget-byte v8, p1, v8

    invoke-static {v5, v8}, Lchat/ola/vn/util/e;->a(BB)I

    move-result v5

    aput v5, v4, v1

    aget-byte v5, p1, v7

    aget-byte v6, p1, v6

    invoke-static {v5, v6}, Lchat/ola/vn/util/e;->a(BB)I

    move-result v5

    aput v5, v4, v3

    const/4 v5, 0x6

    aget-byte v5, p1, v5

    aget-byte p3, p1, p3

    invoke-static {v5, p3}, Lchat/ola/vn/util/e;->a(BB)I

    move-result p3

    aput p3, v9, v1

    const/16 p3, 0x8

    aget-byte p3, p1, p3

    const/16 v1, 0x9

    aget-byte p1, p1, v1

    invoke-static {p3, p1}, Lchat/ola/vn/util/e;->a(BB)I

    move-result p1

    aput p1, v9, v3

    invoke-interface {p2, v0, v2, v4, v9}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;I[I[I)V

    return-void

    :pswitch_2
    invoke-interface {p2, v0, v2}, Lchat/ola/vn/p/g;->g(Ljava/lang/String;I)V

    return-void

    :pswitch_3
    invoke-interface {p2, v0, v2}, Lchat/ola/vn/p/g;->f(Ljava/lang/String;I)V

    return-void

    :pswitch_4
    invoke-interface {p2, v0, v2}, Lchat/ola/vn/p/g;->e(Ljava/lang/String;I)V

    return-void

    :pswitch_5
    invoke-interface {p2, v0, v2}, Lchat/ola/vn/p/g;->d(Ljava/lang/String;I)V

    return-void

    :pswitch_6
    invoke-interface {p2, v0, v2}, Lchat/ola/vn/p/g;->c(Ljava/lang/String;I)V

    return-void

    :pswitch_7
    invoke-interface {p2, v0, v2}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;I)V

    return-void

    :pswitch_8
    invoke-interface {p2, v0, v2}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;I)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 1

    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    const/4 v0, 0x7

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p1, p1, Lchat/ola/vn/w/bk;->ap:[B

    const/16 p3, 0xd1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(S[B)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 12

    const/4 v0, 0x7

    :try_start_0
    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 v0, 0xd1

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object v0

    const/4 v1, 0x0

    aget-byte v3, v0, v1

    const/16 v4, 0x2d

    const/4 v5, 0x3

    const/4 v6, 0x2

    const/4 v7, 0x1

    packed-switch v3, :pswitch_data_0

    return-void

    :pswitch_0
    aget-byte v3, v0, v7
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    if-nez v3, :cond_0

    const/4 v3, 0x0

    :try_start_1
    aget-byte v8, v0, v6

    aget-byte v5, v0, v5

    invoke-static {v8, v5}, Lchat/ola/vn/util/e;->a(BB)I

    move-result v5

    int-to-short v5, v5

    array-length v8, v0

    const/4 v9, 0x4

    sub-int/2addr v8, v9

    new-array v8, v8, [B

    array-length v10, v8

    invoke-static {v0, v9, v8, v1, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-virtual {p1, v4, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short p1, p1

    new-instance v0, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->m()Ljava/io/File;

    move-result-object v4

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, ".snap."

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v10, "."

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v10

    invoke-virtual {v9, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v10, ".tmp"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v0, v4, v9}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    invoke-virtual {v4, v8}, Ljava/io/FileOutputStream;->write([B)V

    iget-object p3, p3, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-static {v2, p3, v1, p1, v7}, Lchat/ola/vn/message/e;->a(Ljava/lang/String;Ljava/lang/String;SSB)Lchat/ola/vn/message/t;

    move-result-object p1

    invoke-virtual {p1, v6}, Lchat/ola/vn/message/t;->a(B)V

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1, p3, v5}, Lchat/ola/vn/message/t;->a(Ljava/lang/String;S)V

    invoke-interface {p2, p1}, Lchat/ola/vn/p/g;->a(Lchat/ola/vn/message/t;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    return-void

    :catchall_0
    move-exception p1

    move-object v3, v4

    goto :goto_0

    :catch_0
    move-object v3, v4

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
    array-length p1, v0

    sub-int/2addr p1, v7

    new-array p1, p1, [B

    array-length p3, p1

    invoke-static {v0, v7, p1, v1, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-static {p1}, Lchat/ola/vn/util/m;->a([B)Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, v2, p1}, Lchat/ola/vn/p/g;->j(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :pswitch_2
    array-length p3, v0

    sub-int/2addr p3, v7

    new-array p3, p3, [B

    array-length v3, p3

    invoke-static {v0, v7, p3, v1, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-static {p3}, Lchat/ola/vn/util/m;->a([B)Ljava/lang/String;

    move-result-object p3

    const-string v0, "x"

    invoke-virtual {p3, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1, v4, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short p1, p1

    aget-object v0, p3, v1

    aget-object p3, p3, v7

    invoke-interface {p2, v2, p1, v0, p3}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;SLjava/lang/String;Ljava/lang/String;)V

    return-void

    :pswitch_3
    aget-byte p3, v0, v7

    int-to-short p3, p3

    aget-byte v3, v0, v6

    int-to-short v6, v3

    array-length v3, v0

    sub-int/2addr v3, v5

    new-array v3, v3, [B

    array-length v7, v3

    invoke-static {v0, v5, v3, v1, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-virtual {p1, v4, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short p1, p1

    new-instance v0, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->l()Ljava/io/File;

    move-result-object v1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, ".voice."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    invoke-virtual {v4, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v5, ".tmp"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v0, v1, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-virtual {v1, v3}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    move-object v1, p2

    move v3, p1

    move v5, v6

    move v6, p3

    invoke-interface/range {v1 .. v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;SLjava/lang/String;SS)V

    return-void

    :pswitch_4
    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/w/cl;->b(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    :catch_3
    :cond_0
    :pswitch_5
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_5
        :pswitch_0
    .end packed-switch
.end method
