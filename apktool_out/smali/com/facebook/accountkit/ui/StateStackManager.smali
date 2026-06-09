.class final Lcom/facebook/accountkit/ui/StateStackManager;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/app/FragmentManager$OnBackStackChangedListener;
.implements Lcom/facebook/accountkit/ui/AdvancedUIManager$AdvancedUIManagerListener;
.implements Lcom/facebook/accountkit/ui/UIManager$UIManagerListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;,
        Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;,
        Lcom/facebook/accountkit/ui/StateStackManager$FragmentType;
    }
.end annotation


# instance fields
.field private final activityRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lcom/facebook/accountkit/ui/AccountKitActivity;",
            ">;"
        }
    .end annotation
.end field

.field private final configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

.field private contentController:Lcom/facebook/accountkit/ui/ContentController;

.field private final contentControllerMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lcom/facebook/accountkit/ui/LoginFlowState;",
            "Lcom/facebook/accountkit/ui/ContentController;",
            ">;"
        }
    .end annotation
.end field

.field private final onPopListeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;",
            ">;"
        }
    .end annotation
.end field

.field private final onPushListeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;",
            ">;"
        }
    .end annotation
.end field

.field private final uiManager:Lcom/facebook/accountkit/ui/UIManager;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->contentControllerMap:Ljava/util/Map;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->onPopListeners:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->onPushListeners:Ljava/util/List;

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->activityRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/app/FragmentManager;->addOnBackStackChangedListener(Landroid/app/FragmentManager$OnBackStackChangedListener;)V

    iput-object p2, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    if-nez p2, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    instance-of p1, p1, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    check-cast p1, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;->getAdvancedUIManager()Lcom/facebook/accountkit/ui/AdvancedUIManager;

    move-result-object p1

    invoke-interface {p1, p0}, Lcom/facebook/accountkit/ui/AdvancedUIManager;->setAdvancedUIManagerListener(Lcom/facebook/accountkit/ui/AdvancedUIManager$AdvancedUIManagerListener;)V

    return-void

    :cond_1
    iget-object p1, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-interface {p1, p0}, Lcom/facebook/accountkit/ui/UIManager;->setUIManagerListener(Lcom/facebook/accountkit/ui/UIManager$UIManagerListener;)V

    :cond_2
    return-void
.end method

