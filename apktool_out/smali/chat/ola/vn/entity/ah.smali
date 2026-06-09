.class public Lchat/ola/vn/entity/ah;
.super Ljava/lang/Object;


# static fields
.field private static a:[B


# instance fields
.field private b:[B

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:I

.field private f:Z

.field private g:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/16 v0, 0x8

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    sput-object v0, Lchat/ola/vn/entity/ah;->a:[B

    return-void

    :array_0
    .array-data 1
        -0x77t
        0x50t
        0x4et
        0x47t
        0xdt
        0xat
        0x1at
        0xat
    .end array-data
.end method

.method public constructor <init>(I)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/entity/ah;-><init>(I[B)V

    return-void
.end method

.method public constructor <init>(I[B)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entity/ah;->b:[B

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/entity/ah;->g:Z

    iput p1, p0, Lchat/ola/vn/entity/ah;->e:I

    iput-object p2, p0, Lchat/ola/vn/entity/ah;->b:[B

    return-void
.end method

.method public static b([B)Ljava/util/List;
    .locals 30
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p0

    const/4 v1, 0x0

    aget-byte v2, v0, v1

    const/4 v3, 0x1

    aget-byte v4, v0, v3

    invoke-static {v2, v4}, Lchat/ola/vn/util/e;->a(BB)I

    move-result v2

    if-lez v2, :cond_2

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5, v2}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v6, 0x2

    const/4 v7, 0x0

    const/4 v8, 0x2

    :goto_0
    if-ge v7, v2, :cond_3

    add-int/lit8 v9, v8, 0x1

    aget-byte v8, v0, v8

    add-int/lit8 v10, v9, 0x1

    aget-byte v9, v0, v9

    invoke-static {v8, v9}, Lchat/ola/vn/util/e;->a(BB)I

    move-result v8

    int-to-short v8, v8

    add-int/lit8 v9, v10, 0x1

    aget-byte v10, v0, v10

    add-int/lit8 v11, v9, 0x1

    aget-byte v9, v0, v9

    add-int/lit8 v12, v11, 0x1

    aget-byte v11, v0, v11

    add-int/lit8 v13, v12, 0x1

    aget-byte v12, v0, v12

    invoke-static {v10, v9, v11, v12}, Lchat/ola/vn/util/e;->a(BBBB)I

    move-result v9

    if-lez v9, :cond_0

    invoke-static {v0, v13, v9}, Lchat/ola/vn/util/o;->a([BII)Ljava/lang/String;

    move-result-object v10

    add-int/2addr v13, v9

    goto :goto_1

    :cond_0
    const/4 v10, 0x0

    :goto_1
    new-instance v9, Lchat/ola/vn/entity/ah;

    invoke-direct {v9, v8}, Lchat/ola/vn/entity/ah;-><init>(I)V

    invoke-virtual {v9, v10}, Lchat/ola/vn/entity/ah;->a(Ljava/lang/String;)V

    add-int/lit8 v8, v13, 0x1

    aget-byte v10, v0, v13

    add-int/lit8 v11, v8, 0x1

    aget-byte v8, v0, v8

    add-int/lit8 v12, v11, 0x1

    aget-byte v11, v0, v11

    add-int/lit8 v13, v12, 0x1

    aget-byte v12, v0, v12

    invoke-static {v10, v8, v11, v12}, Lchat/ola/vn/util/e;->a(BBBB)I

    move-result v8

    if-lez v8, :cond_1

    add-int/lit8 v10, v13, -0x1

    aget-byte v11, v0, v10

    add-int/lit8 v12, v13, -0x2

    aget-byte v14, v0, v12

    add-int/lit8 v15, v13, -0x3

    aget-byte v16, v0, v15

    add-int/lit8 v17, v13, -0x4

    aget-byte v18, v0, v17

    add-int/lit8 v19, v13, -0x5

    aget-byte v20, v0, v19

    add-int/lit8 v21, v13, -0x6

    aget-byte v22, v0, v21

    add-int/lit8 v23, v13, -0x7

    aget-byte v24, v0, v23

    add-int/lit8 v25, v13, -0x8

    aget-byte v26, v0, v25

    sget-object v4, Lchat/ola/vn/entity/ah;->a:[B

    array-length v4, v4

    add-int/2addr v4, v8

    new-array v4, v4, [B

    sget-object v27, Lchat/ola/vn/entity/ah;->a:[B

    const/16 v28, 0x7

    aget-byte v27, v27, v28

    aput-byte v27, v0, v10

    sget-object v27, Lchat/ola/vn/entity/ah;->a:[B

    const/16 v28, 0x6

    aget-byte v27, v27, v28

    aput-byte v27, v0, v12

    sget-object v27, Lchat/ola/vn/entity/ah;->a:[B

    const/16 v28, 0x5

    aget-byte v27, v27, v28

    aput-byte v27, v0, v15

    sget-object v27, Lchat/ola/vn/entity/ah;->a:[B

    const/16 v28, 0x4

    aget-byte v27, v27, v28

    aput-byte v27, v0, v17

    sget-object v27, Lchat/ola/vn/entity/ah;->a:[B

    const/16 v28, 0x3

    aget-byte v27, v27, v28

    aput-byte v27, v0, v19

    sget-object v27, Lchat/ola/vn/entity/ah;->a:[B

    aget-byte v27, v27, v6

    aput-byte v27, v0, v21

    sget-object v27, Lchat/ola/vn/entity/ah;->a:[B

    aget-byte v27, v27, v3

    aput-byte v27, v0, v23

    sget-object v27, Lchat/ola/vn/entity/ah;->a:[B

    aget-byte v27, v27, v1

    aput-byte v27, v0, v25

    sget-object v3, Lchat/ola/vn/entity/ah;->a:[B

    array-length v3, v3

    sub-int v3, v13, v3

    sget-object v6, Lchat/ola/vn/entity/ah;->a:[B

    array-length v6, v6

    add-int/2addr v6, v8

    invoke-static {v0, v3, v4, v1, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    aput-byte v11, v0, v10

    aput-byte v14, v0, v12

    aput-byte v16, v0, v15

    aput-byte v18, v0, v17

    aput-byte v20, v0, v19

    aput-byte v22, v0, v21

    aput-byte v24, v0, v23

    aput-byte v26, v0, v25

    add-int/2addr v13, v8

    invoke-virtual {v9, v4}, Lchat/ola/vn/entity/ah;->a([B)V

    :cond_1
    move v8, v13

    invoke-interface {v5, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v7, v7, 0x1

    const/4 v3, 0x1

    const/4 v6, 0x2

    goto/16 :goto_0

    :cond_2
    const/4 v5, 0x0

    :cond_3
    return-object v5
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ah;->c:Ljava/lang/String;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entity/ah;->f:Z

    return-void
.end method

.method public a([B)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ah;->b:[B

    return-void
.end method

.method public b()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/ah;->e:I

    return v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ah;->d:Ljava/lang/String;

    return-void
.end method

.method public b(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entity/ah;->g:Z

    return-void
.end method

.method public c()[B
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/ah;->b:[B

    return-object v0
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/ah;->c:Ljava/lang/String;

    return-object v0
.end method

.method public e()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/ah;->d:Ljava/lang/String;

    return-object v0
.end method

.method public f()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entity/ah;->f:Z

    return v0
.end method

.method public g()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entity/ah;->g:Z

    return v0
.end method
