.class Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

.field final synthetic val$confirmationCodeView:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;Landroid/widget/EditText;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$4;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$4;->val$confirmationCodeView:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$4;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->access$500(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$4;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->access$600(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;Z)V

    sget-object v0, Lcom/facebook/accountkit/ui/Buttons;->CONFIRMATION_CODE_FIRST_DIGIT:Lcom/facebook/accountkit/ui/Buttons;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/Buttons;->name()Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    invoke-static {v0, v2}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIConfirmationCodeInteraction(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    invoke-interface {p1}, Landroid/text/Editable;->length()I

    move-result p1

    if-ne p1, v1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$4;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$4;->val$confirmationCodeView:Landroid/widget/EditText;

    invoke-static {p1, v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->access$700(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;Landroid/view/View;)Landroid/widget/EditText;

    :cond_1
    iget-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$4;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->access$800(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$OnConfirmationCodeChangedListener;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$4;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->access$800(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$OnConfirmationCodeChangedListener;

    move-result-object p1

    invoke-interface {p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$OnConfirmationCodeChangedListener;->onConfirmationCodeChanged()V

    :cond_2
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method
