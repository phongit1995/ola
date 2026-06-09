.class abstract Lcom/facebook/accountkit/ui/LoginFlowManager;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;


# instance fields
.field protected activityHandler:Lcom/facebook/accountkit/ui/ActivityHandler;

.field private flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

.field private isValid:Z

.field private final loginType:Lcom/facebook/accountkit/ui/LoginType;


# direct methods
.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->isValid:Z

    invoke-virtual {p1}, Landroid/os/Parcel;->readByte()B

    move-result v1

    if-ne v1, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->isValid:Z

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/ui/LoginType;->valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->loginType:Lcom/facebook/accountkit/ui/LoginType;

    invoke-static {}, Lcom/facebook/accountkit/ui/LoginFlowState;->values()[Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result p1

    aget-object p1, v0, p1

    iput-object p1, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/ui/LoginType;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->isValid:Z

    iput-object p1, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->loginType:Lcom/facebook/accountkit/ui/LoginType;

    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-void
.end method


# virtual methods
.method public cancel()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->isValid:Z

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->cancelLogin()V

    return-void
.end method

.method confirmSeamlessLogin()V
    .locals 1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->isValid()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->continueSeamlessLogin()V

    return-void
.end method

.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getAccessToken()Lcom/facebook/accountkit/AccessToken;
    .locals 1

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->isValid:Z

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getCurrentAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object v0

    return-object v0
.end method

.method public getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->activityHandler:Lcom/facebook/accountkit/ui/ActivityHandler;

    return-object v0
.end method

.method public getFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object v0
.end method

.method public getLoginType()Lcom/facebook/accountkit/ui/LoginType;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->loginType:Lcom/facebook/accountkit/ui/LoginType;

    return-object v0
.end method

.method public isValid()Z
    .locals 1

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->isValid:Z

    return v0
.end method

.method public final setFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 0

    iget-boolean p2, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->isValid:Z

    int-to-byte p2, p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeByte(B)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->loginType:Lcom/facebook/accountkit/ui/LoginType;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/LoginType;->name()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/LoginFlowManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/LoginFlowState;->ordinal()I

    move-result p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    return-void
.end method
