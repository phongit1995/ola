.class public final Lcom/google/android/gms/internal/firebase_auth/zzu;
.super Lcom/google/android/gms/internal/firebase_auth/zzgn;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/firebase_auth/zzgn<",
        "Lcom/google/android/gms/internal/firebase_auth/zzu;",
        ">;"
    }
.end annotation


# static fields
.field private static volatile zzdl:[Lcom/google/android/gms/internal/firebase_auth/zzu;


# instance fields
.field private version:I

.field public zzad:Ljava/lang/String;

.field public zzah:Ljava/lang/String;

.field public zzbd:Ljava/lang/String;

.field public zzbh:Ljava/lang/String;

.field private zzbj:[Ljava/lang/String;

.field public zzbk:Z

.field public zzbr:Ljava/lang/String;

.field public zzbv:J

.field public zzbw:J

.field public zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

.field private zzbz:Z

.field private zzcl:Ljava/lang/String;

.field private zzcm:Ljava/lang/String;

.field private zzcn:Ljava/lang/String;

.field private zzde:Ljava/lang/String;

.field private zzdm:[B

.field private zzdn:[B

.field private zzdo:J

.field private zzdp:J

.field private zzdq:Z

.field public zzdr:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 4

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzad:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzah:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbh:Ljava/lang/String;

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzgw;->EMPTY_STRING_ARRAY:[Ljava/lang/String;

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcl:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbr:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcm:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcn:Ljava/lang/String;

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyk:[B

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdm:[B

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyk:[B

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdn:[B

    const/4 v0, 0x0

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->version:I

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbk:Z

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdo:J

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzt;->zzc()[Lcom/google/android/gms/internal/firebase_auth/zzt;

    move-result-object v3

    iput-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    iput-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdp:J

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbz:Z

    iput-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbv:J

    iput-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbw:J

    const-string v1, ""

    iput-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzde:Ljava/lang/String;

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdq:Z

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdr:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbd:Ljava/lang/String;

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzya:I

    return-void
.end method

.method public static zzd()[Lcom/google/android/gms/internal/firebase_auth/zzu;
    .locals 2

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdl:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    if-nez v0, :cond_1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzgr;->zzxz:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdl:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    if-nez v1, :cond_0

    const/4 v1, 0x0

    new-array v1, v1, [Lcom/google/android/gms/internal/firebase_auth/zzu;

    sput-object v1, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdl:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    :cond_0
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    :cond_1
    :goto_0
    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdl:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    return-object v0
.end method


# virtual methods
.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;)Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 4

    :cond_0
    :goto_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    move-result v0

    const/4 v1, 0x0

    sparse-switch v0, :sswitch_data_0

    invoke-super {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)Z

    move-result v0

    if-nez v0, :cond_0

    return-object p0

    :sswitch_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbd:Ljava/lang/String;

    goto :goto_0

    :sswitch_1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdr:Ljava/lang/String;

    goto :goto_0

    :sswitch_2
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdq:Z

    goto :goto_0

    :sswitch_3
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzde:Ljava/lang/String;

    goto :goto_0

    :sswitch_4
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbw:J

    goto :goto_0

    :sswitch_5
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbv:J

    goto :goto_0

    :sswitch_6
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbz:Z

    goto :goto_0

    :sswitch_7
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdp:J

    goto :goto_0

    :sswitch_8
    const/16 v0, 0x72

    invoke-static {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I

    move-result v0

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    if-nez v2, :cond_1

    const/4 v2, 0x0

    goto :goto_1

    :cond_1
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    array-length v2, v2

    :goto_1
    add-int/2addr v0, v2

    new-array v0, v0, [Lcom/google/android/gms/internal/firebase_auth/zzt;

    if-eqz v2, :cond_2

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    invoke-static {v3, v1, v0, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_2
    :goto_2
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    if-ge v2, v1, :cond_3

    new-instance v1, Lcom/google/android/gms/internal/firebase_auth/zzt;

    invoke-direct {v1}, Lcom/google/android/gms/internal/firebase_auth/zzt;-><init>()V

    aput-object v1, v0, v2

    aget-object v1, v0, v2

    invoke-virtual {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgt;)V

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_3
    new-instance v1, Lcom/google/android/gms/internal/firebase_auth/zzt;

    invoke-direct {v1}, Lcom/google/android/gms/internal/firebase_auth/zzt;-><init>()V

    aput-object v1, v0, v2

    aget-object v1, v0, v2

    invoke-virtual {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgt;)V

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    goto/16 :goto_0

    :sswitch_9
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdo:J

    goto/16 :goto_0

    :sswitch_a
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbk:Z

    goto/16 :goto_0

    :sswitch_b
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcu()I

    move-result v0

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->version:I

    goto/16 :goto_0

    :sswitch_c
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readBytes()[B

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdn:[B

    goto/16 :goto_0

    :sswitch_d
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readBytes()[B

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdm:[B

    goto/16 :goto_0

    :sswitch_e
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcn:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_f
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcm:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_10
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbr:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_11
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcl:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_12
    const/16 v0, 0x22

    invoke-static {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I

    move-result v0

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    if-nez v2, :cond_4

    const/4 v2, 0x0

    goto :goto_3

    :cond_4
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    array-length v2, v2

    :goto_3
    add-int/2addr v0, v2

    new-array v0, v0, [Ljava/lang/String;

    if-eqz v2, :cond_5

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    invoke-static {v3, v1, v0, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_5
    :goto_4
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    if-ge v2, v1, :cond_6

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v0, v2

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    :cond_6
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v0, v2

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_13
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbh:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_14
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzah:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_15
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzad:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_16
    return-object p0

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_16
        0xa -> :sswitch_15
        0x12 -> :sswitch_14
        0x1a -> :sswitch_13
        0x22 -> :sswitch_12
        0x2a -> :sswitch_11
        0x32 -> :sswitch_10
        0x3a -> :sswitch_f
        0x42 -> :sswitch_e
        0x4a -> :sswitch_d
        0x52 -> :sswitch_c
        0x58 -> :sswitch_b
        0x60 -> :sswitch_a
        0x68 -> :sswitch_9
        0x72 -> :sswitch_8
        0x78 -> :sswitch_7
        0x80 -> :sswitch_6
        0x88 -> :sswitch_5
        0x90 -> :sswitch_4
        0x9a -> :sswitch_3
        0xa0 -> :sswitch_2
        0xaa -> :sswitch_1
        0xb2 -> :sswitch_0
    .end sparse-switch
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V
    .locals 6

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzad:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzad:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzad:Ljava/lang/String;

    const/4 v1, 0x1

    invoke-virtual {p1, v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzah:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzah:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzah:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbh:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbh:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x3

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbh:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_4

    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_4

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    aget-object v2, v2, v0

    if-eqz v2, :cond_3

    const/4 v3, 0x4

    invoke-virtual {p1, v3, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcl:Ljava/lang/String;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcl:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    const/4 v0, 0x5

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcl:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbr:Ljava/lang/String;

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbr:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6

    const/4 v0, 0x6

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbr:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcm:Ljava/lang/String;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcm:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_7

    const/4 v0, 0x7

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcm:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcn:Ljava/lang/String;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcn:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    const/16 v0, 0x8

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcn:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdm:[B

    sget-object v2, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyk:[B

    invoke-static {v0, v2}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v0

    if-nez v0, :cond_9

    const/16 v0, 0x9

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdm:[B

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(I[B)V

    :cond_9
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdn:[B

    sget-object v2, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyk:[B

    invoke-static {v0, v2}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v0

    if-nez v0, :cond_a

    const/16 v0, 0xa

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdn:[B

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(I[B)V

    :cond_a
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->version:I

    if-eqz v0, :cond_b

    const/16 v0, 0xb

    iget v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->version:I

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzc(II)V

    :cond_b
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbk:Z

    if-eqz v0, :cond_c

    const/16 v0, 0xc

    iget-boolean v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbk:Z

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_c
    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdo:J

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-eqz v0, :cond_d

    const/16 v0, 0xd

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdo:J

    invoke-virtual {p1, v0, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzi(IJ)V

    :cond_d
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    if-eqz v0, :cond_f

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    array-length v0, v0

    if-lez v0, :cond_f

    :goto_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    array-length v0, v0

    if-ge v1, v0, :cond_f

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    aget-object v0, v0, v1

    if-eqz v0, :cond_e

    const/16 v2, 0xe

    invoke-virtual {p1, v2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILcom/google/android/gms/internal/firebase_auth/zzgt;)V

    :cond_e
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_f
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdp:J

    cmp-long v2, v0, v4

    if-eqz v2, :cond_10

    const/16 v0, 0xf

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdp:J

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzi(IJ)V

    :cond_10
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbz:Z

    if-eqz v0, :cond_11

    const/16 v0, 0x10

    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbz:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_11
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbv:J

    cmp-long v2, v0, v4

    if-eqz v2, :cond_12

    const/16 v0, 0x11

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbv:J

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzi(IJ)V

    :cond_12
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbw:J

    cmp-long v2, v0, v4

    if-eqz v2, :cond_13

    const/16 v0, 0x12

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbw:J

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzi(IJ)V

    :cond_13
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzde:Ljava/lang/String;

    if-eqz v0, :cond_14

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzde:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_14

    const/16 v0, 0x13

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzde:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_14
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdq:Z

    if-eqz v0, :cond_15

    const/16 v0, 0x14

    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdq:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_15
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdr:Ljava/lang/String;

    if-eqz v0, :cond_16

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdr:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_16

    const/16 v0, 0x15

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdr:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_16
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbd:Ljava/lang/String;

    if-eqz v0, :cond_17

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbd:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_17

    const/16 v0, 0x16

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbd:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_17
    invoke-super {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V

    return-void
.end method

.method protected final zzb()I
    .locals 8

    invoke-super {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzb()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzad:Ljava/lang/String;

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzad:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzad:Ljava/lang/String;

    invoke-static {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzah:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzah:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const/4 v1, 0x2

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzah:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_1
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbh:Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbh:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const/4 v1, 0x3

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbh:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    const/4 v3, 0x0

    if-eqz v1, :cond_5

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    array-length v1, v1

    if-lez v1, :cond_5

    const/4 v1, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    :goto_0
    iget-object v6, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    array-length v6, v6

    if-ge v1, v6, :cond_4

    iget-object v6, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbj:[Ljava/lang/String;

    aget-object v6, v6, v1

    if-eqz v6, :cond_3

    add-int/lit8 v5, v5, 0x1

    invoke-static {v6}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzam(Ljava/lang/String;)I

    move-result v6

    add-int/2addr v4, v6

    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_4
    add-int/2addr v0, v4

    mul-int/lit8 v5, v5, 0x1

    add-int/2addr v0, v5

    :cond_5
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcl:Ljava/lang/String;

    if-eqz v1, :cond_6

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcl:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    const/4 v1, 0x5

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcl:Ljava/lang/String;

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_6
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbr:Ljava/lang/String;

    if-eqz v1, :cond_7

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbr:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    const/4 v1, 0x6

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbr:Ljava/lang/String;

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_7
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcm:Ljava/lang/String;

    if-eqz v1, :cond_8

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcm:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    const/4 v1, 0x7

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcm:Ljava/lang/String;

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_8
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcn:Ljava/lang/String;

    if-eqz v1, :cond_9

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcn:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_9

    const/16 v1, 0x8

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzcn:Ljava/lang/String;

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_9
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdm:[B

    sget-object v4, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyk:[B

    invoke-static {v1, v4}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v1

    if-nez v1, :cond_a

    const/16 v1, 0x9

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdm:[B

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(I[B)I

    move-result v1

    add-int/2addr v0, v1

    :cond_a
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdn:[B

    sget-object v4, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyk:[B

    invoke-static {v1, v4}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v1

    if-nez v1, :cond_b

    const/16 v1, 0xa

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdn:[B

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(I[B)I

    move-result v1

    add-int/2addr v0, v1

    :cond_b
    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->version:I

    if-eqz v1, :cond_c

    const/16 v1, 0xb

    iget v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->version:I

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzg(II)I

    move-result v1

    add-int/2addr v0, v1

    :cond_c
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbk:Z

    if-eqz v1, :cond_d

    const/16 v1, 0xc

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_d
    iget-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdo:J

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    if-eqz v1, :cond_e

    const/16 v1, 0xd

    iget-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdo:J

    invoke-static {v1, v4, v5}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzd(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_e
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    if-eqz v1, :cond_10

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    array-length v1, v1

    if-lez v1, :cond_10

    :goto_1
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    array-length v1, v1

    if-ge v3, v1, :cond_10

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    aget-object v1, v1, v3

    if-eqz v1, :cond_f

    const/16 v4, 0xe

    invoke-static {v4, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILcom/google/android/gms/internal/firebase_auth/zzgt;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_f
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_10
    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdp:J

    cmp-long v1, v3, v6

    if-eqz v1, :cond_11

    const/16 v1, 0xf

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdp:J

    invoke-static {v1, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzd(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_11
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbz:Z

    if-eqz v1, :cond_12

    const/16 v1, 0x10

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_12
    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbv:J

    cmp-long v1, v3, v6

    if-eqz v1, :cond_13

    const/16 v1, 0x11

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbv:J

    invoke-static {v1, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzd(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_13
    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbw:J

    cmp-long v1, v3, v6

    if-eqz v1, :cond_14

    const/16 v1, 0x12

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbw:J

    invoke-static {v1, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzd(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_14
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzde:Ljava/lang/String;

    if-eqz v1, :cond_15

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzde:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_15

    const/16 v1, 0x13

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzde:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_15
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdq:Z

    if-eqz v1, :cond_16

    const/16 v1, 0x14

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_16
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdr:Ljava/lang/String;

    if-eqz v1, :cond_17

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdr:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_17

    const/16 v1, 0x15

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdr:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_17
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbd:Ljava/lang/String;

    if-eqz v1, :cond_18

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbd:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_18

    const/16 v1, 0x16

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbd:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_18
    return v0
.end method
