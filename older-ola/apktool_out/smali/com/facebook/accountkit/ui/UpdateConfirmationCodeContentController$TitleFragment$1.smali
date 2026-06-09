.class Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment$1;
.super Landroid/text/style/ClickableSpan;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->setPhoneNumberView()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment$1;->this$0:Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;

    invoke-direct {p0}, Landroid/text/style/ClickableSpan;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/Buttons;->PHONE_NUMBER:Lcom/facebook/accountkit/ui/Buttons;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/Buttons;->name()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIResendInteraction(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment$1;->this$0:Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment$OnCompleteListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment$1;->this$0:Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment$OnCompleteListener;

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment$OnCompleteListener;->onEdit(Landroid/content/Context;)V

    :cond_0
    return-void
.end method

.method public updateDrawState(Landroid/text/TextPaint;)V
    .locals 2

    invoke-super {p0, p1}, Landroid/text/style/ClickableSpan;->updateDrawState(Landroid/text/TextPaint;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment$1;->this$0:Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment$1;->this$0:Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/ViewUtility;->getButtonColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/text/TextPaint;->setColor(I)V

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/text/TextPaint;->setUnderlineText(Z)V

    return-void
.end method
