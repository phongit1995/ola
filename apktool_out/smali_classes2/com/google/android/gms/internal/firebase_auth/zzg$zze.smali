.class public final Lcom/google/android/gms/internal/firebase_auth/zzg$zze;
.super Lcom/google/android/gms/internal/firebase_auth/zzgn;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/internal/firebase_auth/zzg;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "zze"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/firebase_auth/zzgn<",
        "Lcom/google/android/gms/internal/firebase_auth/zzg$zze;",
        ">;"
    }
.end annotation


# instance fields
.field private zzad:Ljava/lang/String;

.field public zzaf:Ljava/lang/String;

.field public zzah:Ljava/lang/String;

.field public zzai:Ljava/lang/String;

.field public zzaj:J

.field private zzas:Ljava/lang/String;

.field public zzbh:Ljava/lang/String;

.field private zzbj:[Ljava/lang/String;

.field public zzbk:Z

.field public zzbr:Ljava/lang/String;

.field public zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

.field public zzby:Ljava/lang/String;

.field private zzw:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzw:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzad:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzah:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbh:Ljava/lang/String;

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzgw;->EMPTY_STRING_ARRAY:[Ljava/lang/String;

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaf:Ljava/lang/String;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzt;->zzc()[Lcom/google/android/gms/internal/firebase_auth/zzt;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzas:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbr:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzai:Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaj:J

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzby:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbk:Z

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzya:I

    return-void
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
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbk:Z

    goto :goto_0

    :sswitch_1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzby:Ljava/lang/String;

    goto :goto_0

    :sswitch_2
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaj:J

    goto :goto_0

    :sswitch_3
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzai:Ljava/lang/String;

    goto :goto_0

    :sswitch_4
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbr:Ljava/lang/String;

    goto :goto_0

    :sswitch_5
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzas:Ljava/lang/String;

    goto :goto_0

    :sswitch_6
    const/16 v0, 0x3a

    invoke-static {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I

    move-result v0

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    if-nez v2, :cond_1

    const/4 v2, 0x0

    goto :goto_1

    :cond_1
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    array-length v2, v2

    :goto_1
    add-int/2addr v0, v2

    new-array v0, v0, [Lcom/google/android/gms/internal/firebase_auth/zzt;

    if-eqz v2, :cond_2

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

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

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    goto :goto_0

    :sswitch_7
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaf:Ljava/lang/String;

    goto :goto_0

    :sswitch_8
    const/16 v0, 0x2a

    invoke-static {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I

    move-result v0

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

    if-nez v2, :cond_4

    const/4 v2, 0x0

    goto :goto_3

    :cond_4
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

    array-length v2, v2

    :goto_3
    add-int/2addr v0, v2

    new-array v0, v0, [Ljava/lang/String;

    if-eqz v2, :cond_5

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

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

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_9
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbh:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_a
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzah:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_b
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzad:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_c
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzw:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_d
    return-object p0

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_d
        0xa -> :sswitch_c
        0x12 -> :sswitch_b
        0x1a -> :sswitch_a
        0x22 -> :sswitch_9
        0x2a -> :sswitch_8
        0x32 -> :sswitch_7
        0x3a -> :sswitch_6
        0x42 -> :sswitch_5
        0x4a -> :sswitch_4
        0x52 -> :sswitch_3
        0x58 -> :sswitch_2
        0x62 -> :sswitch_1
        0x68 -> :sswitch_0
    .end sparse-switch
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V
    .locals 5

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzw:Ljava/lang/String;

    const/4 v1, 0x1

    invoke-virtual {p1, v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzad:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzad:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzad:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzah:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzah:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x3

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzah:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbh:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbh:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x4

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbh:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_4

    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_4

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

    aget-object v2, v2, v0

    if-eqz v2, :cond_3

    const/4 v3, 0x5

    invoke-virtual {p1, v3, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaf:Ljava/lang/String;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaf:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    const/4 v0, 0x6

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaf:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    array-length v0, v0

    if-lez v0, :cond_7

    :goto_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    array-length v0, v0

    if-ge v1, v0, :cond_7

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    aget-object v0, v0, v1

    if-eqz v0, :cond_6

    const/4 v2, 0x7

    invoke-virtual {p1, v2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILcom/google/android/gms/internal/firebase_auth/zzgt;)V

    :cond_6
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzas:Ljava/lang/String;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzas:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    const/16 v0, 0x8

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzas:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbr:Ljava/lang/String;

    if-eqz v0, :cond_9

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbr:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_9

    const/16 v0, 0x9

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbr:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_9
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzai:Ljava/lang/String;

    if-eqz v0, :cond_a

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzai:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_a

    const/16 v0, 0xa

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzai:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_a
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaj:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_b

    const/16 v0, 0xb

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaj:J

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzi(IJ)V

    :cond_b
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzby:Ljava/lang/String;

    if-eqz v0, :cond_c

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzby:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_c

    const/16 v0, 0xc

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzby:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_c
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbk:Z

    if-eqz v0, :cond_d

    const/16 v0, 0xd

    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbk:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_d
    invoke-super {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V

    return-void
.end method

.method protected final zzb()I
    .locals 7

    invoke-super {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzb()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzw:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-static {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzad:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzad:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x2

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzad:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzah:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzah:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const/4 v1, 0x3

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzah:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_1
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbh:Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbh:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const/4 v1, 0x4

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbh:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

    const/4 v3, 0x0

    if-eqz v1, :cond_5

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

    array-length v1, v1

    if-lez v1, :cond_5

    const/4 v1, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    :goto_0
    iget-object v6, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

    array-length v6, v6

    if-ge v1, v6, :cond_4

    iget-object v6, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbj:[Ljava/lang/String;

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
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaf:Ljava/lang/String;

    if-eqz v1, :cond_6

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaf:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    const/4 v1, 0x6

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaf:Ljava/lang/String;

    invoke-static {v1, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_6
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    if-eqz v1, :cond_8

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    array-length v1, v1

    if-lez v1, :cond_8

    :goto_1
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    array-length v1, v1

    if-ge v3, v1, :cond_8

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    aget-object v1, v1, v3

    if-eqz v1, :cond_7

    const/4 v4, 0x7

    invoke-static {v4, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILcom/google/android/gms/internal/firebase_auth/zzgt;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_7
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_8
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzas:Ljava/lang/String;

    if-eqz v1, :cond_9

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzas:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_9

    const/16 v1, 0x8

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzas:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_9
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbr:Ljava/lang/String;

    if-eqz v1, :cond_a

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbr:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_a

    const/16 v1, 0x9

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbr:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_a
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzai:Ljava/lang/String;

    if-eqz v1, :cond_b

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzai:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    const/16 v1, 0xa

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzai:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_b
    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaj:J

    const-wide/16 v5, 0x0

    cmp-long v1, v3, v5

    if-eqz v1, :cond_c

    const/16 v1, 0xb

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaj:J

    invoke-static {v1, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzd(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_c
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzby:Ljava/lang/String;

    if-eqz v1, :cond_d

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzby:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_d

    const/16 v1, 0xc

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzby:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_d
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbk:Z

    if-eqz v1, :cond_e

    const/16 v1, 0xd

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_e
    return v0
.end method
