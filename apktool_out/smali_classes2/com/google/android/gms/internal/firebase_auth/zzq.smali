.class public final Lcom/google/android/gms/internal/firebase_auth/zzq;
.super Lcom/google/android/gms/internal/firebase_auth/zzgn;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/firebase_auth/zzgn<",
        "Lcom/google/android/gms/internal/firebase_auth/zzq;",
        ">;"
    }
.end annotation


# instance fields
.field private zzae:J

.field public zzaf:Ljava/lang/String;

.field private zzbq:Ljava/lang/String;

.field public zzbt:Z

.field public zzca:Ljava/lang/String;

.field public zzcb:Ljava/lang/String;

.field private zzcc:Ljava/lang/String;

.field private zzcd:Z

.field private zzce:Z

.field public zzcf:Z

.field public zzr:Ljava/lang/String;

.field private zzu:Ljava/lang/String;

.field private zzv:J


# direct methods
.method public constructor <init>()V
    .locals 4

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzca:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcb:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcc:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcd:Z

    const-string v1, ""

    iput-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzr:Ljava/lang/String;

    const-string v1, ""

    iput-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbq:Ljava/lang/String;

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzae:J

    const-string v3, ""

    iput-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzaf:Ljava/lang/String;

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbt:Z

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzce:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcf:Z

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzu:Ljava/lang/String;

    iput-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzv:J

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzya:I

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

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzv:J

    goto :goto_0

    :sswitch_1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzu:Ljava/lang/String;

    goto :goto_0

    :sswitch_2
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcf:Z

    goto :goto_0

    :sswitch_3
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzce:Z

    goto :goto_0

    :sswitch_4
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbt:Z

    goto :goto_0

    :sswitch_5
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzaf:Ljava/lang/String;

    goto :goto_0

    :sswitch_6
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcv()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzae:J

    goto :goto_0

    :sswitch_7
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbq:Ljava/lang/String;

    goto :goto_0

    :sswitch_8
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzr:Ljava/lang/String;

    goto :goto_0

    :sswitch_9
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzci()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcd:Z

    goto :goto_0

    :sswitch_a
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcc:Ljava/lang/String;

    goto :goto_0

    :sswitch_b
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcb:Ljava/lang/String;

    goto :goto_0

    :sswitch_c
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzca:Ljava/lang/String;

    goto :goto_0

    :sswitch_d
    return-object p0

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_d
        0xa -> :sswitch_c
        0x12 -> :sswitch_b
        0x1a -> :sswitch_a
        0x20 -> :sswitch_9
        0x2a -> :sswitch_8
        0x32 -> :sswitch_7
        0x38 -> :sswitch_6
        0x42 -> :sswitch_5
        0x48 -> :sswitch_4
        0x50 -> :sswitch_3
        0x58 -> :sswitch_2
        0x6a -> :sswitch_1
        0x70 -> :sswitch_0
    .end sparse-switch
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V
    .locals 6

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzca:Ljava/lang/String;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzca:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzca:Ljava/lang/String;

    invoke-virtual {p1, v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcb:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcb:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x2

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcb:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcc:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcc:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x3

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcc:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_2
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcd:Z

    if-eqz v0, :cond_3

    const/4 v0, 0x4

    iget-boolean v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcd:Z

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_3
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzr:Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzr:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    const/4 v0, 0x5

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzr:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_4
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbq:Ljava/lang/String;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbq:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    const/4 v0, 0x6

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbq:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_5
    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzae:J

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-eqz v0, :cond_6

    const/4 v0, 0x7

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzae:J

    invoke-virtual {p1, v0, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzi(IJ)V

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzaf:Ljava/lang/String;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzaf:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_7

    const/16 v0, 0x8

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzaf:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_7
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbt:Z

    if-eqz v0, :cond_8

    const/16 v0, 0x9

    iget-boolean v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbt:Z

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_8
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzce:Z

    if-eqz v0, :cond_9

    const/16 v0, 0xa

    iget-boolean v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzce:Z

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_9
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcf:Z

    if-eq v0, v1, :cond_a

    const/16 v0, 0xb

    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcf:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(IZ)V

    :cond_a
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzu:Ljava/lang/String;

    if-eqz v0, :cond_b

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzu:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_b

    const/16 v0, 0xd

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzu:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    :cond_b
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzv:J

    cmp-long v2, v0, v4

    if-eqz v2, :cond_c

    const/16 v0, 0xe

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzv:J

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(IJ)V

    :cond_c
    invoke-super {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V

    return-void
.end method

.method protected final zzb()I
    .locals 7

    invoke-super {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzb()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzca:Ljava/lang/String;

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzca:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzca:Ljava/lang/String;

    invoke-static {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcb:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcb:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const/4 v1, 0x2

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcb:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_1
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcc:Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcc:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const/4 v1, 0x3

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcc:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_2
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcd:Z

    if-eqz v1, :cond_3

    const/4 v1, 0x4

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzr:Ljava/lang/String;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzr:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    const/4 v1, 0x5

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzr:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_4
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbq:Ljava/lang/String;

    if-eqz v1, :cond_5

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbq:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    const/4 v1, 0x6

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbq:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_5
    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzae:J

    const-wide/16 v5, 0x0

    cmp-long v1, v3, v5

    if-eqz v1, :cond_6

    const/4 v1, 0x7

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzae:J

    invoke-static {v1, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzd(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_6
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzaf:Ljava/lang/String;

    if-eqz v1, :cond_7

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzaf:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    const/16 v1, 0x8

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzaf:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_7
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzbt:Z

    if-eqz v1, :cond_8

    const/16 v1, 0x9

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_8
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzce:Z

    if-eqz v1, :cond_9

    const/16 v1, 0xa

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_9
    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzcf:Z

    if-eq v1, v2, :cond_a

    const/16 v1, 0xb

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzaa(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_a
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzu:Ljava/lang/String;

    if-eqz v1, :cond_b

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzu:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    const/16 v1, 0xd

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzu:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_b
    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzv:J

    cmp-long v3, v1, v5

    if-eqz v3, :cond_c

    const/16 v1, 0xe

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzq;->zzv:J

    invoke-static {v1, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zze(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_c
    return v0
.end method
