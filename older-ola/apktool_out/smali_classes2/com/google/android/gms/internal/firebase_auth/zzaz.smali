.class public final Lcom/google/android/gms/internal/firebase_auth/zzaz;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdp;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzdp<",
        "Lcom/google/android/gms/internal/firebase_auth/zzo;",
        ">;"
    }
.end annotation


# instance fields
.field private zzaf:Ljava/lang/String;

.field private zzag:Ljava/lang/String;

.field private zzah:Ljava/lang/String;

.field private zzbh:Ljava/lang/String;

.field private zzbi:Ljava/lang/String;

.field private zzbr:Ljava/lang/String;

.field private zzbt:Z

.field private zzke:Lcom/google/android/gms/internal/firebase_auth/zzbd;

.field private zzkf:Lcom/google/android/gms/internal/firebase_auth/zzbd;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzbt:Z

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzbd;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzbd;-><init>()V

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzkf:Lcom/google/android/gms/internal/firebase_auth/zzbd;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzbd;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzbd;-><init>()V

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzke:Lcom/google/android/gms/internal/firebase_auth/zzbd;

    return-void
.end method


# virtual methods
.method public final getDisplayName()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzbh:Ljava/lang/String;

    return-object v0
.end method

.method public final getEmail()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzah:Ljava/lang/String;

    return-object v0
.end method

.method public final getPassword()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzbi:Ljava/lang/String;

    return-object v0
.end method

.method public final zzaa(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzke:Lcom/google/android/gms/internal/firebase_auth/zzbd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzbd;->zzbc()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0
.end method

.method public final zzab(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzag:Ljava/lang/String;

    return-object p0
.end method

.method public final synthetic zzao()Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 11

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzo;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzo;-><init>()V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzaf:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzaf:Ljava/lang/String;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzah:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzah:Ljava/lang/String;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzbi:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbi:Ljava/lang/String;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzbh:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbh:Ljava/lang/String;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzbr:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbr:Ljava/lang/String;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzke:Lcom/google/android/gms/internal/firebase_auth/zzbd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzbd;->zzbc()Ljava/util/List;

    move-result-object v1

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzke:Lcom/google/android/gms/internal/firebase_auth/zzbd;

    invoke-virtual {v2}, Lcom/google/android/gms/internal/firebase_auth/zzbd;->zzbc()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    new-array v2, v2, [Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbu:[Ljava/lang/String;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzkf:Lcom/google/android/gms/internal/firebase_auth/zzbd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzbd;->zzbc()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    new-array v2, v2, [I

    const/4 v3, 0x0

    const/4 v4, 0x0

    :goto_0
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v5

    if-ge v4, v5, :cond_5

    invoke-interface {v1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    const/4 v6, -0x1

    invoke-virtual {v5}, Ljava/lang/String;->hashCode()I

    move-result v7

    const v8, -0x13d9e3f8

    const/4 v9, 0x2

    const/4 v10, 0x1

    if-eq v7, v8, :cond_3

    const v8, 0x3f0537c

    if-eq v7, v8, :cond_2

    const v8, 0x73a065a2

    if-eq v7, v8, :cond_1

    const v8, 0x772faa9b

    if-eq v7, v8, :cond_0

    goto :goto_1

    :cond_0
    const-string v7, "PASSWORD"

    invoke-virtual {v5, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    const/4 v5, 0x2

    goto :goto_2

    :cond_1
    const-string v7, "PHOTO_URL"

    invoke-virtual {v5, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    const/4 v5, 0x3

    goto :goto_2

    :cond_2
    const-string v7, "EMAIL"

    invoke-virtual {v5, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    const/4 v5, 0x0

    goto :goto_2

    :cond_3
    const-string v7, "DISPLAY_NAME"

    invoke-virtual {v5, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    const/4 v5, 0x1

    goto :goto_2

    :cond_4
    :goto_1
    const/4 v5, -0x1

    :goto_2
    packed-switch v5, :pswitch_data_0

    const/high16 v9, -0x80000000

    goto :goto_3

    :pswitch_0
    const/4 v9, 0x4

    goto :goto_3

    :pswitch_1
    const/4 v9, 0x5

    goto :goto_3

    :pswitch_2
    const/4 v9, 0x1

    :goto_3
    :pswitch_3
    aput v9, v2, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_5
    iput-object v2, v0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbs:[I

    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzbt:Z

    iput-boolean v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzbt:Z

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzag:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzo;->zzag:Ljava/lang/String;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_3
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public final zzt()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzbr:Ljava/lang/String;

    return-object v0
.end method

.method public final zzu(Ljava/lang/String;)Z
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzkf:Lcom/google/android/gms/internal/firebase_auth/zzbd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzbd;->zzbc()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public final zzv(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzaf:Ljava/lang/String;

    return-object p0
.end method

.method public final zzw(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzkf:Lcom/google/android/gms/internal/firebase_auth/zzbd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzbd;->zzbc()Ljava/util/List;

    move-result-object p1

    const-string v0, "EMAIL"

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0

    :cond_0
    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzah:Ljava/lang/String;

    return-object p0
.end method

.method public final zzx(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzkf:Lcom/google/android/gms/internal/firebase_auth/zzbd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzbd;->zzbc()Ljava/util/List;

    move-result-object p1

    const-string v0, "PASSWORD"

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0

    :cond_0
    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzbi:Ljava/lang/String;

    return-object p0
.end method

.method public final zzy(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzkf:Lcom/google/android/gms/internal/firebase_auth/zzbd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzbd;->zzbc()Ljava/util/List;

    move-result-object p1

    const-string v0, "DISPLAY_NAME"

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0

    :cond_0
    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzbh:Ljava/lang/String;

    return-object p0
.end method

.method public final zzz(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzkf:Lcom/google/android/gms/internal/firebase_auth/zzbd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzbd;->zzbc()Ljava/util/List;

    move-result-object p1

    const-string v0, "PHOTO_URL"

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0

    :cond_0
    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzbr:Ljava/lang/String;

    return-object p0
.end method
