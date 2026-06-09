.class public Lchat/ola/vn/w/s;
.super Ljava/lang/Object;


# instance fields
.field public a:I

.field public b:I

.field public c:[Lchat/ola/vn/w/bq;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a([BB)B
    .locals 0

    if-nez p1, :cond_0

    return p2

    :cond_0
    const/4 p2, 0x0

    aget-byte p1, p1, p2

    return p1
.end method

.method private a([BI)I
    .locals 1

    if-nez p1, :cond_0

    return p2

    :cond_0
    array-length p2, p1

    const/4 v0, 0x1

    if-ne p2, v0, :cond_1

    const/4 p2, 0x0

    aget-byte p1, p1, p2

    invoke-static {p1}, Lchat/ola/vn/util/e;->a(B)I

    move-result p1

    return p1

    :cond_1
    array-length p2, p1

    const/4 v0, 0x2

    if-ne p2, v0, :cond_2

    invoke-static {p1}, Lchat/ola/vn/util/e;->a([B)I

    move-result p1

    return p1

    :cond_2
    array-length p2, p1

    const/4 v0, 0x3

    if-ne p2, v0, :cond_3

    invoke-static {p1}, Lchat/ola/vn/util/e;->b([B)I

    move-result p1

    return p1

    :cond_3
    invoke-static {p1}, Lchat/ola/vn/util/e;->c([B)I

    move-result p1

    return p1
.end method

.method private a([BJ)J
    .locals 0

    if-nez p1, :cond_0

    return-wide p2

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/util/e;->d([B)J

    move-result-wide p1

    return-wide p1
.end method

.method public static a(Lchat/ola/vn/w/s;Ljava/lang/String;)Ljava/util/List;
    .locals 20
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/w/s;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    move-object/from16 v6, p0

    const/4 v7, 0x7

    invoke-virtual {v6, v7}, Lchat/ola/vn/w/s;->c(S)I

    move-result v8

    if-lez v8, :cond_3

    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9, v8}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v10, 0x0

    invoke-virtual {v6, v7, v10}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v0

    move v12, v0

    const/4 v11, 0x0

    :goto_0
    if-ge v11, v8, :cond_4

    invoke-virtual {v6, v7, v12}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v13

    invoke-virtual {v6, v12}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    new-instance v14, Lchat/ola/vn/message/f;

    invoke-direct {v14, v0, v10}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    const/16 v1, 0x16

    invoke-virtual {v6, v1, v12, v13}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    const/16 v15, 0x56

    invoke-virtual {v6, v15, v12, v13}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    move-object v0, v1

    :goto_1
    invoke-virtual {v14, v0}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;)V

    const/4 v4, -0x1

    const/16 v1, 0x3a

    const-wide/16 v16, 0x0

    move-object v0, v6

    move v2, v12

    move v3, v13

    const/4 v7, -0x1

    move-wide/from16 v4, v16

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v4

    const/16 v1, 0x82

    move-wide/from16 v18, v4

    move-wide/from16 v4, v16

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v0

    const/16 v2, 0xc

    invoke-virtual {v6, v2, v12, v13}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v2

    if-ltz v2, :cond_1

    invoke-virtual {v6, v2, v10}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v2

    int-to-short v2, v2

    const/16 v3, 0x2d

    invoke-virtual {v6, v3, v12, v13, v10}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v3

    int-to-short v3, v3

    const/16 v4, 0x26

    invoke-virtual {v6, v4, v12, v13, v7}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v4

    int-to-short v4, v4

    goto :goto_2

    :cond_1
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, -0x1

    :goto_2
    const/16 v5, 0xd

    invoke-virtual {v6, v5, v12, v13}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v6, v15, v12, v13}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v14, v3}, Lchat/ola/vn/message/f;->e(S)V

    invoke-virtual {v14, v7}, Lchat/ola/vn/message/f;->f(Ljava/lang/String;)V

    invoke-virtual {v14, v4}, Lchat/ola/vn/message/f;->c(S)V

    invoke-virtual {v14, v2}, Lchat/ola/vn/message/f;->b(S)V

    invoke-virtual {v14, v5}, Lchat/ola/vn/message/f;->e(Ljava/lang/String;)V

    move-wide/from16 v2, v18

    invoke-virtual {v14, v2, v3}, Lchat/ola/vn/message/f;->c(J)V

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-lez v4, :cond_2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sub-long v4, v2, v0

    iput-wide v4, v14, Lchat/ola/vn/message/f;->N:J

    :cond_2
    invoke-interface {v9, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v11, v11, 0x1

    move v12, v13

    const/4 v7, 0x7

    goto/16 :goto_0

    :cond_3
    const/4 v9, 0x0

    :cond_4
    new-instance v0, Lchat/ola/vn/e/f;

    invoke-direct {v0}, Lchat/ola/vn/e/f;-><init>()V

    invoke-static {v9, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    return-object v9
.end method


# virtual methods
.method public a(IB)B
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/w/s;->b(I)[B

    move-result-object p1

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/w/s;->a([BB)B

    move-result p1

    return p1
.end method

.method public a(IS)B
    .locals 0

    int-to-byte p2, p2

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/w/s;->a(IB)B

    move-result p1

    return p1
.end method

.method public a(SIIB)B
    .locals 0

    invoke-virtual {p0, p1, p2, p3}, Lchat/ola/vn/w/s;->a(SII)I

    move-result p1

    if-ltz p1, :cond_0

    invoke-virtual {p0, p1, p4}, Lchat/ola/vn/w/s;->a(IB)B

    move-result p1

    return p1

    :cond_0
    return p4
.end method

.method public a(SIIS)B
    .locals 0

    int-to-byte p4, p4

    invoke-virtual {p0, p1, p2, p3, p4}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result p1

    return p1
.end method

.method public a()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v0, v0

    return v0
.end method

.method public a(II)I
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/w/s;->b(I)[B

    move-result-object p1

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/w/s;->a([BI)I

    move-result p1

    return p1
.end method

.method public a(SI)I
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    const/4 v1, -0x1

    if-nez v0, :cond_0

    return v1

    :cond_0
    if-gez p2, :cond_1

    const/4 p2, -0x1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v0, v0

    if-lt p2, v0, :cond_2

    iget-object p2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length p2, p2

    add-int/lit8 p2, p2, -0x1

    :cond_2
    :goto_0
    add-int/lit8 p2, p2, 0x1

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v0, v0

    if-ge p2, v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object v0, v0, p2

    iget-short v0, v0, Lchat/ola/vn/w/bq;->a:S

    if-ne v0, p1, :cond_3

    return p2

    :cond_3
    goto :goto_0

    :cond_4
    return v1
.end method

.method public a(SII)I
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    const/4 v1, -0x1

    if-nez v0, :cond_0

    return v1

    :cond_0
    if-gez p2, :cond_1

    const/4 p2, -0x1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v0, v0

    if-lt p2, v0, :cond_2

    iget-object p2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length p2, p2

    add-int/lit8 p2, p2, -0x1

    :cond_2
    :goto_0
    if-gez p3, :cond_3

    iget-object p3, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length p3, p3

    :cond_3
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_4

    return v1

    :cond_4
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v0, v0

    if-ge p2, v0, :cond_6

    if-ge p2, p3, :cond_6

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object v0, v0, p2

    iget-short v0, v0, Lchat/ola/vn/w/bq;->a:S

    if-ne v0, p1, :cond_5

    return p2

    :cond_5
    add-int/lit8 p2, p2, 0x1

    goto :goto_1

    :cond_6
    return v1
.end method

.method public a(SIII)I
    .locals 0

    invoke-virtual {p0, p1, p2, p3}, Lchat/ola/vn/w/s;->a(SII)I

    move-result p1

    if-ltz p1, :cond_0

    invoke-virtual {p0, p1, p4}, Lchat/ola/vn/w/s;->a(II)I

    move-result p1

    return p1

    :cond_0
    return p4
.end method

.method public a(IJ)J
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/w/s;->b(I)[B

    move-result-object p1

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/w/s;->a([BJ)J

    move-result-wide p1

    return-wide p1
.end method

.method public a(SIIJ)J
    .locals 0

    invoke-virtual {p0, p1, p2, p3}, Lchat/ola/vn/w/s;->a(SII)I

    move-result p1

    if-ltz p1, :cond_0

    invoke-virtual {p0, p1, p4, p5}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide p1

    return-wide p1

    :cond_0
    return-wide p4
.end method

.method public a(I)Ljava/lang/Short;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    if-eqz v0, :cond_1

    if-ltz p1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v0, v0

    if-lt p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object p1, v0, p1

    iget-short p1, p1, Lchat/ola/vn/w/bq;->a:S

    invoke-static {p1}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p1

    return-object p1

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(S[B)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-nez v0, :cond_0

    new-array v0, v1, [Lchat/ola/vn/w/bq;

    iput-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    new-instance v1, Lchat/ola/vn/w/bq;

    invoke-direct {v1}, Lchat/ola/vn/w/bq;-><init>()V

    aput-object v1, v0, v2

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object v0, v0, v2

    iput-short p1, v0, Lchat/ola/vn/w/bq;->a:S

    iget-object p1, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object p1, p1, v2

    iput-object p2, p1, Lchat/ola/vn/w/bq;->b:[B

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v0, v0

    add-int/2addr v0, v1

    new-array v0, v0, [Lchat/ola/vn/w/bq;

    new-instance v3, Lchat/ola/vn/w/bq;

    invoke-direct {v3}, Lchat/ola/vn/w/bq;-><init>()V

    aput-object v3, v0, v2

    aget-object v3, v0, v2

    iput-short p1, v3, Lchat/ola/vn/w/bq;->a:S

    aget-object p1, v0, v2

    iput-object p2, p1, Lchat/ola/vn/w/bq;->b:[B

    iget-object p1, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    iget-object p2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length p2, p2

    invoke-static {p1, v2, v0, v1, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iput-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    return-void
.end method

.method public a(S)[B
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v2, v2

    if-ge v0, v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object v2, v2, v0

    iget-short v2, v2, Lchat/ola/vn/w/bq;->a:S

    if-ne v2, p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object p1, p1, v0

    iget-object p1, p1, Lchat/ola/vn/w/bq;->b:[B

    return-object p1

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    return-object v1
.end method

.method public b(SI)I
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    const/4 v1, -0x1

    if-nez v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v2, v2

    if-ge v0, v2, :cond_3

    iget-object v2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object v2, v2, v0

    iget-short v2, v2, Lchat/ola/vn/w/bq;->a:S

    if-ne v2, p1, :cond_2

    if-nez p2, :cond_1

    return v0

    :cond_1
    add-int/lit8 p2, p2, -0x1

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    return v1
.end method

.method public b(S)Ljava/lang/String;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/o;->a([B)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public b(SII)Ljava/lang/String;
    .locals 0

    invoke-virtual {p0, p1, p2, p3}, Lchat/ola/vn/w/s;->a(SII)I

    move-result p1

    if-ltz p1, :cond_0

    invoke-virtual {p0, p1}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public b(I)[B
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    if-eqz v0, :cond_1

    if-ltz p1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v0, v0

    if-lt p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object p1, v0, p1

    iget-object p1, p1, Lchat/ola/vn/w/bq;->b:[B

    return-object p1

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public c(S)I
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v2, v2

    if-ge v1, v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object v2, v2, v1

    iget-short v2, v2, Lchat/ola/vn/w/bq;->a:S

    if-ne v2, p1, :cond_1

    add-int/lit8 v0, v0, 0x1

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    return v0
.end method

.method public c(I)Ljava/lang/String;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/w/s;->b(I)[B

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/o;->a([B)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public d(S)Z
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v2, v2

    if-ge v0, v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object v2, v2, v0

    iget-short v2, v2, Lchat/ola/vn/w/bq;->a:S

    if-ne v2, p1, :cond_1

    const/4 p1, 0x1

    return p1

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    const-string v0, ""

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "[Service]: "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v0, p0, Lchat/ola/vn/w/s;->b:I

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, " [Length]: "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v0, p0, Lchat/ola/vn/w/s;->a:I

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, " [Number Of Keys]: "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v0, v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const-string v0, "Null"

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    if-eqz v1, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "\n"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    :goto_1
    iget-object v2, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    array-length v2, v2

    if-ge v1, v2, :cond_1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " [Key]: "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object v0, v0, v1

    iget-short v0, v0, Lchat/ola/vn/w/bq;->a:S

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, " [Value length]: "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/w/s;->c:[Lchat/ola/vn/w/bq;

    aget-object v0, v0, v1

    iget-object v0, v0, Lchat/ola/vn/w/bq;->b:[B

    array-length v0, v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    return-object v0
.end method
