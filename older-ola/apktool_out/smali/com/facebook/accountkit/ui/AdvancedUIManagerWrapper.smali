.class public Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;
.super Lcom/facebook/accountkit/ui/BaseUIManager;


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final advancedUIManager:Lcom/facebook/accountkit/ui/AdvancedUIManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;-><init>(Landroid/os/Parcel;)V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/ui/AdvancedUIManager;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->advancedUIManager:Lcom/facebook/accountkit/ui/AdvancedUIManager;

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/ui/AdvancedUIManager;I)V
    .locals 0
    .param p2    # I
        .annotation build Landroid/support/annotation/StyleRes;
        .end annotation
    .end param

    invoke-direct {p0, p2}, Lcom/facebook/accountkit/ui/BaseUIManager;-><init>(I)V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->advancedUIManager:Lcom/facebook/accountkit/ui/AdvancedUIManager;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getAdvancedUIManager()Lcom/facebook/accountkit/ui/AdvancedUIManager;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->advancedUIManager:Lcom/facebook/accountkit/ui/AdvancedUIManager;

    return-object v0
.end method

.method public getBodyFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->advancedUIManager:Lcom/facebook/accountkit/ui/AdvancedUIManager;

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/ui/AdvancedUIManager;->getBodyFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getBodyFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public getButtonType(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/ButtonType;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->advancedUIManager:Lcom/facebook/accountkit/ui/AdvancedUIManager;

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/ui/AdvancedUIManager;->getButtonType(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/ButtonType;

    move-result-object p1

    return-object p1
.end method

.method public getFooterFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->advancedUIManager:Lcom/facebook/accountkit/ui/AdvancedUIManager;

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/ui/AdvancedUIManager;->getFooterFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getFooterFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public getHeaderFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->advancedUIManager:Lcom/facebook/accountkit/ui/AdvancedUIManager;

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/ui/AdvancedUIManager;->getHeaderFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getHeaderFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public getTextPosition(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/TextPosition;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->advancedUIManager:Lcom/facebook/accountkit/ui/AdvancedUIManager;

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/ui/AdvancedUIManager;->getTextPosition(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/TextPosition;

    move-result-object p1

    return-object p1
.end method

.method public onError(Lcom/facebook/accountkit/AccountKitError;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->advancedUIManager:Lcom/facebook/accountkit/ui/AdvancedUIManager;

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/ui/AdvancedUIManager;->onError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void
.end method

.method public setUIManagerListener(Lcom/facebook/accountkit/ui/UIManager$UIManagerListener;)V
    .locals 1

    new-instance p1, Ljava/lang/RuntimeException;

    const-string v0, "Use setAdvancedUIManagerListener"

    invoke-direct {p1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/BaseUIManager;->writeToParcel(Landroid/os/Parcel;I)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->advancedUIManager:Lcom/facebook/accountkit/ui/AdvancedUIManager;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    return-void
.end method
