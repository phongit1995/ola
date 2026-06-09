.class final Lcom/facebook/accountkit/ui/LoginErrorContentController;
.super Lcom/facebook/accountkit/ui/ErrorContentController;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;
    }
.end annotation


# static fields
.field private static final LOGIN_FLOW_STATE:Lcom/facebook/accountkit/ui/LoginFlowState;


# instance fields
.field private bottomFragment:Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;

.field private final returnState:Lcom/facebook/accountkit/ui/LoginFlowState;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->ERROR:Lcom/facebook/accountkit/ui/LoginFlowState;

    sput-object v0, Lcom/facebook/accountkit/ui/LoginErrorContentController;->LOGIN_FLOW_STATE:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-void
.end method

.method constructor <init>(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0, p2}, Lcom/facebook/accountkit/ui/ErrorContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController;->returnState:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-void
.end method

.method static synthetic access$000()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginErrorContentController;->LOGIN_FLOW_STATE:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object v0
.end method


# virtual methods
.method public getBottomFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController;->bottomFragment:Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;-><init>()V

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/LoginErrorContentController;->setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController;->bottomFragment:Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;

    return-object v0
.end method

.method getReturnState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController;->returnState:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object v0
.end method

.method public setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .locals 2
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController;->bottomFragment:Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController;->bottomFragment:Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;->getViewState()Landroid/os/Bundle;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController;->bottomFragment:Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;->getViewState()Landroid/os/Bundle;

    move-result-object p1

    invoke-static {}, Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;->access$100()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController;->returnState:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/LoginFlowState;->ordinal()I

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    return-void
.end method
