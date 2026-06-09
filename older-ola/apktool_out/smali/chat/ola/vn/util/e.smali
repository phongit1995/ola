.class public Lchat/ola/vn/util/e;
.super Ljava/lang/Object;


# direct methods
.method public static a(B)I
    .locals 0

    and-int/lit16 p0, p0, 0xff

    return p0
.end method

.method public static a(BB)I
    .locals 0

    and-int/lit16 p0, p0, 0xff

    shl-int/lit8 p0, p0, 0x8

    and-int/lit16 p1, p1, 0xff

    add-int/2addr p0, p1

    return p0
.end method

.method public static a(BBB)I
    .locals 0

    and-int/lit16 p0, p0, 0xff

    shl-int/lit8 p0, p0, 0x10

    and-int/lit16 p1, p1, 0xff

    shl-int/lit8 p1, p1, 0x8

    add-int/2addr p0, p1

    and-int/lit16 p1, p2, 0xff

    add-int/2addr p0, p1

    return p0
.end method

.method public static a(BBBB)I
    .locals 0

    and-int/lit16 p0, p0, 0xff

    shl-int/lit8 p0, p0, 0x18

    and-int/lit16 p1, p1, 0xff

    shl-int/lit8 p1, p1, 0x10

    add-int/2addr p0, p1

    and-int/lit16 p1, p2, 0xff

    shl-int/lit8 p1, p1, 0x8

    add-int/2addr p0, p1

    and-int/lit16 p1, p3, 0xff

    add-int/2addr p0, p1

    return p0
.end method

