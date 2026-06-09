.class public Lcom/google/firebase/auth/internal/FederatedSignInActivity;
.super Landroid/support/v4/app/FragmentActivity;


# annotations
.annotation build Lcom/google/android/gms/common/annotation/KeepName;
.end annotation


# static fields
.field private static zzlo:Z = false


# instance fields
.field private zzlp:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/support/v4/app/FragmentActivity;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zzlp:Z

    return-void
.end method

.method private final zza(ILandroid/content/Intent;)V
    .locals 0

    const/4 p1, 0x0

    sput-boolean p1, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zzlo:Z

    const/4 p1, -0x1

    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->finish()V

    return-void
.end method

.method private final zze(I)V
    .locals 0

    const/4 p1, 0x0

    sput-boolean p1, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zzlo:Z

    iput-boolean p1, p0, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zzlp:Z

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->setResult(I)V

    invoke-virtual {p0}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->finish()V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    invoke-super {p0, p1}, Landroid/support/v4/app/FragmentActivity;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    const-string v1, "com.google.firebase.auth.internal.SIGN_IN"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_1

    const-string v1, "com.google.firebase.auth.internal.GET_CRED"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string p1, "IdpSignInActivity"

    const-string v1, "Unknown action: "

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v1, v0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    :goto_0
    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_1
    invoke-virtual {p0, v2}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->setResult(I)V

    invoke-virtual {p0}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->finish()V

    return-void

    :cond_1
    sget-boolean v0, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zzlo:Z

    if-eqz v0, :cond_2

    goto :goto_1

    :cond_2
    const/4 v0, 0x1

    sput-boolean v0, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zzlo:Z

    if-eqz p1, :cond_3

    const-string v0, "com.google.firebase.auth.internal.KEY_STARTED_SIGN_IN"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result p1

    iput-boolean p1, p0, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zzlp:Z

    :cond_3
    return-void
.end method

.method public onNewIntent(Landroid/content/Intent;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/support/v4/app/FragmentActivity;->onNewIntent(Landroid/content/Intent;)V

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->setIntent(Landroid/content/Intent;)V

    return-void
.end method

.method protected onResume()V
    .locals 7

    invoke-super {p0}, Landroid/support/v4/app/FragmentActivity;->onResume()V

    iget-boolean v0, p0, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zzlp:Z

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-nez v0, :cond_0

    new-instance v0, Landroid/content/Intent;

    const-string v3, "com.google.firebase.auth.api.gms.ui.START_WEB_SIGN_IN"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v3, "com.google.android.gms"

    invoke-virtual {v0, v3}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->getIntent()Landroid/content/Intent;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    const-string v3, "com.google.firebase.auth.internal.OPERATION"

    invoke-virtual {p0}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->getIntent()Landroid/content/Intent;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const v3, 0xa003

    :try_start_0
    invoke-virtual {p0, v0, v3}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const-string v0, "IdpSignInActivity"

    const-string v3, "Could not launch web sign-in Intent. Google Play service is unavailable"

    invoke-static {v0, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, v2}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zze(I)V

    :goto_0
    iput-boolean v1, p0, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zzlp:Z

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v3, "com.google.firebase.auth.internal.WEB_SIGN_IN_FAILED"

    invoke-virtual {v0}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    const/4 v4, -0x1

    if-eqz v3, :cond_2

    const-string v3, "IdpSignInActivity"

    const-string v5, "Web sign-in failed, finishing"

    invoke-static {v3, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v0}, Lcom/google/firebase/auth/internal/zzaf;->zza(Landroid/content/Intent;)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-static {v0}, Lcom/google/firebase/auth/internal/zzaf;->zzb(Landroid/content/Intent;)Lcom/google/android/gms/common/api/Status;

    move-result-object v0

    sput-boolean v2, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zzlo:Z

    new-instance v3, Landroid/content/Intent;

    invoke-direct {v3}, Landroid/content/Intent;-><init>()V

    invoke-static {v3, v0}, Lcom/google/firebase/auth/internal/zzaf;->zza(Landroid/content/Intent;Lcom/google/android/gms/common/api/Status;)V

    invoke-virtual {p0, v4, v3}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->finish()V

    goto :goto_2

    :cond_1
    invoke-direct {p0, v2}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zze(I)V

    goto :goto_2

    :cond_2
    const-string v3, "com.google.firebase.auth.internal.OPERATION"

    invoke-virtual {v0, v3}, Landroid/content/Intent;->hasExtra(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    const-string v3, "com.google.firebase.auth.internal.VERIFY_ASSERTION_REQUEST"

    invoke-virtual {v0, v3}, Landroid/content/Intent;->hasExtra(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    const-string v3, "com.google.firebase.auth.internal.OPERATION"

    invoke-virtual {v0, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v5, "com.google.firebase.auth.internal.SIGN_IN"

    invoke-virtual {v5, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    const-string v3, "com.google.firebase.auth.internal.VERIFY_ASSERTION_REQUEST"

    sget-object v5, Lcom/google/android/gms/internal/firebase_auth/zzbf;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {v0, v3, v5}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelableSerializer;->deserializeFromIntentExtra(Landroid/content/Intent;Ljava/lang/String;Landroid/os/Parcelable$Creator;)Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzbf;

    new-instance v3, Landroid/content/Intent;

    invoke-direct {v3}, Landroid/content/Intent;-><init>()V

    const-string v5, "com.google.firebase.auth.internal.CREDENTIAL_FOR_AUTH_RESULT"

    invoke-static {v0, v3, v5}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelableSerializer;->serializeToIntentExtra(Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable;Landroid/content/Intent;Ljava/lang/String;)V

    :goto_1
    invoke-direct {p0, v4, v3}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zza(ILandroid/content/Intent;)V

    goto :goto_2

    :cond_3
    const-string v5, "com.google.firebase.auth.internal.GET_CRED"

    invoke-virtual {v5, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    new-instance v3, Landroid/content/Intent;

    invoke-direct {v3}, Landroid/content/Intent;-><init>()V

    const-string v5, "com.google.firebase.auth.internal.VERIFY_ASSERTION_REQUEST"

    const-string v6, "com.google.firebase.auth.internal.VERIFY_ASSERTION_REQUEST"

    invoke-virtual {v0, v6}, Landroid/content/Intent;->getByteArrayExtra(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {v3, v5, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[B)Landroid/content/Intent;

    goto :goto_1

    :cond_4
    const/4 v1, 0x0

    :goto_2
    if-nez v1, :cond_5

    invoke-direct {p0, v2}, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zze(I)V

    :cond_5
    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Landroid/support/v4/app/FragmentActivity;->onSaveInstanceState(Landroid/os/Bundle;)V

    const-string v0, "com.google.firebase.auth.internal.KEY_STARTED_SIGN_IN"

    iget-boolean v1, p0, Lcom/google/firebase/auth/internal/FederatedSignInActivity;->zzlp:Z

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method
