.class public Lchat/ola/vn/j/a;
.super Ljava/lang/Object;


# static fields
.field private static final a:[C


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/16 v0, 0x10

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    sput-object v0, Lchat/ola/vn/j/a;->a:[C

    return-void

    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x61s
        0x62s
        0x63s
        0x64s
        0x65s
        0x66s
    .end array-data
.end method

.method public static a(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    :try_start_0
    const-string v0, "MD5"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object p0

    const/4 v1, 0x0

    array-length v2, p0

    invoke-virtual {v0, p0, v1, v2}, Ljava/security/MessageDigest;->update([BII)V

    invoke-virtual {v0}, Ljava/security/MessageDigest;->digest()[B

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/j/a;->a([B)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static a([B)Ljava/lang/String;
    .locals 6

    array-length v0, p0

    mul-int/lit8 v0, v0, 0x2

    new-array v0, v0, [C

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    array-length v3, p0

    if-ge v1, v3, :cond_0

    add-int/lit8 v3, v2, 0x1

    sget-object v4, Lchat/ola/vn/j/a;->a:[C

    aget-byte v5, p0, v1

    ushr-int/lit8 v5, v5, 0x4

    and-int/lit8 v5, v5, 0xf

    aget-char v4, v4, v5

    aput-char v4, v0, v2

    add-int/lit8 v2, v3, 0x1

    sget-object v4, Lchat/ola/vn/j/a;->a:[C

    aget-byte v5, p0, v1

    and-int/lit8 v5, v5, 0xf

    aget-char v4, v4, v5

    aput-char v4, v0, v3

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    new-instance p0, Ljava/lang/String;

    invoke-direct {p0, v0}, Ljava/lang/String;-><init>([C)V

    return-object p0
.end method

.method public static a([B[B)Ljava/lang/String;
    .locals 8

    const/4 v0, 0x0

    if-eqz p0, :cond_6

    if-eqz p1, :cond_6

    array-length v1, p0

    if-eqz v1, :cond_6

    array-length v1, p1

    if-nez v1, :cond_0

    return-object v0

    :cond_0
    const/4 v1, 0x0

    aget-byte v2, p1, v1

    if-gtz v2, :cond_1

    return-object v0

    :cond_1
    aget-byte v0, p0, v1

    new-array v2, v2, [B

    move v3, v0

    :goto_0
    const/16 v4, 0x11

    :try_start_0
    array-length v5, v2

    add-int/2addr v5, v0

    if-ge v3, v5, :cond_3

    add-int/lit8 v5, v3, 0x1

    array-length v6, p0

    if-ge v5, v6, :cond_2

    aget-byte v6, p0, v5

    goto :goto_1

    :cond_2
    const/16 v6, 0x11

    :goto_1
    aget-byte v7, p1, v5

    sub-int/2addr v3, v0

    xor-int/2addr v6, v7

    int-to-byte v6, v6

    aput-byte v6, v2, v3

    move v3, v5

    goto :goto_0

    :cond_3
    invoke-static {v2}, Lchat/ola/vn/util/m;->a([B)Ljava/lang/String;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    :catch_0
    move v3, v0

    :goto_2
    :try_start_1
    array-length v5, v2

    add-int/2addr v5, v0

    if-ge v3, v5, :cond_5

    add-int/lit8 v5, v3, 0x1

    array-length v6, p0

    if-ge v5, v6, :cond_4

    aget-byte v6, p0, v5

    goto :goto_3

    :cond_4
    const/16 v6, 0x11

    :goto_3
    aget-byte v7, p1, v5

    sub-int/2addr v3, v0

    xor-int/2addr v6, v7

    int-to-byte v6, v6

    aput-byte v6, v2, v3

    move v3, v5

    goto :goto_2

    :cond_5
    new-instance p0, Ljava/lang/String;

    array-length p1, v2

    invoke-direct {p0, v2, v1, p1}, Ljava/lang/String;-><init>([BII)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-object p0

    :catch_1
    new-instance p0, Ljava/lang/String;

    array-length p1, v2

    invoke-direct {p0, v2, v1, p1}, Ljava/lang/String;-><init>([BII)V

    return-object p0

    :cond_6
    return-object v0
.end method

.method public static a([BLjava/lang/String;)[B
    .locals 2

    const/4 v0, 0x0

    if-eqz p0, :cond_1

    array-length v1, p0

    if-eqz v1, :cond_1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    return-object v0

    :cond_0
    :try_start_0
    const-string v1, "UTF-8"

    invoke-virtual {p1, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    invoke-static {p1}, Lchat/ola/vn/j/a;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, v1}, Lchat/ola/vn/j/a;->b([B[B)[B

    move-result-object p0

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    invoke-static {p1, p0}, Lchat/ola/vn/j/a;->b([B[B)[B

    move-result-object p0

    return-object p0

    :catch_0
    :cond_1
    return-object v0
.end method

.method public static b([BLjava/lang/String;)[B
    .locals 9

    const/16 v0, 0x11

    const/4 v1, 0x0

    :try_start_0
    aget-byte v2, p0, v1

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    array-length v4, p0

    add-int/lit8 v4, v4, -0x1

    array-length v5, v3

    add-int/2addr v5, v2

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v4

    add-int/lit8 v4, v4, 0x1

    new-array v4, v4, [B

    array-length v5, v3

    int-to-byte v5, v5

    aput-byte v5, v4, v1

    const/4 v5, 0x0

    :goto_0
    array-length v6, v4

    add-int/lit8 v6, v6, -0x1

    if-ge v5, v6, :cond_2

    add-int/lit8 v6, v5, 0x1

    array-length v7, p0

    if-ge v6, v7, :cond_0

    aget-byte v7, p0, v6

    goto :goto_1

    :cond_0
    const/16 v7, 0x11

    :goto_1
    if-lt v5, v2, :cond_1

    sub-int/2addr v5, v2

    array-length v8, v3

    if-ge v5, v8, :cond_1

    aget-byte v5, v3, v5

    goto :goto_2

    :cond_1
    const/4 v5, 0x0

    :goto_2
    xor-int/2addr v5, v7

    int-to-byte v5, v5

    aput-byte v5, v4, v6
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move v5, v6

    goto :goto_0

    :cond_2
    return-object v4

    :catch_0
    :try_start_1
    aget-byte v2, p0, v1

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    array-length v3, p0

    add-int/lit8 v3, v3, -0x1

    array-length v4, p1

    add-int/2addr v4, v2

    invoke-static {v3, v4}, Ljava/lang/Math;->max(II)I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    new-array v3, v3, [B

    array-length v4, p1

    int-to-byte v4, v4

    aput-byte v4, v3, v1

    const/4 v4, 0x0

    :goto_3
    array-length v5, v3

    add-int/lit8 v5, v5, -0x1

    if-ge v4, v5, :cond_5

    add-int/lit8 v5, v4, 0x1

    array-length v6, p0

    if-ge v5, v6, :cond_3

    aget-byte v6, p0, v5

    goto :goto_4

    :cond_3
    const/16 v6, 0x11

    :goto_4
    if-lt v4, v2, :cond_4

    sub-int/2addr v4, v2

    array-length v7, p1

    if-ge v4, v7, :cond_4

    aget-byte v4, p1, v4

    goto :goto_5

    :cond_4
    const/4 v4, 0x0

    :goto_5
    xor-int/2addr v4, v6

    int-to-byte v4, v4

    aput-byte v4, v3, v5
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    move v4, v5

    goto :goto_3

    :cond_5
    return-object v3

    :catch_1
    const/4 p0, 0x0

    return-object p0
.end method

.method private static b([B[B)[B
    .locals 7

    const/4 v0, 0x0

    if-eqz p0, :cond_4

    array-length v1, p0

    if-eqz v1, :cond_4

    if-eqz p1, :cond_4

    array-length v1, p1

    if-nez v1, :cond_0

    return-object v0

    :cond_0
    check-cast v0, [B

    const/4 v0, 0x0

    aget-byte v1, p0, v0

    array-length v2, p0

    add-int/lit8 v2, v2, -0x1

    array-length v3, p1

    add-int/2addr v3, v1

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    new-array v2, v2, [B

    array-length v3, p1

    int-to-byte v3, v3

    aput-byte v3, v2, v0

    const/4 v3, 0x0

    :goto_0
    array-length v4, v2

    add-int/lit8 v4, v4, -0x1

    if-ge v3, v4, :cond_3

    const/16 v4, 0x11

    add-int/lit8 v5, v3, 0x1

    array-length v6, p0

    if-ge v5, v6, :cond_1

    aget-byte v4, p0, v5

    :cond_1
    if-lt v3, v1, :cond_2

    sub-int/2addr v3, v1

    array-length v6, p1

    if-ge v3, v6, :cond_2

    aget-byte v3, p1, v3

    goto :goto_1

    :cond_2
    const/4 v3, 0x0

    :goto_1
    xor-int/2addr v3, v4

    int-to-byte v3, v3

    aput-byte v3, v2, v5

    move v3, v5

    goto :goto_0

    :cond_3
    return-object v2

    :cond_4
    return-object v0
.end method
