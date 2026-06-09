.class final Lcom/facebook/accountkit/internal/AccountKitRequestError;
.super Ljava/lang/Object;


# static fields
.field public static final INVALID_ERROR_CODE:I = -0x1

.field public static final INVALID_HTTP_STATUS_CODE:I = -0x1


# instance fields
.field private final errorCode:I

.field private final errorMessage:Ljava/lang/String;

.field private final errorType:Ljava/lang/String;

.field private final exception:Lcom/facebook/accountkit/AccountKitException;

.field private final requestStatusCode:I

.field private final subErrorCode:I

.field private final userErrorMessage:Ljava/lang/String;


# direct methods
.method public constructor <init>(IIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/facebook/accountkit/AccountKitException;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->requestStatusCode:I

    iput p2, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->errorCode:I

    iput-object p4, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->errorType:Ljava/lang/String;

    iput-object p5, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->errorMessage:Ljava/lang/String;

    iput p3, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->subErrorCode:I

    iput-object p6, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->userErrorMessage:Ljava/lang/String;

    if-eqz p7, :cond_0

    new-instance p1, Lcom/facebook/accountkit/internal/AccountKitServiceException;

    invoke-direct {p1, p0, p7}, Lcom/facebook/accountkit/internal/AccountKitServiceException;-><init>(Lcom/facebook/accountkit/internal/AccountKitRequestError;Lcom/facebook/accountkit/AccountKitException;)V

    :goto_0
    iput-object p1, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->exception:Lcom/facebook/accountkit/AccountKitException;

    return-void

    :cond_0
    new-instance p1, Lcom/facebook/accountkit/internal/AccountKitServiceException;

    sget-object p3, Lcom/facebook/accountkit/AccountKitError$Type;->SERVER_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    new-instance p4, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {p4, p2, p5}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    invoke-direct {p1, p0, p3, p4}, Lcom/facebook/accountkit/internal/AccountKitServiceException;-><init>(Lcom/facebook/accountkit/internal/AccountKitRequestError;Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    goto :goto_0

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/AccountKitException;)V
    .locals 9

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccountKitException;->getError()Lcom/facebook/accountkit/AccountKitError;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/AccountKitError;->getDetailErrorCode()I

    move-result v3

    const/4 v2, -0x1

    const/4 v4, -0x1

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v1, p0

    move-object v8, p1

    invoke-direct/range {v1 .. v8}, Lcom/facebook/accountkit/internal/AccountKitRequestError;-><init>(IIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/facebook/accountkit/AccountKitException;)V

    return-void
.end method


# virtual methods
.method public getErrorCode()I
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->errorCode:I

    return v0
.end method

.method public getErrorMessage()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->errorMessage:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->errorMessage:Ljava/lang/String;

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->exception:Lcom/facebook/accountkit/AccountKitException;

    invoke-virtual {v0}, Lcom/facebook/accountkit/AccountKitException;->getLocalizedMessage()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getErrorType()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->errorType:Ljava/lang/String;

    return-object v0
.end method

.method public getException()Lcom/facebook/accountkit/AccountKitException;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->exception:Lcom/facebook/accountkit/AccountKitException;

    return-object v0
.end method

.method public getRequestStatusCode()I
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->requestStatusCode:I

    return v0
.end method

.method public getSubErrorCode()I
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->subErrorCode:I

    return v0
.end method

.method public getUserErrorMessage()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->userErrorMessage:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "{HttpStatus: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->requestStatusCode:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", errorCode: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->errorCode:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", errorType: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;->errorType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ", errorMessage: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/AccountKitRequestError;->getErrorMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
