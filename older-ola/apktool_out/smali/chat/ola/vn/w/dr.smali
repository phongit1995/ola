.class Lchat/ola/vn/w/dr;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/f/d;


# instance fields
.field private e:Ljava/io/OutputStream;

.field private f:Lchat/ola/vn/p/g;

.field private g:Lchat/ola/vn/w/ci;


# direct methods
.method public constructor <init>(Ljava/io/OutputStream;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/w/dr;->e:Ljava/io/OutputStream;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/w/dr;->f:Lchat/ola/vn/p/g;

    iput-object v0, p0, Lchat/ola/vn/w/dr;->g:Lchat/ola/vn/w/ci;

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/w/dr;->e:Ljava/io/OutputStream;

    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    iput-object v0, p0, Lchat/ola/vn/w/dr;->e:Ljava/io/OutputStream;

    throw v1

    :catch_0
    :goto_0
    iput-object v0, p0, Lchat/ola/vn/w/dr;->e:Ljava/io/OutputStream;

    return-void
.end method

.method public a(Lchat/ola/vn/p/g;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/dr;->f:Lchat/ola/vn/p/g;

    return-void
.end method

.method declared-synchronized a(Lchat/ola/vn/w/cg;Z)V
    .locals 17

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    monitor-enter p0

    const/4 v3, 0x2

    if-nez p2, :cond_2

    :try_start_0
    iget-boolean v4, v2, Lchat/ola/vn/w/cg;->a:Z

    if-eqz v4, :cond_2

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v4

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_1

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v2, v3, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v4, 0x87

    invoke-virtual {v2, v4, v5}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    goto :goto_1

    :cond_1
    :goto_0
    new-instance v2, Ljava/io/IOException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Blank Working session and username: "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " - Working session: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    :catchall_0
    move-exception v0

    move-object v2, v0

    goto/16 :goto_3

    :cond_2
    :goto_1
    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object v4

    const/16 v7, 0x13

    const/4 v8, 0x7

    const/4 v9, 0x5

    const/4 v10, 0x6

    const/4 v11, 0x3

    const/4 v12, 0x1

    const/16 v13, 0xa

    const/4 v14, 0x4

    const/4 v15, 0x0

    if-eqz v4, :cond_3

    array-length v5, v4

    add-int/2addr v5, v13

    new-array v5, v5, [B

    array-length v6, v5

    sub-int/2addr v6, v14

    invoke-static {v6}, Lchat/ola/vn/util/e;->a(I)[B

    move-result-object v6

    aget-byte v16, v6, v15

    aput-byte v16, v5, v15

    aget-byte v16, v6, v12

    aput-byte v16, v5, v12

    aget-byte v12, v6, v3

    aput-byte v12, v5, v3

    aget-byte v3, v6, v11

    aput-byte v3, v5, v11

    aput-byte v10, v5, v14

    aput-byte v9, v5, v9

    aput-byte v13, v5, v10

    aput-byte v7, v5, v8

    const/16 v3, 0x8

    aput-byte v14, v5, v3

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/w/cg;->b()S

    move-result v2

    int-to-byte v2, v2

    const/16 v3, 0x9

    aput-byte v2, v5, v3

    array-length v2, v4

    invoke-static {v4, v15, v5, v13, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object v2, v1, Lchat/ola/vn/w/dr;->e:Ljava/io/OutputStream;

    array-length v3, v5

    invoke-virtual {v2, v5, v15, v3}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_2

    :cond_3
    new-array v4, v13, [B

    array-length v5, v4

    sub-int/2addr v5, v14

    invoke-static {v5}, Lchat/ola/vn/util/e;->a(I)[B

    move-result-object v5

    aget-byte v6, v5, v15

    aput-byte v6, v4, v15

    aget-byte v6, v5, v12

    aput-byte v6, v4, v12

    aget-byte v6, v5, v3

    aput-byte v6, v4, v3

    aget-byte v3, v5, v11

    aput-byte v3, v4, v11

    aput-byte v10, v4, v14

    aput-byte v9, v4, v9

    aput-byte v13, v4, v10

    aput-byte v7, v4, v8

    const/16 v3, 0x8

    aput-byte v14, v4, v3

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/w/cg;->b()S

    move-result v2

    int-to-byte v2, v2

    const/16 v3, 0x9

    aput-byte v2, v4, v3

    iget-object v2, v1, Lchat/ola/vn/w/dr;->e:Ljava/io/OutputStream;

    array-length v3, v4

    invoke-virtual {v2, v4, v15, v3}, Ljava/io/OutputStream;->write([BII)V

    :goto_2
    iget-object v2, v1, Lchat/ola/vn/w/dr;->e:Ljava/io/OutputStream;

    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :goto_3
    monitor-exit p0

    throw v2
.end method

.method public a(Lchat/ola/vn/w/ci;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/dr;->g:Lchat/ola/vn/w/ci;

    return-void
.end method
