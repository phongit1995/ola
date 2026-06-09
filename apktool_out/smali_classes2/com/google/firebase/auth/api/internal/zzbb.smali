.class final Lcom/google/firebase/auth/api/internal/zzbb;
.super Lcom/google/firebase/auth/api/internal/zzam;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzcx;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<ResultT:",
        "Ljava/lang/Object;",
        "CallbackT:",
        "Ljava/lang/Object;",
        ">",
        "Lcom/google/firebase/auth/api/internal/zzam<",
        "Lcom/google/firebase/auth/api/internal/zzcc;",
        "TResultT;>;",
        "Lcom/google/firebase/auth/api/internal/zzcx<",
        "TResultT;>;"
    }
.end annotation


# instance fields
.field private final zzgy:Ljava/lang/String;

.field private zzgz:Lcom/google/firebase/auth/api/internal/zzcy;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/firebase/auth/api/internal/zzcy<",
            "TResultT;TCallbackT;>;"
        }
    .end annotation
.end field

.field private zzha:Lcom/google/android/gms/tasks/TaskCompletionSource;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/tasks/TaskCompletionSource<",
            "TResultT;>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/auth/api/internal/zzcy<",
            "TResultT;TCallbackT;>;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    invoke-direct {p0}, Lcom/google/firebase/auth/api/internal/zzam;-><init>()V

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzgz:Lcom/google/firebase/auth/api/internal/zzcy;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzgz:Lcom/google/firebase/auth/api/internal/zzcy;

    iput-object p0, p1, Lcom/google/firebase/auth/api/internal/zzcy;->zzig:Lcom/google/firebase/auth/api/internal/zzcx;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzgy:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method protected final synthetic doExecute(Lcom/google/android/gms/common/api/Api$AnyClient;Lcom/google/android/gms/tasks/TaskCompletionSource;)V
    .locals 0

    check-cast p1, Lcom/google/firebase/auth/api/internal/zzcc;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzha:Lcom/google/android/gms/tasks/TaskCompletionSource;

    iget-object p2, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzgz:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-interface {p1}, Lcom/google/firebase/auth/api/internal/zzcc;->zzaf()Lcom/google/firebase/auth/api/internal/zzck;

    move-result-object p1

    iput-object p1, p2, Lcom/google/firebase/auth/api/internal/zzcy;->zzid:Lcom/google/firebase/auth/api/internal/zzck;

    invoke-virtual {p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzaa()V

    return-void
.end method

.method public final zza(Ljava/lang/Object;Lcom/google/android/gms/common/api/Status;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TResultT;",
            "Lcom/google/android/gms/common/api/Status;",
            ")V"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzha:Lcom/google/android/gms/tasks/TaskCompletionSource;

    const-string v1, "doExecute must be called before onComplete"

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    if-eqz p2, :cond_1

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzgz:Lcom/google/firebase/auth/api/internal/zzcy;

    iget-object p1, p1, Lcom/google/firebase/auth/api/internal/zzcy;->zziq:Lcom/google/firebase/auth/PhoneAuthCredential;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzha:Lcom/google/android/gms/tasks/TaskCompletionSource;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzgz:Lcom/google/firebase/auth/api/internal/zzcy;

    iget-object v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zziq:Lcom/google/firebase/auth/PhoneAuthCredential;

    invoke-virtual {v0}, Lcom/google/firebase/auth/PhoneAuthCredential;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/firebase/auth/PhoneAuthCredential;

    invoke-static {p2, v0}, Lcom/google/firebase/auth/api/internal/zzce;->zzb(Lcom/google/android/gms/common/api/Status;Lcom/google/firebase/auth/PhoneAuthCredential;)Lcom/google/firebase/auth/FirebaseAuthUserCollisionException;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/google/android/gms/tasks/TaskCompletionSource;->setException(Ljava/lang/Exception;)V

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzgz:Lcom/google/firebase/auth/api/internal/zzcy;

    const/4 p2, 0x0

    iput-object p2, p1, Lcom/google/firebase/auth/api/internal/zzcy;->zziq:Lcom/google/firebase/auth/PhoneAuthCredential;

    return-void

    :cond_0
    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzha:Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-static {p2}, Lcom/google/firebase/auth/api/internal/zzce;->zzb(Lcom/google/android/gms/common/api/Status;)Lcom/google/firebase/FirebaseException;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/google/android/gms/tasks/TaskCompletionSource;->setException(Ljava/lang/Exception;)V

    return-void

    :cond_1
    iget-object p2, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzha:Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-virtual {p2, p1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->setResult(Ljava/lang/Object;)V

    return-void
.end method

.method final zzz()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzbb;->zzgy:Ljava/lang/String;

    return-object v0
.end method
