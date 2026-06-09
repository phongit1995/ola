.class Lchat/ola/vn/u/n;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/f/d;


# instance fields
.field private e:Ljava/io/OutputStream;


# direct methods
.method public constructor <init>(Ljava/io/OutputStream;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/u/n;->e:Ljava/io/OutputStream;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/u/n;->e:Ljava/io/OutputStream;

    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    iput-object v0, p0, Lchat/ola/vn/u/n;->e:Ljava/io/OutputStream;

    throw v1

    :catch_0
    :goto_0
    iput-object v0, p0, Lchat/ola/vn/u/n;->e:Ljava/io/OutputStream;

    return-void
.end method

.method declared-synchronized a(Lchat/ola/vn/w/cg;)V
    .locals 17

    move-object/from16 v1, p0

    monitor-enter p0

    :try_start_0
    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object v2

    const/16 v4, 0x8

    const/16 v5, 0x13

    const/4 v6, 0x7

    const/4 v7, 0x5

    const/4 v8, 0x6

    const/4 v9, 0x3

    const/4 v10, 0x2

    const/4 v11, 0x1

    const/16 v12, 0xa

    const/4 v13, 0x4

    const/4 v14, 0x0

    if-eqz v2, :cond_0

    array-length v15, v2

    add-int/2addr v15, v12

    new-array v15, v15, [B

    array-length v3, v15

    sub-int/2addr v3, v13

    invoke-static {v3}, Lchat/ola/vn/util/e;->a(I)[B

    move-result-object v3

    aget-byte v16, v3, v14

    aput-byte v16, v15, v14

    aget-byte v16, v3, v11

    aput-byte v16, v15, v11

    aget-byte v11, v3, v10

    aput-byte v11, v15, v10

    aget-byte v3, v3, v9

    aput-byte v3, v15, v9

    aput-byte v8, v15, v13

    aput-byte v7, v15, v7

    aput-byte v12, v15, v8

    aput-byte v5, v15, v6

    aput-byte v13, v15, v4

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/w/cg;->b()S

    move-result v3

    int-to-byte v3, v3

    const/16 v4, 0x9

    aput-byte v3, v15, v4

    array-length v3, v2

    invoke-static {v2, v14, v15, v12, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object v2, v1, Lchat/ola/vn/u/n;->e:Ljava/io/OutputStream;

    array-length v3, v15

    invoke-virtual {v2, v15, v14, v3}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_0

    :cond_0
    new-array v2, v12, [B

    array-length v3, v2

    sub-int/2addr v3, v13

    invoke-static {v3}, Lchat/ola/vn/util/e;->a(I)[B

    move-result-object v3

    aget-byte v15, v3, v14

    aput-byte v15, v2, v14

    aget-byte v15, v3, v11

    aput-byte v15, v2, v11

    aget-byte v11, v3, v10

    aput-byte v11, v2, v10

    aget-byte v3, v3, v9

    aput-byte v3, v2, v9

    aput-byte v8, v2, v13

    aput-byte v7, v2, v7

    aput-byte v12, v2, v8

    aput-byte v5, v2, v6

    aput-byte v13, v2, v4

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/w/cg;->b()S

    move-result v3

    int-to-byte v3, v3

    const/16 v4, 0x9

    aput-byte v3, v2, v4

    iget-object v3, v1, Lchat/ola/vn/u/n;->e:Ljava/io/OutputStream;

    array-length v4, v2

    invoke-virtual {v3, v2, v14, v4}, Ljava/io/OutputStream;->write([BII)V

    :goto_0
    iget-object v2, v1, Lchat/ola/vn/u/n;->e:Ljava/io/OutputStream;

    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    move-object v2, v0

    monitor-exit p0

    throw v2
.end method
