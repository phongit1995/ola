.class public final Lcom/google/android/gms/internal/firebase_auth/zzfq;
.super Ljava/lang/Object;


# static fields
.field private static final zzvd:Lcom/google/android/gms/internal/firebase_auth/zzfq;


# instance fields
.field private count:I

.field private zzmd:Z

.field private zzqy:I

.field private zztl:[Ljava/lang/Object;

.field private zzve:[I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzfq;

    const/4 v1, 0x0

    new-array v2, v1, [I

    new-array v3, v1, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2, v3, v1}, Lcom/google/android/gms/internal/firebase_auth/zzfq;-><init>(I[I[Ljava/lang/Object;Z)V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzvd:Lcom/google/android/gms/internal/firebase_auth/zzfq;

    return-void
.end method

.method private constructor <init>()V
    .locals 4

    const/16 v0, 0x8

    new-array v1, v0, [I

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-direct {p0, v2, v1, v0, v3}, Lcom/google/android/gms/internal/firebase_auth/zzfq;-><init>(I[I[Ljava/lang/Object;Z)V

    return-void
.end method

.method private constructor <init>(I[I[Ljava/lang/Object;Z)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzqy:I

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    iput-object p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    iput-object p3, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    iput-boolean p4, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzmd:Z

    return-void
.end method

.method static zza(Lcom/google/android/gms/internal/firebase_auth/zzfq;Lcom/google/android/gms/internal/firebase_auth/zzfq;)Lcom/google/android/gms/internal/firebase_auth/zzfq;
    .locals 6

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    iget v1, p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    add-int/2addr v0, v1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    invoke-static {v1, v0}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v1

    iget-object v2, p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    iget v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    iget v4, p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    const/4 v5, 0x0

    invoke-static {v2, v5, v1, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    invoke-static {v2, v0}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v2

    iget-object v3, p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    iget p0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    iget p1, p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    invoke-static {v3, v5, v2, p0, p1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    new-instance p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;

    const/4 p1, 0x1

    invoke-direct {p0, v0, v1, v2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfq;-><init>(I[I[Ljava/lang/Object;Z)V

    return-object p0
.end method

.method private static zzb(ILjava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzgj;)V
    .locals 2

    ushr-int/lit8 v0, p0, 0x3

    and-int/lit8 p0, p0, 0x7

    const/4 v1, 0x5

    if-eq p0, v1, :cond_1

    packed-switch p0, :pswitch_data_0

    new-instance p0, Ljava/lang/RuntimeException;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw p0

    :pswitch_0
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zzdf()I

    move-result p0

    sget v1, Lcom/google/android/gms/internal/firebase_auth/zzdb$zze;->zzrp:I

    if-ne p0, v1, :cond_0

    invoke-interface {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zzaj(I)V

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;

    invoke-virtual {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgj;)V

    invoke-interface {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zzak(I)V

    return-void

    :cond_0
    invoke-interface {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zzak(I)V

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;

    invoke-virtual {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgj;)V

    invoke-interface {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zzaj(I)V

    return-void

    :pswitch_1
    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzbu;

    invoke-interface {p2, v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zza(ILcom/google/android/gms/internal/firebase_auth/zzbu;)V

    return-void

    :pswitch_2
    check-cast p1, Ljava/lang/Long;

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide p0

    invoke-interface {p2, v0, p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zzc(IJ)V

    return-void

    :pswitch_3
    check-cast p1, Ljava/lang/Long;

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide p0

    invoke-interface {p2, v0, p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zzi(IJ)V

    return-void

    :cond_1
    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p0

    invoke-interface {p2, v0, p0}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zzf(II)V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static zzfz()Lcom/google/android/gms/internal/firebase_auth/zzfq;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzvd:Lcom/google/android/gms/internal/firebase_auth/zzfq;

    return-object v0
.end method

.method static zzga()Lcom/google/android/gms/internal/firebase_auth/zzfq;
    .locals 1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzfq;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfq;-><init>()V

    return-object v0
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 8

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    return v1

    :cond_1
    instance-of v2, p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;

    if-nez v2, :cond_2

    return v1

    :cond_2
    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    iget v3, p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    if-ne v2, v3, :cond_8

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    iget-object v3, p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    iget v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    const/4 v5, 0x0

    :goto_0
    if-ge v5, v4, :cond_4

    aget v6, v2, v5

    aget v7, v3, v5

    if-eq v6, v7, :cond_3

    const/4 v2, 0x0

    goto :goto_1

    :cond_3
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_4
    const/4 v2, 0x1

    :goto_1
    if-eqz v2, :cond_8

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    iget-object p1, p1, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    iget v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    const/4 v4, 0x0

    :goto_2
    if-ge v4, v3, :cond_6

    aget-object v5, v2, v4

    aget-object v6, p1, v4

    invoke-virtual {v5, v6}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_5

    const/4 p1, 0x0

    goto :goto_3

    :cond_5
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    :cond_6
    const/4 p1, 0x1

    :goto_3
    if-nez p1, :cond_7

    return v1

    :cond_7
    return v0

    :cond_8
    return v1
.end method

.method public final hashCode()I
    .locals 8

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    add-int/lit16 v0, v0, 0x20f

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    const/4 v3, 0x0

    const/16 v4, 0x11

    const/4 v5, 0x0

    const/16 v6, 0x11

    :goto_0
    if-ge v5, v2, :cond_0

    mul-int/lit8 v6, v6, 0x1f

    aget v7, v1, v5

    add-int/2addr v6, v7

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_0
    add-int/2addr v0, v6

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    :goto_1
    if-ge v3, v2, :cond_1

    mul-int/lit8 v4, v4, 0x1f

    aget-object v5, v1, v3

    invoke-virtual {v5}, Ljava/lang/Object;->hashCode()I

    move-result v5

    add-int/2addr v4, v5

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_1
    add-int/2addr v0, v4

    return v0
.end method

.method final zza(Lcom/google/android/gms/internal/firebase_auth/zzgj;)V
    .locals 3

    invoke-interface {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zzdf()I

    move-result v0

    sget v1, Lcom/google/android/gms/internal/firebase_auth/zzdb$zze;->zzrq:I

    if-ne v0, v1, :cond_1

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    aget v1, v1, v0

    ushr-int/lit8 v1, v1, 0x3

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    aget-object v2, v2, v0

    invoke-interface {p1, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zza(ILjava/lang/Object;)V

    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_0
    return-void

    :cond_1
    const/4 v0, 0x0

    :goto_1
    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    if-ge v0, v1, :cond_2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    aget v1, v1, v0

    ushr-int/lit8 v1, v1, 0x3

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    aget-object v2, v2, v0

    invoke-interface {p1, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zza(ILjava/lang/Object;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_2
    return-void
.end method

.method final zza(Ljava/lang/StringBuilder;I)V
    .locals 3

    const/4 v0, 0x0

    :goto_0
    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    aget v1, v1, v0

    ushr-int/lit8 v1, v1, 0x3

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    aget-object v2, v2, v0

    invoke-static {p1, p2, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzek;->zza(Ljava/lang/StringBuilder;ILjava/lang/String;Ljava/lang/Object;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method final zzb(ILjava/lang/Object;)V
    .locals 2

    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzmd:Z

    if-nez v0, :cond_0

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    invoke-direct {p1}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw p1

    :cond_0
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    array-length v1, v1

    if-ne v0, v1, :cond_2

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    const/4 v1, 0x4

    if-ge v0, v1, :cond_1

    const/16 v0, 0x8

    goto :goto_0

    :cond_1
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    shr-int/lit8 v0, v0, 0x1

    :goto_0
    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    add-int/2addr v1, v0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    aput p1, v0, v1

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    aput-object p2, p1, v0

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    return-void
.end method

.method public final zzb(Lcom/google/android/gms/internal/firebase_auth/zzgj;)V
    .locals 3

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-interface {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zzdf()I

    move-result v0

    sget v1, Lcom/google/android/gms/internal/firebase_auth/zzdb$zze;->zzrp:I

    if-ne v0, v1, :cond_2

    const/4 v0, 0x0

    :goto_0
    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    if-ge v0, v1, :cond_1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    aget v1, v1, v0

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    aget-object v2, v2, v0

    invoke-static {v1, v2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzb(ILjava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzgj;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return-void

    :cond_2
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    add-int/lit8 v0, v0, -0x1

    :goto_1
    if-ltz v0, :cond_3

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    aget v1, v1, v0

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    aget-object v2, v2, v0

    invoke-static {v1, v2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzb(ILjava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzgj;)V

    add-int/lit8 v0, v0, -0x1

    goto :goto_1

    :cond_3
    return-void
.end method

.method public final zzbs()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzmd:Z

    return-void
.end method

.method public final zzdq()I
    .locals 6

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzqy:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    return v0

    :cond_0
    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    if-ge v0, v2, :cond_2

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    aget v2, v2, v0

    ushr-int/lit8 v3, v2, 0x3

    and-int/lit8 v2, v2, 0x7

    const/4 v4, 0x5

    if-eq v2, v4, :cond_1

    packed-switch v2, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/Throwable;)V

    throw v0

    :pswitch_0
    invoke-static {v3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result v2

    shl-int/lit8 v2, v2, 0x1

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    aget-object v3, v3, v0

    check-cast v3, Lcom/google/android/gms/internal/firebase_auth/zzfq;

    invoke-virtual {v3}, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzdq()I

    move-result v3

    add-int/2addr v2, v3

    goto :goto_1

    :pswitch_1
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    aget-object v2, v2, v0

    check-cast v2, Lcom/google/android/gms/internal/firebase_auth/zzbu;

    invoke-static {v3, v2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzc(ILcom/google/android/gms/internal/firebase_auth/zzbu;)I

    move-result v2

    goto :goto_1

    :pswitch_2
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    aget-object v2, v2, v0

    check-cast v2, Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    invoke-static {v3, v4, v5}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzg(IJ)I

    move-result v2

    goto :goto_1

    :pswitch_3
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    aget-object v2, v2, v0

    check-cast v2, Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    invoke-static {v3, v4, v5}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zze(IJ)I

    move-result v2

    :goto_1
    add-int/2addr v1, v2

    goto :goto_2

    :cond_1
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    aget-object v2, v2, v0

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-static {v3, v2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzj(II)I

    move-result v2

    goto :goto_1

    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    iput v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzqy:I

    return v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public final zzgb()I
    .locals 4

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzqy:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    return v0

    :cond_0
    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->count:I

    if-ge v0, v2, :cond_1

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzve:[I

    aget v2, v2, v0

    ushr-int/lit8 v2, v2, 0x3

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zztl:[Ljava/lang/Object;

    aget-object v3, v3, v0

    check-cast v3, Lcom/google/android/gms/internal/firebase_auth/zzbu;

    invoke-static {v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzd(ILcom/google/android/gms/internal/firebase_auth/zzbu;)I

    move-result v2

    add-int/2addr v1, v2

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    iput v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfq;->zzqy:I

    return v1
.end method
