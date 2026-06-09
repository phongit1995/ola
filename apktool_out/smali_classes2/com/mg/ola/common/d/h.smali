.class public Lcom/mg/ola/common/d/h;
.super Ljava/lang/Object;


# static fields
.field private static final a:[C


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/16 v0, 0x13

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mg/ola/common/d/h;->a:[C

    return-void

    :array_0
    .array-data 2
        0x3131s
        0x3132s
        0x3134s
        0x3137s
        0x3138s
        0x3139s
        0x3141s
        0x3142s
        0x3143s
        0x3145s
        0x3146s
        0x3147s
        0x3148s
        0x3149s
        0x314as
        0x314bs
        0x314cs
        0x314ds
        0x314es
    .end array-data
.end method

.method private static a(C)Z
    .locals 1

    const v0, 0xac00

    if-lt p0, v0, :cond_0

    const v0, 0xd7a3

    if-gt p0, v0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 5

    const/4 v0, 0x0

    if-eqz p0, :cond_8

    if-nez p1, :cond_0

    return v0

    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-le v1, v2, :cond_1

    return v0

    :cond_1
    const/4 v1, 0x0

    const/4 v2, 0x0

    :cond_2
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/mg/ola/common/d/h;->a(C)Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/mg/ola/common/d/h;->b(C)Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/mg/ola/common/d/h;->c(C)C

    move-result v4

    if-ne v3, v4, :cond_3

    goto :goto_0

    :cond_3
    if-lez v2, :cond_6

    goto :goto_2

    :cond_4
    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-ne v3, v4, :cond_5

    :goto_0
    add-int/lit8 v1, v1, 0x1

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_5
    if-lez v2, :cond_6

    goto :goto_2

    :cond_6
    add-int/lit8 v1, v1, 0x1

    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v1, v3, :cond_7

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    if-lt v2, v3, :cond_2

    :cond_7
    :goto_2
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p0

    if-ne v2, p0, :cond_8

    const/4 v0, 0x1

    :cond_8
    return v0
.end method

.method private static b(C)Z
    .locals 5

    sget-object v0, Lcom/mg/ola/common/d/h;->a:[C

    array-length v1, v0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_1

    aget-char v4, v0, v3

    if-ne p0, v4, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    return v2
.end method

.method private static c(C)C
    .locals 2

    sget-object v0, Lcom/mg/ola/common/d/h;->a:[C

    const v1, 0xac00

    sub-int/2addr p0, v1

    div-int/lit16 p0, p0, 0x24c

    aget-char p0, v0, p0

    return p0
.end method
