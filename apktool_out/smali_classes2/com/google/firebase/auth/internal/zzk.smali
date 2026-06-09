.class public final Lcom/google/firebase/auth/internal/zzk;
.super Lcom/google/firebase/auth/FirebaseAuthSettings;


# instance fields
.field private zzbd:Ljava/lang/String;

.field private zzez:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/google/firebase/auth/FirebaseAuthSettings;-><init>()V

    return-void
.end method


# virtual methods
.method public final getPhoneNumber()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/firebase/auth/internal/zzk;->zzbd:Ljava/lang/String;

    return-object v0
.end method

.method public final getSmsCode()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/firebase/auth/internal/zzk;->zzez:Ljava/lang/String;

    return-object v0
.end method

.method public final setAutoRetrievedSmsCodeForPhoneNumber(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/google/firebase/auth/internal/zzk;->zzbd:Ljava/lang/String;

    iput-object p2, p0, Lcom/google/firebase/auth/internal/zzk;->zzez:Ljava/lang/String;

    return-void
.end method

.method public final zzbf()Z
    .locals 1

    iget-object v0, p0, Lcom/google/firebase/auth/internal/zzk;->zzbd:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/firebase/auth/internal/zzk;->zzez:Ljava/lang/String;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method
