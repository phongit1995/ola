.class abstract Lcom/facebook/accountkit/ui/TextContentFragment;
.super Lcom/facebook/accountkit/ui/ContentFragment;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;
    }
.end annotation


# static fields
.field private static final CONTENT_PADDING_BOTTOM_KEY:Ljava/lang/String; = "contentPaddingBottom"

.field private static final CONTENT_PADDING_TOP_KEY:Ljava/lang/String; = "contentPaddingTop"


# instance fields
.field private nextButtonTextProvider:Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;

.field private textView:Landroid/widget/TextView;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ContentFragment;-><init>()V

    return-void
.end method

.method private updateContentPadding()V
    .locals 5

    iget-object v0, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->textView:Landroid/widget/TextView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->getContentPaddingTop()I

    move-result v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->getContentPaddingBottom()I

    move-result v1

    iget-object v2, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->textView:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->textView:Landroid/widget/TextView;

    invoke-virtual {v3}, Landroid/widget/TextView;->getPaddingLeft()I

    move-result v3

    iget-object v4, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->textView:Landroid/widget/TextView;

    invoke-virtual {v4}, Landroid/widget/TextView;->getPaddingRight()I

    move-result v4

    invoke-virtual {v2, v3, v0, v4, v1}, Landroid/widget/TextView;->setPadding(IIII)V

    return-void
.end method


# virtual methods
.method protected createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    sget p3, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_phone_login_text:I

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public getContentPaddingBottom()I
    .locals 3

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "contentPaddingBottom"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public getContentPaddingTop()I
    .locals 3

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "contentPaddingTop"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method protected abstract getText(Ljava/lang/String;)Landroid/text/Spanned;
.end method

.method public onStart()V
    .locals 0

    invoke-super {p0}, Lcom/facebook/accountkit/ui/ContentFragment;->onStart()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->updateText()V

    return-void
.end method

.method protected onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/ContentFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_text:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->textView:Landroid/widget/TextView;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->textView:Landroid/widget/TextView;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->textView:Landroid/widget/TextView;

    new-instance p2, Lcom/facebook/accountkit/ui/CustomLinkMovement;

    new-instance v0, Lcom/facebook/accountkit/ui/TextContentFragment$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/TextContentFragment$1;-><init>(Lcom/facebook/accountkit/ui/TextContentFragment;)V

    invoke-direct {p2, v0}, Lcom/facebook/accountkit/ui/CustomLinkMovement;-><init>(Lcom/facebook/accountkit/ui/CustomLinkMovement$OnURLClickedListener;)V

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setMovementMethod(Landroid/text/method/MovementMethod;)V

    :cond_0
    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->updateContentPadding()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->updateText()V

    return-void
.end method

.method public setContentPaddingBottom(I)V
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "contentPaddingBottom"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->updateContentPadding()V

    return-void
.end method

.method public setContentPaddingTop(I)V
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "contentPaddingTop"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->updateContentPadding()V

    return-void
.end method

.method public setNextButtonTextProvider(Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->nextButtonTextProvider:Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;

    return-void
.end method

.method updateText()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->textView:Landroid/widget/TextView;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->nextButtonTextProvider:Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TextContentFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->textView:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/TextContentFragment;->nextButtonTextProvider:Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;

    invoke-interface {v1}, Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;->getNextButtonText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/facebook/accountkit/ui/TextContentFragment;->getText(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_2
    return-void
.end method
