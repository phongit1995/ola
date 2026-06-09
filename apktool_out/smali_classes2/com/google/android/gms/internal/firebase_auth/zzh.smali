.class public final Lcom/google/android/gms/internal/firebase_auth/zzh;
.super Lcom/google/android/gms/internal/firebase_auth/zzgn;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/firebase_auth/zzgn<",
        "Lcom/google/android/gms/internal/firebase_auth/zzh;",
        ">;"
    }
.end annotation


# instance fields
.field public zzg:Ljava/lang/String;

.field public zzh:Ljava/lang/String;

.field private zzi:Ljava/lang/String;

.field private zzj:Ljava/lang/String;

.field private zzk:Ljava/lang/String;

.field private zzl:Ljava/lang/String;

.field private zzm:Ljava/lang/String;

.field private zzn:Ljava/lang/String;

.field private zzo:Ljava/lang/String;

.field private zzp:Ljava/lang/String;

.field private zzq:Ljava/lang/String;

.field private zzr:Ljava/lang/String;

.field private zzs:Ljava/lang/String;

.field private zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

.field private zzu:Ljava/lang/String;

.field private zzv:J


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzg:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzh:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzi:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzj:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzk:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzl:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzm:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzn:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzo:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzp:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzq:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzr:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzs:Ljava/lang/String;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzf;->zza()[Lcom/google/android/gms/internal/firebase_auth/zzf;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzu:Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzv:J

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzya:I

    return-void
.end method


# virtual methods
.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;)Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 4

    :cond_0
    :goto_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    invoke-super {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)Z

    move-result v0

    if-nez v0, :cond_0

    return-object p0

    :sswitch_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzv:J

    goto :goto_0

    :sswitch_1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzu:Ljava/lang/String;

    goto :goto_0

    :sswitch_2
    const/16 v0, 0x72

    invoke-static {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    const/4 v1, 0x0

    goto :goto_1

    :cond_1
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    array-length v1, v1

    :goto_1
    add-int/2addr v0, v1

    new-array v0, v0, [Lcom/google/android/gms/internal/firebase_auth/zzf;

    if-eqz v1, :cond_2

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    invoke-static {v3, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_2
    :goto_2
    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    if-ge v1, v2, :cond_3

    new-instance v2, Lcom/google/android/gms/internal/firebase_auth/zzf;

    invoke-direct {v2}, Lcom/google/android/gms/internal/firebase_auth/zzf;-><init>()V

    aput-object v2, v0, v1

    aget-object v2, v0, v1

    invoke-virtual {p1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgt;)V

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_3
    new-instance v2, Lcom/google/android/gms/internal/firebase_auth/zzf;

    invoke-direct {v2}, Lcom/google/android/gms/internal/firebase_auth/zzf;-><init>()V

    aput-object v2, v0, v1

    aget-object v1, v0, v1

    invoke-virtual {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgt;)V

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    goto :goto_0

    :sswitch_3
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzs:Ljava/lang/String;

    goto :goto_0

    :sswitch_4
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzr:Ljava/lang/String;

    goto :goto_0

    :sswitch_5
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzq:Ljava/lang/String;

    goto :goto_0

    :sswitch_6
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzp:Ljava/lang/String;

    goto :goto_0

    :sswitch_7
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzo:Ljava/lang/String;

    goto :goto_0

    :sswitch_8
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzn:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_9
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzm:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_a
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzl:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_b
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzk:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_c
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzj:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_d
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzi:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_e
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzh:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_f
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzg:Ljava/lang/String;

    goto/16 :goto_0

    :sswitch_10
    return-object p0

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_10
        0xa -> :sswitch_f
        0x12 -> :sswitch_e
        0x1a -> :sswitch_d
        0x22 -> :sswitch_c
        0x2a -> :sswitch_b
        0x32 -> :sswitch_a
        0x3a -> :sswitch_9
        0x42 -> :sswitch_8
        0x4a -> :sswitch_7
        0x52 -> :sswitch_6
        0x5a -> :sswitch_5
        0x62 -> :sswitch_4
        0x6a -> :sswitch_3
        0x72 -> :sswitch_2
        0x7a -> :sswitch_1
        0x80 -> :sswitch_0
    .end sparse-switch
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V
    .locals 5

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzg:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzg:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzg:Ljava/lang/String;

    const/4 v1, 0x1

    invoke-virtual {p1, v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzh:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzh:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzh:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzi:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzi:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x3

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzi:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzj:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzj:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const/4 v0, 0x4

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzj:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_3
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzk:Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzk:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    const/4 v0, 0x5

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzk:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_4
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzl:Ljava/lang/String;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzl:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    const/4 v0, 0x6

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzl:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzm:Ljava/lang/String;

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzm:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6

    const/4 v0, 0x7

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzm:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzn:Ljava/lang/String;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzn:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_7

    const/16 v0, 0x8

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzn:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzo:Ljava/lang/String;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzo:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    const/16 v0, 0x9

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzo:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzp:Ljava/lang/String;

    if-eqz v0, :cond_9

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzp:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_9

    const/16 v0, 0xa

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzp:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_9
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzq:Ljava/lang/String;

    if-eqz v0, :cond_a

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzq:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_a

    const/16 v0, 0xb

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzq:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_a
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzr:Ljava/lang/String;

    if-eqz v0, :cond_b

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzr:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_b

    const/16 v0, 0xc

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzr:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_b
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzs:Ljava/lang/String;

    if-eqz v0, :cond_c

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzs:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_c

    const/16 v0, 0xd

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzs:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_c
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    if-eqz v0, :cond_e

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    array-length v0, v0

    if-lez v0, :cond_e

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    array-length v1, v1

    if-ge v0, v1, :cond_e

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    aget-object v1, v1, v0

    if-eqz v1, :cond_d

    const/16 v2, 0xe

    invoke-virtual {p1, v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILcom/google/android/gms/internal/firebase_auth/zzgt;)V

    :cond_d
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_e
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzu:Ljava/lang/String;

    if-eqz v0, :cond_f

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzu:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_f

    const/16 v0, 0xf

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzu:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_f
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzv:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_10

    const/16 v0, 0x10

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzv:J

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(IJ)V

    :cond_10
    invoke-super {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V

    return-void
.end method

.method protected final zzb()I
    .locals 6

    invoke-super {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzb()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzg:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzg:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzg:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-static {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzh:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzh:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const/4 v1, 0x2

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzh:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_1
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzi:Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzi:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const/4 v1, 0x3

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzi:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzj:Ljava/lang/String;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzj:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    const/4 v1, 0x4

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzj:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzk:Ljava/lang/String;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzk:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    const/4 v1, 0x5

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzk:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_4
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzl:Ljava/lang/String;

    if-eqz v1, :cond_5

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzl:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    const/4 v1, 0x6

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzl:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_5
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzm:Ljava/lang/String;

    if-eqz v1, :cond_6

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzm:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    const/4 v1, 0x7

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzm:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_6
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzn:Ljava/lang/String;

    if-eqz v1, :cond_7

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzn:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    const/16 v1, 0x8

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzn:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_7
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzo:Ljava/lang/String;

    if-eqz v1, :cond_8

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzo:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    const/16 v1, 0x9

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzo:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_8
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzp:Ljava/lang/String;

    if-eqz v1, :cond_9

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzp:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_9

    const/16 v1, 0xa

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzp:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_9
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzq:Ljava/lang/String;

    if-eqz v1, :cond_a

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzq:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_a

    const/16 v1, 0xb

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzq:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_a
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzr:Ljava/lang/String;

    if-eqz v1, :cond_b

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzr:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    const/16 v1, 0xc

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzr:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_b
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzs:Ljava/lang/String;

    if-eqz v1, :cond_c

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzs:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_c

    const/16 v1, 0xd

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzs:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_c
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    if-eqz v1, :cond_e

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    array-length v1, v1

    if-lez v1, :cond_e

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    array-length v2, v2

    if-ge v1, v2, :cond_e

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzt:[Lcom/google/android/gms/internal/firebase_auth/zzf;

    aget-object v2, v2, v1

    if-eqz v2, :cond_d

    const/16 v3, 0xe

    invoke-static {v3, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILcom/google/android/gms/internal/firebase_auth/zzgt;)I

    move-result v2

    add-int/2addr v0, v2

    :cond_d
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_e
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzu:Ljava/lang/String;

    if-eqz v1, :cond_f

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzu:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_f

    const/16 v1, 0xf

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzu:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_f
    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzv:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-eqz v5, :cond_10

    const/16 v1, 0x10

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzh;->zzv:J

    invoke-static {v1, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zze(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_10
    return v0
.end method
