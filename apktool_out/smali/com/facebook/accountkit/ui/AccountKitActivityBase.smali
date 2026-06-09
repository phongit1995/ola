.class abstract Lcom/facebook/accountkit/ui/AccountKitActivityBase;
.super Landroid/support/v7/app/AppCompatActivity;


# static fields
.field public static final ACCOUNT_KIT_ACTIVITY_CONFIGURATION:Ljava/lang/String;

.field private static final TAG:Ljava/lang/String;

.field private static final VIEW_STATE_KEY:Ljava/lang/String;


# instance fields
.field configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field error:Lcom/facebook/accountkit/AccountKitError;

.field private keyboardObserver:Lcom/facebook/accountkit/ui/KeyboardObserver;

.field uiManager:Lcom/facebook/accountkit/ui/UIManager;

.field private final viewState:Landroid/os/Bundle;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->TAG:Ljava/lang/String;

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->ACCOUNT_KIT_ACTIVITY_CONFIGURATION:Ljava/lang/String;

    const-class v0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->TAG:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".viewState"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->VIEW_STATE_KEY:Ljava/lang/String;

    return-void
.end method

.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/support/v7/app/AppCompatActivity;-><init>()V

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->viewState:Landroid/os/Bundle;

    return-void
.end method


# virtual methods
.method ensureNextButton(Lcom/facebook/accountkit/ui/ContentController;)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    sget-object v1, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CONTEMPORARY:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v0

    if-nez p1, :cond_2

    invoke-virtual {v0}, Landroid/app/FragmentManager;->beginTransaction()Landroid/app/FragmentTransaction;

    move-result-object p1

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_content_bottom_fragment:I

    invoke-virtual {p0, p1, v0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->remove(Landroid/app/FragmentTransaction;I)Landroid/app/Fragment;

    move-result-object v0

    if-nez v0, :cond_1

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_content_bottom_keyboard_fragment:I

    invoke-virtual {p0, p1, v0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->remove(Landroid/app/FragmentTransaction;I)Landroid/app/Fragment;

    :cond_1
    invoke-virtual {p1}, Landroid/app/FragmentTransaction;->commit()I

    return-void

    :cond_2
    invoke-interface {p1}, Lcom/facebook/accountkit/ui/ContentController;->getBottomFragment()Lcom/facebook/accountkit/ui/ContentFragment;

    move-result-object p1

    invoke-virtual {v0}, Landroid/app/FragmentManager;->beginTransaction()Landroid/app/FragmentTransaction;

    move-result-object v0

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/ContentFragment;->isKeyboardFragment()Z

    move-result v1

    if-eqz v1, :cond_3

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_content_bottom_fragment:I

    invoke-virtual {p0, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->remove(Landroid/app/FragmentTransaction;I)Landroid/app/Fragment;

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_content_bottom_keyboard_fragment:I

    :goto_0
    invoke-virtual {p0, v0, v1, p1}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V

    goto :goto_1

    :cond_3
    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_content_bottom_keyboard_fragment:I

    invoke-virtual {p0, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->remove(Landroid/app/FragmentTransaction;I)Landroid/app/Fragment;

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_content_bottom_fragment:I

    goto :goto_0

    :goto_1
    invoke-virtual {v0}, Landroid/app/FragmentTransaction;->commit()I

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1    # Landroid/os/Bundle;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-super {p0, p1}, Landroid/support/v7/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->getIntent()Landroid/content/Intent;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->ACCOUNT_KIT_ACTIVITY_CONFIGURATION:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    if-nez v0, :cond_0

    new-instance p1, Lcom/facebook/accountkit/AccountKitError;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->INITIALIZATION_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_INTENT_EXTRAS_CONFIGURATION:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {p1, v0, v1}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->sendResult()V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->doesTextColorContrast(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logInvalidUIManager()V

    new-instance p1, Lcom/facebook/accountkit/AccountKitError;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->INITIALIZATION_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_BACKGROUND_CONTRACT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {p1, v0, v1}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->sendResult()V

    return-void

    :cond_1
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-interface {v0}, Lcom/facebook/accountkit/ui/UIManager;->getThemeId()I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_2

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->setTheme(I)V

    :cond_2
    const/4 v0, 0x1

    invoke-static {v0}, Landroid/support/v7/app/AppCompatDelegate;->setCompatVectorFromResourcesEnabled(Z)V

    invoke-static {p0}, Lcom/facebook/accountkit/ui/ViewUtility;->isTablet(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_3

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->setRequestedOrientation(I)V

    :cond_3
    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_activity_layout:I

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->setContentView(I)V

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_content_view:I

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/ConstrainedLinearLayout;

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_scroll_view:I

    invoke-virtual {p0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->findViewById(I)Landroid/view/View;

    move-result-object v1

    if-eqz v0, :cond_4

    if-eqz v1, :cond_4

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ConstrainedLinearLayout;->getMinHeight()I

    move-result v2

    if-gez v2, :cond_4

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ConstrainedLinearLayout;->getRootView()Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_4

    new-instance v2, Lcom/facebook/accountkit/ui/KeyboardObserver;

    invoke-direct {v2, v1}, Lcom/facebook/accountkit/ui/KeyboardObserver;-><init>(Landroid/view/View;)V

    iput-object v2, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->keyboardObserver:Lcom/facebook/accountkit/ui/KeyboardObserver;

    new-instance v1, Lcom/facebook/accountkit/ui/AccountKitActivityBase$1;

    invoke-direct {v1, p0, v0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase$1;-><init>(Lcom/facebook/accountkit/ui/AccountKitActivityBase;Lcom/facebook/accountkit/ui/ConstrainedLinearLayout;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->keyboardObserver:Lcom/facebook/accountkit/ui/KeyboardObserver;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/KeyboardObserver;->setOnVisibleFrameChangedListener(Lcom/facebook/accountkit/ui/KeyboardObserver$OnVisibleFrameChangedListener;)V

    :cond_4
    if-eqz p1, :cond_5

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->viewState:Landroid/os/Bundle;

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->VIEW_STATE_KEY:Ljava/lang/String;

    invoke-virtual {p1, v1}, Landroid/os/Bundle;->getBundle(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/os/Bundle;->putAll(Landroid/os/Bundle;)V

    :cond_5
    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object p1

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_background:I

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->applyThemeBackground(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/view/View;)V

    return-void
.end method

.method protected onDestroy()V
    .locals 2

    invoke-super {p0}, Landroid/support/v7/app/AppCompatActivity;->onDestroy()V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->keyboardObserver:Lcom/facebook/accountkit/ui/KeyboardObserver;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->keyboardObserver:Lcom/facebook/accountkit/ui/KeyboardObserver;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/KeyboardObserver;->setOnVisibleFrameChangedListener(Lcom/facebook/accountkit/ui/KeyboardObserver$OnVisibleFrameChangedListener;)V

    iput-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->keyboardObserver:Lcom/facebook/accountkit/ui/KeyboardObserver;

    :cond_0
    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->VIEW_STATE_KEY:Ljava/lang/String;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->viewState:Landroid/os/Bundle;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    invoke-super {p0, p1}, Landroid/support/v7/app/AppCompatActivity;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method remove(Landroid/app/FragmentTransaction;I)Landroid/app/Fragment;
    .locals 1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0, p2}, Landroid/app/FragmentManager;->findFragmentById(I)Landroid/app/Fragment;

    move-result-object p2

    if-eqz p2, :cond_0

    invoke-virtual {p1, p2}, Landroid/app/FragmentTransaction;->remove(Landroid/app/Fragment;)Landroid/app/FragmentTransaction;

    :cond_0
    return-object p2
.end method

.method replace(Landroid/app/FragmentTransaction;ILandroid/app/Fragment;)V
    .locals 1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0, p2}, Landroid/app/FragmentManager;->findFragmentById(I)Landroid/app/Fragment;

    move-result-object v0

    if-eq v0, p3, :cond_0

    invoke-virtual {p1, p2, p3}, Landroid/app/FragmentTransaction;->replace(ILandroid/app/Fragment;)Landroid/app/FragmentTransaction;

    :cond_0
    return-void
.end method

.method abstract sendResult()V
.end method
