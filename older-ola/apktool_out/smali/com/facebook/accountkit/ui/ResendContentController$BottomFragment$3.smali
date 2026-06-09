.class Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;

.field final synthetic val$showAlternateButtonText:Z


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;Z)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$3;->this$0:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;

    iput-boolean p2, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$3;->val$showAlternateButtonText:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$3;->val$showAlternateButtonText:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/facebook/accountkit/ui/Buttons;->CONFIRMATION_CODE_CALLBACK:Lcom/facebook/accountkit/ui/Buttons;

    :goto_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/Buttons;->name()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_0
    sget-object v0, Lcom/facebook/accountkit/ui/Buttons;->CONFIRMATION_CODE_CALLBACK_ALTERNATE:Lcom/facebook/accountkit/ui/Buttons;

    goto :goto_0

    :goto_1
    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIResendInteraction(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$3;->this$0:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->access$100(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;)Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$OnCompleteListener;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$3;->this$0:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->access$100(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;)Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$OnCompleteListener;

    move-result-object v0

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$OnCompleteListener;->onConfirmationCodeCallback(Landroid/content/Context;)V

    :cond_1
    return-void
.end method
