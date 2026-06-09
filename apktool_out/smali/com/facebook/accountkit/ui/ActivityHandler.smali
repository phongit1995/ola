.class public abstract Lcom/facebook/accountkit/ui/ActivityHandler;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field protected static final COMPLETION_UI_DURATION_MS:J = 0x7d0L


# instance fields
.field protected final configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

.field protected tracker:Lcom/facebook/accountkit/Tracker;


# direct methods
.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-class v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ActivityHandler;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    return-void
.end method

.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ActivityHandler;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public abstract getLoginTracker(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/Tracker;
.end method

.method public abstract onAccountVerifiedComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
.end method

.method onConfirmSeamlessLogin(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowManager;)V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->CONFIRM_INSTANT_VERIFICATION_LOGIN:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/LoginFlowManager;->confirmSeamlessLogin()V

    return-void
.end method

.method public abstract onSentCodeComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityHandler;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    return-void
.end method
