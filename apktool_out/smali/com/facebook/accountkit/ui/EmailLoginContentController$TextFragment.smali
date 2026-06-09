.class public final Lcom/facebook/accountkit/ui/EmailLoginContentController$TextFragment;
.super Lcom/facebook/accountkit/ui/TextContentFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/EmailLoginContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "TextFragment"
.end annotation


# static fields
.field private static final ACCOUNT_KIT_URL:Ljava/lang/String; = "https://www.accountkit.com/faq"


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;-><init>()V

    return-void
.end method


# virtual methods
.method protected createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    sget p3, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_email_login_text:I

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic getContentPaddingBottom()I
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->getContentPaddingBottom()I

    move-result v0

    return v0
.end method

.method public bridge synthetic getContentPaddingTop()I
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->getContentPaddingTop()I

    move-result v0

    return v0
.end method

.method getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$100()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    return-object v0
.end method

.method protected getText(Ljava/lang/String;)Landroid/text/Spanned;
    .locals 3

    sget v0, Lcom/facebook/accountkit/R$string;->com_accountkit_email_login_text:I

    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getApplicationName()Ljava/lang/String;

    move-result-object p1

    const/4 v2, 0x1

    aput-object p1, v1, v2

    const-string p1, "https://www.accountkit.com/faq"

    const/4 v2, 0x2

    aput-object p1, v1, v2

    invoke-virtual {p0, v0, v1}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TextFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/text/Html;->fromHtml(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object p1

    return-object p1
.end method

.method isKeyboardFragment()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public bridge synthetic onActivityCreated(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/TextContentFragment;->onActivityCreated(Landroid/os/Bundle;)V

    return-void
.end method

.method public bridge synthetic onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/TextContentFragment;->onCreate(Landroid/os/Bundle;)V

    return-void
.end method

.method public bridge synthetic onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    invoke-super {p0, p1, p2, p3}, Lcom/facebook/accountkit/ui/TextContentFragment;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/TextContentFragment;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method public bridge synthetic onStart()V
    .locals 0

    invoke-super {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->onStart()V

    return-void
.end method

.method public bridge synthetic setContentPaddingBottom(I)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/TextContentFragment;->setContentPaddingBottom(I)V

    return-void
.end method

.method public bridge synthetic setContentPaddingTop(I)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/TextContentFragment;->setContentPaddingTop(I)V

    return-void
.end method

.method public bridge synthetic setNextButtonTextProvider(Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/TextContentFragment;->setNextButtonTextProvider(Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;)V

    return-void
.end method
