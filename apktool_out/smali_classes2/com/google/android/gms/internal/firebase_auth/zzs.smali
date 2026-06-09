.class public final Lcom/google/android/gms/internal/firebase_auth/zzs;
.super Lcom/google/android/gms/internal/firebase_auth/zzgn;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/firebase_auth/zzgn<",
        "Lcom/google/android/gms/internal/firebase_auth/zzs;",
        ">;"
    }
.end annotation


# instance fields
.field private zzae:J

.field private zzaf:Ljava/lang/String;

.field public zzah:Ljava/lang/String;

.field public zzbi:Ljava/lang/String;

.field private zzbm:Ljava/lang/String;

.field private zzbn:Ljava/lang/String;

.field private zzbq:Ljava/lang/String;

.field public zzbt:Z

.field private zzcc:Ljava/lang/String;

.field private zzdi:Ljava/lang/String;

.field private zzu:Ljava/lang/String;

.field private zzv:J


# direct methods
.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzah:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbi:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzcc:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbm:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbn:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzdi:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbq:Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzae:J

    const-string v2, ""

    iput-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzaf:Ljava/lang/String;

    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbt:Z

    const-string v2, ""

    iput-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzu:Ljava/lang/String;

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzv:J

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzya:I

    return-void
.end method


# virtual methods
.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;)Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 2

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

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzv:J

    goto :goto_0

    :sswitch_1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzu:Ljava/lang/String;

    goto :goto_0

    :sswitch_2
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbt:Z

    goto :goto_0

    :sswitch_3
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzaf:Ljava/lang/String;

    goto :goto_0

    :sswitch_4
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzae:J

    goto :goto_0

    :sswitch_5
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbq:Ljava/lang/String;

    goto :goto_0

    :sswitch_6
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzdi:Ljava/lang/String;

    goto :goto_0

    :sswitch_7
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbn:Ljava/lang/String;

    goto :goto_0

    :sswitch_8
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbm:Ljava/lang/String;

    goto :goto_0

    :sswitch_9
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzcc:Ljava/lang/String;

    goto :goto_0

    :sswitch_a
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbi:Ljava/lang/String;

    goto :goto_0

    :sswitch_b
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzah:Ljava/lang/String;

    goto :goto_0

    :sswitch_c
    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_c
        0xa -> :sswitch_b
        0x12 -> :sswitch_a
        0x1a -> :sswitch_9
        0x22 -> :sswitch_8
        0x2a -> :sswitch_7
        0x32 -> :sswitch_6
        0x3a -> :sswitch_5
        0x40 -> :sswitch_4
        0x4a -> :sswitch_3
        0x50 -> :sswitch_2
        0x5a -> :sswitch_1
        0x60 -> :sswitch_0
    .end sparse-switch
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V
    .locals 6

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzah:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzah:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzah:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbi:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbi:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbi:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzcc:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzcc:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x3

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzcc:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbm:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbm:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const/4 v0, 0x4

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbm:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_3
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbn:Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbn:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    const/4 v0, 0x5

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbn:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_4
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzdi:Ljava/lang/String;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzdi:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    const/4 v0, 0x6

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzdi:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbq:Ljava/lang/String;

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbq:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6

    const/4 v0, 0x7

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbq:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_6
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzae:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_7

    const/16 v0, 0x8

    iget-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzae:J

    invoke-virtual {p1, v0, v4, v5}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzi(IJ)V

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzaf:Ljava/lang/String;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzaf:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    const/16 v0, 0x9

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzaf:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_8
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbt:Z

    if-eqz v0, :cond_9

    const/16 v0, 0xa

    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbt:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_9
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzu:Ljava/lang/String;

    if-eqz v0, :cond_a

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzu:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_a

    const/16 v0, 0xb

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzu:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_a
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzv:J

    cmp-long v4, v0, v2

    if-eqz v4, :cond_b

    const/16 v0, 0xc

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzv:J

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(IJ)V

    :cond_b
    invoke-super {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V

    return-void
.end method

.method protected final zzb()I
    .locals 7

    invoke-super {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzb()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzah:Ljava/lang/String;

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzah:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzah:Ljava/lang/String;

    invoke-static {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbi:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbi:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const/4 v1, 0x2

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbi:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_1
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzcc:Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzcc:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const/4 v1, 0x3

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzcc:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbm:Ljava/lang/String;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbm:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    const/4 v1, 0x4

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbm:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbn:Ljava/lang/String;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbn:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    const/4 v1, 0x5

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbn:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_4
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzdi:Ljava/lang/String;

    if-eqz v1, :cond_5

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzdi:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    const/4 v1, 0x6

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzdi:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_5
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbq:Ljava/lang/String;

    if-eqz v1, :cond_6

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbq:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    const/4 v1, 0x7

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbq:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_6
    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzae:J

    const-wide/16 v5, 0x0

    cmp-long v1, v3, v5

    if-eqz v1, :cond_7

    const/16 v1, 0x8

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzae:J

    invoke-static {v1, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzd(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_7
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzaf:Ljava/lang/String;

    if-eqz v1, :cond_8

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzaf:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    const/16 v1, 0x9

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzaf:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_8
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzbt:Z

    if-eqz v1, :cond_9

    const/16 v1, 0xa

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_9
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzu:Ljava/lang/String;

    if-eqz v1, :cond_a

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzu:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_a

    const/16 v1, 0xb

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzu:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_a
    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzv:J

    cmp-long v3, v1, v5

    if-eqz v3, :cond_b

    const/16 v1, 0xc

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzs;->zzv:J

    invoke-static {v1, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zze(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_b
    return v0
.end method
