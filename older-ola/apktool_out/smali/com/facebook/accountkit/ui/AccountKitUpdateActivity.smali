.class public final Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;
.super Lcom/facebook/accountkit/ui/AccountKitActivityBase;

# interfaces
.implements Lcom/facebook/accountkit/ui/UIManager$UIManagerListener;


# static fields
.field private static final UPDATE_FLOW_BROADCAST_RECEIVER_FILTER:Landroid/content/IntentFilter;


# instance fields
.field private finalUpdateState:Ljava/lang/String;

.field private result:Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;

.field private updateStateStackManager:Lcom/facebook/accountkit/ui/UpdateStateStackManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->getIntentFilter()Landroid/content/IntentFilter;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->UPDATE_FLOW_BROADCAST_RECEIVER_FILTER:Landroid/content/IntentFilter;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;-><init>()V

    sget-object v0, Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;->CANCELLED:Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->result:Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;

    return-void
.end method

.method private sendResult(ILcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "account_kit_update_result"

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    invoke-virtual {p0, p1, v0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->finish()V

    return-void
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    invoke-super {p0, p1, p2, p3}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onActivityResult(IILandroid/content/Intent;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->updateStateStackManager:Lcom/facebook/accountkit/ui/UpdateStateStackManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1, p2, p3}, Lcom/facebook/accountkit/ui/ContentController;->onActivityResult(IILandroid/content/Intent;)V

    :cond_0
    return-void
.end method

.method public onBack()V
    .locals 0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->onBackPressed()V

    return-void
.end method

.method public onBackPressed()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->updateStateStackManager:Lcom/facebook/accountkit/ui/UpdateStateStackManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-super {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onBackPressed()V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->updateStateStackManager:Lcom/facebook/accountkit/ui/UpdateStateStackManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->popState()V

    return-void
.end method

.method public onCancel()V
    .locals 0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->sendCancelResult()V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1    # Landroid/os/Bundle;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onCreate(Landroid/os/Bundle;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-interface {v0, p0}, Lcom/facebook/accountkit/ui/UIManager;->setUIManagerListener(Lcom/facebook/accountkit/ui/UIManager$UIManagerListener;)V

    new-instance v0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {v0, p0, v1}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;-><init>(Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->updateStateStackManager:Lcom/facebook/accountkit/ui/UpdateStateStackManager;

    invoke-static {p0, p1}, Lcom/facebook/accountkit/internal/AccountKitController;->onUpdateActivityCreate(Landroid/app/Activity;Landroid/os/Bundle;)V

    invoke-static {p0}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->updateStateStackManager:Lcom/facebook/accountkit/ui/UpdateStateStackManager;

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->UPDATE_FLOW_BROADCAST_RECEIVER_FILTER:Landroid/content/IntentFilter;

    invoke-virtual {p1, v0, v1}, Landroid/support/v4/content/LocalBroadcastManager;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)V

    return-void
.end method

.method protected onDestroy()V
    .locals 2

    invoke-static {p0}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->updateStateStackManager:Lcom/facebook/accountkit/ui/UpdateStateStackManager;

    invoke-virtual {v0, v1}, Landroid/support/v4/content/LocalBroadcastManager;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    invoke-super {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onDestroy()V

    invoke-static {p0}, Lcom/facebook/accountkit/internal/AccountKitController;->onUpdateActivityDestroy(Landroid/app/Activity;)V

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1

    const/4 v0, 0x4

    if-eq p1, v0, :cond_0

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->onBackPressed()V

    const/4 p1, 0x1

    return p1
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 2

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    const v1, 0x102002c

    if-eq v0, v1, :cond_0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result p1

    return p1

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->onBackPressed()V

    const/4 p1, 0x1

    return p1
.end method

.method protected onPause()V
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onPause()V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->updateStateStackManager:Lcom/facebook/accountkit/ui/UpdateStateStackManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p0}, Lcom/facebook/accountkit/ui/ContentController;->onPause(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method protected onResume()V
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onResume()V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->updateStateStackManager:Lcom/facebook/accountkit/ui/UpdateStateStackManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p0}, Lcom/facebook/accountkit/ui/ContentController;->onResume(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/facebook/accountkit/internal/AccountKitController;->onUpdateActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method sendCancelResult()V
    .locals 3

    new-instance v0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-direct {v0, v1, v1, v2}, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;-><init>(Ljava/lang/String;Lcom/facebook/accountkit/AccountKitError;Z)V

    const/4 v1, 0x0

    invoke-direct {p0, v1, v0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->sendResult(ILcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;)V

    return-void
.end method

.method sendResult()V
    .locals 5

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->result:Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;

    sget-object v1, Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;->SUCCESS:Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;

    const/4 v2, 0x0

    if-ne v0, v1, :cond_0

    const/4 v0, -0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    new-instance v1, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;

    iget-object v3, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->finalUpdateState:Ljava/lang/String;

    iget-object v4, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-direct {v1, v3, v4, v2}, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;-><init>(Ljava/lang/String;Lcom/facebook/accountkit/AccountKitError;Z)V

    invoke-direct {p0, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->sendResult(ILcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;)V

    return-void
.end method

.method setFinalUpdateState(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->finalUpdateState:Ljava/lang/String;

    return-void
.end method

.method setUpdateResult(Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->result:Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;

    return-void
.end method

.method updateUI(Lcom/facebook/accountkit/ui/UpdateFlowState;Lcom/facebook/accountkit/ui/ContentController;)V
    .locals 7

    sget-object v0, Lcom/facebook/accountkit/ui/UpdateFlowState;->CODE_INPUT_ERROR:Lcom/facebook/accountkit/ui/UpdateFlowState;

    if-eq p1, v0, :cond_1

    sget-object v0, Lcom/facebook/accountkit/ui/UpdateFlowState;->PHONE_NUMBER_INPUT_ERROR:Lcom/facebook/accountkit/ui/UpdateFlowState;

    if-ne p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-static {v0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getDefaultHeaderFragment(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/UpdateFlowState;)Landroid/app/Fragment;

    move-result-object v0

    goto :goto_1

    :cond_1
    :goto_0
    invoke-interface {p2}, Lcom/facebook/accountkit/ui/ContentController;->getHeaderFragment()Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object v0

    :goto_1
    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-static {v1, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getDefaultBodyFragment(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/UpdateFlowState;)Landroid/app/Fragment;

    move-result-object p1

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-static {v1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getDefaultFooterFragment(Lcom/facebook/accountkit/ui/UIManager;)Landroid/app/Fragment;

    move-result-object v1

    invoke-interface {p2}, Lcom/facebook/accountkit/ui/ContentController;->getTopFragment()Lcom/facebook/accountkit/ui/ContentFragment;

    move-result-object v2

    invoke-interface {p2}, Lcom/facebook/accountkit/ui/ContentController;->getTextFragment()Lcom/facebook/accountkit/ui/ContentFragment;

    move-result-object v3

    invoke-interface {p2}, Lcom/facebook/accountkit/ui/ContentController;->getBottomFragment()Lcom/facebook/accountkit/ui/ContentFragment;

    move-result-object v4

    if-eqz v3, :cond_2

    sget v5, Lcom/facebook/accountkit/R$dimen;->com_accountkit_vertical_spacer_small_height:I

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    invoke-virtual {v6, v5}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v5

    instance-of v6, v3, Lcom/facebook/accountkit/ui/TextContentFragment;

    if-eqz v6, :cond_2

    move-object v6, v3

    check-cast v6, Lcom/facebook/accountkit/ui/TextContentFragment;

    invoke-virtual {v6, v5}, Lcom/facebook/accountkit/ui/TextContentFragment;->setContentPaddingTop(I)V

    const/4 v5, 0x0

    invoke-virtual {v6, v5}, Lcom/facebook/accountkit/ui/TextContentFragment;->setContentPaddingBottom(I)V

    :cond_2
    invoke-virtual {p0, p2}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->ensureNextButton(Lcom/facebook/accountkit/ui/ContentController;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/app/FragmentManager;->beginTransaction()Landroid/app/FragmentTransaction;

    move-result-object v5

    sget v6, Lcom/facebook/accountkit/R$id;->com_accountkit_header_fragment:I

    invoke-virtual {p0, v5, v6, v0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_content_top_fragment:I

    invoke-virtual {p0, v5, v0, v2}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_content_top_text_fragment:I

    const/4 v2, 0x0

    invoke-virtual {p0, v5, v0, v2}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_content_center_fragment:I

    invoke-virtual {p0, v5, v0, p1}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    sget p1, Lcom/facebook/accountkit/R$id;->com_accountkit_content_bottom_text_fragment:I

    invoke-virtual {p0, v5, p1, v3}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    sget-object v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CONTEMPORARY:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result p1

    if-nez p1, :cond_3

    sget p1, Lcom/facebook/accountkit/R$id;->com_accountkit_content_bottom_fragment:I

    invoke-virtual {p0, v5, p1, v4}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    sget p1, Lcom/facebook/accountkit/R$id;->com_accountkit_footer_fragment:I

    invoke-virtual {p0, v5, p1, v1}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    :cond_3
    invoke-virtual {v5, v2}, Landroid/app/FragmentTransaction;->addToBackStack(Ljava/lang/String;)Landroid/app/FragmentTransaction;

    invoke-static {p0}, Lcom/facebook/accountkit/ui/ViewUtility;->hideKeyboard(Landroid/app/Activity;)V

    invoke-virtual {v5}, Landroid/app/FragmentTransaction;->commit()I

    invoke-interface {p2, p0}, Lcom/facebook/accountkit/ui/ContentController;->onResume(Landroid/app/Activity;)V

    return-void
.end method