.method public static a([B)I
    .locals 3

    const/4 v0, 0x0

    if-eqz p0, :cond_1

    array-length v1, p0

    const/4 v2, 0x2

    if-ge v1, v2, :cond_0

    return v0

    :cond_0
    aget-byte v0, p0, v0

    const/4 v1, 0x1

    aget-byte p0, p0, v1

    invoke-static {v0, p0}, Lchat/ola/vn/util/e;->a(BB)I

    move-result p0

    return p0

    :cond_1
    return v0
.end method

.method public static a(BBBBBBBB)J
    .locals 4

    int-to-long v0, p0

    const/16 p0, 0x38

    shl-long/2addr v0, p0

    and-int/lit16 p0, p1, 0xff

    int-to-long p0, p0

    const/16 v2, 0x30

    shl-long/2addr p0, v2

    add-long v2, v0, p0

    and-int/lit16 p0, p2, 0xff

    int-to-long p0, p0

    const/16 p2, 0x28

    shl-long/2addr p0, p2

    add-long v0, v2, p0

    and-int/lit16 p0, p3, 0xff

    int-to-long p0, p0

    const/16 p2, 0x20

    shl-long/2addr p0, p2

    add-long p2, v0, p0

    and-int/lit16 p0, p4, 0xff

    int-to-long p0, p0

    const/16 p4, 0x18

    shl-long/2addr p0, p4

    add-long v0, p2, p0

    and-int/lit16 p0, p5, 0xff

    shl-int/lit8 p0, p0, 0x10

    int-to-long p0, p0

    add-long p2, v0, p0

    and-int/lit16 p0, p6, 0xff

    shl-int/lit8 p0, p0, 0x8

    int-to-long p0, p0

    add-long p4, p2, p0

    and-int/lit16 p0, p7, 0xff

    shl-int/lit8 p0, p0, 0x0

    int-to-long p0, p0

    add-long p2, p4, p0

    return-wide p2
.end method

.method public static a(I)[B
    .locals 4

    const/4 v0, 0x4

    new-array v0, v0, [B

    ushr-int/lit8 v1, p0, 0x18

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    const/4 v2, 0x0

    aput-byte v1, v0, v2

    ushr-int/lit8 v1, p0, 0x10

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    const/4 v3, 0x1

    aput-byte v1, v0, v3

    ushr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    const/4 v3, 0x2

    aput-byte v1, v0, v3

    ushr-int/2addr p0, v2

    and-int/lit16 p0, p0, 0xff

    int-to-byte p0, p0

    const/4 v1, 0x3

    aput-byte p0, v0, v1

    return-object v0
.end method

.method public static a(J)[B
    .locals 6

    const/16 v0, 0x8

    new-array v1, v0, [B

    const/16 v2, 0x38

    ushr-long v2, p0, v2

    long-to-int v2, v2

    int-to-byte v2, v2

    const/4 v3, 0x0

    aput-byte v2, v1, v3

    const/16 v2, 0x30

    ushr-long v4, p0, v2

    long-to-int v2, v4

    int-to-byte v2, v2

    const/4 v4, 0x1

    aput-byte v2, v1, v4

    const/16 v2, 0x28

    ushr-long v4, p0, v2

    long-to-int v2, v4

    int-to-byte v2, v2

    const/4 v4, 0x2

    aput-byte v2, v1, v4

    const/16 v2, 0x20

    ushr-long v4, p0, v2

    long-to-int v2, v4

    int-to-byte v2, v2

    const/4 v4, 0x3

    aput-byte v2, v1, v4

    const/16 v2, 0x18

    ushr-long v4, p0, v2

    long-to-int v2, v4

    int-to-byte v2, v2

    const/4 v4, 0x4

    aput-byte v2, v1, v4

    const/16 v2, 0x10

    ushr-long v4, p0, v2

    long-to-int v2, v4

    int-to-byte v2, v2

    const/4 v4, 0x5

    aput-byte v2, v1, v4

    ushr-long v4, p0, v0

    long-to-int v0, v4

    int-to-byte v0, v0

    const/4 v2, 0x6

    aput-byte v0, v1, v2

    ushr-long/2addr p0, v3

    long-to-int p0, p0

    int-to-byte p0, p0

    const/4 p1, 0x7

    aput-byte p0, v1, p1

    return-object v1
.end method

.method public static a(S)[B
    .locals 3

    const/4 v0, 0x2

    new-array v0, v0, [B

    ushr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    const/4 v2, 0x0

    aput-byte v1, v0, v2

    ushr-int/2addr p0, v2

    and-int/lit16 p0, p0, 0xff

    int-to-byte p0, p0

    const/4 v1, 0x1

    aput-byte p0, v0, v1

    return-object v0
.end method

.method public static b([B)I
    .locals 3

    const/4 v0, 0x0

    if-eqz p0, :cond_1

    array-length v1, p0

    const/4 v2, 0x3

    if-ge v1, v2, :cond_0

    return v0

    :cond_0
    aget-byte v0, p0, v0

    const/4 v1, 0x1

    aget-byte v1, p0, v1

    const/4 v2, 0x2

    aget-byte p0, p0, v2

    invoke-static {v0, v1, p0}, Lchat/ola/vn/util/e;->a(BBB)I

    move-result p0

    return p0

    :cond_1
    return v0
.end method

.method public static c([B)I
    .locals 4

    const/4 v0, 0x0

    if-eqz p0, :cond_1

    array-length v1, p0

    const/4 v2, 0x4

    if-ge v1, v2, :cond_0

    return v0

    :cond_0
    aget-byte v0, p0, v0

    const/4 v1, 0x1

    aget-byte v1, p0, v1

    const/4 v2, 0x2

    aget-byte v2, p0, v2

    const/4 v3, 0x3

    aget-byte p0, p0, v3

    invoke-static {v0, v1, v2, p0}, Lchat/ola/vn/util/e;->a(BBBB)I

    move-result p0

    return p0

    :cond_1
    return v0
.end method

.method public static d([B)J
    .locals 10

    array-length v0, p0

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-ge v0, v1, :cond_2

    const/16 v0, 0x38

    const/4 v0, 0x0

    const/4 v3, 0x0

    const/16 v4, 0x38

    :goto_0
    array-length v5, p0

    if-ge v0, v5, :cond_0

    aget-byte v5, p0, v0

    and-int/lit16 v5, v5, 0xff

    shl-int/2addr v5, v4

    add-int/2addr v3, v5

    add-int/lit8 v4, v4, -0x8

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    :goto_1
    if-ge v0, v1, :cond_1

    shl-int p0, v2, v4

    add-int/2addr v3, p0

    add-int/lit8 v4, v4, -0x8

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    int-to-long v0, v3

    return-wide v0

    :cond_2
    array-length v0, p0

    if-le v0, v1, :cond_4

    const/16 v0, 0x18

    const/4 v0, 0x0

    const/16 v3, 0x18

    :goto_2
    if-ge v2, v1, :cond_3

    aget-byte v4, p0, v2

    and-int/lit16 v4, v4, 0xff

    shl-int/2addr v4, v3

    add-int/2addr v0, v4

    add-int/lit8 v3, v3, -0x8

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_3
    int-to-long v0, v0

    return-wide v0

    :cond_4
    aget-byte v2, p0, v2

    const/4 v0, 0x1

    aget-byte v3, p0, v0

    const/4 v0, 0x2

    aget-byte v4, p0, v0

    const/4 v0, 0x3

    aget-byte v5, p0, v0

    const/4 v0, 0x4

    aget-byte v6, p0, v0

    const/4 v0, 0x5

    aget-byte v7, p0, v0

    const/4 v0, 0x6

    aget-byte v8, p0, v0

    const/4 v0, 0x7

    aget-byte v9, p0, v0

    invoke-static/range {v2 .. v9}, Lchat/ola/vn/util/e;->a(BBBBBBBB)J

    move-result-wide v0

    return-wide v0
.end method
