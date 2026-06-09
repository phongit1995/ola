.class public final Lcom/google/android/gms/internal/firebase_auth/zzk;
.super Lcom/google/android/gms/internal/firebase_auth/zzgn;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/firebase_auth/zzgn<",
        "Lcom/google/android/gms/internal/firebase_auth/zzk;",
        ">;"
    }
.end annotation


# instance fields
.field private zzae:J

.field public zzaf:Ljava/lang/String;

.field private zzal:[Ljava/lang/String;

.field private zzam:[Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzaf:Ljava/lang/String;

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzgw;->EMPTY_STRING_ARRAY:[Ljava/lang/String;

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzgw;->EMPTY_STRING_ARRAY:[Ljava/lang/String;

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzae:J

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzya:I

    return-void
.end method


# virtual methods
.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;)Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 4

    :cond_0
    :goto_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    move-result v0

    if-eqz v0, :cond_b

    const/16 v1, 0xa

    if-eq v0, v1, :cond_a

    const/16 v1, 0x12

    const/4 v2, 0x0

    if-eq v0, v1, :cond_6

    const/16 v1, 0x1a

    if-eq v0, v1, :cond_2

    const/16 v1, 0x20

    if-eq v0, v1, :cond_1

    invoke-super {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)Z

    move-result v0

    if-nez v0, :cond_0

    return-object p0

    :cond_1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzae:J

    goto :goto_0

    :cond_2
    invoke-static {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    if-nez v1, :cond_3

    const/4 v1, 0x0

    goto :goto_1

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    array-length v1, v1

    :goto_1
    add-int/2addr v0, v1

    new-array v0, v0, [Ljava/lang/String;

    if-eqz v1, :cond_4

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    invoke-static {v3, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_4
    :goto_2
    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    if-ge v1, v2, :cond_5

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_5
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    goto :goto_0

    :cond_6
    invoke-static {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    if-nez v1, :cond_7

    const/4 v1, 0x0

    goto :goto_3

    :cond_7
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    array-length v1, v1

    :goto_3
    add-int/2addr v0, v1

    new-array v0, v0, [Ljava/lang/String;

    if-eqz v1, :cond_8

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    invoke-static {v3, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_8
    :goto_4
    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    if-ge v1, v2, :cond_9

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    :cond_9
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    goto/16 :goto_0

    :cond_a
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzaf:Ljava/lang/String;

    goto/16 :goto_0

    :cond_b
    return-object p0
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V
    .locals 5

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzaf:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzaf:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzaf:Ljava/lang/String;

    const/4 v1, 0x1

    invoke-virtual {p1, v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_2

    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_2

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    aget-object v2, v2, v0

    if-eqz v2, :cond_1

    const/4 v3, 0x2

    invoke-virtual {p1, v3, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_4

    :goto_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    array-length v0, v0

    if-ge v1, v0, :cond_4

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    aget-object v0, v0, v1

    if-eqz v0, :cond_3

    const/4 v2, 0x3

    invoke-virtual {p1, v2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_4
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzae:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_5

    const/4 v0, 0x4

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzae:J

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzi(IJ)V

    :cond_5
    invoke-super {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V

    return-void
.end method

.method protected final zzb()I
    .locals 7

    invoke-super {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzb()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzaf:Ljava/lang/String;

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzaf:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzaf:Ljava/lang/String;

    invoke-static {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    const/4 v3, 0x0

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    array-length v1, v1

    if-lez v1, :cond_3

    const/4 v1, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    :goto_0
    iget-object v6, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    array-length v6, v6

    if-ge v1, v6, :cond_2

    iget-object v6, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzal:[Ljava/lang/String;

    aget-object v6, v6, v1

    if-eqz v6, :cond_1

    add-int/lit8 v5, v5, 0x1

    invoke-static {v6}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzam(Ljava/lang/String;)I

    move-result v6

    add-int/2addr v4, v6

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    add-int/2addr v0, v4

    mul-int/lit8 v5, v5, 0x1

    add-int/2addr v0, v5

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    if-eqz v1, :cond_6

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    array-length v1, v1

    if-lez v1, :cond_6

    const/4 v1, 0x0

    const/4 v4, 0x0

    :goto_1
    iget-object v5, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    array-length v5, v5

    if-ge v3, v5, :cond_5

    iget-object v5, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzam:[Ljava/lang/String;

    aget-object v5, v5, v3

    if-eqz v5, :cond_4

    add-int/lit8 v4, v4, 0x1

    invoke-static {v5}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzam(Ljava/lang/String;)I

    move-result v5

    add-int/2addr v1, v5

    :cond_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_5
    add-int/2addr v0, v1

    mul-int/lit8 v4, v4, 0x1

    add-int/2addr v0, v4

    :cond_6
    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzae:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-eqz v5, :cond_7

    const/4 v1, 0x4

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzk;->zzae:J

    invoke-static {v1, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzd(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_7
    return v0
.end method
