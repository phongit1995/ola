.class final Lcom/google/firebase/auth/api/internal/zzde;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdh;


# instance fields
.field private final synthetic zzix:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zzdb;Ljava/lang/String;)V
    .locals 0

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzde;->zzix:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final varargs zza(Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;[Ljava/lang/Object;)V
    .locals 0

    iget-object p2, p0, Lcom/google/firebase/auth/api/internal/zzde;->zzix:Ljava/lang/String;

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;->onCodeAutoRetrievalTimeOut(Ljava/lang/String;)V

    return-void
.end method
