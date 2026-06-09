.class public Lchat/ola/vn/w/ce;
.super Ljava/lang/Object;


# instance fields
.field public a:Ljava/io/InputStream;

.field private b:Lchat/ola/vn/p/g;


# direct methods
.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/w/ce;->a:Ljava/io/InputStream;

    return-void
.end method

.method private a([B)I
    .locals 3

    const/4 v0, 0x0

    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/w/ce;->a:Ljava/io/InputStream;

    array-length v2, p1

    sub-int/2addr v2, v0

    invoke-virtual {v1, p1, v0, v2}, Ljava/io/InputStream;->read([BII)I

    move-result v1

    if-gez v1, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    add-int/2addr v0, v1

    goto :goto_0

    :cond_1
    return v0
.end method


# virtual methods
.method public a()Lchat/ola/vn/w/s;
    .locals 15

    new-instance v0, Lchat/ola/vn/w/s;

    invoke-direct {v0}, Lchat/ola/vn/w/s;-><init>()V

    const/4 v1, 0x7

    new-array v1, v1, [B

    invoke-direct {p0, v1}, Lchat/ola/vn/w/ce;->a([B)I

    move-result v2

    const/4 v3, 0x0

    if-gtz v2, :cond_0

    return-object v3

    :cond_0
    const/4 v2, 0x0

    aget-byte v4, v1, v2

    const/4 v5, 0x1

    aget-byte v6, v1, v5

    invoke-static {v4, v6}, Lchat/ola/vn/util/e;->a(BB)I

    move-result v4

    const/4 v6, 0x2

    aget-byte v7, v1, v6

    const/4 v8, 0x3

    aget-byte v9, v1, v8

    const/4 v10, 0x4

    aget-byte v11, v1, v10

    const/4 v12, 0x5

    aget-byte v13, v1, v12

    invoke-static {v7, v9, v11, v13}, Lchat/ola/vn/util/e;->a(BBBB)I

    move-result v7

    iput v7, v0, Lchat/ola/vn/w/s;->a:I

    const/4 v9, 0x6

    aget-byte v1, v1, v9

    invoke-static {v1}, Lchat/ola/vn/util/e;->a(B)I

    move-result v1

    iput v1, v0, Lchat/ola/vn/w/s;->b:I

    if-lez v7, :cond_6

    new-array v1, v4, [Lchat/ola/vn/w/bq;

    const/4 v4, 0x0

    :goto_0
    array-length v7, v1

    if-ge v4, v7, :cond_5

    new-array v7, v12, [B

    invoke-direct {p0, v7}, Lchat/ola/vn/w/ce;->a([B)I

    move-result v9

    if-gez v9, :cond_1

    return-object v3

    :cond_1
    aget-byte v9, v7, v2

    invoke-static {v9}, Lchat/ola/vn/util/e;->a(B)I

    move-result v9

    int-to-short v9, v9

    aget-byte v11, v7, v5

    aget-byte v13, v7, v6

    aget-byte v14, v7, v8

    aget-byte v7, v7, v10

    invoke-static {v11, v13, v14, v7}, Lchat/ola/vn/util/e;->a(BBBB)I

    move-result v7

    if-ltz v7, :cond_4

    const v11, 0xfa000

    if-le v7, v11, :cond_2

    return-object v3

    :cond_2
    new-array v7, v7, [B

    invoke-direct {p0, v7}, Lchat/ola/vn/w/ce;->a([B)I

    move-result v11

    if-gez v11, :cond_3

    return-object v3

    :cond_3
    new-instance v11, Lchat/ola/vn/w/bq;

    invoke-direct {v11}, Lchat/ola/vn/w/bq;-><init>()V

    aput-object v11, v1, v4

    aget-object v11, v1, v4

    iput-short v9, v11, Lchat/ola/vn/w/bq;->a:S

    aget-object v9, v1, v4

    iput-object v7, v9, Lchat/ola/vn/w/bq;->b:[B

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_4
    return-object v3

    :cond_5
    iput-object v1, v0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    :cond_6
    return-object v0
.end method

.method public a(Lchat/ola/vn/p/g;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ce;->b:Lchat/ola/vn/p/g;

    return-void
.end method

.method public b()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/w/ce;->a:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
