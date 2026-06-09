.class Lcom/facebook/accountkit/ui/EmailLoginFlowManager;
.super Lcom/facebook/accountkit/ui/LoginFlowManager;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/ui/EmailLoginFlowManager;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private email:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/ui/EmailLoginFlowManager$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/EmailLoginFlowManager$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/LoginFlowManager;-><init>(Landroid/os/Parcel;)V

    const-class v0, Lcom/facebook/accountkit/ui/ActivityEmailHandler;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/ActivityHandler;

    iput-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->activityHandler:Lcom/facebook/accountkit/ui/ActivityHandler;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->email:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginType;->EMAIL:Lcom/facebook/accountkit/ui/LoginType;

    invoke-direct {p0, v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;-><init>(Lcom/facebook/accountkit/ui/LoginType;)V

    new-instance v0, Lcom/facebook/accountkit/ui/ActivityEmailHandler;

    invoke-direct {v0, p1}, Lcom/facebook/accountkit/ui/ActivityEmailHandler;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->activityHandler:Lcom/facebook/accountkit/ui/ActivityHandler;

    return-void
.end method


# virtual methods
.method public getEmail()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->email:Ljava/lang/String;

    return-object v0
.end method

.method public logInWithEmail(Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;Ljava/lang/String;)V
    .locals 1
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->isValid()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->email:Ljava/lang/String;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->email:Ljava/lang/String;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->getValue()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1, p2}, Lcom/facebook/accountkit/internal/AccountKitController;->logInWithEmail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/facebook/accountkit/EmailLoginModel;

    :cond_1
    return-void
.end method

.method public setEmail(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->email:Ljava/lang/String;

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/LoginFlowManager;->writeToParcel(Landroid/os/Parcel;I)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->activityHandler:Lcom/facebook/accountkit/ui/ActivityHandler;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->email:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void
.end method
