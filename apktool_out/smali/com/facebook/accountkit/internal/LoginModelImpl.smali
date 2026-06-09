.class abstract Lcom/facebook/accountkit/internal/LoginModelImpl;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/LoginModel;


# static fields
.field private static final PARCEL_VERSION:I = 0x2


# instance fields
.field private accessToken:Lcom/facebook/accountkit/AccessToken;

.field private code:Ljava/lang/String;

.field private error:Lcom/facebook/accountkit/AccountKitError;

.field private expiresInSeconds:J

.field protected fields:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private finalAuthState:Ljava/lang/String;

.field private initialAuthState:Ljava/lang/String;

.field private loginModelCode:Ljava/lang/String;

.field private responseType:Ljava/lang/String;

.field private status:Lcom/facebook/accountkit/internal/LoginStatus;


# direct methods
.method constructor <init>(Landroid/os/Parcel;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->EMPTY:Lcom/facebook/accountkit/internal/LoginStatus;

    iput-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->status:Lcom/facebook/accountkit/internal/LoginStatus;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->fields:Ljava/util/Map;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const-class v0, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/AccountKitError;

    iput-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->expiresInSeconds:J

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->loginModelCode:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/LoginStatus;->valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->status:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->responseType:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->finalAuthState:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->code:Ljava/lang/String;

    return-void

    :cond_0
    new-instance p1, Lcom/facebook/accountkit/AccountKitError;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    invoke-direct {p1, v0}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;)V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    sget-object p1, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->status:Lcom/facebook/accountkit/internal/LoginStatus;

    return-void
.end method

.method constructor <init>(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->EMPTY:Lcom/facebook/accountkit/internal/LoginStatus;

    iput-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->status:Lcom/facebook/accountkit/internal/LoginStatus;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->fields:Ljava/util/Map;

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->responseType:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 7

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/facebook/accountkit/internal/LoginModelImpl;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    check-cast p1, Lcom/facebook/accountkit/internal/LoginModelImpl;

    iget-wide v3, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->expiresInSeconds:J

    iget-wide v5, p1, Lcom/facebook/accountkit/internal/LoginModelImpl;->expiresInSeconds:J

    cmp-long v1, v3, v5

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    iget-object v3, p1, Lcom/facebook/accountkit/internal/LoginModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->loginModelCode:Ljava/lang/String;

    iget-object v3, p1, Lcom/facebook/accountkit/internal/LoginModelImpl;->loginModelCode:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->status:Lcom/facebook/accountkit/internal/LoginStatus;

    iget-object v3, p1, Lcom/facebook/accountkit/internal/LoginModelImpl;->status:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->responseType:Ljava/lang/String;

    iget-object v3, p1, Lcom/facebook/accountkit/internal/LoginModelImpl;->responseType:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->finalAuthState:Ljava/lang/String;

    iget-object v3, p1, Lcom/facebook/accountkit/internal/LoginModelImpl;->finalAuthState:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->code:Ljava/lang/String;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/LoginModelImpl;->code:Ljava/lang/String;

    invoke-static {v1, p1}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    return v0

    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method public getAccessToken()Lcom/facebook/accountkit/AccessToken;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->accessToken:Lcom/facebook/accountkit/AccessToken;

    return-object v0
.end method

.method public getCode()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->code:Ljava/lang/String;

    return-object v0
.end method

.method public getError()Lcom/facebook/accountkit/AccountKitError;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    return-object v0
.end method

.method getExpiresInSeconds()J
    .locals 2

    iget-wide v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->expiresInSeconds:J

    return-wide v0
.end method

.method public getFinalAuthState()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->finalAuthState:Ljava/lang/String;

    return-object v0
.end method

.method public getInitialAuthState()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->initialAuthState:Ljava/lang/String;

    return-object v0
.end method

.method getLoginRequestCode()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->loginModelCode:Ljava/lang/String;

    return-object v0
.end method

.method public getPrivacyPolicy()Ljava/lang/String;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->fields:Ljava/util/Map;

    const-string v1, "privacy_policy"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getResponseType()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->responseType:Ljava/lang/String;

    return-object v0
.end method

.method public getStatus()Lcom/facebook/accountkit/internal/LoginStatus;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->status:Lcom/facebook/accountkit/internal/LoginStatus;

    return-object v0
.end method

.method public getTermsOfService()Ljava/lang/String;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->fields:Ljava/util/Map;

    const-string v1, "terms_of_service"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method putField(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->fields:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method setAccessToken(Lcom/facebook/accountkit/AccessToken;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->accessToken:Lcom/facebook/accountkit/AccessToken;

    return-void
.end method

.method setCode(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->code:Ljava/lang/String;

    return-void
.end method

.method setError(Lcom/facebook/accountkit/AccountKitError;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    return-void
.end method

.method setExpiresInSeconds(J)V
    .locals 0

    iput-wide p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->expiresInSeconds:J

    return-void
.end method

.method setFinalAuthState(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->finalAuthState:Ljava/lang/String;

    return-void
.end method

.method setInitialAuthState(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->initialAuthState:Ljava/lang/String;

    return-void
.end method

.method setLoginCode(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->loginModelCode:Ljava/lang/String;

    return-void
.end method

.method setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->status:Lcom/facebook/accountkit/internal/LoginStatus;

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 2

    const/4 v0, 0x2

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    iget-wide v0, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->expiresInSeconds:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->loginModelCode:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->status:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {p2}, Lcom/facebook/accountkit/internal/LoginStatus;->name()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->responseType:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->finalAuthState:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/LoginModelImpl;->code:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void
.end method
