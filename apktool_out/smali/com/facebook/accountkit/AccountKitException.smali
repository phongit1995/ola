.class public Lcom/facebook/accountkit/AccountKitException;
.super Ljava/lang/RuntimeException;


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field private final error:Lcom/facebook/accountkit/AccountKitError;


# direct methods
.method public constructor <init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    .locals 1

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccountKitError$Type;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    new-instance v0, Lcom/facebook/accountkit/AccountKitError;

    invoke-direct {v0, p1, p2}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    iput-object v0, p0, Lcom/facebook/accountkit/AccountKitException;->error:Lcom/facebook/accountkit/AccountKitError;

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;Ljava/lang/String;)V
    .locals 3

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccountKitError$Type;->getMessage()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p3, v1, v2

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p3

    invoke-direct {p0, p3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    new-instance p3, Lcom/facebook/accountkit/AccountKitError;

    invoke-direct {p3, p1, p2}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    iput-object p3, p0, Lcom/facebook/accountkit/AccountKitException;->error:Lcom/facebook/accountkit/AccountKitError;

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;Ljava/lang/Throwable;)V
    .locals 1

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccountKitError$Type;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    new-instance p3, Lcom/facebook/accountkit/AccountKitError;

    invoke-direct {p3, p1, p2}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    iput-object p3, p0, Lcom/facebook/accountkit/AccountKitException;->error:Lcom/facebook/accountkit/AccountKitError;

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/AccountKitError$Type;Ljava/lang/Throwable;)V
    .locals 1

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccountKitError$Type;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    new-instance p2, Lcom/facebook/accountkit/AccountKitError;

    invoke-direct {p2, p1}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;)V

    iput-object p2, p0, Lcom/facebook/accountkit/AccountKitException;->error:Lcom/facebook/accountkit/AccountKitError;

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/AccountKitError;)V
    .locals 1

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccountKitError;->getErrorType()Lcom/facebook/accountkit/AccountKitError$Type;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/AccountKitError$Type;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    iput-object p1, p0, Lcom/facebook/accountkit/AccountKitException;->error:Lcom/facebook/accountkit/AccountKitError;

    return-void
.end method


# virtual methods
.method public getError()Lcom/facebook/accountkit/AccountKitError;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/AccountKitException;->error:Lcom/facebook/accountkit/AccountKitError;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/AccountKitException;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v0}, Lcom/facebook/accountkit/AccountKitError;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
