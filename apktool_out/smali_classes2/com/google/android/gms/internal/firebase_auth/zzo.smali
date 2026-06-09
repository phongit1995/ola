.class public final Lcom/google/android/gms/internal/firebase_auth/zzo;
.super Lcom/google/android/gms/internal/firebase_auth/zzgn;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/firebase_auth/zzgn<",
        "Lcom/google/android/gms/internal/firebase_auth/zzo;",
        ">;"
    }
.end annotation


# instance fields
.field private zzad:Ljava/lang/String;

.field private zzae:J

.field public zzaf:Ljava/lang/String;

.field public zzag:Ljava/lang/String;

.field public zzah:Ljava/lang/String;

.field public zzbh:Ljava/lang/String;

.field public zzbi:Ljava/lang/String;

.field private zzbj:[Ljava/lang/String;

.field private zzbk:Z

.field private zzbl:Z

.field private zzbm:Ljava/lang/String;

.field private zzbn:Ljava/lang/String;

.field private zzbo:Lcom/google/android/gms/internal/firebase_auth/zzfm;

.field private zzbp:Z

.field private zzbq:Ljava/lang/String;

.field public zzbr:Ljava/lang/String;

.field public zzbs:[I

.field public zzbt:Z

.field public zzbu:[Ljava/lang/String;

.field private zzbv:J

.field private zzbw:J


# direct methods
.method public constructor <init>()V
    .locals 4

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzaf:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzad:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbh:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzah:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbi:Ljava/lang/String;

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzgw;->EMPTY_STRING_ARRAY:[Ljava/lang/String;

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzag:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbk:Z

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbl:Z

    const-string v1, ""

    iput-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbm:Ljava/lang/String;

    const-string v1, ""

    iput-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbn:Ljava/lang/String;

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbp:Z

    const-string v1, ""

    iput-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbq:Ljava/lang/String;

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzae:J

    const-string v3, ""

    iput-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbr:Ljava/lang/String;

    sget-object v3, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzti:[I

    iput-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbt:Z

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzgw;->EMPTY_STRING_ARRAY:[Ljava/lang/String;

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    iput-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbv:J

    iput-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbw:J

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzya:I

    return-void
.end method

.method private final zzd(Lcom/google/android/gms/internal/firebase_auth/zzgk;)Lcom/google/android/gms/internal/firebase_auth/zzo;
    .locals 8

    :cond_0
    :goto_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    move-result v0

    const/16 v1, 0x90

    const/4 v2, 0x0

    sparse-switch v0, :sswitch_data_0

    invoke-super {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)Z

    move-result v0

    if-nez v0, :cond_0

    return-object p0

    :sswitch_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbw:J

    goto :goto_0

    :sswitch_1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbv:J

    goto :goto_0

    :sswitch_2
    const/16 v0, 0xa2

    invoke-static {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    if-nez v1, :cond_1

    const/4 v1, 0x0

    goto :goto_1

    :cond_1
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    array-length v1, v1

    :goto_1
    add-int/2addr v0, v1

    new-array v0, v0, [Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    invoke-static {v3, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_2
    :goto_2
    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    if-ge v1, v2, :cond_3

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_3
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    goto :goto_0

    :sswitch_3
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbt:Z

    goto :goto_0

    :sswitch_4
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    move-result v0

    invoke-virtual {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzp(I)I

    move-result v0

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->getPosition()I

    move-result v3

    const/4 v4, 0x0

    :catch_0
    :goto_3
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzgl()I

    move-result v5

    if-lez v5, :cond_4

    :try_start_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    move-result v5

    invoke-static {v5}, Lcom/google/android/gms/internal/firebase_auth/zze;->zza(I)I
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    :cond_4
    if-eqz v4, :cond_8

    invoke-virtual {p1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzay(I)V

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    if-nez v3, :cond_5

    const/4 v3, 0x0

    goto :goto_4

    :cond_5
    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    array-length v3, v3

    :goto_4
    add-int/2addr v4, v3

    new-array v4, v4, [I

    if-eqz v3, :cond_6

    iget-object v5, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    invoke-static {v5, v2, v4, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_6
    :goto_5
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzgl()I

    move-result v2

    if-lez v2, :cond_7

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->getPosition()I

    move-result v2

    :try_start_1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    move-result v5

    invoke-static {v5}, Lcom/google/android/gms/internal/firebase_auth/zze;->zza(I)I

    move-result v5

    aput v5, v4, v3
    :try_end_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_1

    add-int/lit8 v3, v3, 0x1

    goto :goto_5

    :catch_1
    invoke-virtual {p1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzay(I)V

    invoke-virtual {p0, p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)Z

    goto :goto_5

    :cond_7
    iput-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    :cond_8
    invoke-virtual {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzq(I)V

    goto/16 :goto_0

    :sswitch_5
    invoke-static {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I

    move-result v1

    new-array v3, v1, [I

    const/4 v4, 0x0

    const/4 v5, 0x0

    :goto_6
    if-ge v4, v1, :cond_a

    if-eqz v4, :cond_9

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    :cond_9
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->getPosition()I

    move-result v6

    :try_start_2
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    move-result v7

    invoke-static {v7}, Lcom/google/android/gms/internal/firebase_auth/zze;->zza(I)I

    move-result v7

    aput v7, v3, v5
    :try_end_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_2 .. :try_end_2} :catch_2

    add-int/lit8 v5, v5, 0x1

    goto :goto_7

    :catch_2
    invoke-virtual {p1, v6}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzay(I)V

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)Z

    :goto_7
    add-int/lit8 v4, v4, 0x1

    goto :goto_6

    :cond_a
    if-eqz v5, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    if-nez v0, :cond_b

    const/4 v0, 0x0

    goto :goto_8

    :cond_b
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    array-length v0, v0

    :goto_8
    if-nez v0, :cond_c

    array-length v1, v3

    if-ne v5, v1, :cond_c

    iput-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    goto/16 :goto_0

    :cond_c
    add-int v1, v0, v5

    new-array v1, v1, [I

    if-eqz v0, :cond_d

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    invoke-static {v4, v2, v1, v2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_d
    invoke-static {v3, v2, v1, v0, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iput-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    goto/16 :goto_0

    :sswitch_6
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbr:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_7
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzae:J

    goto/16 :goto_0

    :sswitch_8
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbq:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_9
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbp:Z

    goto/16 :goto_0

    :sswitch_a
    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzfm;->zzfw()Lcom/google/android/gms/internal/firebase_auth/zzer;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zza(Lcom/google/android/gms/internal/firebase_auth/zzer;)Lcom/google/android/gms/internal/firebase_auth/zzdb;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzfm;

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbo:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    goto/16 :goto_0

    :sswitch_b
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbn:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_c
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbm:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_d
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbl:Z

    goto/16 :goto_0

    :sswitch_e
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbk:Z

    goto/16 :goto_0

    :sswitch_f
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzag:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_10
    const/16 v0, 0x3a

    invoke-static {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    if-nez v1, :cond_e

    const/4 v1, 0x0

    goto :goto_9

    :cond_e
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    array-length v1, v1

    :goto_9
    add-int/2addr v0, v1

    new-array v0, v0, [Ljava/lang/String;

    if-eqz v1, :cond_f

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    invoke-static {v3, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_f
    :goto_a
    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    if-ge v1, v2, :cond_10

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    add-int/lit8 v1, v1, 0x1

    goto :goto_a

    :cond_10
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_11
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbi:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_12
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzah:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_13
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbh:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_14
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzad:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_15
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzaf:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_16
    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_16
        0x12 -> :sswitch_15
        0x1a -> :sswitch_14
        0x22 -> :sswitch_13
        0x2a -> :sswitch_12
        0x32 -> :sswitch_11
        0x3a -> :sswitch_10
        0x42 -> :sswitch_f
        0x48 -> :sswitch_e
        0x50 -> :sswitch_d
        0x5a -> :sswitch_c
        0x62 -> :sswitch_b
        0x6a -> :sswitch_a
        0x70 -> :sswitch_9
        0x7a -> :sswitch_8
        0x80 -> :sswitch_7
        0x8a -> :sswitch_6
        0x90 -> :sswitch_5
        0x92 -> :sswitch_4
        0x98 -> :sswitch_3
        0xa2 -> :sswitch_2
        0xa8 -> :sswitch_1
        0xb0 -> :sswitch_0
    .end sparse-switch
.end method


# virtual methods
.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;)Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 0

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzd(Lcom/google/android/gms/internal/firebase_auth/zzgk;)Lcom/google/android/gms/internal/firebase_auth/zzo;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V
    .locals 6

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzaf:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzaf:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzaf:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzad:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzad:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x3

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzad:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbh:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbh:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x4

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbh:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzah:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzah:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const/4 v0, 0x5

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzah:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_3
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbi:Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbi:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    const/4 v0, 0x6

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbi:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_4
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_6

    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_6

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    aget-object v2, v2, v0

    if-eqz v2, :cond_5

    const/4 v3, 0x7

    invoke-virtual {p1, v3, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzag:Ljava/lang/String;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzag:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_7

    const/16 v0, 0x8

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzag:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_7
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbk:Z

    if-eqz v0, :cond_8

    const/16 v0, 0x9

    iget-boolean v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbk:Z

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_8
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbl:Z

    if-eqz v0, :cond_9

    const/16 v0, 0xa

    iget-boolean v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbl:Z

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_9
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbm:Ljava/lang/String;

    if-eqz v0, :cond_a

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbm:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_a

    const/16 v0, 0xb

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbm:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_a
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbn:Ljava/lang/String;

    if-eqz v0, :cond_b

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbn:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_b

    const/16 v0, 0xc

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbn:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_b
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbo:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    if-eqz v0, :cond_c

    const/16 v0, 0xd

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbo:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zze(ILcom/google/android/gms/internal/firebase_auth/zzeh;)V

    :cond_c
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbp:Z

    if-eqz v0, :cond_d

    const/16 v0, 0xe

    iget-boolean v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbp:Z

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_d
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbq:Ljava/lang/String;

    if-eqz v0, :cond_e

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbq:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_e

    const/16 v0, 0xf

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbq:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_e
    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzae:J

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-eqz v0, :cond_f

    const/16 v0, 0x10

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzae:J

    invoke-virtual {p1, v0, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzi(IJ)V

    :cond_f
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbr:Ljava/lang/String;

    if-eqz v0, :cond_10

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbr:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_10

    const/16 v0, 0x11

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbr:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_10
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    if-eqz v0, :cond_11

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    array-length v0, v0

    if-lez v0, :cond_11

    const/4 v0, 0x0

    :goto_1
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    array-length v2, v2

    if-ge v0, v2, :cond_11

    const/16 v2, 0x12

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    aget v3, v3, v0

    invoke-virtual {p1, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzc(II)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_11
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbt:Z

    if-eqz v0, :cond_12

    const/16 v0, 0x13

    iget-boolean v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbt:Z

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_12
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    if-eqz v0, :cond_14

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_14

    :goto_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    array-length v0, v0

    if-ge v1, v0, :cond_14

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    aget-object v0, v0, v1

    if-eqz v0, :cond_13

    const/16 v2, 0x14

    invoke-virtual {p1, v2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_13
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_14
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbv:J

    cmp-long v2, v0, v4

    if-eqz v2, :cond_15

    const/16 v0, 0x15

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbv:J

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzi(IJ)V

    :cond_15
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbw:J

    cmp-long v2, v0, v4

    if-eqz v2, :cond_16

    const/16 v0, 0x16

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbw:J

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzi(IJ)V

    :cond_16
    invoke-super {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V

    return-void
.end method

.method protected final zzb()I
    .locals 8

    invoke-super {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzb()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzaf:Ljava/lang/String;

    const/4 v2, 0x2

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzaf:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzaf:Ljava/lang/String;

    invoke-static {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzad:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzad:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const/4 v1, 0x3

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzad:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_1
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbh:Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbh:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const/4 v1, 0x4

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbh:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzah:Ljava/lang/String;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzah:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    const/4 v1, 0x5

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzah:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbi:Ljava/lang/String;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbi:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    const/4 v1, 0x6

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbi:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_4
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    const/4 v3, 0x0

    if-eqz v1, :cond_7

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    array-length v1, v1

    if-lez v1, :cond_7

    const/4 v1, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    :goto_0
    iget-object v6, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    array-length v6, v6

    if-ge v1, v6, :cond_6

    iget-object v6, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbj:[Ljava/lang/String;

    aget-object v6, v6, v1

    if-eqz v6, :cond_5

    add-int/lit8 v5, v5, 0x1

    invoke-static {v6}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzam(Ljava/lang/String;)I

    move-result v6

    add-int/2addr v4, v6

    :cond_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_6
    add-int/2addr v0, v4

    mul-int/lit8 v5, v5, 0x1

    add-int/2addr v0, v5

    :cond_7
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzag:Ljava/lang/String;

    if-eqz v1, :cond_8

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzag:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    const/16 v1, 0x8

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzag:Ljava/lang/String;

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_8
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbk:Z

    if-eqz v1, :cond_9

    const/16 v1, 0x9

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    add-int/2addr v0, v1

    :cond_9
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbl:Z

    if-eqz v1, :cond_a

    const/16 v1, 0xa

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    add-int/2addr v0, v1

    :cond_a
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbm:Ljava/lang/String;

    if-eqz v1, :cond_b

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbm:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    const/16 v1, 0xb

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbm:Ljava/lang/String;

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_b
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbn:Ljava/lang/String;

    if-eqz v1, :cond_c

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbn:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_c

    const/16 v1, 0xc

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbn:Ljava/lang/String;

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_c
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbo:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    if-eqz v1, :cond_d

    const/16 v1, 0xd

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbo:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzc(ILcom/google/android/gms/internal/firebase_auth/zzeh;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_d
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbp:Z

    if-eqz v1, :cond_e

    const/16 v1, 0xe

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    add-int/2addr v0, v1

    :cond_e
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbq:Ljava/lang/String;

    if-eqz v1, :cond_f

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbq:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_f

    const/16 v1, 0xf

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbq:Ljava/lang/String;

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_f
    iget-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzae:J

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    if-eqz v1, :cond_10

    const/16 v1, 0x10

    iget-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzae:J

    invoke-static {v1, v4, v5}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzd(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_10
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbr:Ljava/lang/String;

    if-eqz v1, :cond_11

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbr:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_11

    const/16 v1, 0x11

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbr:Ljava/lang/String;

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_11
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    if-eqz v1, :cond_13

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    array-length v1, v1

    if-lez v1, :cond_13

    const/4 v1, 0x0

    const/4 v4, 0x0

    :goto_1
    iget-object v5, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    array-length v5, v5

    if-ge v1, v5, :cond_12

    iget-object v5, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    aget v5, v5, v1

    invoke-static {v5}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzab(I)I

    move-result v5

    add-int/2addr v4, v5

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_12
    add-int/2addr v0, v4

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    array-length v1, v1

    mul-int/lit8 v1, v1, 0x2

    add-int/2addr v0, v1

    :cond_13
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbt:Z

    if-eqz v1, :cond_14

    const/16 v1, 0x13

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    add-int/2addr v0, v1

    :cond_14
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    if-eqz v1, :cond_17

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    array-length v1, v1

    if-lez v1, :cond_17

    const/4 v1, 0x0

    const/4 v4, 0x0

    :goto_2
    iget-object v5, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    array-length v5, v5

    if-ge v3, v5, :cond_16

    iget-object v5, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    aget-object v5, v5, v3

    if-eqz v5, :cond_15

    add-int/lit8 v4, v4, 0x1

    invoke-static {v5}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzam(Ljava/lang/String;)I

    move-result v5

    add-int/2addr v1, v5

    :cond_15
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_16
    add-int/2addr v0, v1

    mul-int/lit8 v4, v4, 0x2

    add-int/2addr v0, v4

    :cond_17
    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbv:J

    cmp-long v3, v1, v6

    if-eqz v3, :cond_18

    const/16 v1, 0x15

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbv:J

    invoke-static {v1, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzd(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_18
    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbw:J

    cmp-long v3, v1, v6

    if-eqz v3, :cond_19

    const/16 v1, 0x16

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbw:J

    invoke-static {v1, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzd(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_19
    return v0
.end method
