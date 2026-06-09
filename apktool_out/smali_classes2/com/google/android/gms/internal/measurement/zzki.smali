.class public final Lcom/google/android/gms/internal/measurement/zzki;
.super Lcom/google/android/gms/internal/measurement/zzacd;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/measurement/zzacd<",
        "Lcom/google/android/gms/internal/measurement/zzki;",
        ">;"
    }
.end annotation


# static fields
.field private static volatile zzatp:[Lcom/google/android/gms/internal/measurement/zzki;


# instance fields
.field public zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

.field public zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

.field public zzats:Ljava/lang/Boolean;

.field public zzatt:Ljava/lang/String;

.field public zzatu:Ljava/lang/Boolean;

.field public zzatv:Ljava/lang/Boolean;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/google/android/gms/internal/measurement/zzacd;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzbzo:I

    return-void
.end method

.method public static zzls()[Lcom/google/android/gms/internal/measurement/zzki;
    .locals 2

    sget-object v0, Lcom/google/android/gms/internal/measurement/zzki;->zzatp:[Lcom/google/android/gms/internal/measurement/zzki;

    if-nez v0, :cond_1

    sget-object v0, Lcom/google/android/gms/internal/measurement/zzach;->zzbzn:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/google/android/gms/internal/measurement/zzki;->zzatp:[Lcom/google/android/gms/internal/measurement/zzki;

    if-nez v1, :cond_0

    const/4 v1, 0x0

    new-array v1, v1, [Lcom/google/android/gms/internal/measurement/zzki;

    sput-object v1, Lcom/google/android/gms/internal/measurement/zzki;->zzatp:[Lcom/google/android/gms/internal/measurement/zzki;

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
    sget-object v0, Lcom/google/android/gms/internal/measurement/zzki;->zzatp:[Lcom/google/android/gms/internal/measurement/zzki;

    return-object v0
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/google/android/gms/internal/measurement/zzki;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    check-cast p1, Lcom/google/android/gms/internal/measurement/zzki;

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    if-nez v1, :cond_2

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    if-eqz v1, :cond_3

    return v2

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    invoke-virtual {v1, v3}, Lcom/google/android/gms/internal/measurement/zzkl;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    return v2

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    if-nez v1, :cond_4

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    if-eqz v1, :cond_5

    return v2

    :cond_4
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    invoke-virtual {v1, v3}, Lcom/google/android/gms/internal/measurement/zzkj;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    return v2

    :cond_5
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    if-nez v1, :cond_6

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    if-eqz v1, :cond_7

    return v2

    :cond_6
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    invoke-virtual {v1, v3}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    return v2

    :cond_7
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    if-nez v1, :cond_8

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    if-eqz v1, :cond_9

    return v2

    :cond_8
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_9

    return v2

    :cond_9
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    if-nez v1, :cond_a

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    if-eqz v1, :cond_b

    return v2

    :cond_a
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    invoke-virtual {v1, v3}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    return v2

    :cond_b
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    if-nez v1, :cond_c

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    if-eqz v1, :cond_d

    return v2

    :cond_c
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    invoke-virtual {v1, v3}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_d

    return v2

    :cond_d
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    if-eqz v1, :cond_f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/measurement/zzacf;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_e

    goto :goto_0

    :cond_e
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    iget-object p1, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/measurement/zzacf;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1

    :cond_f
    :goto_0
    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    if-eqz v1, :cond_11

    iget-object p1, p1, Lcom/google/android/gms/internal/measurement/zzki;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzacf;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_10

    return v0

    :cond_10
    return v2

    :cond_11
    return v0
.end method

.method public final hashCode()I
    .locals 3

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    add-int/lit16 v0, v0, 0x20f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    mul-int/lit8 v0, v0, 0x1f

    const/4 v2, 0x0

    if-nez v1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {v1}, Lcom/google/android/gms/internal/measurement/zzkl;->hashCode()I

    move-result v1

    :goto_0
    add-int/2addr v0, v1

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    mul-int/lit8 v0, v0, 0x1f

    if-nez v1, :cond_1

    const/4 v1, 0x0

    goto :goto_1

    :cond_1
    invoke-virtual {v1}, Lcom/google/android/gms/internal/measurement/zzkj;->hashCode()I

    move-result v1

    :goto_1
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    if-nez v1, :cond_2

    const/4 v1, 0x0

    goto :goto_2

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->hashCode()I

    move-result v1

    :goto_2
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    if-nez v1, :cond_3

    const/4 v1, 0x0

    goto :goto_3

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    :goto_3
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    if-nez v1, :cond_4

    const/4 v1, 0x0

    goto :goto_4

    :cond_4
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->hashCode()I

    move-result v1

    :goto_4
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    if-nez v1, :cond_5

    const/4 v1, 0x0

    goto :goto_5

    :cond_5
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->hashCode()I

    move-result v1

    :goto_5
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    if-eqz v1, :cond_7

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/measurement/zzacf;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_6

    goto :goto_6

    :cond_6
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/measurement/zzacf;->hashCode()I

    move-result v2

    :cond_7
    :goto_6
    add-int/2addr v0, v2

    return v0
.end method

.method protected final zza()I
    .locals 4

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzacd;->zza()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    invoke-static {v2, v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zzb(ILcom/google/android/gms/internal/measurement/zzacj;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    if-eqz v1, :cond_1

    const/4 v1, 0x2

    iget-object v3, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/measurement/zzacb;->zzb(ILcom/google/android/gms/internal/measurement/zzacj;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_1
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    if-eqz v1, :cond_2

    const/4 v1, 0x3

    iget-object v3, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    invoke-static {v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zzaq(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    if-eqz v1, :cond_3

    const/4 v1, 0x4

    iget-object v3, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/google/android/gms/internal/measurement/zzacb;->zzc(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    if-eqz v1, :cond_4

    const/4 v1, 0x5

    iget-object v3, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    invoke-static {v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zzaq(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_4
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    if-eqz v1, :cond_5

    const/4 v1, 0x6

    iget-object v3, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    invoke-static {v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zzaq(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_5
    return v0
.end method

.method public final zza(Lcom/google/android/gms/internal/measurement/zzacb;)V
    .locals 2

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zza(ILcom/google/android/gms/internal/measurement/zzacj;)V

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    if-eqz v0, :cond_1

    const/4 v0, 0x2

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zza(ILcom/google/android/gms/internal/measurement/zzacj;)V

    :cond_1
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    if-eqz v0, :cond_2

    const/4 v0, 0x3

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zza(IZ)V

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    if-eqz v0, :cond_3

    const/4 v0, 0x4

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zzb(ILjava/lang/String;)V

    :cond_3
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    if-eqz v0, :cond_4

    const/4 v0, 0x5

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zza(IZ)V

    :cond_4
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    if-eqz v0, :cond_5

    const/4 v0, 0x6

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zza(IZ)V

    :cond_5
    invoke-super {p0, p1}, Lcom/google/android/gms/internal/measurement/zzacd;->zza(Lcom/google/android/gms/internal/measurement/zzacb;)V

    return-void
.end method

.method public final synthetic zzb(Lcom/google/android/gms/internal/measurement/zzaca;)Lcom/google/android/gms/internal/measurement/zzacj;
    .locals 2

    :cond_0
    :goto_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->zzvl()I

    move-result v0

    if-eqz v0, :cond_9

    const/16 v1, 0xa

    if-eq v0, v1, :cond_7

    const/16 v1, 0x12

    if-eq v0, v1, :cond_5

    const/16 v1, 0x18

    if-eq v0, v1, :cond_4

    const/16 v1, 0x22

    if-eq v0, v1, :cond_3

    const/16 v1, 0x28

    if-eq v0, v1, :cond_2

    const/16 v1, 0x30

    if-eq v0, v1, :cond_1

    invoke-super {p0, p1, v0}, Lcom/google/android/gms/internal/measurement/zzacd;->zza(Lcom/google/android/gms/internal/measurement/zzaca;I)Z

    move-result v0

    if-nez v0, :cond_0

    return-object p0

    :cond_1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->zzvm()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatv:Ljava/lang/Boolean;

    goto :goto_0

    :cond_2
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->zzvm()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatu:Ljava/lang/Boolean;

    goto :goto_0

    :cond_3
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatt:Ljava/lang/String;

    goto :goto_0

    :cond_4
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->zzvm()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzats:Ljava/lang/Boolean;

    goto :goto_0

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    if-nez v0, :cond_6

    new-instance v0, Lcom/google/android/gms/internal/measurement/zzkj;

    invoke-direct {v0}, Lcom/google/android/gms/internal/measurement/zzkj;-><init>()V

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatr:Lcom/google/android/gms/internal/measurement/zzkj;

    goto :goto_1

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    if-nez v0, :cond_8

    new-instance v0, Lcom/google/android/gms/internal/measurement/zzkl;

    invoke-direct {v0}, Lcom/google/android/gms/internal/measurement/zzkl;-><init>()V

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzki;->zzatq:Lcom/google/android/gms/internal/measurement/zzkl;

    :goto_1
    invoke-virtual {p1, v0}, Lcom/google/android/gms/internal/measurement/zzaca;->zza(Lcom/google/android/gms/internal/measurement/zzacj;)V

    goto :goto_0

    :cond_9
    return-object p0
.end method
