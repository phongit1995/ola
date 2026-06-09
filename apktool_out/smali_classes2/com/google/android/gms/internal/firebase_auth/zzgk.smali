.class public final Lcom/google/android/gms/internal/firebase_auth/zzgk;
.super Ljava/lang/Object;


# instance fields
.field private final buffer:[B

.field private zzmq:I

.field private zzmr:I

.field private zzms:I

.field private zzmx:I

.field private zzmz:I

.field private zzna:I

.field private final zzxk:I

.field private final zzxl:I

.field private zzxm:I

.field private zzxn:I

.field private zzxo:Lcom/google/android/gms/internal/firebase_auth/zzcd;


# direct methods
.method private constructor <init>([BII)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const v0, 0x7fffffff

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzna:I

    const/16 v0, 0x40

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmr:I

    const/high16 v0, 0x4000000

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzms:I

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->buffer:[B

    iput p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxk:I

    add-int/2addr p3, p2

    iput p3, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxm:I

    iput p3, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxl:I

    iput p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    return-void
.end method

.method private final zzcy()V
    .locals 2

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxm:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmx:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxm:I

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxm:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzna:I

    if-le v0, v1, :cond_0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzna:I

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmx:I

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxm:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmx:I

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxm:I

    return-void

    :cond_0
    const/4 v0, 0x0

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmx:I

    return-void
.end method

.method private final zzcz()B
    .locals 3

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxm:I

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgp()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object v0

    throw v0

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->buffer:[B

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    aget-byte v0, v0, v1

    return v0
.end method

.method public static zzi([BII)Lcom/google/android/gms/internal/firebase_auth/zzgk;
    .locals 1

    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzgk;

    const/4 v0, 0x0

    invoke-direct {p1, p0, v0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzgk;-><init>([BII)V

    return-object p1
.end method

.method private final zzr(I)V
    .locals 2

    if-gez p1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgq()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object p1

    throw p1

    :cond_0
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    add-int/2addr v0, p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzna:I

    if-le v0, v1, :cond_1

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzna:I

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    sub-int/2addr p1, v0

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzr(I)V

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgp()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object p1

    throw p1

    :cond_1
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxm:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    sub-int/2addr v0, v1

    if-gt p1, v0, :cond_2

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    return-void

    :cond_2
    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgp()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object p1

    throw p1
.end method


# virtual methods
.method public final getPosition()I
    .locals 2

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxk:I

    sub-int/2addr v0, v1

    return v0
.end method

.method public final readBytes()[B
    .locals 5

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    move-result v0

    if-gez v0, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgq()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object v0

    throw v0

    :cond_0
    if-nez v0, :cond_1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyk:[B

    return-object v0

    :cond_1
    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxm:I

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    sub-int/2addr v1, v2

    if-le v0, v1, :cond_2

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgp()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object v0

    throw v0

    :cond_2
    new-array v1, v0, [B

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->buffer:[B

    iget v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    const/4 v4, 0x0

    invoke-static {v2, v3, v1, v4, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    add-int/2addr v2, v0

    iput v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    return-object v1
.end method

.method public final readString()Ljava/lang/String;
    .locals 5

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    move-result v0

    if-gez v0, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgq()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object v0

    throw v0

    :cond_0
    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxm:I

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    sub-int/2addr v1, v2

    if-le v0, v1, :cond_1

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgp()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object v0

    throw v0

    :cond_1
    new-instance v1, Ljava/lang/String;

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->buffer:[B

    iget v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    sget-object v4, Lcom/google/android/gms/internal/firebase_auth/zzgr;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v1, v2, v3, v0, v4}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    add-int/2addr v2, v0

    iput v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    return-object v1
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzer;)Lcom/google/android/gms/internal/firebase_auth/zzdb;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Lcom/google/android/gms/internal/firebase_auth/zzdb<",
            "TT;*>;>(",
            "Lcom/google/android/gms/internal/firebase_auth/zzer<",
            "TT;>;)TT;"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxo:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->buffer:[B

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxk:I

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxl:I

    invoke-static {v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzd([BII)Lcom/google/android/gms/internal/firebase_auth/zzcd;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxo:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxo:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxk:I

    sub-int/2addr v1, v2

    if-le v0, v1, :cond_1

    new-instance p1, Ljava/io/IOException;

    const-string v2, "CodedInputStream read ahead of CodedInputByteBufferNano: %s > %s"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v3, v4

    const/4 v0, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v3, v0

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_1
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxo:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    sub-int/2addr v1, v0

    invoke-virtual {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzr(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxo:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmr:I

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmq:I

    sub-int/2addr v1, v2

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzo(I)I

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxo:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzco;->zzdl()Lcom/google/android/gms/internal/firebase_auth/zzco;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zza(Lcom/google/android/gms/internal/firebase_auth/zzer;Lcom/google/android/gms/internal/firebase_auth/zzco;)Lcom/google/android/gms/internal/firebase_auth/zzeh;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzdb;

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmz:I

    invoke-virtual {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzn(I)Z
    :try_end_0
    .catch Lcom/google/android/gms/internal/firebase_auth/zzdh; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzgs;

    const-string v1, ""

    invoke-direct {v0, v1, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgs;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v0
.end method

.method public final zzay(I)V
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmz:I

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzs(II)V

    return-void
.end method

.method public final zzb(Lcom/google/android/gms/internal/firebase_auth/zzgt;)V
    .locals 3

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmq:I

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmr:I

    if-lt v1, v2, :cond_0

    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzgs;

    const-string v0, "Protocol message had too many levels of nesting.  May be malicious.  Use CodedInputStream.setRecursionLimit() to increase the depth limit."

    invoke-direct {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgs;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    invoke-virtual {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzp(I)I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmq:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmq:I

    invoke-virtual {p1, p0}, Lcom/google/android/gms/internal/firebase_auth/zzgt;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;)Lcom/google/android/gms/internal/firebase_auth/zzgt;

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzm(I)V

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmq:I

    add-int/lit8 p1, p1, -0x1

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmq:I

    invoke-virtual {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzq(I)V

    return-void
.end method

.method public final zzcc()I
    .locals 2

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxm:I

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmz:I

    return v0

    :cond_0
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    move-result v0

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmz:I

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmz:I

    if-nez v0, :cond_1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzgs;

    const-string v1, "Protocol message contained an invalid tag (zero)."

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgs;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmz:I

    return v0
.end method

.method public final zzce()J
    .locals 2

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    return-wide v0
.end method

.method public final zzci()Z
    .locals 1

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final zzcu()I
    .locals 3

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    move-result v0

    if-ltz v0, :cond_0

    return v0

    :cond_0
    and-int/lit8 v0, v0, 0x7f

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    move-result v1

    if-ltz v1, :cond_1

    shl-int/lit8 v1, v1, 0x7

    :goto_0
    or-int/2addr v0, v1

    return v0

    :cond_1
    and-int/lit8 v1, v1, 0x7f

    shl-int/lit8 v1, v1, 0x7

    or-int/2addr v0, v1

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    move-result v1

    if-ltz v1, :cond_2

    shl-int/lit8 v1, v1, 0xe

    goto :goto_0

    :cond_2
    and-int/lit8 v1, v1, 0x7f

    shl-int/lit8 v1, v1, 0xe

    or-int/2addr v0, v1

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    move-result v1

    if-ltz v1, :cond_3

    shl-int/lit8 v1, v1, 0x15

    goto :goto_0

    :cond_3
    and-int/lit8 v1, v1, 0x7f

    shl-int/lit8 v1, v1, 0x15

    or-int/2addr v0, v1

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    move-result v1

    shl-int/lit8 v2, v1, 0x1c

    or-int/2addr v0, v2

    if-gez v1, :cond_6

    const/4 v1, 0x0

    :goto_1
    const/4 v2, 0x5

    if-ge v1, v2, :cond_5

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    move-result v2

    if-ltz v2, :cond_4

    return v0

    :cond_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_5
    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgr()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object v0

    throw v0

    :cond_6
    return v0
.end method

.method public final zzcv()J
    .locals 8

    const/4 v0, 0x0

    const-wide/16 v1, 0x0

    :goto_0
    const/16 v3, 0x40

    if-ge v0, v3, :cond_1

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    move-result v3

    and-int/lit8 v4, v3, 0x7f

    int-to-long v4, v4

    shl-long/2addr v4, v0

    or-long v6, v1, v4

    and-int/lit16 v1, v3, 0x80

    if-nez v1, :cond_0

    return-wide v6

    :cond_0
    add-int/lit8 v0, v0, 0x7

    move-wide v1, v6

    goto :goto_0

    :cond_1
    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgr()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object v0

    throw v0
.end method

.method public final zzgl()I
    .locals 2

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzna:I

    const v1, 0x7fffffff

    if-ne v0, v1, :cond_0

    const/4 v0, -0x1

    return v0

    :cond_0
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzna:I

    sub-int/2addr v1, v0

    return v1
.end method

.method public final zzm(I)V
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmz:I

    if-eq v0, p1, :cond_0

    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzgs;

    const-string v0, "Protocol message end-group tag did not match expected tag."

    invoke-direct {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgs;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    return-void
.end method

.method public final zzn(I)Z
    .locals 2

    and-int/lit8 v0, p1, 0x7

    const/4 v1, 0x1

    packed-switch v0, :pswitch_data_0

    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzgs;

    const-string v0, "Protocol message tag had invalid wire type."

    invoke-direct {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgs;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    return v1

    :pswitch_1
    const/4 p1, 0x0

    return p1

    :cond_0
    :pswitch_2
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzn(I)Z

    move-result v0

    if-nez v0, :cond_0

    :cond_1
    ushr-int/lit8 p1, p1, 0x3

    shl-int/lit8 p1, p1, 0x3

    or-int/lit8 p1, p1, 0x4

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzm(I)V

    return v1

    :pswitch_3
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    move-result p1

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzr(I)V

    return v1

    :pswitch_4
    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcz()B

    return v1

    :pswitch_5
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    return v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public final zzp(I)I
    .locals 1

    if-gez p1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgq()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object p1

    throw p1

    :cond_0
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    add-int/2addr p1, v0

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzna:I

    if-le p1, v0, :cond_1

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzgs;->zzgp()Lcom/google/android/gms/internal/firebase_auth/zzgs;

    move-result-object p1

    throw p1

    :cond_1
    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzna:I

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcy()V

    return v0
.end method

.method public final zzq(I)V
    .locals 0

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzna:I

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcy()V

    return-void
.end method

.method public final zzr(II)[B
    .locals 3

    if-nez p2, :cond_0

    sget-object p1, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyk:[B

    return-object p1

    :cond_0
    new-array v0, p2, [B

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxk:I

    add-int/2addr v1, p1

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->buffer:[B

    const/4 v2, 0x0

    invoke-static {p1, v1, v0, v2, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v0
.end method

.method final zzs(II)V
    .locals 3

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxk:I

    sub-int/2addr v0, v1

    if-le p1, v0, :cond_0

    new-instance p2, Ljava/lang/IllegalArgumentException;

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxk:I

    sub-int/2addr v0, v1

    const/16 v1, 0x32

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v1, "Position "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, " is beyond current "

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p2

    :cond_0
    if-gez p1, :cond_1

    new-instance p2, Ljava/lang/IllegalArgumentException;

    const/16 v0, 0x18

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v0, "Bad position "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p2

    :cond_1
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxk:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzxn:I

    iput p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzmz:I

    return-void
.end method
