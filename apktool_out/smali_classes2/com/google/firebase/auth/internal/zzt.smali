.class final Lcom/google/firebase/auth/internal/zzt;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final zzky:Ljava/lang/String;

.field final synthetic zzlm:Lcom/google/firebase/auth/internal/zzs;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/internal/zzs;Ljava/lang/String;)V
    .locals 0
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/google/firebase/auth/internal/zzt;->zzlm:Lcom/google/firebase/auth/internal/zzs;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/firebase/auth/internal/zzt;->zzky:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    iget-object v0, p0, Lcom/google/firebase/auth/internal/zzt;->zzky:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/firebase/FirebaseApp;->getInstance(Ljava/lang/String;)Lcom/google/firebase/FirebaseApp;

    move-result-object v0

    invoke-static {v0}, Lcom/google/firebase/auth/FirebaseAuth;->getInstance(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/FirebaseAuth;

    move-result-object v1

    invoke-virtual {v0}, Lcom/google/firebase/FirebaseApp;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/google/firebase/auth/internal/zzx;->initialize(Landroid/content/Context;)V

    invoke-virtual {v1}, Lcom/google/firebase/auth/FirebaseAuth;->getCurrentUser()Lcom/google/firebase/auth/FirebaseUser;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/google/firebase/auth/internal/zzx;->zzlq:Lcom/google/android/gms/flags/Flag;

    invoke-virtual {v0}, Lcom/google/android/gms/flags/Flag;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Lcom/google/firebase/auth/FirebaseAuth;->getAccessToken(Z)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    invoke-static {}, Lcom/google/firebase/auth/internal/zzs;->zzbk()Lcom/google/android/gms/common/logging/Logger;

    move-result-object v1

    const-string v2, "Token refreshing started"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/google/android/gms/common/logging/Logger;->v(Ljava/lang/String;[Ljava/lang/Object;)V

    new-instance v1, Lcom/google/firebase/auth/internal/zzu;

    invoke-direct {v1, p0}, Lcom/google/firebase/auth/internal/zzu;-><init>(Lcom/google/firebase/auth/internal/zzt;)V

    invoke-virtual {v0, v1}, Lcom/google/android/gms/tasks/Task;->addOnFailureListener(Lcom/google/android/gms/tasks/OnFailureListener;)Lcom/google/android/gms/tasks/Task;

    :cond_0
    return-void
.end method
