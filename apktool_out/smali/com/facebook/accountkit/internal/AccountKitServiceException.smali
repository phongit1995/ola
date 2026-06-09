.class final Lcom/facebook/accountkit/internal/AccountKitServiceException;
.super Lcom/facebook/accountkit/AccountKitException;


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field private final error:Lcom/facebook/accountkit/internal/AccountKitRequestError;


# direct methods
.method public constructor <init>(Lcom/facebook/accountkit/internal/AccountKitRequestError;Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    .locals 0

    invoke-direct {p0, p2, p3}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AccountKitServiceException;->error:Lcom/facebook/accountkit/internal/AccountKitRequestError;

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/internal/AccountKitRequestError;Lcom/facebook/accountkit/AccountKitException;)V
    .locals 0

    invoke-virtual {p2}, Lcom/facebook/accountkit/AccountKitException;->getError()Lcom/facebook/accountkit/AccountKitError;

    move-result-object p2

    invoke-direct {p0, p2}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError;)V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AccountKitServiceException;->error:Lcom/facebook/accountkit/internal/AccountKitRequestError;

    return-void
.end method


# virtual methods
.method public final getRequestError()Lcom/facebook/accountkit/internal/AccountKitRequestError;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitServiceException;->error:Lcom/facebook/accountkit/internal/AccountKitRequestError;

    return-object v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "{AccountKitServiceException: httpResponseCode: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitServiceException;->error:Lcom/facebook/accountkit/internal/AccountKitRequestError;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/AccountKitRequestError;->getRequestStatusCode()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", errorCode: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitServiceException;->error:Lcom/facebook/accountkit/internal/AccountKitRequestError;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/AccountKitRequestError;->getErrorCode()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", errorType: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitServiceException;->error:Lcom/facebook/accountkit/internal/AccountKitRequestError;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/AccountKitRequestError;->getErrorType()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ", message: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitServiceException;->error:Lcom/facebook/accountkit/internal/AccountKitRequestError;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/AccountKitRequestError;->getErrorMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