.method private ensureContentController(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/LoginFlowState;Z)Lcom/facebook/accountkit/ui/ContentController;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->contentControllerMap:Ljava/util/Map;

    invoke-interface {v0, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/ContentController;

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    sget-object v0, Lcom/facebook/accountkit/ui/StateStackManager$2;->$SwitchMap$com$facebook$accountkit$ui$LoginFlowState:[I

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/LoginFlowState;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    return-object v1

    :pswitch_0
    new-instance p3, Lcom/facebook/accountkit/ui/ResendContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/ResendContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto/16 :goto_0

    :pswitch_1
    new-instance p3, Lcom/facebook/accountkit/ui/EmailVerifyContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/EmailVerifyContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto/16 :goto_0

    :pswitch_2
    new-instance p3, Lcom/facebook/accountkit/ui/EmailLoginContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/EmailLoginContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto/16 :goto_0

    :pswitch_3
    new-instance v0, Lcom/facebook/accountkit/ui/LoginErrorContentController;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {v0, p3, v1}, Lcom/facebook/accountkit/ui/LoginErrorContentController;-><init>(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    move-object p3, v0

    goto/16 :goto_0

    :pswitch_4
    new-instance p3, Lcom/facebook/accountkit/ui/VerifiedCodeContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/VerifiedCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto/16 :goto_0

    :pswitch_5
    new-instance p3, Lcom/facebook/accountkit/ui/VerifyingCodeContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/VerifyingCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto/16 :goto_0

    :pswitch_6
    new-instance p3, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_7
    new-instance p3, Lcom/facebook/accountkit/ui/VerifyingCodeContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/VerifyingCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_8
    new-instance p3, Lcom/facebook/accountkit/ui/ConfirmAccountVerifiedContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/ConfirmAccountVerifiedContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_9
    new-instance p3, Lcom/facebook/accountkit/ui/AccountVerifiedContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/AccountVerifiedContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_a
    sget-object p3, Lcom/facebook/accountkit/ui/StateStackManager$2;->$SwitchMap$com$facebook$accountkit$ui$LoginType:[I

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginType;->ordinal()I

    move-result v0

    aget p3, p3, v0

    packed-switch p3, :pswitch_data_1

    new-instance p1, Ljava/lang/RuntimeException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "Unexpected login type: "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p3, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p3}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object p3

    invoke-virtual {p3}, Lcom/facebook/accountkit/ui/LoginType;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_b
    new-instance p3, Lcom/facebook/accountkit/ui/EmailSentCodeContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/EmailSentCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_c
    new-instance p3, Lcom/facebook/accountkit/ui/PhoneSentCodeContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/PhoneSentCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_d
    new-instance p3, Lcom/facebook/accountkit/ui/SendingCodeContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/SendingCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_e
    new-instance p3, Lcom/facebook/accountkit/ui/PhoneLoginContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p3, v0}, Lcom/facebook/accountkit/ui/PhoneLoginContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    :goto_0
    if-eqz p4, :cond_3

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object p4

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_header_fragment:I

    invoke-virtual {p4, v0}, Landroid/app/FragmentManager;->findFragmentById(I)Landroid/app/Fragment;

    move-result-object p4

    instance-of v0, p4, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    if-eqz v0, :cond_1

    check-cast p4, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    invoke-interface {p3, p4}, Lcom/facebook/accountkit/ui/ContentController;->setHeaderFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V

    :cond_1
    sget p4, Lcom/facebook/accountkit/R$id;->com_accountkit_content_top_fragment:I

    invoke-direct {p0, p1, p4}, Lcom/facebook/accountkit/ui/StateStackManager;->getContentFragment(Lcom/facebook/accountkit/ui/AccountKitActivity;I)Lcom/facebook/accountkit/ui/ContentFragment;

    move-result-object p4

    invoke-interface {p3, p4}, Lcom/facebook/accountkit/ui/ContentController;->setTopFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    sget p4, Lcom/facebook/accountkit/R$id;->com_accountkit_content_center_fragment:I

    invoke-direct {p0, p1, p4}, Lcom/facebook/accountkit/ui/StateStackManager;->getContentFragment(Lcom/facebook/accountkit/ui/AccountKitActivity;I)Lcom/facebook/accountkit/ui/ContentFragment;

    move-result-object p4

    invoke-interface {p3, p4}, Lcom/facebook/accountkit/ui/ContentController;->setCenterFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    sget p4, Lcom/facebook/accountkit/R$id;->com_accountkit_content_bottom_fragment:I

    invoke-direct {p0, p1, p4}, Lcom/facebook/accountkit/ui/StateStackManager;->getContentFragment(Lcom/facebook/accountkit/ui/AccountKitActivity;I)Lcom/facebook/accountkit/ui/ContentFragment;

    move-result-object p4

    invoke-interface {p3, p4}, Lcom/facebook/accountkit/ui/ContentController;->setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object p4

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_footer_fragment:I

    invoke-virtual {p4, v0}, Landroid/app/FragmentManager;->findFragmentById(I)Landroid/app/Fragment;

    move-result-object p4

    instance-of v0, p4, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    if-eqz v0, :cond_2

    check-cast p4, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    invoke-interface {p3, p4}, Lcom/facebook/accountkit/ui/ContentController;->setFooterFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V

    :cond_2
    invoke-interface {p3, p1}, Lcom/facebook/accountkit/ui/ContentController;->onResume(Landroid/app/Activity;)V

    :cond_3
    iget-object p1, p0, Lcom/facebook/accountkit/ui/StateStackManager;->contentControllerMap:Ljava/util/Map;

    invoke-interface {p1, p2, p3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p3

    :pswitch_f
    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_c
        :pswitch_b
    .end packed-switch
.end method

.method private getContentFragment(Lcom/facebook/accountkit/ui/AccountKitActivity;I)Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/app/FragmentManager;->findFragmentById(I)Landroid/app/Fragment;

    move-result-object p1

    instance-of p2, p1, Lcom/facebook/accountkit/ui/ContentFragment;

    if-nez p2, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/ContentFragment;

    return-object p1
.end method

.method private pushState(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowManager;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V
    .locals 11
    .param p4    # Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/StateStackManager;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v1

    const/4 v2, 0x0

    invoke-direct {p0, p1, v0, p3, v2}, Lcom/facebook/accountkit/ui/StateStackManager;->ensureContentController(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/LoginFlowState;Z)Lcom/facebook/accountkit/ui/ContentController;

    move-result-object p3

    if-eqz p3, :cond_17

    if-ne v1, p3, :cond_0

    return-void

    :cond_0
    instance-of v3, p2, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;

    const/4 v4, 0x0

    if-eqz v3, :cond_1

    move-object v3, p2

    check-cast v3, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;

    invoke-virtual {v3}, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;->getNotificationChannel()Lcom/facebook/accountkit/ui/NotificationChannel;

    move-result-object v3

    goto :goto_0

    :cond_1
    move-object v3, v4

    :goto_0
    iget-object v5, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-static {v5}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIManager(Lcom/facebook/accountkit/ui/UIManager;)V

    sget-object v5, Lcom/facebook/accountkit/ui/LoginFlowState;->RESEND:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v6, 0x1

    if-ne v0, v5, :cond_2

    instance-of v5, p3, Lcom/facebook/accountkit/ui/ResendContentController;

    if-nez v5, :cond_4

    :cond_2
    sget-object v5, Lcom/facebook/accountkit/ui/LoginFlowState;->CODE_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    if-ne v0, v5, :cond_3

    instance-of v5, p3, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    if-nez v5, :cond_4

    :cond_3
    instance-of v5, p3, Lcom/facebook/accountkit/ui/LoginErrorContentController;

    if-eqz v5, :cond_5

    :cond_4
    invoke-interface {p3}, Lcom/facebook/accountkit/ui/ContentController;->getHeaderFragment()Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object v5

    goto :goto_2

    :cond_5
    iget-object v5, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-interface {v5, v0}, Lcom/facebook/accountkit/ui/UIManager;->getHeaderFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object v5

    iget-object v7, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v7}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v7

    sget-object v8, Lcom/facebook/accountkit/ui/StateStackManager$FragmentType;->HEADER:Lcom/facebook/accountkit/ui/StateStackManager$FragmentType;

    invoke-virtual {v8}, Lcom/facebook/accountkit/ui/StateStackManager$FragmentType;->name()Ljava/lang/String;

    move-result-object v8

    if-eqz v5, :cond_6

    const/4 v9, 0x1

    goto :goto_1

    :cond_6
    const/4 v9, 0x0

    :goto_1
    invoke-static {v7, v8, v9}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUICustomFragment(Lcom/facebook/accountkit/ui/LoginType;Ljava/lang/String;Z)V

    :goto_2
    iget-object v7, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-interface {v7, v0}, Lcom/facebook/accountkit/ui/UIManager;->getBodyFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object v7

    iget-object v8, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v8}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v8

    sget-object v9, Lcom/facebook/accountkit/ui/StateStackManager$FragmentType;->BODY:Lcom/facebook/accountkit/ui/StateStackManager$FragmentType;

    invoke-virtual {v9}, Lcom/facebook/accountkit/ui/StateStackManager$FragmentType;->name()Ljava/lang/String;

    move-result-object v9

    if-eqz v7, :cond_7

    const/4 v10, 0x1

    goto :goto_3

    :cond_7
    const/4 v10, 0x0

    :goto_3
    invoke-static {v8, v9, v10}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUICustomFragment(Lcom/facebook/accountkit/ui/LoginType;Ljava/lang/String;Z)V

    iget-object v8, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-interface {v8, v0}, Lcom/facebook/accountkit/ui/UIManager;->getFooterFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object v8

    iget-object v9, p0, Lcom/facebook/accountkit/ui/StateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v9}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v9

    sget-object v10, Lcom/facebook/accountkit/ui/StateStackManager$FragmentType;->FOOTER:Lcom/facebook/accountkit/ui/StateStackManager$FragmentType;

    invoke-virtual {v10}, Lcom/facebook/accountkit/ui/StateStackManager$FragmentType;->name()Ljava/lang/String;

    move-result-object v10

    if-eqz v8, :cond_8

    goto :goto_4

    :cond_8
    const/4 v6, 0x0

    :goto_4
    invoke-static {v9, v10, v6}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUICustomFragment(Lcom/facebook/accountkit/ui/LoginType;Ljava/lang/String;Z)V

    if-nez v5, :cond_9

    iget-object v5, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object p2

    invoke-static {v5, v0, p2, v3}, Lcom/facebook/accountkit/ui/BaseUIManager;->getDefaultHeaderFragment(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/LoginType;Lcom/facebook/accountkit/ui/NotificationChannel;)Landroid/app/Fragment;

    move-result-object v5

    :cond_9
    if-nez v7, :cond_a

    iget-object p2, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-static {p2, v0}, Lcom/facebook/accountkit/ui/BaseUIManager;->getDefaultBodyFragment(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object v7

    :cond_a
    if-nez v8, :cond_b

    iget-object p2, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-static {p2}, Lcom/facebook/accountkit/ui/BaseUIManager;->getDefaultFooterFragment(Lcom/facebook/accountkit/ui/UIManager;)Landroid/app/Fragment;

    move-result-object v8

    :cond_b
    iget-object p2, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-interface {p2, v0}, Lcom/facebook/accountkit/ui/UIManager;->getTextPosition(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/TextPosition;

    move-result-object p2

    instance-of v3, p3, Lcom/facebook/accountkit/ui/ButtonContentController;

    if-eqz v3, :cond_c

    iget-object v3, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-interface {v3, v0}, Lcom/facebook/accountkit/ui/UIManager;->getButtonType(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/ButtonType;

    move-result-object v0

    if-eqz v0, :cond_c

    move-object v3, p3

    check-cast v3, Lcom/facebook/accountkit/ui/ButtonContentController;

    invoke-interface {v3, v0}, Lcom/facebook/accountkit/ui/ButtonContentController;->setButtonType(Lcom/facebook/accountkit/ui/ButtonType;)V

    :cond_c
    invoke-interface {p3}, Lcom/facebook/accountkit/ui/ContentController;->getTopFragment()Lcom/facebook/accountkit/ui/ContentFragment;

    move-result-object v0

    invoke-interface {p3}, Lcom/facebook/accountkit/ui/ContentController;->getTextFragment()Lcom/facebook/accountkit/ui/ContentFragment;

    move-result-object v3

    invoke-interface {p3}, Lcom/facebook/accountkit/ui/ContentController;->getBottomFragment()Lcom/facebook/accountkit/ui/ContentFragment;

    move-result-object v6

    if-eqz p4, :cond_d

    iget-object v9, p0, Lcom/facebook/accountkit/ui/StateStackManager;->onPushListeners:Ljava/util/List;

    invoke-interface {v9, p4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-interface {p4, p3}, Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;->onContentControllerReady(Lcom/facebook/accountkit/ui/ContentController;)V

    :cond_d
    if-nez p2, :cond_e

    sget-object p2, Lcom/facebook/accountkit/ui/TextPosition;->BELOW_BODY:Lcom/facebook/accountkit/ui/TextPosition;

    :cond_e
    if-eqz v3, :cond_11

    sget-object p4, Lcom/facebook/accountkit/ui/StateStackManager$2;->$SwitchMap$com$facebook$accountkit$ui$TextPosition:[I

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/TextPosition;->ordinal()I

    move-result v9

    aget p4, p4, v9

    packed-switch p4, :pswitch_data_0

    const/4 p4, 0x0

    :goto_5
    const/4 v9, 0x0

    goto :goto_6

    :pswitch_0
    sget p4, Lcom/facebook/accountkit/R$dimen;->com_accountkit_vertical_spacer_small_height:I

    move v9, p4

    const/4 p4, 0x0

    goto :goto_6

    :pswitch_1
    sget p4, Lcom/facebook/accountkit/R$dimen;->com_accountkit_vertical_spacer_small_height:I

    goto :goto_5

    :goto_6
    if-nez p4, :cond_f

    const/4 p4, 0x0

    goto :goto_7

    :cond_f
    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v10

    invoke-virtual {v10, p4}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p4

    :goto_7
    if-nez v9, :cond_10

    goto :goto_8

    :cond_10
    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2, v9}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v2

    :goto_8
    instance-of v9, v3, Lcom/facebook/accountkit/ui/TextContentFragment;

    if-eqz v9, :cond_11

    move-object v9, v3

    check-cast v9, Lcom/facebook/accountkit/ui/TextContentFragment;

    invoke-virtual {v9, p4}, Lcom/facebook/accountkit/ui/TextContentFragment;->setContentPaddingTop(I)V

    invoke-virtual {v9, v2}, Lcom/facebook/accountkit/ui/TextContentFragment;->setContentPaddingBottom(I)V

    :cond_11
    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object p4

    if-eqz v1, :cond_12

    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->onContentControllerDismissed(Lcom/facebook/accountkit/ui/ContentController;)V

    invoke-interface {v1}, Lcom/facebook/accountkit/ui/ContentController;->isTransient()Z

    move-result v1

    if-eqz v1, :cond_12

    invoke-virtual {p4}, Landroid/app/FragmentManager;->popBackStack()V

    :cond_12
    iget-object v1, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    sget-object v2, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CONTEMPORARY:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {v1, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result v1

    if-eqz v1, :cond_13

    invoke-virtual {p1, p3}, Lcom/facebook/accountkit/ui/AccountKitActivity;->ensureNextButton(Lcom/facebook/accountkit/ui/ContentController;)V

    :cond_13
    invoke-virtual {p4}, Landroid/app/FragmentManager;->beginTransaction()Landroid/app/FragmentTransaction;

    move-result-object p4

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_header_fragment:I

    invoke-virtual {p1, p4, v1, v5}, Lcom/facebook/accountkit/ui/AccountKitActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_content_top_fragment:I

    invoke-virtual {p1, p4, v1, v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_content_top_text_fragment:I

    sget-object v1, Lcom/facebook/accountkit/ui/TextPosition;->ABOVE_BODY:Lcom/facebook/accountkit/ui/TextPosition;

    if-ne p2, v1, :cond_14

    move-object v1, v3

    goto :goto_9

    :cond_14
    move-object v1, v4

    :goto_9
    invoke-virtual {p1, p4, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_content_center_fragment:I

    invoke-virtual {p1, p4, v0, v7}, Lcom/facebook/accountkit/ui/AccountKitActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_content_bottom_text_fragment:I

    sget-object v1, Lcom/facebook/accountkit/ui/TextPosition;->BELOW_BODY:Lcom/facebook/accountkit/ui/TextPosition;

    if-ne p2, v1, :cond_15

    goto :goto_a

    :cond_15
    move-object v3, v4

    :goto_a
    invoke-virtual {p1, p4, v0, v3}, Lcom/facebook/accountkit/ui/AccountKitActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    sget-object v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CONTEMPORARY:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {p2, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result p2

    if-nez p2, :cond_16

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_content_bottom_fragment:I

    invoke-virtual {p1, p4, p2, v6}, Lcom/facebook/accountkit/ui/AccountKitActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_footer_fragment:I

    invoke-virtual {p1, p4, p2, v8}, Lcom/facebook/accountkit/ui/AccountKitActivity;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    :cond_16
    invoke-virtual {p4, v4}, Landroid/app/FragmentTransaction;->addToBackStack(Ljava/lang/String;)Landroid/app/FragmentTransaction;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->hideKeyboard(Landroid/app/Activity;)V

    invoke-virtual {p4}, Landroid/app/FragmentTransaction;->commit()I

    invoke-interface {p3, p1}, Lcom/facebook/accountkit/ui/ContentController;->onResume(Landroid/app/Activity;)V

    :cond_17
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method getContentController()Lcom/facebook/accountkit/ui/ContentController;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->contentController:Lcom/facebook/accountkit/ui/ContentController;

    return-object v0
.end method

.method getErrorOnPushListener(Ljava/lang/String;)Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    new-instance v0, Lcom/facebook/accountkit/ui/StateStackManager$1;

    invoke-direct {v0, p0, p1}, Lcom/facebook/accountkit/ui/StateStackManager$1;-><init>(Lcom/facebook/accountkit/ui/StateStackManager;Ljava/lang/String;)V

    return-object v0
.end method

.method multiPopBackStack(Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->activityRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/AccountKitActivity;

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p1, :cond_1

    iget-object v1, p0, Lcom/facebook/accountkit/ui/StateStackManager;->onPopListeners:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/FragmentManager;->popBackStack()V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->ensureNextButton(Lcom/facebook/accountkit/ui/ContentController;)V

    return-void
.end method

.method public onBack()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->activityRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/AccountKitActivity;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->onBackPressed()V

    return-void
.end method

.method public onBackStackChanged()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->activityRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/AccountKitActivity;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/StateStackManager;->updateContentController(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-void
.end method

.method public onCancel()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->activityRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/AccountKitActivity;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendCancelResult()V

    return-void
.end method

.method popBackStack(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V
    .locals 3
    .param p2    # Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->activityRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/AccountKitActivity;

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p2, :cond_1

    iget-object v1, p0, Lcom/facebook/accountkit/ui/StateStackManager;->onPopListeners:Ljava/util/List;

    invoke-interface {v1, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    sget-object p2, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v1, 0x0

    invoke-direct {p0, v0, p1, p2, v1}, Lcom/facebook/accountkit/ui/StateStackManager;->ensureContentController(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/LoginFlowState;Z)Lcom/facebook/accountkit/ui/ContentController;

    move-result-object p2

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowState;->PHONE_NUMBER_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    if-eq p1, v2, :cond_3

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowState;->EMAIL_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    if-ne p1, v2, :cond_2

    goto :goto_0

    :cond_2
    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/FragmentManager;->popBackStack()V

    goto :goto_1

    :cond_3
    :goto_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object p1

    invoke-virtual {p1, v1, v1}, Landroid/app/FragmentManager;->popBackStack(II)V

    :goto_1
    invoke-virtual {v0, p2}, Lcom/facebook/accountkit/ui/AccountKitActivity;->ensureNextButton(Lcom/facebook/accountkit/ui/ContentController;)V

    return-void
.end method

.method pushError(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowManager;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/AccountKitError;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V
    .locals 1
    .param p5    # Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-interface {v0, p4}, Lcom/facebook/accountkit/ui/UIManager;->onError(Lcom/facebook/accountkit/AccountKitError;)V

    invoke-direct {p0, p1, p2, p3, p5}, Lcom/facebook/accountkit/ui/StateStackManager;->pushState(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowManager;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    return-void
.end method

.method pushState(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowManager;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V
    .locals 1
    .param p3    # Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-direct {p0, p1, p2, v0, p3}, Lcom/facebook/accountkit/ui/StateStackManager;->pushState(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowManager;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    return-void
.end method

.method updateContentController(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 3

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_content_top_fragment:I

    invoke-direct {p0, p1, v0}, Lcom/facebook/accountkit/ui/StateStackManager;->getContentFragment(Lcom/facebook/accountkit/ui/AccountKitActivity;I)Lcom/facebook/accountkit/ui/ContentFragment;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ContentFragment;->getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v2, 0x1

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/facebook/accountkit/ui/StateStackManager;->ensureContentController(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/LoginFlowState;Z)Lcom/facebook/accountkit/ui/ContentController;

    move-result-object p1

    if-nez p1, :cond_1

    return-void

    :cond_1
    iput-object p1, p0, Lcom/facebook/accountkit/ui/StateStackManager;->contentController:Lcom/facebook/accountkit/ui/ContentController;

    new-instance p1, Ljava/util/ArrayList;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->onPopListeners:Ljava/util/List;

    invoke-direct {p1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->onPopListeners:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;

    invoke-interface {v0}, Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;->onContentPopped()V

    goto :goto_0

    :cond_2
    new-instance p1, Ljava/util/ArrayList;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->onPushListeners:Ljava/util/List;

    invoke-direct {p1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager;->onPushListeners:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;

    invoke-interface {v0}, Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;->onContentPushed()V

    goto :goto_1

    :cond_3
    return-void
.end method
